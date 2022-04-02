// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] mipi_packetizer.v
//   \ \  / /\ \  / /    [Description ] CRC, ECC, short packet, long packet    
//    \ \/ /  \ \/ /     [Timestamp   ] Wednesday August 15 10:00:30 2017
//     \  /    \  /      [version     ] 1.0.0
//      \/      \/       
//
// ===========Oooo==========================================Oooo========
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author |Mod. Date |Changes Made:
// V1.0 | GQG    |08/15/17  |Initial version
// ===========Oooo==========================================Oooo========
`timescale 1 ns / 1 ps
`include "lvds2mipi_defines.v"

module mipi_packetizer (
								input														I_lcd_clk,//60MHz
								input														I_rst_n,
								//MIPI_RD_CTRL SIDE
							  //Inputs
								input 													I_lcd_hs,
								input 													I_lcd_vs,
								input 													I_lcd_de,
								input [7:0] 											I_lcd_rgb_lane0,
								input [7:0] 											I_lcd_rgb_lane1,
								input [7:0] 											I_lcd_rgb_lane2,
								input [7:0] 											I_lcd_rgb_lane3,
                			input [2:0]												I_lcd_tx_packet_type,
                			input 													I_lcd_tx_valid_data_flag,
                			input 													I_lcd_tx_packet_flag,

								//MIPI_HS_LP SIDE
							 	//Outputs
								output reg												O_hs_en,
								output reg[7:0] 										O_hs_rgb_lane0,
								output reg[7:0] 										O_hs_rgb_lane1,
								output reg[7:0] 										O_hs_rgb_lane2,
								output reg[7:0] 										O_hs_rgb_lane3
								);
	/*******************************************************************************
	 * Data type  parameter
	 *******************************************************************************/
	parameter DT_VEDIO 		=6'h3E;
	//parameter DT_VSYNC_S 	=6'h01;
	//parameter DT_VSYNC_E		=6'h11;
	parameter DT_HSYNC_S 	=6'h21;
	//parameter DT_HSYNC_E 	=6'h31;

	parameter DATA_TYPE_HSS		=3'h1;
	parameter DATA_TYPE_VSS		=3'h4;

	//parameter DATA_TYPE_BLP		=3'h2;
	//parameter DATA_TYPE_VIDEO	=3'h3;

	/*******************************************************************************
 	* MIPI DSI hs mode FSM States defined
 	*******************************************************************************/
	parameter STATE_IDLE           	= 3'b000;
	parameter STATE_TX_HSS_INVALID  = 3'b001;
	parameter STATE_TX_HSS_VALID    = 3'b010;
	parameter STATE_TX_VSS_INVALID  = 3'b011;
	parameter STATE_TX_BLP      		= 3'b100;
	parameter STATE_TX_VIDEO    		= 3'b101;

	/*******************************************************************************
	 * reg and wire definition
	 *******************************************************************************/
	//reg [5:0] 										Packet_header_dt;
	//reg [15:0] 										Packet_header_wc;
	//wire [1:0] 										Packet_header_vc;
	wire [7:0] 									Lcd_rgb_lane0_inv;
	wire [7:0] 									Lcd_rgb_lane1_inv;
	wire [7:0] 									Lcd_rgb_lane2_inv;
	wire [7:0] 									Lcd_rgb_lane3_inv;

	wire [31:0] 									Lcd_rgb_lane_inv;
	wire [31:0] 									Lcd_rgb_lane;

	reg [15:0] 										Crc_long_packet;

	reg [2:0] 										Fsm_mipi_hs;
	reg 												I_lcd_de_reg;
	
	//wire [7:0] 										Ecc;
	/*******************************************************************************
	 * ECC function
	 *******************************************************************************/
	/*function [7:0] Ecc_cal;
	input [23:0] D;
	begin
	    Ecc_cal[7]=0;
	    Ecc_cal[6]=0;
	    Ecc_cal[5]=D[10]^D[11]^D[12]^D[13]^D[14]^D[15]^D[16]^D[17]^D[18]^D[19]^D[21]^D[22]^D[23];
	    Ecc_cal[4]=D[4] ^D[5] ^D[6] ^D[7] ^D[8] ^D[9] ^D[16]^D[17]^D[18]^D[19]^D[20]^D[22]^D[23];
	    Ecc_cal[3]=D[1] ^D[2] ^D[3] ^D[7] ^D[8] ^D[9] ^D[13]^D[14]^D[15]^D[19]^D[20]^D[21]^D[23];
	    Ecc_cal[2]=D[0] ^D[2] ^D[3] ^D[5] ^D[6] ^D[9] ^D[11]^D[12]^D[15]^D[18]^D[20]^D[21]^D[22];
	    Ecc_cal[1]=D[0] ^D[1] ^D[3] ^D[4] ^D[6] ^D[8] ^D[10]^D[12]^D[14]^D[17]^D[20]^D[21]^D[22]^D[23];
	    Ecc_cal[0]=D[0] ^D[1] ^D[2] ^D[4] ^D[5] ^D[7] ^D[10]^D[11]^D[13]^D[16]^D[20]^D[21]^D[22]^D[23];
	end
	endfunction*/
	/*******************************************************************************
	 * CRC function
	 *******************************************************************************/
  /*function [15:0] Crc16_cal;
  input [7:0] D;
  input [15:0] Crc;
  begin
    Crc16_cal[0] = D[0] ^ D[4] 	^ Crc[0] 	^ Crc[4] ^ Crc[8];
    Crc16_cal[1] = D[1] ^ D[5] 	^ Crc[1] 	^ Crc[5] ^ Crc[9];
    Crc16_cal[2] = D[2] ^ D[6] 	^ Crc[2] 	^ Crc[6] ^ Crc[10];
    Crc16_cal[3] = D[0] ^ D[3] 	^ D[7] 		^ Crc[0] ^ Crc[3] ^ Crc[7] ^ Crc[11];
    Crc16_cal[4] = D[1] ^ Crc[1]^ Crc[12];
    Crc16_cal[5] = D[2] ^ Crc[2]^ Crc[13];
    Crc16_cal[6] = D[3] ^ Crc[3]^ Crc[14];
    Crc16_cal[7] = D[0] ^ D[4] 	^ Crc[0] 	^ Crc[4] ^ Crc[15];
    Crc16_cal[8] = D[0] ^ D[1] 	^ D[5] 		^ Crc[0] ^ Crc[1] ^ Crc[5];
    Crc16_cal[9] = D[1] ^ D[2] 	^ D[6] 		^ Crc[1] ^ Crc[2] ^ Crc[6];
    Crc16_cal[10]= D[2] ^ D[3] 	^ D[7] 		^ Crc[2] ^ Crc[3] ^ Crc[7];
    Crc16_cal[11]= D[3] ^ Crc[3];
    Crc16_cal[12]= D[0] ^ D[4] 	^ Crc[0] 	^ Crc[4];
    Crc16_cal[13]= D[1] ^ D[5] 	^ Crc[1] 	^ Crc[5];
    Crc16_cal[14]= D[2] ^ D[6] 	^ Crc[2] 	^ Crc[6];
    Crc16_cal[15]= D[3] ^ D[7] 	^ Crc[3] 	^ Crc[7];
  end
  endfunction*/
	
  // polynomial: x^16 + x^12 + x^5 + 1
  // data width: 16
  // convention: the first serial bit is D[15]
  /*function [15:0] nextCRC16_D16;
  input [15:0] Data;
  input [15:0] crc;
  reg [15:0] d;
  reg [15:0] c;
  reg [15:0] newcrc;
  begin
    d = Data;
    c = crc;
    newcrc[0] = d[12] ^ d[11] ^ d[8] ^ d[4] ^ d[0] ^ c[0] ^ c[4] ^ c[8] ^ c[11] ^ c[12];
    newcrc[1] = d[13] ^ d[12] ^ d[9] ^ d[5] ^ d[1] ^ c[1] ^ c[5] ^ c[9] ^ c[12] ^ c[13];
    newcrc[2] = d[14] ^ d[13] ^ d[10] ^ d[6] ^ d[2] ^ c[2] ^ c[6] ^ c[10] ^ c[13] ^ c[14];
    newcrc[3] = d[15] ^ d[14] ^ d[11] ^ d[7] ^ d[3] ^ c[3] ^ c[7] ^ c[11] ^ c[14] ^ c[15];
    newcrc[4] = d[15] ^ d[12] ^ d[8] ^ d[4] ^ c[4] ^ c[8] ^ c[12] ^ c[15];
    newcrc[5] = d[13] ^ d[12] ^ d[11] ^ d[9] ^ d[8] ^ d[5] ^ d[4] ^ d[0] ^ c[0] ^ c[4] ^ c[5] ^ c[8] ^ c[9] ^ c[11] ^ c[12] ^ c[13];
    newcrc[6] = d[14] ^ d[13] ^ d[12] ^ d[10] ^ d[9] ^ d[6] ^ d[5] ^ d[1] ^ c[1] ^ c[5] ^ c[6] ^ c[9] ^ c[10] ^ c[12] ^ c[13] ^ c[14];
    newcrc[7] = d[15] ^ d[14] ^ d[13] ^ d[11] ^ d[10] ^ d[7] ^ d[6] ^ d[2] ^ c[2] ^ c[6] ^ c[7] ^ c[10] ^ c[11] ^ c[13] ^ c[14] ^ c[15];
    newcrc[8] = d[15] ^ d[14] ^ d[12] ^ d[11] ^ d[8] ^ d[7] ^ d[3] ^ c[3] ^ c[7] ^ c[8] ^ c[11] ^ c[12] ^ c[14] ^ c[15];
    newcrc[9] = d[15] ^ d[13] ^ d[12] ^ d[9] ^ d[8] ^ d[4] ^ c[4] ^ c[8] ^ c[9] ^ c[12] ^ c[13] ^ c[15];
    newcrc[10] = d[14] ^ d[13] ^ d[10] ^ d[9] ^ d[5] ^ c[5] ^ c[9] ^ c[10] ^ c[13] ^ c[14];
    newcrc[11] = d[15] ^ d[14] ^ d[11] ^ d[10] ^ d[6] ^ c[6] ^ c[10] ^ c[11] ^ c[14] ^ c[15];
    newcrc[12] = d[15] ^ d[8] ^ d[7] ^ d[4] ^ d[0] ^ c[0] ^ c[4] ^ c[7] ^ c[8] ^ c[15];
    newcrc[13] = d[9] ^ d[8] ^ d[5] ^ d[1] ^ c[1] ^ c[5] ^ c[8] ^ c[9];
    newcrc[14] = d[10] ^ d[9] ^ d[6] ^ d[2] ^ c[2] ^ c[6] ^ c[9] ^ c[10];
    newcrc[15] = d[11] ^ d[10] ^ d[7] ^ d[3] ^ c[3] ^ c[7] ^ c[10] ^ c[11];
    nextCRC16_D16 = newcrc;
  end
  endfunction*/
  // polynomial: x^16 + x^12 + x^5 + 1
  // data width: 32
  // convention: the first serial bit is D[31]
  function [15:0] nextCRC16_D32;

    input [31:0] Data;
    input [15:0] crc;
    reg [31:0] d;
    reg [15:0] c;
    reg [15:0] newcrc;
  begin
    d = Data;
    c = crc;

    newcrc[0] = d[28] ^ d[27] ^ d[26] ^ d[22] ^ d[20] ^ d[19] ^ d[12] ^ d[11] ^ d[8] ^ d[4] ^ d[0] ^ c[3] ^ c[4] ^ c[6] ^ c[10] ^ c[11] ^ c[12];
    newcrc[1] = d[29] ^ d[28] ^ d[27] ^ d[23] ^ d[21] ^ d[20] ^ d[13] ^ d[12] ^ d[9] ^ d[5] ^ d[1] ^ c[4] ^ c[5] ^ c[7] ^ c[11] ^ c[12] ^ c[13];
    newcrc[2] = d[30] ^ d[29] ^ d[28] ^ d[24] ^ d[22] ^ d[21] ^ d[14] ^ d[13] ^ d[10] ^ d[6] ^ d[2] ^ c[5] ^ c[6] ^ c[8] ^ c[12] ^ c[13] ^ c[14];
    newcrc[3] = d[31] ^ d[30] ^ d[29] ^ d[25] ^ d[23] ^ d[22] ^ d[15] ^ d[14] ^ d[11] ^ d[7] ^ d[3] ^ c[6] ^ c[7] ^ c[9] ^ c[13] ^ c[14] ^ c[15];
    newcrc[4] = d[31] ^ d[30] ^ d[26] ^ d[24] ^ d[23] ^ d[16] ^ d[15] ^ d[12] ^ d[8] ^ d[4] ^ c[0] ^ c[7] ^ c[8] ^ c[10] ^ c[14] ^ c[15];
    newcrc[5] = d[31] ^ d[28] ^ d[26] ^ d[25] ^ d[24] ^ d[22] ^ d[20] ^ d[19] ^ d[17] ^ d[16] ^ d[13] ^ d[12] ^ d[11] ^ d[9] ^ d[8] ^ d[5] ^ d[4] ^ d[0] ^ c[0] ^ c[1] ^ c[3] ^ c[4] ^ c[6] ^ c[8] ^ c[9] ^ c[10] ^ c[12] ^ c[15];
    newcrc[6] = d[29] ^ d[27] ^ d[26] ^ d[25] ^ d[23] ^ d[21] ^ d[20] ^ d[18] ^ d[17] ^ d[14] ^ d[13] ^ d[12] ^ d[10] ^ d[9] ^ d[6] ^ d[5] ^ d[1] ^ c[1] ^ c[2] ^ c[4] ^ c[5] ^ c[7] ^ c[9] ^ c[10] ^ c[11] ^ c[13];
    newcrc[7] = d[30] ^ d[28] ^ d[27] ^ d[26] ^ d[24] ^ d[22] ^ d[21] ^ d[19] ^ d[18] ^ d[15] ^ d[14] ^ d[13] ^ d[11] ^ d[10] ^ d[7] ^ d[6] ^ d[2] ^ c[2] ^ c[3] ^ c[5] ^ c[6] ^ c[8] ^ c[10] ^ c[11] ^ c[12] ^ c[14];
    newcrc[8] = d[31] ^ d[29] ^ d[28] ^ d[27] ^ d[25] ^ d[23] ^ d[22] ^ d[20] ^ d[19] ^ d[16] ^ d[15] ^ d[14] ^ d[12] ^ d[11] ^ d[8] ^ d[7] ^ d[3] ^ c[0] ^ c[3] ^ c[4] ^ c[6] ^ c[7] ^ c[9] ^ c[11] ^ c[12] ^ c[13] ^ c[15];
    newcrc[9] = d[30] ^ d[29] ^ d[28] ^ d[26] ^ d[24] ^ d[23] ^ d[21] ^ d[20] ^ d[17] ^ d[16] ^ d[15] ^ d[13] ^ d[12] ^ d[9] ^ d[8] ^ d[4] ^ c[0] ^ c[1] ^ c[4] ^ c[5] ^ c[7] ^ c[8] ^ c[10] ^ c[12] ^ c[13] ^ c[14];
    newcrc[10] = d[31] ^ d[30] ^ d[29] ^ d[27] ^ d[25] ^ d[24] ^ d[22] ^ d[21] ^ d[18] ^ d[17] ^ d[16] ^ d[14] ^ d[13] ^ d[10] ^ d[9] ^ d[5] ^ c[0] ^ c[1] ^ c[2] ^ c[5] ^ c[6] ^ c[8] ^ c[9] ^ c[11] ^ c[13] ^ c[14] ^ c[15];
    newcrc[11] = d[31] ^ d[30] ^ d[28] ^ d[26] ^ d[25] ^ d[23] ^ d[22] ^ d[19] ^ d[18] ^ d[17] ^ d[15] ^ d[14] ^ d[11] ^ d[10] ^ d[6] ^ c[1] ^ c[2] ^ c[3] ^ c[6] ^ c[7] ^ c[9] ^ c[10] ^ c[12] ^ c[14] ^ c[15];
    newcrc[12] = d[31] ^ d[29] ^ d[28] ^ d[24] ^ d[23] ^ d[22] ^ d[18] ^ d[16] ^ d[15] ^ d[8] ^ d[7] ^ d[4] ^ d[0] ^ c[0] ^ c[2] ^ c[6] ^ c[7] ^ c[8] ^ c[12] ^ c[13] ^ c[15];
    newcrc[13] = d[30] ^ d[29] ^ d[25] ^ d[24] ^ d[23] ^ d[19] ^ d[17] ^ d[16] ^ d[9] ^ d[8] ^ d[5] ^ d[1] ^ c[0] ^ c[1] ^ c[3] ^ c[7] ^ c[8] ^ c[9] ^ c[13] ^ c[14];
    newcrc[14] = d[31] ^ d[30] ^ d[26] ^ d[25] ^ d[24] ^ d[20] ^ d[18] ^ d[17] ^ d[10] ^ d[9] ^ d[6] ^ d[2] ^ c[1] ^ c[2] ^ c[4] ^ c[8] ^ c[9] ^ c[10] ^ c[14] ^ c[15];
    newcrc[15] = d[31] ^ d[27] ^ d[26] ^ d[25] ^ d[21] ^ d[19] ^ d[18] ^ d[11] ^ d[10] ^ d[7] ^ d[3] ^ c[2] ^ c[3] ^ c[5] ^ c[9] ^ c[10] ^ c[11] ^ c[15];
    nextCRC16_D32 = newcrc;
  end
  endfunction
  // polynomial: x^16 + x^12 + x^5 + 1
  // data width: 64
  // convention: the first serial bit is D[63]
 /* function [15:0] nextCRC16_D64;

    input [63:0] Data;
    input [15:0] crc;
    reg [63:0] d;
    reg [15:0] c;
    reg [15:0] newcrc;
    begin
    d = Data;
    c = crc;

    newcrc[0] = d[63] ^ d[58] ^ d[56] ^ d[55] ^ d[52] ^ d[51] ^ d[49] ^ d[48] ^ d[42] ^ d[35] ^ d[33] ^ d[32] ^ d[28] ^ d[27] ^ d[26] ^ d[22] ^ d[20] ^ d[19] ^ d[12] ^ d[11] ^ d[8] ^ d[4] ^ d[0] ^ c[0] ^ c[1] ^ c[3] ^ c[4] ^ c[7] ^ c[8] ^ c[10] ^ c[15];
    newcrc[1] = d[59] ^ d[57] ^ d[56] ^ d[53] ^ d[52] ^ d[50] ^ d[49] ^ d[43] ^ d[36] ^ d[34] ^ d[33] ^ d[29] ^ d[28] ^ d[27] ^ d[23] ^ d[21] ^ d[20] ^ d[13] ^ d[12] ^ d[9] ^ d[5] ^ d[1] ^ c[1] ^ c[2] ^ c[4] ^ c[5] ^ c[8] ^ c[9] ^ c[11];
    newcrc[2] = d[60] ^ d[58] ^ d[57] ^ d[54] ^ d[53] ^ d[51] ^ d[50] ^ d[44] ^ d[37] ^ d[35] ^ d[34] ^ d[30] ^ d[29] ^ d[28] ^ d[24] ^ d[22] ^ d[21] ^ d[14] ^ d[13] ^ d[10] ^ d[6] ^ d[2] ^ c[2] ^ c[3] ^ c[5] ^ c[6] ^ c[9] ^ c[10] ^ c[12];
    newcrc[3] = d[61] ^ d[59] ^ d[58] ^ d[55] ^ d[54] ^ d[52] ^ d[51] ^ d[45] ^ d[38] ^ d[36] ^ d[35] ^ d[31] ^ d[30] ^ d[29] ^ d[25] ^ d[23] ^ d[22] ^ d[15] ^ d[14] ^ d[11] ^ d[7] ^ d[3] ^ c[3] ^ c[4] ^ c[6] ^ c[7] ^ c[10] ^ c[11] ^ c[13];
    newcrc[4] = d[62] ^ d[60] ^ d[59] ^ d[56] ^ d[55] ^ d[53] ^ d[52] ^ d[46] ^ d[39] ^ d[37] ^ d[36] ^ d[32] ^ d[31] ^ d[30] ^ d[26] ^ d[24] ^ d[23] ^ d[16] ^ d[15] ^ d[12] ^ d[8] ^ d[4] ^ c[4] ^ c[5] ^ c[7] ^ c[8] ^ c[11] ^ c[12] ^ c[14];
    newcrc[5] = d[61] ^ d[60] ^ d[58] ^ d[57] ^ d[55] ^ d[54] ^ d[53] ^ d[52] ^ d[51] ^ d[49] ^ d[48] ^ d[47] ^ d[42] ^ d[40] ^ d[38] ^ d[37] ^ d[35] ^ d[31] ^ d[28] ^ d[26] ^ d[25] ^ d[24] ^ d[22] ^ d[20] ^ d[19] ^ d[17] ^ d[16] ^ d[13] ^ d[12] ^ d[11] ^ d[9] ^ d[8] ^ d[5] ^ d[4] ^ d[0] ^ c[0] ^ c[1] ^ c[3] ^ c[4] ^ c[5] ^ c[6] ^ c[7] ^ c[9] ^ c[10] ^ c[12] ^ c[13];
    newcrc[6] = d[62] ^ d[61] ^ d[59] ^ d[58] ^ d[56] ^ d[55] ^ d[54] ^ d[53] ^ d[52] ^ d[50] ^ d[49] ^ d[48] ^ d[43] ^ d[41] ^ d[39] ^ d[38] ^ d[36] ^ d[32] ^ d[29] ^ d[27] ^ d[26] ^ d[25] ^ d[23] ^ d[21] ^ d[20] ^ d[18] ^ d[17] ^ d[14] ^ d[13] ^ d[12] ^ d[10] ^ d[9] ^ d[6] ^ d[5] ^ d[1] ^ c[0] ^ c[1] ^ c[2] ^ c[4] ^ c[5] ^ c[6] ^ c[7] ^ c[8] ^ c[10] ^ c[11] ^ c[13] ^ c[14];
    newcrc[7] = d[63] ^ d[62] ^ d[60] ^ d[59] ^ d[57] ^ d[56] ^ d[55] ^ d[54] ^ d[53] ^ d[51] ^ d[50] ^ d[49] ^ d[44] ^ d[42] ^ d[40] ^ d[39] ^ d[37] ^ d[33] ^ d[30] ^ d[28] ^ d[27] ^ d[26] ^ d[24] ^ d[22] ^ d[21] ^ d[19] ^ d[18] ^ d[15] ^ d[14] ^ d[13] ^ d[11] ^ d[10] ^ d[7] ^ d[6] ^ d[2] ^ c[1] ^ c[2] ^ c[3] ^ c[5] ^ c[6] ^ c[7] ^ c[8] ^ c[9] ^ c[11] ^ c[12] ^ c[14] ^ c[15];
    newcrc[8] = d[63] ^ d[61] ^ d[60] ^ d[58] ^ d[57] ^ d[56] ^ d[55] ^ d[54] ^ d[52] ^ d[51] ^ d[50] ^ d[45] ^ d[43] ^ d[41] ^ d[40] ^ d[38] ^ d[34] ^ d[31] ^ d[29] ^ d[28] ^ d[27] ^ d[25] ^ d[23] ^ d[22] ^ d[20] ^ d[19] ^ d[16] ^ d[15] ^ d[14] ^ d[12] ^ d[11] ^ d[8] ^ d[7] ^ d[3] ^ c[2] ^ c[3] ^ c[4] ^ c[6] ^ c[7] ^ c[8] ^ c[9] ^ c[10] ^ c[12] ^ c[13] ^ c[15];
    newcrc[9] = d[62] ^ d[61] ^ d[59] ^ d[58] ^ d[57] ^ d[56] ^ d[55] ^ d[53] ^ d[52] ^ d[51] ^ d[46] ^ d[44] ^ d[42] ^ d[41] ^ d[39] ^ d[35] ^ d[32] ^ d[30] ^ d[29] ^ d[28] ^ d[26] ^ d[24] ^ d[23] ^ d[21] ^ d[20] ^ d[17] ^ d[16] ^ d[15] ^ d[13] ^ d[12] ^ d[9] ^ d[8] ^ d[4] ^ c[3] ^ c[4] ^ c[5] ^ c[7] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[13] ^ c[14];
    newcrc[10] = d[63] ^ d[62] ^ d[60] ^ d[59] ^ d[58] ^ d[57] ^ d[56] ^ d[54] ^ d[53] ^ d[52] ^ d[47] ^ d[45] ^ d[43] ^ d[42] ^ d[40] ^ d[36] ^ d[33] ^ d[31] ^ d[30] ^ d[29] ^ d[27] ^ d[25] ^ d[24] ^ d[22] ^ d[21] ^ d[18] ^ d[17] ^ d[16] ^ d[14] ^ d[13] ^ d[10] ^ d[9] ^ d[5] ^ c[4] ^ c[5] ^ c[6] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[14] ^ c[15];
    newcrc[11] = d[63] ^ d[61] ^ d[60] ^ d[59] ^ d[58] ^ d[57] ^ d[55] ^ d[54] ^ d[53] ^ d[48] ^ d[46] ^ d[44] ^ d[43] ^ d[41] ^ d[37] ^ d[34] ^ d[32] ^ d[31] ^ d[30] ^ d[28] ^ d[26] ^ d[25] ^ d[23] ^ d[22] ^ d[19] ^ d[18] ^ d[17] ^ d[15] ^ d[14] ^ d[11] ^ d[10] ^ d[6] ^ c[0] ^ c[5] ^ c[6] ^ c[7] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[15];
    newcrc[12] = d[63] ^ d[62] ^ d[61] ^ d[60] ^ d[59] ^ d[54] ^ d[52] ^ d[51] ^ d[48] ^ d[47] ^ d[45] ^ d[44] ^ d[38] ^ d[31] ^ d[29] ^ d[28] ^ d[24] ^ d[23] ^ d[22] ^ d[18] ^ d[16] ^ d[15] ^ d[8] ^ d[7] ^ d[4] ^ d[0] ^ c[0] ^ c[3] ^ c[4] ^ c[6] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
    newcrc[13] = d[63] ^ d[62] ^ d[61] ^ d[60] ^ d[55] ^ d[53] ^ d[52] ^ d[49] ^ d[48] ^ d[46] ^ d[45] ^ d[39] ^ d[32] ^ d[30] ^ d[29] ^ d[25] ^ d[24] ^ d[23] ^ d[19] ^ d[17] ^ d[16] ^ d[9] ^ d[8] ^ d[5] ^ d[1] ^ c[0] ^ c[1] ^ c[4] ^ c[5] ^ c[7] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
    newcrc[14] = d[63] ^ d[62] ^ d[61] ^ d[56] ^ d[54] ^ d[53] ^ d[50] ^ d[49] ^ d[47] ^ d[46] ^ d[40] ^ d[33] ^ d[31] ^ d[30] ^ d[26] ^ d[25] ^ d[24] ^ d[20] ^ d[18] ^ d[17] ^ d[10] ^ d[9] ^ d[6] ^ d[2] ^ c[1] ^ c[2] ^ c[5] ^ c[6] ^ c[8] ^ c[13] ^ c[14] ^ c[15];
    newcrc[15] = d[63] ^ d[62] ^ d[57] ^ d[55] ^ d[54] ^ d[51] ^ d[50] ^ d[48] ^ d[47] ^ d[41] ^ d[34] ^ d[32] ^ d[31] ^ d[27] ^ d[26] ^ d[25] ^ d[21] ^ d[19] ^ d[18] ^ d[11] ^ d[10] ^ d[7] ^ d[3] ^ c[0] ^ c[2] ^ c[3] ^ c[6] ^ c[7] ^ c[9] ^ c[14] ^ c[15];
    nextCRC16_D64 = newcrc;
  end
  endfunction*/
 /*******************************************************************************/
	//assign Packet_header_vc=2'b00;
	//assign Ecc = Ecc_cal({Packet_header_wc,Packet_header_vc,Packet_header_dt});//ECC calculation

 /*******************************************************************************/
 //CRC calculation
 /*******************************************************************************/
	assign Lcd_rgb_lane={I_lcd_rgb_lane3[7:0],I_lcd_rgb_lane2[7:0],I_lcd_rgb_lane1[7:0],I_lcd_rgb_lane0[7:0]};

	generate                                    
	genvar i;                                   
	for(i=0;i<32;i=i+1) begin : inv_lane        
		assign Lcd_rgb_lane_inv[i] = Lcd_rgb_lane[31-i];
	end                                 
	endgenerate  

	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
    if(!I_rst_n) 
      Crc_long_packet <= 16'hffff;//initial value
    else if(I_lcd_hs)
    	Crc_long_packet <= 16'hffff;
    else if (I_lcd_de) 
    	Crc_long_packet <= nextCRC16_D32(Lcd_rgb_lane_inv,Crc_long_packet);
    else
    	Crc_long_packet <= 16'hffff;
	end
 /*******************************************************************************/
 //Initialize DT value  
 /*******************************************************************************/ 
	/*always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Packet_header_dt<=DT_VSYNC_S;
			Packet_header_wc<=16'd0;
		end
		else begin
			if(I_lcd_vs)begin
				Packet_header_dt<=DT_VSYNC_S;
				Packet_header_wc<=16'd0;
			end
			else if(I_lcd_hs)begin
				Packet_header_dt<=DT_HSYNC_S;
				Packet_header_wc<=16'd0;
			end
			else if(I_lcd_hs_rgb)begin
				Packet_header_dt<=DT_VEDIO;
				Packet_header_wc<=16'h1680;//RGB888  1920*3=5760
			end
		end
	end*/
	
 /*******************************************************************************/
 //Packetize  
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk) 
	begin
		I_lcd_de_reg<=I_lcd_de;
	end

	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Fsm_mipi_hs<=STATE_IDLE;
			O_hs_en<=0;
			O_hs_rgb_lane0<=0;
			O_hs_rgb_lane1<=0;
			O_hs_rgb_lane2<=0;
			O_hs_rgb_lane3<=0;
		end
		else begin
			case(Fsm_mipi_hs)
				STATE_IDLE:begin//idle
					if(I_lcd_tx_packet_flag)begin
						if(I_lcd_tx_packet_type==DATA_TYPE_HSS)begin
							if(I_lcd_tx_valid_data_flag)begin
							  Fsm_mipi_hs<=STATE_TX_HSS_VALID;//enter STATE_TX_HSS_VALID
								O_hs_en<=1;
								O_hs_rgb_lane0<=8'hb8;
								O_hs_rgb_lane1<=8'hb8;
								O_hs_rgb_lane2<=8'hb8;
								O_hs_rgb_lane3<=8'hb8;
							end
							else begin
								Fsm_mipi_hs<=STATE_TX_HSS_INVALID;//enter STATE_TX_HSS_INVALID
								O_hs_en<=1;
								O_hs_rgb_lane0<=8'hb8;
								O_hs_rgb_lane1<=8'hb8;
								O_hs_rgb_lane2<=8'hb8;
								O_hs_rgb_lane3<=8'hb8;								
							end
						end
						else if(I_lcd_tx_packet_type==DATA_TYPE_VSS)begin
								Fsm_mipi_hs<=STATE_TX_VSS_INVALID;//enter STATE_TX_HSS_INVALID
								O_hs_en<=1;
								O_hs_rgb_lane0<=8'hb8;
								O_hs_rgb_lane1<=8'hb8;
								O_hs_rgb_lane2<=8'hb8;
								O_hs_rgb_lane3<=8'hb8;								
						end
						else begin
							Fsm_mipi_hs<=STATE_IDLE;
							O_hs_en<=0;
							O_hs_rgb_lane0<=0;
							O_hs_rgb_lane1<=0;
							O_hs_rgb_lane2<=0;
							O_hs_rgb_lane3<=0;						
						end
					end
					else begin
						Fsm_mipi_hs<=STATE_IDLE;
						O_hs_en<=0;
						O_hs_rgb_lane0<=0;
						O_hs_rgb_lane1<=0;
						O_hs_rgb_lane2<=0;
						O_hs_rgb_lane3<=0;						
					end
				end
				STATE_TX_HSS_INVALID:begin//tx hs start packet
					O_hs_en<=1;
					O_hs_rgb_lane0<=8'h21;
					O_hs_rgb_lane1<=8'h00;
					O_hs_rgb_lane2<=8'h00;
					O_hs_rgb_lane3<=8'h12;
					Fsm_mipi_hs<=STATE_IDLE;
				end
				STATE_TX_VSS_INVALID:begin//tx vs start packet
					O_hs_en<=1;
					O_hs_rgb_lane0<=8'h01;
					O_hs_rgb_lane1<=8'h00;
					O_hs_rgb_lane2<=8'h00;
					O_hs_rgb_lane3<=8'h07;
					Fsm_mipi_hs<=STATE_IDLE;
				end
				STATE_TX_HSS_VALID:begin//tx hs start packet
					O_hs_en<=1;
					O_hs_rgb_lane0<=8'h21;
					O_hs_rgb_lane1<=8'h00;
					O_hs_rgb_lane2<=8'h00;
					O_hs_rgb_lane3<=8'h12;
					Fsm_mipi_hs<=STATE_TX_BLP;
				end
				STATE_TX_BLP:begin//tx hs start packet
					O_hs_en<=1;
					if(I_lcd_de) begin
						O_hs_rgb_lane0<=I_lcd_rgb_lane0;
						O_hs_rgb_lane1<=I_lcd_rgb_lane1;
						O_hs_rgb_lane2<=I_lcd_rgb_lane2;
						O_hs_rgb_lane3<=I_lcd_rgb_lane3;
					end
					else begin
						Fsm_mipi_hs<=STATE_TX_VIDEO;
						O_hs_rgb_lane0<=8'h3e;
						O_hs_rgb_lane1<=8'h80;
						O_hs_rgb_lane2<=8'h16;
						O_hs_rgb_lane3<=8'h3b;
					end
				end
				STATE_TX_VIDEO:begin
					O_hs_en<=1;
					if(I_lcd_de)begin//tx video data
						O_hs_rgb_lane0<=I_lcd_rgb_lane0;
						O_hs_rgb_lane1<=I_lcd_rgb_lane1;
						O_hs_rgb_lane2<=I_lcd_rgb_lane2;
						O_hs_rgb_lane3<=I_lcd_rgb_lane3;
					end
					else if(I_lcd_de_reg)begin//tx video crc
						Fsm_mipi_hs<=STATE_IDLE;
						O_hs_rgb_lane0<=Crc_long_packet[7:0];
						O_hs_rgb_lane1<=Crc_long_packet[15:8];
						O_hs_rgb_lane2<=0;
						O_hs_rgb_lane3<=0;
					end
				end
				default:begin
					Fsm_mipi_hs<=STATE_IDLE;
				end
			endcase
		end 
	end
//***************************************************//
endmodule 

// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] mipi_data_rd.v
//   \ \  / /\ \  / /    [Description ] read mipi data from SDRAM 
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

module mipi_data_rd_ctrl (
								input							I_lcd_clk,//60MHz
								input							I_rst_n,
								//MIPI PACKET SIDE
							  //Outputs
                			output 						O_lcd_de,
                			output 						O_lcd_hs,
                			output 						O_lcd_vs,
                			output [7:0]				O_lcd_rgb_lane0,
                			output [7:0]				O_lcd_rgb_lane1,
                			output [7:0]				O_lcd_rgb_lane2,
                			output [7:0]				O_lcd_rgb_lane3,
                			output reg[2:0]			O_lcd_tx_packet_type,
                			output reg					O_lcd_tx_valid_data_flag,
                			output reg					O_lcd_tx_packet_flag,

							  //LVDS SIDE
							 	//Inputs
								output 	O_rgb_lane0_rden,
								input 	I_empty_lane0,
								input 	[15:0]	I_rgb_lane0_data,

								output 	O_rgb_lane1_rden,
								input 	I_empty_lane1,
								input 	[15:0]	I_rgb_lane1_data,

								output 	O_rgb_lane2_rden,
								input 	I_empty_lane2,
								input 	[15:0]	I_rgb_lane2_data,

								output 	O_rgb_lane3_rden,
								input 	I_empty_lane3,
								input 	[15:0]	I_rgb_lane3_data,

								output reg	O_vshsde_rden,
								input 	I_empty_vshsde,
								input 	[7:0]	I_vshsde_ctrl,
								output  [2:0]test_mipi

								);

								
/*******************************************************************************
 *******************************************************************************/
	//parameter VSS 		=8'h0F;
	//parameter HSS 		=8'hF0;
	parameter DES_VALID		=8'hFF;
	parameter DES_INVALID	=8'h0F;
	parameter DVS_VALID		=8'hF0;


	parameter DATA_TYPE_HSS		=3'h1;
	parameter DATA_TYPE_BLP		=3'h2;
	parameter DATA_TYPE_VIDEO	=3'h3;
	parameter DATA_TYPE_VSS		=3'h4;

	parameter NUM_LINE_RD		=(`LCD_H_WIDTH*3)/8;

	parameter STATE_IDLE           	 	= 3'b000;
	parameter STATE_RD_CTRL		       	= 3'b001;
	parameter STATE_TX_HSS         		= 3'b010;
	parameter STATE_TX_BLP          		= 3'b011;
	parameter STATE_TX_VEDIO          	= 3'b100;
/*******************************************************************************
 * reg and wire definition
 *******************************************************************************/
	reg [7:0] 		Lcd_rgb_lane0_reg;
//	reg [15:0] 		Lcd_rgb_lane0_shift_reg[0:11];
	reg [7:0] 		Lcd_rgb_lane1_reg;
//	reg [15:0] 		Lcd_rgb_lane1_shift_reg[0:11];
	reg [7:0] 		Lcd_rgb_lane2_reg;
//	reg [15:0] 		Lcd_rgb_lane2_shift_reg[0:11];
	reg [7:0] 		Lcd_rgb_lane3_reg;
//	reg [15:0] 		Lcd_rgb_lane3_shift_reg[0:11];
	reg [15:0] 		I_rgb_lane0_data_reg;
	reg [15:0] 		I_rgb_lane1_data_reg;
	reg [15:0] 		I_rgb_lane2_data_reg;
	reg [15:0] 		I_rgb_lane3_data_reg;

//	reg [7:0]                     I_vshsde_ctrl_reg;
//	reg 									Lcd_hsync,Lcd_vsync;
	reg 									Lcd_de_rd,Lcd_de;
//	reg [15:0]                    Lcd_de_shift;
	reg 									Lcd_blp_rd;
	reg 									Lcd_de_rd_sw;
	reg 									Lcd_de_rden_ctrl;

	reg [2:0]                     Fsm_rgb_ctrl;

	reg [10:0]                    Count_line_rd;
	reg [3:0]                     Count_rd_blp;

	wire [7:0] 		Blp_0lane[0:14];
	wire [7:0] 		Blp_1lane[0:14];
	wire [7:0] 		Blp_2lane[0:14];
	wire [7:0] 		Blp_3lane[0:14];

assign test_mipi={Lcd_de_rd_sw,Lcd_blp_rd,Lcd_de_rd};
 /*********************************************
 **********************************************/
	assign O_lcd_rgb_lane0=Lcd_rgb_lane0_reg;
	assign O_lcd_rgb_lane1=Lcd_rgb_lane1_reg;
	assign O_lcd_rgb_lane2=Lcd_rgb_lane2_reg;
	assign O_lcd_rgb_lane3=Lcd_rgb_lane3_reg;

	//assign O_lcd_hs=Lcd_hsync;
	//assign O_lcd_vs=Lcd_vsync;
	assign O_lcd_hs=0;
	assign O_lcd_vs=0;
	assign O_lcd_de=Lcd_de;

	assign O_rgb_lane0_rden=Lcd_de_rden_ctrl;
	assign O_rgb_lane1_rden=Lcd_de_rden_ctrl;
	assign O_rgb_lane2_rden=Lcd_de_rden_ctrl;
	assign O_rgb_lane3_rden=Lcd_de_rden_ctrl;

	assign Blp_0lane[0]=8'h19;
	assign Blp_0lane[1]=8'h55;
	assign Blp_0lane[2]=8'h55;
	assign Blp_0lane[3]=8'h55;
	assign Blp_0lane[4]=8'h55;
	assign Blp_0lane[5]=8'h55;
	assign Blp_0lane[6]=8'h55;
	assign Blp_0lane[7]=8'h55;
	assign Blp_0lane[8]=8'h55;
	assign Blp_0lane[9]=8'h55;
	assign Blp_0lane[10]=8'h55;
	assign Blp_0lane[11]=8'h55;
	assign Blp_0lane[12]=8'h55;
	assign Blp_0lane[13]=8'h55;
	assign Blp_0lane[14]=8'h55;

	assign Blp_1lane[0]=8'h36;
	assign Blp_1lane[1]=8'h55;
	assign Blp_1lane[2]=8'h55;
	assign Blp_1lane[3]=8'h55;
	assign Blp_1lane[4]=8'h55;
	assign Blp_1lane[5]=8'h55;
	assign Blp_1lane[6]=8'h55;
	assign Blp_1lane[7]=8'h55;
	assign Blp_1lane[8]=8'h55;
	assign Blp_1lane[9]=8'h55;
	assign Blp_1lane[10]=8'h55;
	assign Blp_1lane[11]=8'h55;
	assign Blp_1lane[12]=8'h55;
	assign Blp_1lane[13]=8'h55;
	assign Blp_1lane[14]=8'h55;

	assign Blp_2lane[0]=8'h00;
	assign Blp_2lane[1]=8'h55;
	assign Blp_2lane[2]=8'h55;
	assign Blp_2lane[3]=8'h55;
	assign Blp_2lane[4]=8'h55;
	assign Blp_2lane[5]=8'h55;
	assign Blp_2lane[6]=8'h55;
	assign Blp_2lane[7]=8'h55;
	assign Blp_2lane[8]=8'h55;
	assign Blp_2lane[9]=8'h55;
	assign Blp_2lane[10]=8'h55;
	assign Blp_2lane[11]=8'h55;
	assign Blp_2lane[12]=8'h55;
	assign Blp_2lane[13]=8'h55;
	assign Blp_2lane[14]=8'h1c;


	assign Blp_3lane[0]=8'h2a;
	assign Blp_3lane[1]=8'h55;
	assign Blp_3lane[2]=8'h55;
	assign Blp_3lane[3]=8'h55;
	assign Blp_3lane[4]=8'h55;
	assign Blp_3lane[5]=8'h55;
	assign Blp_3lane[6]=8'h55;
	assign Blp_3lane[7]=8'h55;
	assign Blp_3lane[8]=8'h55;
	assign Blp_3lane[9]=8'h55;
	assign Blp_3lane[10]=8'h55;
	assign Blp_3lane[11]=8'h55;
	assign Blp_3lane[12]=8'h55;
	assign Blp_3lane[13]=8'h55;
	assign Blp_3lane[14]=8'h6d;

 /*********************************************
 //
 **********************8***********************/
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Fsm_rgb_ctrl<=STATE_IDLE;
			O_vshsde_rden<=0;
			Count_rd_blp<=0;
			Lcd_de_rd_sw<=0;
			Lcd_blp_rd<=0;
			O_lcd_tx_packet_type<=0;
			O_lcd_tx_valid_data_flag<=0;
			O_lcd_tx_packet_flag<=0;
		end
		else begin
			case(Fsm_rgb_ctrl)
				STATE_IDLE:begin//idle
					O_lcd_tx_packet_type<=0;
					O_lcd_tx_valid_data_flag<=0;
					O_lcd_tx_packet_flag<=0;
					Lcd_de_rd_sw<=0;
					Lcd_blp_rd<=0;
					Count_rd_blp<=0;
					if(~I_empty_vshsde)begin
						Fsm_rgb_ctrl<=STATE_RD_CTRL;//enter STATE_RD_CTRL
						O_vshsde_rden<=1;
					end
					else begin
						Fsm_rgb_ctrl<=STATE_IDLE;
						O_vshsde_rden<=0;
					end
				end
				STATE_RD_CTRL:begin
					O_vshsde_rden<=0;
					if(I_vshsde_ctrl==DES_VALID)begin//tx hss & video data
						Fsm_rgb_ctrl<=STATE_TX_HSS;
						O_lcd_tx_packet_type<=DATA_TYPE_HSS;
						O_lcd_tx_valid_data_flag<=1;
						O_lcd_tx_packet_flag<=1;
					end
					else if(I_vshsde_ctrl==DES_INVALID)begin//only tx hss
						Fsm_rgb_ctrl<=STATE_IDLE;
						O_lcd_tx_packet_type<=DATA_TYPE_HSS;
						O_lcd_tx_valid_data_flag<=0;
						O_lcd_tx_packet_flag<=1;
					end
					else if(I_vshsde_ctrl==DVS_VALID)begin//only tx hss
						Fsm_rgb_ctrl<=STATE_IDLE;
						O_lcd_tx_packet_type<=DATA_TYPE_VSS;
						O_lcd_tx_valid_data_flag<=0;
						O_lcd_tx_packet_flag<=1;
					end
					else
						Fsm_rgb_ctrl<=STATE_IDLE;
				end
				STATE_TX_HSS:begin
					O_lcd_tx_packet_flag<=1;
					Fsm_rgb_ctrl<=STATE_TX_BLP;
					O_lcd_tx_packet_type<=DATA_TYPE_BLP;
					Lcd_blp_rd<=1;
				end
				STATE_TX_BLP:begin
					if(Count_rd_blp<14) begin
						Count_rd_blp<=Count_rd_blp+1'b1;
						O_lcd_tx_packet_flag<=0;
					end
					else begin
						Lcd_blp_rd<=0;
						Fsm_rgb_ctrl<=STATE_TX_VEDIO;
						O_lcd_tx_packet_flag<=1;
						O_lcd_tx_packet_type<=DATA_TYPE_VIDEO;
					end
					if(Count_rd_blp==14)
						Lcd_de_rd_sw<=1;
					else
						Lcd_de_rd_sw<=0;
				end
				STATE_TX_VEDIO:begin
					Lcd_de_rd_sw<=0;
					O_lcd_tx_packet_flag<=0;
					Fsm_rgb_ctrl<=STATE_IDLE;
				end
				default:begin
					Fsm_rgb_ctrl<=STATE_IDLE;
				end
			endcase
		end 
	end
 /*******************************************************************************/
 //rd RGB data from fifo
 /*******************************************************************************/
 	always @(posedge I_lcd_clk or negedge I_rst_n)
	begin
   	if (~I_rst_n) begin 
			Count_line_rd<=NUM_LINE_RD-1;
			Lcd_de_rd<=0;
			Lcd_de_rden_ctrl<=0;
		end
		else begin
			if (Lcd_de_rd_sw)  begin                                    
				Count_line_rd<=0;
				Lcd_de_rd<=1;
				Lcd_de_rden_ctrl<=1;
			end   
			else begin
				if(Count_line_rd<NUM_LINE_RD*2-1) begin
					Count_line_rd<=Count_line_rd+1'b1;
				end
				if(Count_line_rd<NUM_LINE_RD*2-1) begin
					Lcd_de_rd<=1;
					Lcd_de_rden_ctrl<=~Lcd_de_rden_ctrl;
				end
				else begin
					Lcd_de_rd<=0;
					Lcd_de_rden_ctrl<=0;
				end
			end
		end
	end
 /*******************************************************************************/
 //shift LCD RGB data & de for N periods to match mipi transmission 
 /*******************************************************************************/
 	always @(posedge I_lcd_clk)
	begin
		I_rgb_lane0_data_reg<=I_rgb_lane0_data;
		I_rgb_lane1_data_reg<=I_rgb_lane1_data;
		I_rgb_lane2_data_reg<=I_rgb_lane2_data;
		I_rgb_lane3_data_reg<=I_rgb_lane3_data;
		
		
		if(~Lcd_blp_rd)begin
			if(Lcd_de_rden_ctrl) begin
			 Lcd_rgb_lane0_reg<=I_rgb_lane0_data[7:0];
			 Lcd_rgb_lane1_reg<=I_rgb_lane1_data[7:0];
			 Lcd_rgb_lane2_reg<=I_rgb_lane2_data[7:0];
			 Lcd_rgb_lane3_reg<=I_rgb_lane3_data[7:0];
			end
			else begin
			 Lcd_rgb_lane0_reg<=I_rgb_lane0_data_reg[15:8];
			 Lcd_rgb_lane1_reg<=I_rgb_lane1_data_reg[15:8];
			 Lcd_rgb_lane2_reg<=I_rgb_lane2_data_reg[15:8];
			 Lcd_rgb_lane3_reg<=I_rgb_lane3_data_reg[15:8];
			end
		  Lcd_de <= Lcd_de_rd;
		end
		else begin
		  Lcd_rgb_lane0_reg<=Blp_0lane[Count_rd_blp];
		  Lcd_rgb_lane1_reg<=Blp_1lane[Count_rd_blp];
		  Lcd_rgb_lane2_reg<=Blp_2lane[Count_rd_blp];
		  Lcd_rgb_lane3_reg<=Blp_3lane[Count_rd_blp];
		  Lcd_de <= Lcd_blp_rd;
		end
	end
endmodule 

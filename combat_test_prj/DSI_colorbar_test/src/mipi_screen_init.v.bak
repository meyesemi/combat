// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] mipi_screen_init.v
//   \ \  / /\ \  / /    [Description ] generate MIPI LCD initial data 
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
//`include "mcu2mipi_defines.v"


module mipi_screen_init (
								input														I_mipi_init_clk,//15MHz
								input														I_rst_n,
								input														I_mipi_screen_onoff,

								//MIPI_HS_LP_TX SIDE
							  //Outputs
                			output reg												O_init_done,
                			output reg[1:0]										O_init_lp_data,
                			output reg												O_VBL_on_sw,
                			output reg												O_PWMBL_on_sw


								);

								
	/*******************************************************************************
 * MIPI INIT FSM States defined
 *******************************************************************************/
	parameter STATE_IDLE           	 	 		= 5'b00000;
	parameter STATE_RST_PRE_WAIT_2MS         	= 5'b00001;
	parameter STATE_BL_WAIT100MS       			= 5'b00010;
	parameter STATE_RST_POST_WAIT_10MS  	 	= 5'b00011;
	parameter STATE_PACKET_START          		= 5'b00100;
	parameter STATE_PACKET_DATA 					= 5'b00101;
	parameter STATE_PACKET_END          		= 5'b00110;
	parameter STATE_WAIT_120MS          		= 5'b00111;
	parameter STATE_ON_DONE          			= 5'b01000;
	parameter STATE_OFF_DONE						= 5'b01001;
	
	
	/*******************************************************************************
	 * reg and wire definition
	 *******************************************************************************/
	reg [5:0] 	Fsm_mipi_init;
//	reg 			Clk_mipi_init;
//	reg 			Clk_mipi_init_delay;
//	reg [9:0] 	Count_delay_clk;

	reg [23:0] 	Count_mipi_init;
//	reg [6:0] 	Count_mipi_tx_byte;
//	reg [3:0] 	Count_mipi_tx_bit;
//	reg			Flag_packet_start;
	//wire 		I_mipi_screen_onoff;
//	wire [31:0]	Enter_escape_data;
//	wire [3:0] 	Exit_escape_data;
//	wire [7:0] 	Lp_data;
//	wire [31:0] Lp_encode_data;
//	wire [7:0] 	Dcs_data_mem [0:127];
	//wire  		Flag_init_count_rst;
 /*******************************************************************************/
	//assign I_mipi_screen_onoff=1;

/*assign Dcs_data_mem[0] = 8'h87;
assign Dcs_data_mem[1] = 8'h15;
assign Dcs_data_mem[2] = 8'h8f;
assign Dcs_data_mem[3] = 8'ha5;
assign Dcs_data_mem[4] = 8'h24;*/
//delay 5ms
/*
assign Dcs_data_mem[0] = 8'h87;//reset
assign Dcs_data_mem[1] = 8'h05;
assign Dcs_data_mem[2] = 8'h01;
assign Dcs_data_mem[3] = 8'h00;
assign Dcs_data_mem[4] = 8'h10;
//delay 20ms
*/
/*assign Dcs_data_mem[5] = 8'h87;//display off
assign Dcs_data_mem[6] = 8'h05;
assign Dcs_data_mem[7] = 8'h28;
assign Dcs_data_mem[8] = 8'h00;
assign Dcs_data_mem[9] = 8'h06;

assign Dcs_data_mem[5] = 8'h87;//reset
assign Dcs_data_mem[6] = 8'h15;
assign Dcs_data_mem[7] = 8'h01;
assign Dcs_data_mem[8] = 8'h00;
assign Dcs_data_mem[9] = 8'h03;*/


/*assign Dcs_data_mem[10] = 8'h87;
assign Dcs_data_mem[11] = 8'h15;
assign Dcs_data_mem[12] = 8'h8f;
assign Dcs_data_mem[13] = 8'ha5;
assign Dcs_data_mem[14] = 8'h24;


assign Dcs_data_mem[15] = 8'h87;
assign Dcs_data_mem[16] = 8'h15;
assign Dcs_data_mem[17] = 8'h83;
assign Dcs_data_mem[18] = 8'haa;
assign Dcs_data_mem[19] = 8'h2d;

assign Dcs_data_mem[20] = 8'h87;
assign Dcs_data_mem[21] = 8'h15;
assign Dcs_data_mem[22] = 8'h84;
assign Dcs_data_mem[23] = 8'h11;
assign Dcs_data_mem[24] = 8'h38;

assign Dcs_data_mem[25] = 8'h87;
assign Dcs_data_mem[26] = 8'h15;
assign Dcs_data_mem[27] = 8'ha9;
assign Dcs_data_mem[28] = 8'h4b;
assign Dcs_data_mem[29] = 8'h2f;


assign Dcs_data_mem[30] = 8'h87;
assign Dcs_data_mem[31] = 8'h15;
assign Dcs_data_mem[32] = 8'h83;
assign Dcs_data_mem[33] = 8'h00;
assign Dcs_data_mem[34] = 8'h33;

assign Dcs_data_mem[35] = 8'h87;
assign Dcs_data_mem[36] = 8'h15;
assign Dcs_data_mem[37] = 8'h84;
assign Dcs_data_mem[38] = 8'h00;
assign Dcs_data_mem[39] = 8'h16;

assign Dcs_data_mem[40] = 8'h87;
assign Dcs_data_mem[41] = 8'h15;
assign Dcs_data_mem[42] = 8'h8f;
assign Dcs_data_mem[43] = 8'h00;
assign Dcs_data_mem[44] = 8'h35;*/

/*
assign Dcs_data_mem[5] = 8'h87;//sleep out
assign Dcs_data_mem[6] = 8'h05;
assign Dcs_data_mem[7] = 8'h11;
assign Dcs_data_mem[8] = 8'h00;
assign Dcs_data_mem[9] = 8'h36;

assign Dcs_data_mem[10] = 8'h87;//display on
assign Dcs_data_mem[11] = 8'h05;
assign Dcs_data_mem[12] = 8'h29;
assign Dcs_data_mem[13] = 8'h00;
assign Dcs_data_mem[14] = 8'h1C;
*/
/*
	assign Dcs_data_mem[45] = 8'h87;//SLEEP OUT
	assign Dcs_data_mem[46] = 8'h15;
	assign Dcs_data_mem[47] = 8'h11;
	assign Dcs_data_mem[48] = 8'h00;
	assign Dcs_data_mem[49] = 8'h25;
	
	assign Dcs_data_mem[50] = 8'h87;//DISPLAY ON
	assign Dcs_data_mem[51] = 8'h15;
	assign Dcs_data_mem[52] = 8'h29;
	assign Dcs_data_mem[53] = 8'h00;
	assign Dcs_data_mem[54] = 8'h0F;
*/
/*
assign Dcs_data_mem[15] = 8'h87;

	//convert single bit to double bit(0=>01;1=>10) and  RZ code
	assign Lp_encode_data[31:30] = Lp_data[0] ? 2'b10 : 2'b01;
	assign Lp_encode_data[29:28] = 2'b00;                  
	assign Lp_encode_data[27:26] = Lp_data[1] ? 2'b10 : 2'b01;
	assign Lp_encode_data[25:24] = 2'b00;                  
	assign Lp_encode_data[23:22] = Lp_data[2] ? 2'b10 : 2'b01;
	assign Lp_encode_data[21:20] = 2'b00;                  
	assign Lp_encode_data[19:18] = Lp_data[3] ? 2'b10 : 2'b01;
	assign Lp_encode_data[17:16] = 2'b00;                  
	assign Lp_encode_data[15:14] = Lp_data[4] ? 2'b10 : 2'b01;
	assign Lp_encode_data[13:12] = 2'b00;                  
	assign Lp_encode_data[11:10] = Lp_data[5] ? 2'b10 : 2'b01;
	assign Lp_encode_data[9:8]   = 2'b00;                  
	assign Lp_encode_data[7:6]   = Lp_data[6] ? 2'b10 : 2'b01;
	assign Lp_encode_data[5:4]   = 2'b00;                  
	assign Lp_encode_data[3:2]   = Lp_data[7] ? 2'b10 : 2'b01;
	assign Lp_encode_data[1:0]   = 2'b00; 
	
  assign Enter_escape_data = 32'b1111_1111_1111_1111_1111_1111_1000_0100; //enter escape mode
  assign Exit_escape_data 	= 4'b1011; //exit escape mode
  assign Lp_data=Dcs_data_mem[Count_mipi_tx_byte];*/
 /*******************************************************************************/
 //control to output hp&lp signal(O_hs_data_en)  
 /*******************************************************************************/ 

	always @(posedge I_mipi_init_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Fsm_mipi_init<=STATE_IDLE;
			O_init_done<=0;
//			Count_mipi_tx_byte<=0;
//			Count_mipi_tx_bit<=0;
			O_init_lp_data<=2'b11;
//			Flag_packet_start<=0;
			O_VBL_on_sw<=0;
			O_PWMBL_on_sw<=0;
		end
		else begin
			case(Fsm_mipi_init)
				STATE_IDLE:begin
					O_init_lp_data<=2'b11;
					O_init_done<=0;
					O_VBL_on_sw<=0;
					O_PWMBL_on_sw<=0;
//					Count_mipi_tx_byte<=0;
//					Count_mipi_tx_bit<=0;
					Fsm_mipi_init<=STATE_RST_POST_WAIT_10MS;
				end
				STATE_RST_POST_WAIT_10MS:begin//delay 500ms, then enter initial data send stage
//					if(Count_mipi_init==8000000) begin//227575
					if(Count_mipi_init==80000) begin//227575
						Fsm_mipi_init<=STATE_BL_WAIT100MS;
					end
					else
						Fsm_mipi_init<=STATE_RST_POST_WAIT_10MS;
				end
				/*STATE_PACKET_START:begin//initial data send
					Count_mipi_tx_bit<=Count_mipi_tx_bit+1;
					O_init_lp_data[1]<=Enter_escape_data[31-2*Count_mipi_tx_bit];
					O_init_lp_data[0]<=Enter_escape_data[30-2*Count_mipi_tx_bit];
					if(Count_mipi_tx_bit==15) begin
						Fsm_mipi_init<=STATE_PACKET_DATA;
					end
					else
						Fsm_mipi_init<=STATE_PACKET_START;
				end
				STATE_PACKET_DATA:begin
					Count_mipi_tx_bit<=Count_mipi_tx_bit+1;
					if(Count_mipi_tx_bit==15)
						Count_mipi_tx_byte<=Count_mipi_tx_byte+1;
		
					if(Count_mipi_tx_bit==0)begin
						if(Lp_data==8'h87)begin
							Flag_packet_start<=1;
							if(Flag_packet_start) begin
								Fsm_mipi_init<=STATE_PACKET_END;
								O_init_lp_data[1]<=Exit_escape_data[3];
								O_init_lp_data[0]<=Exit_escape_data[2];
							end
							else begin
								Fsm_mipi_init<=STATE_PACKET_DATA;
								O_init_lp_data[1]<=Lp_encode_data[31-2*Count_mipi_tx_bit];
								O_init_lp_data[0]<=Lp_encode_data[30-2*Count_mipi_tx_bit];
							end
						end
						else begin
							Fsm_mipi_init<=STATE_PACKET_DATA;
							O_init_lp_data[1]<=Lp_encode_data[31-2*Count_mipi_tx_bit];
							O_init_lp_data[0]<=Lp_encode_data[30-2*Count_mipi_tx_bit];
						end
					end
					else begin
						Fsm_mipi_init<=STATE_PACKET_DATA;
						O_init_lp_data[1]<=Lp_encode_data[31-2*Count_mipi_tx_bit];
						O_init_lp_data[0]<=Lp_encode_data[30-2*Count_mipi_tx_bit];
					end
				end
				STATE_PACKET_END:begin
					O_init_lp_data[1]<=Exit_escape_data[1];
					O_init_lp_data[0]<=Exit_escape_data[0];
					Fsm_mipi_init<=STATE_WAIT_120MS;
				end
				STATE_WAIT_120MS:begin
					Flag_packet_start<=0;
					if(Count_mipi_tx_byte==5)begin //delay 5ms
						if(Count_mipi_init==400000)
							Fsm_mipi_init<=STATE_PACKET_START;
						else
							Fsm_mipi_init<=STATE_WAIT_120MS;
					end
					else if(Count_mipi_tx_byte==10)begin//delay 20ms
						if(Count_mipi_init==400000)
							Fsm_mipi_init<=STATE_PACKET_START;
						else
							Fsm_mipi_init<=STATE_WAIT_120MS;
					end
					else if(Count_mipi_tx_byte==15)begin//delay 40ms
						if(Count_mipi_init==1000000)
							Fsm_mipi_init<=STATE_BL_WAIT100MS;
						else
							Fsm_mipi_init<=STATE_WAIT_120MS;
					end
				end*/
				STATE_BL_WAIT100MS:begin
					O_init_done<=1;
//					if(Count_mipi_init==9000000)
					if(Count_mipi_init==90000)
						Fsm_mipi_init<=STATE_ON_DONE;
					else
						Fsm_mipi_init<=STATE_BL_WAIT100MS;

//					if(Count_mipi_init==8500000)
					if(Count_mipi_init==85000)
						O_PWMBL_on_sw<=1;
				end
				STATE_ON_DONE:begin
					O_VBL_on_sw<=1;
				end
				default:begin
					Fsm_mipi_init<=STATE_IDLE;
					O_init_done<=0;
				end
			endcase
		end 
	end
 /*******************************************************************************/
 // Count_mipi_init
 /*******************************************************************************/ 
	always @(posedge I_mipi_init_clk or negedge I_rst_n) 
	begin
		if (~I_rst_n) begin 
			Count_mipi_init<=0;
		end
		else begin
			/*if(Fsm_mipi_init==STATE_PACKET_START||Fsm_mipi_init==STATE_IDLE)
				Count_mipi_init<=0;
			else if(Fsm_mipi_init==STATE_RST_POST_WAIT_10MS || Fsm_mipi_init==STATE_WAIT_120MS || Fsm_mipi_init==STATE_BL_WAIT100MS)
				Count_mipi_init<=Count_mipi_init+1;
			else
				Count_mipi_init<=Count_mipi_init;*/

			if(Fsm_mipi_init==STATE_IDLE)
				Count_mipi_init<=0;
			else if(Fsm_mipi_init==STATE_RST_POST_WAIT_10MS || Fsm_mipi_init==STATE_BL_WAIT100MS)
				Count_mipi_init<=Count_mipi_init+1;
			else
				Count_mipi_init<=Count_mipi_init;
		end 
	end

endmodule 

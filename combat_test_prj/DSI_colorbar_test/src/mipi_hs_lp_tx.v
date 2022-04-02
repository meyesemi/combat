// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] mipi_hs_lp_tx.v
//   \ \  / /\ \  / /    [Description ] hs & lp tx control 
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


module mipi_hs_lp_tx (
							  input													I_lcd_clk,//25MHz
							  input													I_rst_n,
							  //MIPI_PACKET_CONTROL SIDE
							  //Inputs
                       input 													I_hs_en,
                       input [7:0] 										I_hs_rgb_lane0,
                       input [7:0] 										I_hs_rgb_lane1,
                       input [7:0] 										I_hs_rgb_lane2,
                       input [7:0] 										I_hs_rgb_lane3,
								//MIPI_INIT_CONTROL
							  //Inputs
                       input 													I_init_done,
                       input [1:0]											I_init_lp_data,
								//MIPI DSI PHY SIDE
							 	//Outputs
                       output reg											O_hs_clk_en,
                       output reg											O_hs_data_en,
                       output [7:0] 										O_hs_data_lane0,
                       output [7:0] 										O_hs_data_lane1,
                       output [7:0] 										O_hs_data_lane2,
                       output [7:0] 										O_hs_data_lane3,
                       output [1:0]											O_lp_data_lane0,
                       output [1:0]											O_lp_data_lane1,
                       output [1:0]											O_lp_data_lane2,
                       output [1:0]											O_lp_data_lane3,
                       output [1:0]											O_lp_clk

								);

								
/*******************************************************************************
 * hs&lp Data Delay and Clk Delay parameter
 *******************************************************************************/
	parameter LP_01_CLK_DLY 		= 8;
	parameter LP_00_CLK_DLY 		= 8;
	parameter HS_ZERO_CLK_DLY     = 30;
	parameter HS_PRE_CLK_DLY 	   = 2;

	parameter LP_01_DATA_DLY 		= 8;
	parameter LP_00_DATA_DLY 		= 8;
	parameter HS_ZERO_DATA_DLY 	= 16;
	parameter HS_TRAIL_DATA_DLY 	= 8; 
	parameter HS_POST_CLK_DLY 	   = 14;
	parameter HS_TRAIL_CLK_DLY    = 8;
	//hs tx start
	parameter LP_01_CLK_S			= 0;
	parameter LP_00_CLK_S			= LP_01_CLK_DLY;
	parameter HS_ZERO_CLK_S 		= LP_01_CLK_DLY + LP_00_CLK_DLY;
	//parameter HS_PRE_CLK_S  		= LP_01_CLK_DLY + LP_00_CLK_DLY + HS_ZERO_CLK_DLY;
	parameter LP_01_DATA_S 		= LP_01_CLK_DLY + LP_00_CLK_DLY + HS_ZERO_CLK_DLY + HS_PRE_CLK_DLY;
	parameter LP_00_DATA_S	 		= LP_01_CLK_DLY + LP_00_CLK_DLY + HS_ZERO_CLK_DLY + HS_PRE_CLK_DLY + LP_01_DATA_DLY;
	parameter HS_ZERO_DATA_S 	   = LP_01_CLK_DLY + LP_00_CLK_DLY + HS_ZERO_CLK_DLY + HS_PRE_CLK_DLY + LP_01_DATA_DLY+LP_00_DATA_DLY;
	parameter HS_DATA_S 			= LP_01_CLK_DLY + LP_00_CLK_DLY + HS_ZERO_CLK_DLY + HS_PRE_CLK_DLY + LP_01_DATA_DLY+LP_00_DATA_DLY+HS_ZERO_DATA_DLY;
	
	//hs tx end
	parameter LP_11_DATA_E 		= HS_TRAIL_DATA_DLY+HS_DATA_S;
	//parameter HS_TRAIL_CLK_E 	   = HS_TRAIL_DATA_DLY + HS_POST_CLK_DLY +HS_DATA_S;
	parameter LP_11_CLK_E 			= HS_TRAIL_DATA_DLY + HS_POST_CLK_DLY + HS_TRAIL_CLK_DLY + HS_DATA_S;
	/*******************************************************************************
 	*MIPI HS&LP TX CONTROL FSM definitation
 	*******************************************************************************/
	parameter STATE_IDLE          	= 3'b000;
	parameter STATE_LP_INIT          = 3'b001;
	parameter STATE_HS_IDLE         	= 3'b010;
	parameter STATE_HS_START         = 3'b011;
	parameter STATE_HS_DATA          = 3'b100;
	parameter STATE_HS_END          	= 3'b101;
	
	
	/*******************************************************************************
	 * reg and wire definition
	 *******************************************************************************/
	reg [7:0] Rgb_d_hold_Reg0 [0:HS_DATA_S];
	reg [7:0] Rgb_d_hold_Reg1 [0:HS_DATA_S];
	reg [7:0] Rgb_d_hold_Reg2 [0:HS_DATA_S];
	reg [7:0] Rgb_d_hold_Reg3 [0:HS_DATA_S];

	reg [1:0] Lp_data_lane0_reg;
	reg [1:0] Lp_data_lane1_reg;
	reg [1:0] Lp_data_lane2_reg;
	reg [1:0] Lp_data_lane3_reg;


	reg [1:0] Lp_clk_reg;
	reg  		 Hs_en_reg;
	reg [7:0] Count_hs_tx_start;
	reg [7:0] Count_hs_tx_end;
	reg [7:0] i;
	wire  	 Hs_en_start;
	wire  	 Hs_en_end;
	
 /*******************************************************************************/
	assign Hs_en_start=! Hs_en_reg&& I_hs_en;
	assign Hs_en_end=Hs_en_reg&& ! I_hs_en;
	
	assign O_lp_clk=Lp_clk_reg;
	assign O_lp_data_lane0=I_init_done?Lp_data_lane0_reg:I_init_lp_data;
	assign O_lp_data_lane1=Lp_data_lane1_reg;
	assign O_lp_data_lane2=Lp_data_lane2_reg;
	assign O_lp_data_lane3=Lp_data_lane3_reg;

	assign O_hs_data_lane0=Rgb_d_hold_Reg0[HS_DATA_S];
	assign O_hs_data_lane1=Rgb_d_hold_Reg1[HS_DATA_S];
	assign O_hs_data_lane2=Rgb_d_hold_Reg2[HS_DATA_S];
	assign O_hs_data_lane3=Rgb_d_hold_Reg3[HS_DATA_S];
 /*******************************************************************************/
 //shift I_hs_rgb to Rgb_d_hold_Reg one by one 
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk) 
	begin
	   Hs_en_reg<=I_hs_en;
	end
	
 /*******************************************************************************/
 //shift I_hs_rgb to Rgb_d_hold_Reg one by one 
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk) 
	begin
	   for(i=1;i<=HS_DATA_S;i=i+1)begin
		  Rgb_d_hold_Reg0[i]<=Rgb_d_hold_Reg0[i-1];
		  Rgb_d_hold_Reg0[0]<=I_hs_rgb_lane0;
		  Rgb_d_hold_Reg1[i]<=Rgb_d_hold_Reg1[i-1];
		  Rgb_d_hold_Reg1[0]<=I_hs_rgb_lane1;
		  Rgb_d_hold_Reg2[i]<=Rgb_d_hold_Reg2[i-1];
		  Rgb_d_hold_Reg2[0]<=I_hs_rgb_lane2;
		  Rgb_d_hold_Reg3[i]<=Rgb_d_hold_Reg3[i-1];
		  Rgb_d_hold_Reg3[0]<=I_hs_rgb_lane3;
		end
	end
	/*******************************************************************************/
 //generate Count_hs_tx_start  based on I_hs_en signal
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Count_hs_tx_start<=0;
		end
		else begin
			if(Hs_en_start)begin
				Count_hs_tx_start<=0;
			end
			else if(Count_hs_tx_start<150)begin
				Count_hs_tx_start<=Count_hs_tx_start+1;
			end
			else
				Count_hs_tx_start<=Count_hs_tx_start;
		end
	end
 /*******************************************************************************/
 //generate Count_hs_tx_end  based on I_hs_en signal
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Count_hs_tx_end<=0;
		end
		else begin
			if(Hs_en_end)begin
				Count_hs_tx_end<=0;
			end
			else if(Count_hs_tx_end<150)begin
				Count_hs_tx_end<=Count_hs_tx_end+1;
			end
			else
				Count_hs_tx_end<=Count_hs_tx_end;
		end
	end
 /*******************************************************************************/
 //control to output hp&lp signal(O_hs_clk_en)  
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			O_hs_clk_en<=0;
		end
		else begin
			if(~I_init_done)begin
				O_hs_clk_en<=0;
			end
			else begin
				if(Count_hs_tx_start==HS_ZERO_CLK_S)
					O_hs_clk_en<=1;
				else if(Count_hs_tx_end==LP_11_CLK_E)
					O_hs_clk_en<=0;
			end
		end
	end
 /*******************************************************************************/
 //control to output hp&lp signal(O_hs_data_en)  
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			O_hs_data_en<=0;
		end
		else begin
			if(~I_init_done)begin
				O_hs_data_en<=0;
			end
			else begin
				if(Count_hs_tx_start==HS_ZERO_DATA_S)
					O_hs_data_en<=1;
				else if(Count_hs_tx_end==LP_11_DATA_E)
					O_hs_data_en<=0;
			end
		end 
	end
 /*******************************************************************************/
 //control to output hp&lp signal(Lp_clk_reg)  
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Lp_clk_reg<=2'b11;
		end
		else begin
			if(~I_init_done)begin
				Lp_clk_reg<=2'b11;
			end
			else begin
				if(Count_hs_tx_start==LP_01_CLK_S)
					Lp_clk_reg<=2'b01;
				else if(Count_hs_tx_start==LP_00_CLK_S)
					Lp_clk_reg<=2'b00;
				else if(Count_hs_tx_end==LP_11_CLK_E)
					Lp_clk_reg<=2'b11;
			end
		end
	end
 /*******************************************************************************/
 //control to output hp&lp signal(Lp_data_reg)  
 /*******************************************************************************/ 
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Lp_data_lane0_reg<=2'b11;
			Lp_data_lane1_reg<=2'b11;
			Lp_data_lane2_reg<=2'b11;
			Lp_data_lane3_reg<=2'b11;
		end
		else begin
			if(~I_init_done)begin
				Lp_data_lane0_reg<=2'b11;
				Lp_data_lane1_reg<=2'b11;
				Lp_data_lane2_reg<=2'b11;
				Lp_data_lane3_reg<=2'b11;
			end
			else begin
				if(Count_hs_tx_start==LP_01_DATA_S)begin
					Lp_data_lane0_reg<=2'b01;
					Lp_data_lane1_reg<=2'b01;
					Lp_data_lane2_reg<=2'b01;
					Lp_data_lane3_reg<=2'b01;
				end
				else if(Count_hs_tx_start==LP_00_DATA_S)begin
					Lp_data_lane0_reg<=2'b00;
					Lp_data_lane1_reg<=2'b00;
					Lp_data_lane2_reg<=2'b00;
					Lp_data_lane3_reg<=2'b00;
				end
				else if(Count_hs_tx_end==LP_11_DATA_E)begin
					Lp_data_lane0_reg<=2'b11;
					Lp_data_lane1_reg<=2'b11;
					Lp_data_lane2_reg<=2'b11;
					Lp_data_lane3_reg<=2'b11;
				end
			end
		end 
	end
 /*******************************************************************************/ 

endmodule 

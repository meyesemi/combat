// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] mipi_dsi_module.v
//   \ \  / /\ \  / /    [Description ] mipi dsi module 
//    \ \/ /  \ \/ /     [Timestamp   ] Wednesday March 12 10:00:30 2017
//     \  /    \  /      [version     ] 1.0.0
//      \/      \/       
//
// ===========Oooo==========================================Oooo========
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author |Mod. Date |Changes Made:
// V1.0 | GQG    |08/15/17  |Initial version
// ===========Oooo==========================================Oooo========
`timescale 100 ps / 100 ps
//`include "mcu2mipi_defines.v"


module mipi_dsi_top(
								input														I_lcd_clk,//60MHz
								input														I_rst_n,
							  //LVDS SIDE
							 	//Inputs/Outputs
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

								output 	O_vshsde_rden,
								input 	I_empty_vshsde,
								input 	[7:0]	I_vshsde_ctrl,
								//test
								//output 			O_data_rden,

								//MIPI_LCD SIDE
							 	//Outputs
								output 			O_hs_clk_en,
								output 			O_hs_data_en,
								output [7:0] 	O_hs_lane0_data,
								output [7:0] 	O_hs_lane1_data,
								output [7:0] 	O_hs_lane2_data,
								output [7:0] 	O_hs_lane3_data,
								output [1:0]	O_lp_data_lane0,
								output [1:0]	O_lp_data_lane1,
								output [1:0]	O_lp_data_lane2,
								output [1:0]	O_lp_data_lane3,
								output [1:0]	O_lp_clk,
								output 			O_VBL_on_sw,
								output 			O_PWMBL_on_sw,
								output 	[2:0]	test_mipi


				);
	//*******************************************************//
	//wire
	//*******************************************************//
  	wire 						Lcd_de;
  	wire 						Lcd_hs;
  	wire 						Lcd_hs_rgb;
  	wire 						Lcd_vs;
  	wire [7:0]				Lcd_rgb_lane0;
  	wire [7:0]				Lcd_rgb_lane1;
  	wire [7:0]				Lcd_rgb_lane2;
  	wire [7:0]				Lcd_rgb_lane3;
  	wire [2:0]				Lcd_tx_packet_type;
  	wire 						Lcd_tx_valid_data_flag;
  	wire 						Lcd_tx_packet_flag;
  	
  	wire 						Hs_en;
  	wire [7:0]				Hs_rgb_lane0;
  	wire [7:0]				Hs_rgb_lane1;
  	wire [7:0]				Hs_rgb_lane2;
  	wire [7:0]				Hs_rgb_lane3;
  
  	wire                 Init_done;
	wire [1:0]				Init_lp_data;
	
	reg	I_mipi_init_clk;
	reg	[1:0]Count_mipi_init_clk;

	//assign O_init_done=Init_done;
	//assign O_data_rden= Lcd_de;
	//*******************************************************//
	always @(posedge I_lcd_clk or negedge I_rst_n) 
	begin
    if(!I_rst_n) begin
		Count_mipi_init_clk<=0;
		I_mipi_init_clk<=0;
		end
    else begin
		Count_mipi_init_clk<=Count_mipi_init_clk+1;
		if(Count_mipi_init_clk==1)
			I_mipi_init_clk<=~I_mipi_init_clk;
		else if(Count_mipi_init_clk==3)
			I_mipi_init_clk<=~I_mipi_init_clk;
		else
			I_mipi_init_clk<=I_mipi_init_clk;
    end
	end
	//*******************************************************//
	//MIPI侧读出控制信息后，所有的节拍向后顺延一个HS间隔时间，来保证读rgb数据连续。
	mipi_data_rd_ctrl	mipi_data_rd_ctrl_inst(
					.I_lcd_clk(I_lcd_clk),
					.I_rst_n(I_rst_n), 
					
					.O_lcd_de(Lcd_de), 
					.O_lcd_hs(Lcd_hs), 
					.O_lcd_vs(lcd_vs), 
					.O_lcd_rgb_lane0(Lcd_rgb_lane0), 
					.O_lcd_rgb_lane1(Lcd_rgb_lane1), 
					.O_lcd_rgb_lane2(Lcd_rgb_lane2), 
					.O_lcd_rgb_lane3(Lcd_rgb_lane3), 
					.O_lcd_tx_packet_type(Lcd_tx_packet_type), 
					.O_lcd_tx_valid_data_flag(Lcd_tx_valid_data_flag), 
					.O_lcd_tx_packet_flag(Lcd_tx_packet_flag), 

					.O_rgb_lane0_rden(O_rgb_lane0_rden),
					.I_empty_lane0(I_empty_lane0), 
					.I_rgb_lane0_data(I_rgb_lane0_data), 
					.O_rgb_lane1_rden(O_rgb_lane1_rden),
					.I_empty_lane1(I_empty_lane1), 
					.I_rgb_lane1_data(I_rgb_lane1_data), 
					.O_rgb_lane2_rden(O_rgb_lane2_rden),
					.I_empty_lane2(I_empty_lane2), 
					.I_rgb_lane2_data(I_rgb_lane2_data), 
					.O_rgb_lane3_rden(O_rgb_lane3_rden),
					.I_empty_lane3(I_empty_lane3), 
					.I_rgb_lane3_data(I_rgb_lane3_data), 
					
					.O_vshsde_rden(O_vshsde_rden),
					.I_empty_vshsde(I_empty_vshsde), 
					.I_vshsde_ctrl(I_vshsde_ctrl),
                    .test_mipi(test_mipi)
 				);	
 				
	mipi_packetizer	mipi_packetizer_inst(
					.I_lcd_clk(I_lcd_clk),
					.I_rst_n(I_rst_n), 
					
					.I_lcd_de(Lcd_de), 
					.I_lcd_hs(Lcd_hs), 
					.I_lcd_vs(lcd_vs), 
					.I_lcd_rgb_lane0(Lcd_rgb_lane0), 
					.I_lcd_rgb_lane1(Lcd_rgb_lane1), 
					.I_lcd_rgb_lane2(Lcd_rgb_lane2), 
					.I_lcd_rgb_lane3(Lcd_rgb_lane3), 
					.I_lcd_tx_packet_type(Lcd_tx_packet_type), 
					.I_lcd_tx_valid_data_flag(Lcd_tx_valid_data_flag), 
					.I_lcd_tx_packet_flag(Lcd_tx_packet_flag), 
					
					.O_hs_en(Hs_en), 
					.O_hs_rgb_lane0(Hs_rgb_lane0),
					.O_hs_rgb_lane1(Hs_rgb_lane1),
					.O_hs_rgb_lane2(Hs_rgb_lane2),
					.O_hs_rgb_lane3(Hs_rgb_lane3)
 				);

	mipi_screen_init	mipi_screen_init_inst(
					.I_mipi_init_clk(I_mipi_init_clk),
					.I_rst_n(I_rst_n),
					.I_mipi_screen_onoff(1'b1),
					
					.O_init_done(Init_done), 
					.O_init_lp_data(Init_lp_data),
					.O_VBL_on_sw(O_VBL_on_sw),
					.O_PWMBL_on_sw(O_PWMBL_on_sw)
		
 				);

	mipi_hs_lp_tx	mipi_hs_lp_tx_inst(
					.I_lcd_clk(I_lcd_clk),
					.I_rst_n(I_rst_n),
					
					.I_hs_en(Hs_en),
					.I_hs_rgb_lane0(Hs_rgb_lane0), 
					.I_hs_rgb_lane1(Hs_rgb_lane1), 
					.I_hs_rgb_lane2(Hs_rgb_lane2), 
					.I_hs_rgb_lane3(Hs_rgb_lane3), 
					
					.I_init_done(Init_done), 
					//.I_init_done(1'b0), 
					.I_init_lp_data(Init_lp_data),
					
					.O_hs_clk_en(O_hs_clk_en), 
					.O_hs_data_en(O_hs_data_en),
					.O_hs_data_lane0(O_hs_lane0_data),
					.O_hs_data_lane1(O_hs_lane1_data),
					.O_hs_data_lane2(O_hs_lane2_data),
					.O_hs_data_lane3(O_hs_lane3_data),
					.O_lp_data_lane0(O_lp_data_lane0), 
					.O_lp_data_lane1(O_lp_data_lane1), 
					.O_lp_data_lane2(O_lp_data_lane2), 
					.O_lp_data_lane3(O_lp_data_lane3), 
					.O_lp_clk(O_lp_clk)
					
 				);
	//*******************************************************//
endmodule

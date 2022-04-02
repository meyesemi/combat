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
//`include "mcu2mipi_defines.v"

module rgb_data_asyfifo (
								input														I_sclk,//69MHz
								input														I_lcd_clk,//60MHz
								input														I_rst_n,
								//LVDS SIDE
							  //Inputs
								input 	I_rgb_lane0_wren,
								input 	[15:0]I_rgb_lane0_data,
								input 	I_rgb_lane1_wren,
								input 	[15:0]I_rgb_lane1_data,
								input 	I_rgb_lane2_wren,
								input 	[15:0]I_rgb_lane2_data,
								input 	I_rgb_lane3_wren,
								input 	[15:0]I_rgb_lane3_data,

								input 	I_vshsde_wren,
								input 	[7:0]I_vshsde_ctrl,
								//MIPI SIDE
							 	//Outputs
								input 	I_rgb_lane0_rden,
								output 	O_empty_lane0,
								output 	[15:0]	O_rgb_lane0_data,

								input 	I_rgb_lane1_rden,
								output 	O_empty_lane1,
								output 	[15:0]	O_rgb_lane1_data,

								input 	I_rgb_lane2_rden,
								output 	O_empty_lane2,
								output 	[15:0]	O_rgb_lane2_data,

								input 	I_rgb_lane3_rden,
								output 	O_empty_lane3,
								output 	[15:0]	O_rgb_lane3_data,

								input 	I_vshsde_rden,
								output 	O_empty_vshsde,
								output 	[7:0]	O_vshsde_ctrl
								);
	/*******************************************************************************
	 * reg and wire definition
	 *******************************************************************************/
 /*******************************************************************************/


 /*******************************************************************************/
 //rgb data
 /*******************************************************************************/
//lane0 
	afifo #(
	  .DATASIZE      (16),
	  .ADDRSIZE      (10)
	)afifo_lane0(
	  .rdata(O_rgb_lane0_data), 
	  .full(), 
	  .afull(),
	  .empty(O_empty_lane0),
	  .aempty(),
	  .wdata(I_rgb_lane0_data),
	  .wen(I_rgb_lane0_wren), 
	  .wclk(I_sclk), 
	  .wrst_n(I_rst_n), 
	  .ren(I_rgb_lane0_rden), 
	  .rclk(I_lcd_clk), 
	  .rrst_n(I_rst_n)
  );
//lane1 
	afifo #(
	  .DATASIZE      (16),
	  .ADDRSIZE      (10)
	)afifo_lane1(
	  .rdata(O_rgb_lane1_data), 
	  .full(), 
	  .afull(),
	  .empty(O_empty_lane1),
	  .aempty(),
	  .wdata(I_rgb_lane1_data),
	  .wen(I_rgb_lane1_wren), 
	  .wclk(I_sclk), 
	  .wrst_n(I_rst_n), 
	  .ren(I_rgb_lane1_rden), 
	  .rclk(I_lcd_clk), 
	  .rrst_n(I_rst_n)
  );
//lane2 
	afifo #(
	  .DATASIZE      (16),
	  .ADDRSIZE      (10)
	)afifo_lane2(
	  .rdata(O_rgb_lane2_data), 
	  .full(), 
	  .afull(),
	  .empty(O_empty_lane2),
	  .aempty(),
	  .wdata(I_rgb_lane2_data),
	  .wen(I_rgb_lane2_wren), 
	  .wclk(I_sclk), 
	  .wrst_n(I_rst_n), 
	  .ren(I_rgb_lane2_rden), 
	  .rclk(I_lcd_clk), 
	  .rrst_n(I_rst_n)
  );
//lane3 
	afifo #(
	  .DATASIZE      (16),
	  .ADDRSIZE      (10)
	)afifo_lane3(
	  .rdata(O_rgb_lane3_data), 
	  .full(), 
	  .afull(),
	  .empty(O_empty_lane3),
	  .aempty(),
	  .wdata(I_rgb_lane3_data),
	  .wen(I_rgb_lane3_wren), 
	  .wclk(I_sclk), 
	  .wrst_n(I_rst_n), 
	  .ren(I_rgb_lane3_rden), 
	  .rclk(I_lcd_clk), 
	  .rrst_n(I_rst_n)
  );
//vshsde 
	afifo #(
	  .DATASIZE      (8),
	  .ADDRSIZE      (6)
	)afifo_lane4(
	  .rdata(O_vshsde_ctrl), 
	  .full(), 
	  .afull(),
	  .empty(O_empty_vshsde),
	  .aempty(),
	  .wdata(I_vshsde_ctrl),
	  .wen(I_vshsde_wren), 
	  .wclk(I_sclk), 
	  .wrst_n(I_rst_n), 
	  .ren(I_vshsde_rden), 
	  .rclk(I_lcd_clk), 
	  .rrst_n(I_rst_n)
  );

 /*******************************************************************************/
 /*******************************************************************************/ 
endmodule 

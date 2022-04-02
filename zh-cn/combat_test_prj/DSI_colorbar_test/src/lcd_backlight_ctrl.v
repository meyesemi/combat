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


module lcd_backlight_ctrl (
								input														I_clk,//50MHz
								input														I_rst_n,
								input														I_PWMBL_on_sw,

							  //Outputs
                			output 												O_lcd_pwm
								);

	reg[15:0] Led_brightness_count;
	reg Led_brightness_ctrl;

	assign O_lcd_pwm=Led_brightness_ctrl & I_PWMBL_on_sw;
	 /*******************************************************************************/
	 //LED brightness controller
	 /*******************************************************************************/
	//LED背光灯亮度控制
	always @(posedge I_clk or negedge I_rst_n)
	begin
		if (~I_rst_n) begin
			Led_brightness_count<=0;
			Led_brightness_ctrl<=1'b0;
		end
		else begin
			if(Led_brightness_count<3999)
				Led_brightness_count<=Led_brightness_count+1'b1;
			else
				Led_brightness_count<=0;

			if(Led_brightness_count==0)
				Led_brightness_ctrl<=1'b1;
			else if(Led_brightness_count==999)
				Led_brightness_ctrl<=1'b0;
		end
	end
endmodule
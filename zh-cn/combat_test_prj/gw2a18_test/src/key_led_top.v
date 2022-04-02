`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  
// Module Name:  
// Project Name: 
// Target Devices: Gowin
// Tool Versions: 
// Description: 
//      
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define UD #1
module top(
    input           clk,
    input           clk_50,
    input           key,
    input  [1:0]    btn,
    
    output          sd_clk,
    input           sd_sddef,
    inout           sd_cmd,
    output [3:0]    sd_data,
    
    output [7:0]    lcd_b,
    output [7:0]    lcd_g,
    output [7:0]    lcd_r,
    output          lcd_hs,
    output          lcd_vs,
    output          lcd_de,
    output          lcd_clk,
    output          lcd_pwm,
    
    output          lcd_scl,
    inout           lcd_sda,
    input           lcd_int,
    
    output [3:0]    led,
    output          tmds_clk_n,  // 
    output          tmds_clk_p,  //
    output [2:0]    tmds_data_n, //
    output [2:0]    tmds_data_p  //
);

   wire [1:0] ctrl;
   wire       pll_lock;
   assign lcd_scl = pll_lock;
   
   key_ctl key_ctl(
       .clk        (  lcd_clk  ),//input            clk,
       .key        (  key  ),//input            key,
                 
       .ctrl       (  ctrl  )//output     [1:0] ctrl
   );
   
   led u_led(
       .clk   (  lcd_clk   ),//input         clk,
       .ctrl  (  ctrl  ),//input  [1:0]  ctrl,
                      
       .led   (  led   ) //output [3:0]  led
   );

   hdmi_out_top
   (
    .sys_clk             (  clk         ),//input wire        sys_clk,     // input system clock 40MHz
    .btn                 (  btn         ),
    
    .lcd_r               (  lcd_r       ),
    .lcd_g               (  lcd_g       ),
    .lcd_b               (  lcd_b       ),
    .lcd_hs              (  lcd_hs      ),
    .lcd_vs              (  lcd_vs      ),
    .lcd_de              (  lcd_de      ),
    .lcd_clk             (  lcd_clk     ),
    .pll_lock            (  pll_lock    ),
                                    
    .tmds_clk_n          (  tmds_clk_n  ),//output            tmds_clk_n,  // 
    .tmds_clk_p          (  tmds_clk_p  ),//output            tmds_clk_p,  //
    .tmds_data_n         (  tmds_data_n ),//output [2:0]      tmds_data_n, //
    .tmds_data_p         (  tmds_data_p ) //output [2:0]      tmds_data_p  //
   );

endmodule

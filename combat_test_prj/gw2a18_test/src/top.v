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
    output           sd_cmd,
    output [3:0]    sd_data,

    input           u_rx,
    output          u_tx,
    
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
    output          tx_scl,
    inout           tx_sda,
    input           rx_scl,
    inout           rx_sda,
    
    output [3:0]    led,
    output          tmds_clk_n,  // 
    output          tmds_clk_p,  //
    output [2:0]    tmds_data_n, //
    output [2:0]    tmds_data_p,  //

//    input          tmds_rx_clk_n,  // 
//    input          tmds_rx_clk_p,  //
//    input [2:0]    tmds_rx_data_n, //
//    input [2:0]    tmds_rx_data_p  //
    output          tmds_rx_clk_n,  // 
    output          tmds_rx_clk_p,  //
    output [2:0]    tmds_rx_data_n, //
    output [2:0]    tmds_rx_data_p  //
);

   wire [1:0] ctrl;
   wire       pll_lock;
   assign lcd_scl = pll_lock;

   assign tx_scl = rx_scl;
   assign tx_sda = rx_sda;
//   assign rx_sda = tx_sda;
   wire   tmds_clk;
   wire [2:0] tmds_data;
//   TLVDS_OBUF txc(
//    .O(tmds_clk_p),
//    .OB(tmds_clk_n),
//    .I(tmds_clk)
//    );   

//    TLVDS_OBUF tx0(
//    .O(tmds_data_p[0]),
//    .OB(tmds_data_n[0]),
//    .I(tmds_data[0])
//    );  

//    TLVDS_OBUF tx1(
//    .O(tmds_data_p[1]),
//    .OB(tmds_data_n[1]),
//    .I(tmds_data[1])
//    ); 
// 
//    TLVDS_OBUF tx2(
//    .O(tmds_data_p[2]),
//    .OB(tmds_data_n[2]),
//    .I(tmds_data[2])
//    ); 

//    TLVDS_IBUF rxc(
//        .O(tmds_clk),
//        .I(tmds_rx_clk_p),
//        .IB(tmds_rx_clk_n)
//    );

//    TLVDS_IBUF rx0(
//        .O(tmds_data[0]),
//        .I(tmds_rx_data_p[0]),
//        .IB(tmds_rx_data_n[0])
//    );

//    TLVDS_IBUF rx1(
//        .O(tmds_data[1]),
//        .I(tmds_rx_data_p[1]),
//        .IB(tmds_rx_data_n[1])
//    );

//    TLVDS_IBUF rx2(
//        .O(tmds_data[2]),
//        .I(tmds_rx_data_p[2]),
//        .IB(tmds_rx_data_n[2])
//    );
   assign sd_clk = clk;
   assign sd_cmd = clk;
   assign sd_data = {4{clk}};

    uart_top(
        //input ports
        .clk     (clk_50),//input         clk,
        .rstn    (1'b1),//input         rstn,
        .uart_rx (u_rx),//input         uart_rx,
        
        //output ports
         //output  [7:0] led,
        .uart_tx (u_tx) //output        uart_tx
    );

   key_ctl key_ctl(
       .clk        (  clk_50  ),//input            clk,
       .key        (  key  ),//input            key,
                 
       .ctrl       (  ctrl  )//output     [1:0] ctrl
   );
   
   led u_led(
       .clk   (  clk_50   ),//input         clk,
       .ctrl  (  ctrl  ),//input  [1:0]  ctrl,
                      
       .led   (  led   ) //output [3:0]  led
   );

   hdmi_out_top hdmi_out_top
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
                                    
    .tmds_clk_n          (  tmds_rx_clk_n  ),//output            tmds_clk_n,  // 
    .tmds_clk_p          (  tmds_rx_clk_p  ),//output            tmds_clk_p,  //
    .tmds_data_n         (  tmds_rx_data_n ),//output [2:0]      tmds_data_n, //
    .tmds_data_p         (  tmds_rx_data_p ) //output [2:0]      tmds_data_p  //
   );

endmodule

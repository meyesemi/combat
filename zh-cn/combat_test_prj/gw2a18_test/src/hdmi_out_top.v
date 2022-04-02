`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date: 2019-09-16 19:46
// Design Name: 
// Module Name: hdmi_out_top
// Project Name: hdmi_out
// Target Devices: Zynq 7030 ffg676
// Tool Versions: 
// Description:  
// 
// Dependencies: 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1

module hdmi_out_top
(
    input             sys_clk,     // input system clock 40MHz
    input  [1:0]      btn,
    output [7:0]      lcd_r,
    output [7:0]      lcd_g,
    output [7:0]      lcd_b,

    output            lcd_hs,
    output            lcd_vs,
    output            lcd_de,
    output            lcd_clk,
    output            pll_lock,
                                    
    output            tmds_clk_n,  // 
    output            tmds_clk_p,  //
    output [2:0]      tmds_data_n, //
    output [2:0]      tmds_data_p  //
);
   //`include "display_mod.vh"
    parameter   COCLOR_DEPP = 4'd8;
    parameter   X_WIDTH = 4'd12;
    parameter   Y_WIDTH = 4'd12;
    parameter   FRACTIONAL_BITS = 4'd12;
    parameter V_TOTAL = 12'd750;
    parameter V_FP = 12'd5;
    parameter V_BP = 12'd20;
    parameter V_SYNC = 12'd5;
    parameter V_ACT = 12'd720;
    parameter H_TOTAL = 12'd1650;
    parameter H_FP = 12'd110;
    parameter H_BP = 12'd220;
    parameter H_SYNC = 12'd40;
    parameter H_ACT = 12'd1280;
    parameter HV_OFFSET = 12'd0;

    wire        clk_in;
    wire        clk_in_5x;
    wire        rstn;
    wire        rstn1;
    wire        clk_in1;
    wire        clk_in1_5x;

    TMDS_pll u_tmds_pll(
        .clkin		(sys_clk   ), 	//input clk 
        .clkout     (clk_in_5x ), 	//output clk 
        .lock		(pll_lock  ) 	//output lock
    );

    assign rstn = pll_lock;

    lcd_pll lcd_pll(
        .clkout(clk_in1_5x), //output clkout
        .lock(rstn1), //output lock
        .clkin(sys_clk) //input clkin
    );

    CLKDIV u_clkdiv(
        .RESETN(rstn),
        .HCLKIN(clk_in_5x), //clk  x5
        .CLKOUT(clk_in),    //clk  x1
        .CALIB (1'b1)
    );
    defparam u_clkdiv.DIV_MODE="5";
    defparam u_clkdiv.GSREN="false";

    CLKDIV u_clkdiv1(
        .RESETN(rstn1),
        .HCLKIN(clk_in1_5x), //clk  x5
        .CLKOUT(clk_in1),    //clk  x1
        .CALIB (1'b1)
    );
    defparam u_clkdiv1.DIV_MODE="5";
    defparam u_clkdiv1.GSREN="false";

    wire                        pix_clk;
    wire [X_WIDTH - 1'b1:0]     act_x;
    wire [Y_WIDTH - 1'b1:0]     act_y;
    wire [COCLOR_DEPP - 1'b1:0] r_out;
    wire [COCLOR_DEPP - 1'b1:0] g_out;
    wire [COCLOR_DEPP - 1'b1:0] b_out;
    
    wire                        hs;
    wire                        vs;
    wire                        de;
    wire                        hs1;
    wire                        vs1;
    wire                        de1;
    wire                        hs_out;
    wire                        vs_out;
    wire                        de_out;
    wire [ 7:0] pattern_set;
    wire [ 7:0] pattern_set1;
    wire [ 7:0] red;
    wire [ 7:0] green;
    wire [ 7:0] blue;
    wire [ 7:0] red1;
    wire [ 7:0] green1;
    wire [ 7:0] blue1;
    wire                        pix_clk1;
    wire [X_WIDTH - 1'b1:0]     act_x1;
    wire [Y_WIDTH - 1'b1:0]     act_y1;
      
    btn_ctl btn_ctl(
        .clk              (  clk_in        ),
        .btn              (  btn            ),
        .vs               (  vs             ),
        .red              (  red            ),
        .green            (  green          ), 
        .blue             (  blue           ),
        .pattern_set      (  pattern_set    )
    );

    btn_ctl btn_ctl1(
        .clk              (  clk_in1         ),
        .btn              (  btn             ),
        .vs               (  vs1             ),
        .red              (  red1            ),
        .green            (  green1          ), 
        .blue             (  blue1           ),
        .pattern_set      (  pattern_set1    )
    );
    /* ********************* */
    sync_vg #(
        .X_BITS               (  X_WIDTH      ), 
        .Y_BITS               (  Y_WIDTH      ),
        .V_TOTAL              (  V_TOTAL      ),//parameter               V_TOTAL = 12'd750,                            
        .V_FP                 (  V_FP         ),//parameter               V_FP = 12'd5,                                 
        .V_BP                 (  V_BP         ),//parameter               V_BP = 12'd20,                                
        .V_SYNC               (  V_SYNC       ),//parameter               V_SYNC = 12'd5,                               
        .V_ACT                (  V_ACT        ),//parameter               V_ACT = 12'd720,                              
        .H_TOTAL              (  H_TOTAL      ),//parameter               H_TOTAL = 12'd1650,                           
        .H_FP                 (  H_FP         ),//parameter               H_FP = 12'd110,                               
        .H_BP                 (  H_BP         ),//parameter               H_BP = 12'd220,                               
        .H_SYNC               (  H_SYNC       ),//parameter               H_SYNC = 12'd40,                              
        .H_ACT                (  H_ACT        ),//parameter               H_ACT = 12'd1280,                             
        .HV_OFFSET            (  HV_OFFSET    ) //parameter               HV_OFFSET = 12'd0   
    ) sync_vg
    (
        .clk                  (  clk_in       ),//input                   clk,                                 
        .rstn                 (  rstn         ),//input                   rstn,                            
        .vs_out               (  vs           ),//output reg              vs_out,                                                                                                                                      
        .hs_out               (  hs           ),//output reg              hs_out,            
        .de_out               (  de           ),//output reg              de_out,            
        .v_count_out          (               ),//output reg [Y_BITS:0]   v_count_out,       
        .h_count_out          (               ),//output reg [X_BITS-1:0] h_count_out,       
        .x_out                (  act_x        ),//output reg [X_BITS-1:0] x_out,             
        .y_out                (  act_y        ),//output reg [Y_BITS:0]   y_out,             
        .clk_out              (  pix_clk      ) //output wire             clk_out    // inverted output clock - unconnected                                                                                                          
    );
    
    pattern_vg #(
        .COCLOR_DEPP          (  COCLOR_DEPP     ), // Bits per channel
        .X_BITS               (  X_WIDTH         ),
        .Y_BITS               (  Y_WIDTH         ),
        .FRACT_BITS           (  FRACTIONAL_BITS ),
        .H_ACT                (  H_ACT           ),
        .V_ACT                (  V_ACT           )
    ) // Number of fractional bits for ramp pattern
    pattern_vg (
        .rstn                 (  rstn         ),//input                   rstn,                                                                                                                                                                                                                                                                                                                              
        .pix_clk              (  clk_in       ),//input                   clk_in,                                                                                                                                                                                                                                                                                                                            
        .act_x                (  act_x        ),//input      [X_BITS-1:0] x,                                                                                                                                                                                                                                                                                                                                 
        .act_y                (  act_y        ),//input      [Y_BITS-1:0] y,
                                              
        // input video                                                                                                                                                                                                                                                                                                                                  
        .vn_in                (  vs           ),//input                   vn_in,                                                                                                                                                                                                                                                                                                                                
        .hn_in                (  hs           ),//input                   hn_in,                                                                                                                                                                                                                                                                                                                                
        .dn_in                (  de           ),//input                   dn_in,                                                                                                                                                                                                                                                                                                                                
        .r_in                 (  red          ),//input      [B-1:0]      r_in,                                                                                                                                                                                                                                                                                             
        .g_in                 (  green        ),//input      [B-1:0]      g_in,                                                                                                                                                                                                                                                                                             
        .b_in                 (  blue         ),//input      [B-1:0]      b_in,
        .pattern_type         (  pattern_set  ),//input      [7:0]              pattern_type
        .pattern_ramp_step    (  20'h0333     ),//input  [FRACT_BITS+COCLOR_DEPP-1:0]  b_in,
        
        // test pattern image output                                                                                                                                                                                                                                                                                             
        .vn_out               (  vs_out       ),//output reg              vn_out,                                                                                                                                                                                                                                                                                                                            
        .hn_out               (  hs_out       ),//output reg              hn_out,                                                                                                                                                                                                                                                                                                                            
        .den_out              (  de_out       ),//output reg              den_out,                                                                                                                                                                                                                                                                                                                           
        .r_out                (  r_out        ),//output reg [B-1:0]      r_out,                                                                                                                                                                                                                                                                                                                             
        .g_out                (  g_out        ),//output reg [B-1:0]      g_out,                                                                                                                                                                                                                                                                                                                             
        .b_out                (  b_out        ) //output reg [B-1:0]      b_out   
    );


    sync_vg #(
        .X_BITS               (  X_WIDTH      ), 
        .Y_BITS               (  Y_WIDTH      ),
        .V_TOTAL              (  12'd517      ),//parameter               V_TOTAL = 12'd750,                            
        .V_FP                 (  12'd6         ),//parameter               V_FP = 12'd5,                                 
        .V_BP                 (  12'd23         ),//parameter               V_BP = 12'd20,                                
        .V_SYNC               (  12'd8       ),//parameter               V_SYNC = 12'd5,                               
        .V_ACT                (  12'd480        ),//parameter               V_ACT = 12'd720,                              
        .H_TOTAL              (  12'd1088      ),//parameter               H_TOTAL = 12'd1650,                           
        .H_FP                 (  12'd16         ),//parameter               H_FP = 12'd110,                               
        .H_BP                 (  12'd112         ),//parameter               H_BP = 12'd220,                               
        .H_SYNC               (  12'd112       ),//parameter               H_SYNC = 12'd40,                              
        .H_ACT                (  12'd800        ),//parameter               H_ACT = 12'd1280,                             
        .HV_OFFSET            (  12'd0    ) //parameter               HV_OFFSET = 12'd0   
    ) sync_vg1
    (
        .clk                  (  clk_in1      ),//input                   clk,                                 
        .rstn                 (  rstn1         ),//input                   rstn,                            
        .vs_out               (  vs1          ),//output reg              vs_out,                                                                                                                                      
        .hs_out               (  hs1          ),//output reg              hs_out,            
        .de_out               (  de1          ),//output reg              de_out,            
        .v_count_out          (               ),//output reg [Y_BITS:0]   v_count_out,       
        .h_count_out          (               ),//output reg [X_BITS-1:0] h_count_out,       
        .x_out                (  act_x1       ),//output reg [X_BITS-1:0] x_out,             
        .y_out                (  act_y1       ),//output reg [Y_BITS:0]   y_out,             
        .clk_out              (  pix_clk1     ) //output wire             clk_out    // inverted output clock - unconnected                                                                                                          
    );

    pattern_vg #(
        .COCLOR_DEPP          (  COCLOR_DEPP     ), // Bits per channel
        .X_BITS               (  X_WIDTH         ),
        .Y_BITS               (  Y_WIDTH         ),
        .FRACT_BITS           (  FRACTIONAL_BITS ),
        .H_ACT                (  12'd800           ),
        .V_ACT                (  12'd480           )
    ) // Number of fractional bits for ramp pattern
    pattern_vg1 (
        .rstn                 (  rstn1         ),//input                   rstn,                                                                                                                                                                                                                                                                                                                              
        .pix_clk              (  clk_in1       ),//input                   clk_in,                                                                                                                                                                                                                                                                                                                            
        .act_x                (  act_x1        ),//input      [X_BITS-1:0] x,                                                                                                                                                                                                                                                                                                                                 
        .act_y                (  act_y1        ),//input      [Y_BITS-1:0] y,
                                              
        // input video                                                                                                                                                                                                                                                                                                                                  
        .vn_in                (  vs1           ),//input                   vn_in,                                                                                                                                                                                                                                                                                                                                
        .hn_in                (  hs1           ),//input                   hn_in,                                                                                                                                                                                                                                                                                                                                
        .dn_in                (  de1           ),//input                   dn_in,                                                                                                                                                                                                                                                                                                                                
        .r_in                 (  red1           ),//input      [B-1:0]      r_in,                                                                                                                                                                                                                                                                                             
        .g_in                 (  green1         ),//input      [B-1:0]      g_in,                                                                                                                                                                                                                                                                                             
        .b_in                 (  blue1          ),//input      [B-1:0]      b_in,
        .pattern_type         (  pattern_set1   ),//input      [7:0]              pattern_type
        .pattern_ramp_step    (  20'h051E     ),//input  [FRACT_BITS+COCLOR_DEPP-1:0]  b_in,
        
        // test pattern image output                                                                                                                                                                                                                                                                                             
        .vn_out               (  lcd_vs       ),//output reg              vn_out,                                                                                                                                                                                                                                                                                                                            
        .hn_out               (  lcd_hs       ),//output reg              hn_out,                                                                                                                                                                                                                                                                                                                            
        .den_out              (  lcd_de       ),//output reg              den_out,                                                                                                                                                                                                                                                                                                                           
        .r_out                (  lcd_r        ),//output reg [B-1:0]      r_out,                                                                                                                                                                                                                                                                                                                             
        .g_out                (  lcd_g        ),//output reg [B-1:0]      g_out,                                                                                                                                                                                                                                                                                                                             
        .b_out                (  lcd_b        ) //output reg [B-1:0]      b_out   
    );

    assign lcd_clk = pix_clk1;
    
    rgb2dvi rgb2dvi (
         // DVI 1.0 TMDS video interface
          .tmds_clk_p         (  tmds_clk_p           ),
          .tmds_clk_n         (  tmds_clk_n           ),
          .tmds_data_p        (  tmds_data_p          ),
          .tmds_data_n        (  tmds_data_n          ),
                                                      
         //Auxiliary signals                          
          .rstn               (  rstn                 ), //-synchronous reset; must be reset when RefClk is not within spec
                                      
          // video in                 
          .vid_pdata          (  {r_out,g_out,b_out}  ),//(  {lcd_b,lcd_g,lcd_r}  ),//
          .vid_pvde           (  de_out               ),//(  lcd_de               ),//
          .vid_phsync         (  hs_out               ),//(  lcd_hs               ),//
          .vid_pvsync         (  vs_out               ),//(  lcd_vs               ),//
          .pixelclk           (  pix_clk              ),
                                                      
          .serialclk          (  clk_in_5x            )// 5x PixelClk
   ); 
endmodule

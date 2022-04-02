`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//        Company        : Myminieye
//     Internet site     : www.myminieye.com
// WeChat public account : MYMINIEYE
//       Engineer        : Nill
// 
//      Create Date      : 2020-03-09 17:54  
//      Design Name      :  
//      Module Name      : iic_dri
//     Project Name      : 
//    Target Devices     : Gowin@GW1N-UV4LQ144C6/I5
//     Tool Versions     : 
//      Description      : 
//                       
//     Dependencies      : 
//                       
//       Revision        : Revision 0.01 - File Created
//  Additional Comments  :
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module tb();
    reg           clk_27; //37ns
    reg           clk_50; //20ns
    reg           key;
    reg [1:0]     btn;
    
    wire          sd_clk;         
    reg           sd_sddef;       
    wire          sd_cmd;         
    wire [3:0]    sd_data;        
                                    
    wire [7:0]    lcd_b;          
    wire [7:0]    lcd_g;          
    wire [7:0]    lcd_r;          
    wire          lcd_hs;         
    wire          lcd_vs;         
    wire          lcd_de;         
    wire          lcd_clk;        
    wire          lcd_pwm;        
                                    
    wire          lcd_scl;        
    wire          lcd_sda;        
    reg           lcd_int;        
                                    
    wire [3:0]    led;            
    wire          tmds_clk_n;  // 
    wire          tmds_clk_p;  // 
    wire [2:0]    tmds_data_n; // 
    wire [2:0]    tmds_data_p; // 
    
    always #10    clk_50 = ~clk_50;
    always #18    clk_27 = ~clk_27;
    
    initial
    begin
        #0 clk_50 = 0;
           clk_27 = 0;
           key = 1;
           btn = 3;
           lcd_int = 0;
           sd_sddef = 0;
        repeat(100)@(posedge clk_50);
           key = 0;
        repeat(20)@(posedge clk_50);
           key = 1;
        
        repeat(1280*720)@(posedge clk_50);
           btn = 2;
        repeat(10)@(posedge clk_50);
           btn = 3;
    end

    top top(
        .clk         (  clk_27       ),//input           clk,
        .clk_50      (  clk_50       ),//input           clk_50,
        .key         (  key          ),//input           key,
        .btn         (  btn          ),//input  [1:0]    btn,

        .sd_clk      (  sd_clk       ),//output          sd_clk,
        .sd_sddef    (  sd_sddef     ),//input           sd_sddef,
        .sd_cmd      (  sd_cmd       ),//inout           sd_cmd,
        .sd_data     (  sd_data      ),//output [3:0]    sd_data,
    
        .lcd_b       (  lcd_b        ),//output [7:0]    lcd_b,
        .lcd_g       (  lcd_g        ),//output [7:0]    lcd_g,
        .lcd_r       (  lcd_r        ),//output [7:0]    lcd_r,
        .lcd_hs      (  lcd_hs       ),//output          lcd_hs,
        .lcd_vs      (  lcd_vs       ),//output          lcd_vs,
        .lcd_de      (  lcd_de       ),//output          lcd_de,
        .lcd_clk     (  lcd_clk      ),//output          lcd_clk,
        .lcd_pwm     (  lcd_pwm      ),//output          lcd_pwm,
       
        .lcd_scl     (  lcd_scl      ),//output          lcd_scl,
        .lcd_sda     (  lcd_sda      ),//inout           lcd_sda,
        .lcd_int     (  lcd_int      ),//input           lcd_int,

        .led         (  led          ),//output [3:0]    led,
        .tmds_clk_n  (  tmds_clk_n   ),//output          tmds_clk_n,  // 
        .tmds_clk_p  (  tmds_clk_p   ),//output          tmds_clk_p,  //
        .tmds_data_n (  tmds_data_n  ),//output [2:0]    tmds_data_n, //
        .tmds_data_p (  tmds_data_p  ) //output [2:0]    tmds_data_p  //
    );
    
endmodule

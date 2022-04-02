`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/10 10:25:30
// Design Name: 
// Module Name: btn_ctl
// Project Name: 
// Target Devices: 
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


module btn_ctl (                     
    input              clk,              
    input      [ 0:0]  btn,              
       
    output reg [ 7:0]  out
);
    parameter SIM = 1'b0;

    wire [0:0]  button;
    reg  [0:0]  button_r;
    
    always @(posedge clk)
    begin
        button_r <= button;
    end

    wire btn_deb;
    // °´¼üÏû¶¶
    generate
       begin
           if(SIM == 1'b0)
               btn_deb#(
                   .BTN_WIDTH           ( 4'd1    )//parameter                  BTN_WIDTH = 4'd8
               )                                  
               (                                  
                   .clk                 ( clk     ),//input                      clk,  //12MHz
                   .btn_in              ( btn     ),//input      [BTN_WIDTH-1:0] btn_in,
               
                   .btn_deb             ( button  ) //output reg [BTN_WIDTH-1:0] btn_deb
               );
           else
               assign button = btn;
       end
    endgenerate
    
    reg [7:0] key_cnt=0;
    always @(posedge clk)
    begin
        if((~button) & button_r)
            key_cnt <= key_cnt + 3'd1;
    end


endmodule

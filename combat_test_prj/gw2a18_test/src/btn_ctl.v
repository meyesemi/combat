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
    input      [ 1:0]  btn,              
    input              vs ,         
    output reg [ 7:0]  red,
    output reg [ 7:0]  green,
    output reg [ 7:0]  blue,   
    output reg [ 7:0]  pattern_set        
);
    parameter SIM = 1'b0;

    wire [1:0]  button;
    reg  [1:0]  button_r;
    
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
                   .BTN_WIDTH           ( 4'd2    )//parameter                  BTN_WIDTH = 4'd8
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
    
    reg [ 2:0]     pattern_set_r = 3'd4;

    reg vs_r;
    always @(posedge clk)
    begin
        vs_r <= vs;
    end
    
    reg [2:0] color_cnt=0;
    always @(posedge clk)
    begin
        if(pattern_set_r < 3'd2)
        begin
            if((~button[1]) & ~button_r[1])
                color_cnt <= color_cnt + 3'd1;
        end
    end
    
    always @(posedge clk)
    begin
        if(~vs_r & vs)
        begin
            case(color_cnt)
                3'd0:
                begin
                    red <= 0;
                    green <= 8'hff;
                    blue <= 0;
                end
                3'd1:
                begin
                    red <= 0;
                    green <= 8'h00;
                    blue <= 0;
                end
                3'd2:
                begin
                    red <= 0;
                    green <= 0;
                    blue <= 8'hff;
                end
                3'd3:
                begin
                    red <= 8'hff;
                    green <= 0;
                    blue <= 0;
                end
                3'd4:
                begin
                    red <= 8'hff;
                    green <= 8'hff;
                    blue <= 0;
                end
                3'd5:
                begin
                    red <= 8'hff;
                    green <= 0;
                    blue <= 8'hff;
                end
                3'd6:
                begin
                    red <= 0;
                    green <= 8'hff;
                    blue <= 8'hff;
                end
                3'd7:
                begin
                    red <= 8'hff;
                    green <= 8'hff;
                    blue <= 8'hff;
                end
            endcase
        end
    end
    
    always @(posedge clk)
    begin
        if((~button[0]) & button_r[0])
        begin
            if(pattern_set_r == 3'd4)
                pattern_set_r <= 3'd0;
            else
                pattern_set_r <= pattern_set_r + 3'd1;
        end
    end
    
    always @(posedge clk)
    begin
        if(~vs_r & vs)
        begin
             pattern_set <= pattern_set_r;
        end
    end

endmodule

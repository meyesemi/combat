`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  
// Module Name:  led
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
module led(
    input         clk,
    input  [1:0]  ctrl,
                  
    output [3:0]  led
);

    reg [24:0] led_light_cnt = 25'd0;
    reg [ 3:0] led_status = 4'b1000;
    
    //  time counter
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd19_999_999)
            led_light_cnt <= `UD 25'd0;
        else
            led_light_cnt <= `UD led_light_cnt + 25'd1; 
    end
    
    reg [1:0] ctrl_1d;    //保存上一个led状态周期的ctrl值
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd19_999_999)
            ctrl_1d <= ctrl;
    end

    // led status change
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd19_999_999)//0.5s 周期
        begin
            case(ctrl)
                2'd0 :  //从高位到低位的led流水灯
                begin
                    if(ctrl_1d != ctrl)
                        led_status <= `UD 4'b1000;
                    else
                        led_status <= `UD {led_status[0],led_status[3:1]};
                end
                2'd1 :  //从地位到高位的led流水灯
                begin
                    if(ctrl_1d != ctrl)
                        led_status <= `UD 4'b0001;
                    else
                        led_status <= `UD {led_status[2:0],led_status[3]};
                end
                2'd2 :  //从低位到高位增加亮灯的个数
                begin
                    if(ctrl_1d != ctrl || led_status == 4'b1111)
                        led_status <= `UD 4'b0000;
                    else
                        led_status <= `UD {led_status[2:0],1'b1};
                end
                2'd3 :  //从高位到低位增加灭灯的个数
                begin
                    if(ctrl_1d != ctrl || led_status == 4'b0000)
                        led_status <= `UD 4'b1111;
                    else
                        led_status <= `UD {1'b0,led_status[3:1]};
                end
            endcase
        end
    end

    assign led = led_status;

endmodule

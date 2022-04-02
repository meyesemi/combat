`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date: 2019-09-16 19:46
// Design Name: 
// Module Name: pattern_vg
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

module pattern_vg # (
    parameter                            COCLOR_DEPP=8, // number of bits per channel
    parameter                            X_BITS=13,
    parameter                            Y_BITS=13,
    parameter                            FRACT_BITS = 12,
    parameter                            H_ACT = 12'd1280,
    parameter                            V_ACT = 12'd720
)(                                       
    input                                rstn, 
    input                                pix_clk,
    input [X_BITS-1:0]                   act_x,
    input [Y_BITS-1:0]                   act_y,
    input                                vn_in, 
    input                                hn_in, 
    input                                dn_in,
    input [COCLOR_DEPP-1:0]              r_in, 
    input [COCLOR_DEPP-1:0]              g_in, 
    input [COCLOR_DEPP-1:0]              b_in,
                                         
    input [7:0]                          pattern_type,
    input [FRACT_BITS + COCLOR_DEPP-1:0] pattern_ramp_step,
    
    output reg                           vn_out, 
    output reg                           hn_out, 
    output reg                           den_out,
    output reg [COCLOR_DEPP-1:0]         r_out, 
    output reg [COCLOR_DEPP-1:0]         g_out, 
    output reg [COCLOR_DEPP-1:0]         b_out
);

    reg [COCLOR_DEPP+FRACT_BITS-1:0] ramp_values; // 12-bit fractional end for ramp values  
    
    always @(posedge pix_clk)
    begin
        vn_out <= `UD vn_in;
        hn_out <= `UD hn_in;
        den_out <= `UD dn_in;
    end

    always @(posedge pix_clk)
    begin
        if (!rstn)
            ramp_values <= `UD 0;
        else if (pattern_type == 8'b0) // no PATTERN_TYPE_TYPE
        begin
            r_out <= `UD r_in;
            g_out <= `UD g_in;
            b_out <= `UD b_in;
        end
        else if (pattern_type == 8'b1) // border
        begin
            if (dn_in && ((act_y < 12'd32) || (act_x < 12'd32) || (act_x > H_ACT - 5'd31) || (act_y > V_ACT - 5'd31)))
            begin
                r_out <= `UD 8'hFF;
                g_out <= `UD 8'h00;
                b_out <= `UD 8'hFF;
            end
            else
            begin
                r_out <= `UD r_in;
                g_out <= `UD g_in;
                b_out <= `UD b_in;
            end
        end
        else if (pattern_type == 8'd2) // moireX
        begin
            if ((dn_in) && act_x[5] == 1'b1)
            begin
                r_out <= 8'hdd;
                g_out <= 8'hdd;
                b_out <= 8'h00;
            end
            else
            begin
                r_out <= 8'hdd;
                g_out <= 8'h00;
                b_out <= 8'hdd;
            end
        end
        else if (pattern_type == 8'd3) // moireY
        begin
            if (dn_in)
            begin
                if(act_y[5] == 1'b1)
                begin
                    r_out <= 8'hdd;
                    g_out <= 8'h00;
                    b_out <= 8'hdd;
                end
                else
                begin
                    r_out <= 8'h0;
                    g_out <= 8'hdd;
                    b_out <= 8'h0;
                end
            end
            else
            begin
                r_out <= 8'h00;
                g_out <= 8'h00;
                b_out <= 8'h00;
            end
        end
        else if (pattern_type == 8'd4) // Simple RAMP
        begin
                r_out <= `UD ramp_values[COCLOR_DEPP+FRACT_BITS-1:FRACT_BITS];
                g_out <= `UD ramp_values[COCLOR_DEPP+FRACT_BITS-1:FRACT_BITS];
                b_out <= `UD ramp_values[COCLOR_DEPP+FRACT_BITS-1:FRACT_BITS];
            if ((act_x == H_ACT - 1) && (dn_in))
                ramp_values <= `UD 0;
            else if ((act_x == 0) && (dn_in))
                ramp_values <= `UD pattern_ramp_step;
            else if (dn_in)
                ramp_values <= `UD ramp_values + pattern_ramp_step;
        end
    end
    
endmodule

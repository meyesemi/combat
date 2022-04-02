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
//    VS     ______                                       ______
//HS  __    |      |_______________¡­¡­____________________|      |
//   |       h_sync  h_bp       h_act                h_fp
//   |__                    _______________________
//DE    |   _______________|                       |_____________
//      |
//      .
//      |
//    __|
//   |  
//   |__ 
//      |
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1


module sync_vg # (
    parameter               X_BITS=12,
    parameter               Y_BITS=12,
    parameter               V_TOTAL = 12'd750,
    parameter               V_FP = 12'd5,
    parameter               V_BP = 12'd20,
    parameter               V_SYNC = 12'd5,
    parameter               V_ACT = 12'd720,
    parameter               H_TOTAL = 12'd1650,
    parameter               H_FP = 12'd110,
    parameter               H_BP = 12'd220,
    parameter               H_SYNC = 12'd40,
    parameter               H_ACT = 12'd1280,
    parameter               HV_OFFSET = 12'd0 
)(
    input                   clk,
    input                   rstn,
    output reg              vs_out,
    output reg              hs_out,
    output reg              de_out,
    output reg [Y_BITS:0]   v_count_out,
    output reg [X_BITS-1:0] h_count_out,
    output reg [X_BITS-1:0] x_out,
    output reg [Y_BITS:0]   y_out,
    output wire             clk_out
);

    reg [X_BITS-1:0] h_count;
    reg [Y_BITS-1:0] v_count;
    
 //   assign clk_out = !clk;
    BUFG pix_buf(
      .O(clk_out),
      .I(!clk)
    );
    
    /* horizontal counter */
    always @(posedge clk)
    begin
        if (!rstn)
            h_count <= `UD 0;
        else
        begin
            if (h_count < H_TOTAL - 1)
                h_count <= `UD h_count + 1;
            else
                h_count <= `UD 0;
        end
    end
    
    /* vertical counter */
    always @(posedge clk)
    begin
        if (!rstn)
            v_count <= `UD 0;
        else
        if (h_count == H_TOTAL - 1)
        begin
            if (v_count == V_TOTAL - 1)
                v_count <= `UD 0;
            else
                v_count <= `UD v_count + 1;
        end
    end
    
    always @(posedge clk)
    begin
        if (!rstn)
            hs_out <= `UD 4'b0;
        else 
            hs_out <= `UD ((h_count < H_SYNC));
    end
    
    always @(posedge clk)
    begin
        if (!rstn)
            vs_out <= `UD 4'b0;
        else 
        begin
            if ((v_count == 0) && (h_count == HV_OFFSET))
                vs_out <= `UD 1'b1;
            else if ((v_count == V_SYNC) && (h_count == HV_OFFSET))
                vs_out <= `UD 1'b0;
            else
                vs_out <= `UD vs_out;
        end
    end
    
    always @(posedge clk)
    begin
        if (!rstn)
            de_out <= `UD 4'b0;
        else
            de_out <= (((v_count >= V_SYNC + V_BP) && (v_count <= V_TOTAL - V_FP - 1)) && 
                      ((h_count >= H_SYNC + H_BP) && (h_count <= H_TOTAL - H_FP - 1)));
    end
    
    // h and v counter output
    always @(posedge clk)
    begin
        h_count_out <= `UD h_count;
        
        v_count_out <= `UD v_count;
    end
    
    // active pixels counter output
    always @(posedge clk)
    begin
        if (!rstn)
        begin
            x_out <= `UD 'd0;
            y_out <= `UD 'd0;
        end
        else 
        begin
        /* X and Y coords ¨C for a backend pattern generator */
            if(h_count > (H_SYNC + H_BP - 1'b1))
                x_out <= `UD (h_count - (H_SYNC + H_BP));
            else
                x_out <= `UD 'd0;
            
            if(v_count > (V_SYNC + V_BP - 1'b1))
                y_out <= `UD { 1'b0, (v_count - (V_SYNC + V_BP)) };
            else
                y_out <= `UD 'd0;
        end
    end
    
endmodule

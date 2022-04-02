`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date: 2019-09-16 19:46
// Design Name: 
// Module Name: SyncAsync
// Project Name: 
// Target Devices: 
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
module outputserdes#(
    parameter                  KPARALLELWIDTH = 10
)(
    input                      pixelclk,
    input                      serialclk,
    input                      rstn,
    
    input [KPARALLELWIDTH-1:0] pdataout,
    
    output                     sdataout_p,
    output                     sdataout_n 
);

    wire                       sDataOut;
    
    TLVDS_OBUF TLVDS_OBUF(
    .O(sdataout_p),
    .OB(sdataout_n),
    .I(sDataOut)
    );
   
   
    OSER10 OSER10(
     .Q (sDataOut),
     .D0(pdataout[0]),
     .D1(pdataout[1]),
     .D2(pdataout[2]),
     .D3(pdataout[3]),
     .D4(pdataout[4]),
     .D5(pdataout[5]),
     .D6(pdataout[6]),
     .D7(pdataout[7]),
     .D8(pdataout[8]),
     .D9(pdataout[9]),
     .PCLK(pixelclk),
     .FCLK(serialclk),
     .RESET(~rstn)
    );
    defparam OSER10.GSREN="false";
    defparam OSER10.LSREN ="true";
   
endmodule

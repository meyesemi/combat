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

    reg        cmos_pclk;
    wire[15:0] cmos_d_16bit;
    wire       cmos_href_16bit;
    reg [7:0]  cmos_d_d0=0;
    reg        cmos_href_d0;
    reg        cmos_vsync_d0;
    wire       cmos_hblank;
    wire       pixel_clk_16bit;

    always #5 cmos_pclk = ~cmos_pclk;

    initial
    begin
         #0 cmos_pclk = 0;
            cmos_href_d0 = 1'b0;
         repeat(100)@(posedge cmos_pclk);
            cmos_href_d0 = 1'b1;

         repeat(800)@(posedge cmos_pclk);
            cmos_href_d0 = 1'b0;
    end

    always @(posedge cmos_pclk)
begin
    cmos_d_d0 <= cmos_d_d0 + 1'b1;
end

    cmos_8_16bit cmos_8_16bit_m0(
    	.rst(1'b0),
    	.pclk(cmos_pclk),
    	.pdata_i(cmos_d_d0),
    	.de_i(cmos_href_d0),
    	
    	.pixel_clk(pixel_clk_16bit),
    	.pdata_o(cmos_d_16bit),
    	.hblank(cmos_hblank),
    	.de_o(cmos_href_16bit)
    );


endmodule

//
// Written by Synplify Pro 
// Product Version "N-2018.03G"
// Program "Synplify Pro", Mapper "mapgw, Build 1138R"
// Tue Aug 21 16:21:45 2018
//
// Source file index table:
// Object locations will have the form <file>:<line>
// file 0 "\e:\gowin\1.8\synplifypro\lib\generic\gw2a.v "
// file 1 "\e:\gowin\1.8\synplifypro\lib\vlog\hypermods.v "
// file 2 "\e:\gowin\1.8\synplifypro\lib\vlog\umr_capim.v "
// file 3 "\e:\gowin\1.8\synplifypro\lib\vlog\scemi_objects.v "
// file 4 "\e:\gowin\1.8\synplifypro\lib\vlog\scemi_pipes.svh "
// file 5 "\e:\gowin\1.8\ide\ipcore\mipi_tx\data\dphy_tx.v "
// file 6 "\d:\user-bak\users\zhuomian\ivideo_7to1_dynamic_rx18klq144_8channal_sytechboard_20180818_v2.1_mipiip\sytech_lvds2mipi\src\dphy_tx_top\temp\mipi_tx\dphy_define.v "
// file 7 "\e:\gowin\1.8\ide\ipcore\mipi_tx\data\dphy_tx_top.v "
// file 8 "\e:\gowin\1.8\synplifypro\lib\nlconst.dat "

`timescale 100 ps/100 ps
module \~oserx4.DPHY_TX_TOP_  (
  data_in3,
  data_in2,
  data_in1,
  data_in0,
  hs_clk_en_i,
  clk_bit_90,
  hs_data_en_i,
  clk_bit,
  HS_CLK_N,
  HS_CLK_P,
  HS_DATA3_N,
  HS_DATA3_P,
  HS_DATA2_N,
  HS_DATA2_P,
  HS_DATA1_N,
  HS_DATA1_P,
  HS_DATA0_N,
  HS_DATA0_P,
  sclk_0,
  reset_n
)
;
input [7:0] data_in3 ;
input [7:0] data_in2 ;
input [7:0] data_in1 ;
input [7:0] data_in0 ;
input hs_clk_en_i ;
input clk_bit_90 ;
input hs_data_en_i ;
input clk_bit ;
output HS_CLK_N ;
output HS_CLK_P ;
output HS_DATA3_N ;
output HS_DATA3_P ;
output HS_DATA2_N ;
output HS_DATA2_P ;
output HS_DATA1_N ;
output HS_DATA1_P ;
output HS_DATA0_N ;
output HS_DATA0_P ;
inout sclk_0 /* synthesis syn_tristate = 1 */ ;
input reset_n ;
wire hs_clk_en_i ;
wire clk_bit_90 ;
wire hs_data_en_i ;
wire clk_bit ;
wire HS_CLK_N ;
wire HS_CLK_P ;
wire HS_DATA3_N ;
wire HS_DATA3_P ;
wire HS_DATA2_N ;
wire HS_DATA2_P ;
wire HS_DATA1_N ;
wire HS_DATA1_P ;
wire HS_DATA0_N ;
wire HS_DATA0_P ;
wire sclk_0 ;
wire reset_n ;
wire reset_n_i ;
wire buf_douto0 ;
wire buf_doutoe0 ;
wire buf_douto1 ;
wire buf_doutoe1 ;
wire buf_douto2 ;
wire buf_doutoe2 ;
wire buf_douto3 ;
wire buf_doutoe3 ;
wire buf_clkout ;
wire buf_clkoe ;
wire GND ;
wire VCC ;
// @5:439
  INV reset_n_i_cZ (
	.I(reset_n),
	.O(reset_n_i)
);
//@5:163
// @5:494
  TLVDS_TBUF U1_OB0 (
	.O(HS_DATA0_P),
	.OB(HS_DATA0_N),
	.I(buf_douto0),
	.OEN(buf_doutoe0)
);
// @5:485
  TLVDS_TBUF U1_OB1 (
	.O(HS_DATA1_P),
	.OB(HS_DATA1_N),
	.I(buf_douto1),
	.OEN(buf_doutoe1)
);
// @5:476
  TLVDS_TBUF U1_OB2 (
	.O(HS_DATA2_P),
	.OB(HS_DATA2_N),
	.I(buf_douto2),
	.OEN(buf_doutoe2)
);
// @5:467
  TLVDS_TBUF U1_OB3 (
	.O(HS_DATA3_P),
	.OB(HS_DATA3_N),
	.I(buf_douto3),
	.OEN(buf_doutoe3)
);
// @5:459
  TLVDS_TBUF U0_OB (
	.O(HS_CLK_P),
	.OB(HS_CLK_N),
	.I(buf_clkout),
	.OEN(buf_clkoe)
);
// @5:449
  CLKDIV U3_CLKDIV (
	.CLKOUT(sclk_0),
	.CALIB(GND),
	.HCLKIN(clk_bit),
	.RESETN(reset_n)
);
defparam U3_CLKDIV.DIV_MODE="4";
// @5:439
  OSER8 U5_OSER80 (
	.Q0(buf_douto0),
	.Q1(buf_doutoe0),
	.D0(data_in0[0]),
	.D1(data_in0[1]),
	.D2(data_in0[2]),
	.D3(data_in0[3]),
	.D4(data_in0[4]),
	.D5(data_in0[5]),
	.D6(data_in0[6]),
	.D7(data_in0[7]),
	.FCLK(clk_bit),
	.PCLK(sclk_0),
	.RESET(reset_n_i),
	.TX0(hs_data_en_i),
	.TX1(hs_data_en_i),
	.TX2(hs_data_en_i),
	.TX3(hs_data_en_i)
);
defparam U5_OSER80.HWL="false";
defparam U5_OSER80.TXCLK_POL=1'b0;
// @5:432
  OSER8 U5_OSER81 (
	.Q0(buf_douto1),
	.Q1(buf_doutoe1),
	.D0(data_in1[0]),
	.D1(data_in1[1]),
	.D2(data_in1[2]),
	.D3(data_in1[3]),
	.D4(data_in1[4]),
	.D5(data_in1[5]),
	.D6(data_in1[6]),
	.D7(data_in1[7]),
	.FCLK(clk_bit),
	.PCLK(sclk_0),
	.RESET(reset_n_i),
	.TX0(hs_data_en_i),
	.TX1(hs_data_en_i),
	.TX2(hs_data_en_i),
	.TX3(hs_data_en_i)
);
defparam U5_OSER81.HWL="false";
defparam U5_OSER81.TXCLK_POL=1'b0;
// @5:425
  OSER8 U5_OSER82 (
	.Q0(buf_douto2),
	.Q1(buf_doutoe2),
	.D0(data_in2[0]),
	.D1(data_in2[1]),
	.D2(data_in2[2]),
	.D3(data_in2[3]),
	.D4(data_in2[4]),
	.D5(data_in2[5]),
	.D6(data_in2[6]),
	.D7(data_in2[7]),
	.FCLK(clk_bit),
	.PCLK(sclk_0),
	.RESET(reset_n_i),
	.TX0(hs_data_en_i),
	.TX1(hs_data_en_i),
	.TX2(hs_data_en_i),
	.TX3(hs_data_en_i)
);
defparam U5_OSER82.HWL="false";
defparam U5_OSER82.TXCLK_POL=1'b0;
// @5:418
  OSER8 U5_OSER83 (
	.Q0(buf_douto3),
	.Q1(buf_doutoe3),
	.D0(data_in3[0]),
	.D1(data_in3[1]),
	.D2(data_in3[2]),
	.D3(data_in3[3]),
	.D4(data_in3[4]),
	.D5(data_in3[5]),
	.D6(data_in3[6]),
	.D7(data_in3[7]),
	.FCLK(clk_bit),
	.PCLK(sclk_0),
	.RESET(reset_n_i),
	.TX0(hs_data_en_i),
	.TX1(hs_data_en_i),
	.TX2(hs_data_en_i),
	.TX3(hs_data_en_i)
);
defparam U5_OSER83.HWL="false";
defparam U5_OSER83.TXCLK_POL=1'b0;
// @5:412
  OSER8 U6_OSER8 (
	.Q0(buf_clkout),
	.Q1(buf_clkoe),
	.D0(VCC),
	.D1(GND),
	.D2(VCC),
	.D3(GND),
	.D4(VCC),
	.D5(GND),
	.D6(VCC),
	.D7(GND),
	.FCLK(clk_bit_90),
	.PCLK(sclk_0),
	.RESET(reset_n_i),
	.TX0(hs_clk_en_i),
	.TX1(hs_clk_en_i),
	.TX2(hs_clk_en_i),
	.TX3(hs_clk_en_i)
);
defparam U6_OSER8.HWL="false";
defparam U6_OSER8.TXCLK_POL=1'b0;
  GND GND_cZ (
	.G(GND)
);
  VCC VCC_cZ (
	.V(VCC)
);
endmodule /* \~oserx4.DPHY_TX_TOP_  */

module \~IO_Ctrl_TX.DPHY_TX_TOP_  (
  un1_lp_data3_out,
  lp_data3_out,
  un1_lp_data2_out,
  lp_data2_out,
  un1_lp_data1_out,
  lp_data1_out,
  un1_lp_data0_out,
  lp_data0_out,
  un1_lp_clk_out,
  lp_clk_out,
  un2_LP_DATA0_1z,
  lp_data0_dir,
  un2_LP_DATA1_1z,
  lp_data1_dir,
  un2_LP_DATA2_1z,
  lp_data2_dir,
  un2_LP_DATA3_1z,
  lp_data3_dir,
  un2_LP_CLK_1z,
  lp_clk_dir,
  hs_clk_en_i_1z,
  hs_clk_en,
  hs_data_en_i_1z,
  hs_data_en
)
;
output [1:0] un1_lp_data3_out ;
input [1:0] lp_data3_out ;
output [1:0] un1_lp_data2_out ;
input [1:0] lp_data2_out ;
output [1:0] un1_lp_data1_out ;
input [1:0] lp_data1_out ;
output [1:0] un1_lp_data0_out ;
input [1:0] lp_data0_out ;
output [1:0] un1_lp_clk_out ;
input [1:0] lp_clk_out ;
output un2_LP_DATA0_1z ;
input lp_data0_dir ;
output un2_LP_DATA1_1z ;
input lp_data1_dir ;
output un2_LP_DATA2_1z ;
input lp_data2_dir ;
output un2_LP_DATA3_1z ;
input lp_data3_dir ;
output un2_LP_CLK_1z ;
input lp_clk_dir ;
output hs_clk_en_i_1z ;
input hs_clk_en ;
output hs_data_en_i_1z ;
input hs_data_en ;
wire un2_LP_DATA0_1z ;
wire lp_data0_dir ;
wire un2_LP_DATA1_1z ;
wire lp_data1_dir ;
wire un2_LP_DATA2_1z ;
wire lp_data2_dir ;
wire un2_LP_DATA3_1z ;
wire lp_data3_dir ;
wire un2_LP_CLK_1z ;
wire lp_clk_dir ;
wire hs_clk_en_i_1z ;
wire hs_clk_en ;
wire hs_data_en_i_1z ;
wire hs_data_en ;
wire GND ;
wire VCC ;
// @5:268
  INV hs_data_en_i (
	.I(hs_data_en),
	.O(hs_data_en_i_1z)
);
// @5:267
  INV hs_clk_en_i (
	.I(hs_clk_en),
	.O(hs_clk_en_i_1z)
);
// @5:241
  LUT2 un2_LP_CLK (
	.I0(hs_clk_en),
	.I1(lp_clk_dir),
	.F(un2_LP_CLK_1z)
);
defparam un2_LP_CLK.INIT=4'h1;
// @5:247
  LUT2 un2_LP_DATA3 (
	.I0(hs_data_en),
	.I1(lp_data3_dir),
	.F(un2_LP_DATA3_1z)
);
defparam un2_LP_DATA3.INIT=4'h1;
// @5:253
  LUT2 un2_LP_DATA2 (
	.I0(hs_data_en),
	.I1(lp_data2_dir),
	.F(un2_LP_DATA2_1z)
);
defparam un2_LP_DATA2.INIT=4'h1;
// @5:259
  LUT2 un2_LP_DATA1 (
	.I0(hs_data_en),
	.I1(lp_data1_dir),
	.F(un2_LP_DATA1_1z)
);
defparam un2_LP_DATA1.INIT=4'h1;
// @5:265
  LUT2 un2_LP_DATA0 (
	.I0(hs_data_en),
	.I1(lp_data0_dir),
	.F(un2_LP_DATA0_1z)
);
defparam un2_LP_DATA0.INIT=4'h1;
// @5:267
  LUT2 \un1_lp_clk_out_cZ[0]  (
	.I0(hs_clk_en),
	.I1(lp_clk_out[0]),
	.F(un1_lp_clk_out[0])
);
defparam \un1_lp_clk_out_cZ[0] .INIT=4'h4;
// @5:267
  LUT2 \un1_lp_clk_out_cZ[1]  (
	.I0(hs_clk_en),
	.I1(lp_clk_out[1]),
	.F(un1_lp_clk_out[1])
);
defparam \un1_lp_clk_out_cZ[1] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data0_out_cZ[0]  (
	.I0(hs_data_en),
	.I1(lp_data0_out[0]),
	.F(un1_lp_data0_out[0])
);
defparam \un1_lp_data0_out_cZ[0] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data0_out_cZ[1]  (
	.I0(hs_data_en),
	.I1(lp_data0_out[1]),
	.F(un1_lp_data0_out[1])
);
defparam \un1_lp_data0_out_cZ[1] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data1_out_cZ[0]  (
	.I0(hs_data_en),
	.I1(lp_data1_out[0]),
	.F(un1_lp_data1_out[0])
);
defparam \un1_lp_data1_out_cZ[0] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data1_out_cZ[1]  (
	.I0(hs_data_en),
	.I1(lp_data1_out[1]),
	.F(un1_lp_data1_out[1])
);
defparam \un1_lp_data1_out_cZ[1] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data2_out_cZ[0]  (
	.I0(hs_data_en),
	.I1(lp_data2_out[0]),
	.F(un1_lp_data2_out[0])
);
defparam \un1_lp_data2_out_cZ[0] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data2_out_cZ[1]  (
	.I0(hs_data_en),
	.I1(lp_data2_out[1]),
	.F(un1_lp_data2_out[1])
);
defparam \un1_lp_data2_out_cZ[1] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data3_out_cZ[0]  (
	.I0(hs_data_en),
	.I1(lp_data3_out[0]),
	.F(un1_lp_data3_out[0])
);
defparam \un1_lp_data3_out_cZ[0] .INIT=4'h4;
// @5:268
  LUT2 \un1_lp_data3_out_cZ[1]  (
	.I0(hs_data_en),
	.I1(lp_data3_out[1]),
	.F(un1_lp_data3_out[1])
);
defparam \un1_lp_data3_out_cZ[1] .INIT=4'h4;
  GND GND_cZ (
	.G(GND)
);
  VCC VCC_cZ (
	.V(VCC)
);
endmodule /* \~IO_Ctrl_TX.DPHY_TX_TOP_  */

module \~DPHY_TX.DPHY_TX_TOP_  (
  lp_clk_out,
  un1_lp_clk_out,
  lp_data0_out,
  un1_lp_data0_out,
  lp_data1_out,
  un1_lp_data1_out,
  lp_data2_out,
  un1_lp_data2_out,
  lp_data3_out,
  un1_lp_data3_out,
  data_in0,
  data_in1,
  data_in2,
  data_in3,
  hs_data_en,
  hs_clk_en,
  lp_clk_dir,
  un2_LP_CLK,
  lp_data3_dir,
  un2_LP_DATA3,
  lp_data2_dir,
  un2_LP_DATA2,
  lp_data1_dir,
  un2_LP_DATA1,
  lp_data0_dir,
  un2_LP_DATA0,
  reset_n,
  sclk,
  HS_DATA0_P,
  HS_DATA0_N,
  HS_DATA1_P,
  HS_DATA1_N,
  HS_DATA2_P,
  HS_DATA2_N,
  HS_DATA3_P,
  HS_DATA3_N,
  HS_CLK_P,
  HS_CLK_N,
  clk_bit,
  clk_bit_90
)
;
input [1:0] lp_clk_out ;
output [1:0] un1_lp_clk_out ;
input [1:0] lp_data0_out ;
output [1:0] un1_lp_data0_out ;
input [1:0] lp_data1_out ;
output [1:0] un1_lp_data1_out ;
input [1:0] lp_data2_out ;
output [1:0] un1_lp_data2_out ;
input [1:0] lp_data3_out ;
output [1:0] un1_lp_data3_out ;
input [7:0] data_in0 ;
input [7:0] data_in1 ;
input [7:0] data_in2 ;
input [7:0] data_in3 ;
input hs_data_en ;
input hs_clk_en ;
input lp_clk_dir ;
output un2_LP_CLK ;
input lp_data3_dir ;
output un2_LP_DATA3 ;
input lp_data2_dir ;
output un2_LP_DATA2 ;
input lp_data1_dir ;
output un2_LP_DATA1 ;
input lp_data0_dir ;
output un2_LP_DATA0 ;
input reset_n ;
inout sclk /* synthesis syn_tristate = 1 */ ;
output HS_DATA0_P ;
output HS_DATA0_N ;
output HS_DATA1_P ;
output HS_DATA1_N ;
output HS_DATA2_P ;
output HS_DATA2_N ;
output HS_DATA3_P ;
output HS_DATA3_N ;
output HS_CLK_P ;
output HS_CLK_N ;
input clk_bit ;
input clk_bit_90 ;
wire hs_data_en ;
wire hs_clk_en ;
wire lp_clk_dir ;
wire un2_LP_CLK ;
wire lp_data3_dir ;
wire un2_LP_DATA3 ;
wire lp_data2_dir ;
wire un2_LP_DATA2 ;
wire lp_data1_dir ;
wire un2_LP_DATA1 ;
wire lp_data0_dir ;
wire un2_LP_DATA0 ;
wire reset_n ;
wire sclk ;
wire HS_DATA0_P ;
wire HS_DATA0_N ;
wire HS_DATA1_P ;
wire HS_DATA1_N ;
wire HS_DATA2_P ;
wire HS_DATA2_N ;
wire HS_DATA3_P ;
wire HS_DATA3_N ;
wire HS_CLK_P ;
wire HS_CLK_N ;
wire clk_bit ;
wire clk_bit_90 ;
wire hs_clk_en_i ;
wire hs_data_en_i ;
wire GND ;
wire VCC ;
// @5:163
  \~oserx4.DPHY_TX_TOP_  u_oserx4 (
	.data_in3(data_in3[7:0]),
	.data_in2(data_in2[7:0]),
	.data_in1(data_in1[7:0]),
	.data_in0(data_in0[7:0]),
	.hs_clk_en_i(hs_clk_en_i),
	.clk_bit_90(clk_bit_90),
	.hs_data_en_i(hs_data_en_i),
	.clk_bit(clk_bit),
	.HS_CLK_N(HS_CLK_N),
	.HS_CLK_P(HS_CLK_P),
	.HS_DATA3_N(HS_DATA3_N),
	.HS_DATA3_P(HS_DATA3_P),
	.HS_DATA2_N(HS_DATA2_N),
	.HS_DATA2_P(HS_DATA2_P),
	.HS_DATA1_N(HS_DATA1_N),
	.HS_DATA1_P(HS_DATA1_P),
	.HS_DATA0_N(HS_DATA0_N),
	.HS_DATA0_P(HS_DATA0_P),
	.sclk_0(sclk),
	.reset_n(reset_n)
);
  \~IO_Ctrl_TX.DPHY_TX_TOP_  u_IO_Ctrl_TX (
	.un1_lp_data3_out(un1_lp_data3_out[1:0]),
	.lp_data3_out(lp_data3_out[1:0]),
	.un1_lp_data2_out(un1_lp_data2_out[1:0]),
	.lp_data2_out(lp_data2_out[1:0]),
	.un1_lp_data1_out(un1_lp_data1_out[1:0]),
	.lp_data1_out(lp_data1_out[1:0]),
	.un1_lp_data0_out(un1_lp_data0_out[1:0]),
	.lp_data0_out(lp_data0_out[1:0]),
	.un1_lp_clk_out(un1_lp_clk_out[1:0]),
	.lp_clk_out(lp_clk_out[1:0]),
	.un2_LP_DATA0_1z(un2_LP_DATA0),
	.lp_data0_dir(lp_data0_dir),
	.un2_LP_DATA1_1z(un2_LP_DATA1),
	.lp_data1_dir(lp_data1_dir),
	.un2_LP_DATA2_1z(un2_LP_DATA2),
	.lp_data2_dir(lp_data2_dir),
	.un2_LP_DATA3_1z(un2_LP_DATA3),
	.lp_data3_dir(lp_data3_dir),
	.un2_LP_CLK_1z(un2_LP_CLK),
	.lp_clk_dir(lp_clk_dir),
	.hs_clk_en_i_1z(hs_clk_en_i),
	.hs_clk_en(hs_clk_en),
	.hs_data_en_i_1z(hs_data_en_i),
	.hs_data_en(hs_data_en)
);
  GND GND_cZ (
	.G(GND)
);
  VCC VCC_cZ (
	.V(VCC)
);
endmodule /* \~DPHY_TX.DPHY_TX_TOP_  */

module DPHY_TX_TOP (
  reset_n,
  HS_CLK_P,
  HS_CLK_N,
  clk_bit,
  clk_bit_90,
  HS_DATA3_P,
  HS_DATA3_N,
  data_in3,
  HS_DATA2_P,
  HS_DATA2_N,
  data_in2,
  HS_DATA1_P,
  HS_DATA1_N,
  data_in1,
  HS_DATA0_P,
  HS_DATA0_N,
  data_in0,
  LP_CLK,
  lp_clk_out,
  lp_clk_in,
  lp_clk_dir,
  LP_DATA3,
  lp_data3_out,
  lp_data3_in,
  lp_data3_dir,
  LP_DATA2,
  lp_data2_out,
  lp_data2_in,
  lp_data2_dir,
  LP_DATA1,
  lp_data1_out,
  lp_data1_in,
  lp_data1_dir,
  LP_DATA0,
  lp_data0_out,
  lp_data0_in,
  lp_data0_dir,
  hs_clk_en,
  hs_data_en,
  sclk
)
;
input reset_n ;
output HS_CLK_P ;
output HS_CLK_N ;
input clk_bit ;
input clk_bit_90 ;
output HS_DATA3_P ;
output HS_DATA3_N ;
input [7:0] data_in3 ;
output HS_DATA2_P ;
output HS_DATA2_N ;
input [7:0] data_in2 ;
output HS_DATA1_P ;
output HS_DATA1_N ;
input [7:0] data_in1 ;
output HS_DATA0_P ;
output HS_DATA0_N ;
input [7:0] data_in0 ;
inout [1:0] LP_CLK /* synthesis syn_tristate = 1 */ ;
input [1:0] lp_clk_out ;
output [1:0] lp_clk_in /* synthesis syn_tristate = 1 */ ;
input lp_clk_dir ;
inout [1:0] LP_DATA3 /* synthesis syn_tristate = 1 */ ;
input [1:0] lp_data3_out ;
output [1:0] lp_data3_in /* synthesis syn_tristate = 1 */ ;
input lp_data3_dir ;
inout [1:0] LP_DATA2 /* synthesis syn_tristate = 1 */ ;
input [1:0] lp_data2_out ;
output [1:0] lp_data2_in /* synthesis syn_tristate = 1 */ ;
input lp_data2_dir ;
inout [1:0] LP_DATA1 /* synthesis syn_tristate = 1 */ ;
input [1:0] lp_data1_out ;
output [1:0] lp_data1_in /* synthesis syn_tristate = 1 */ ;
input lp_data1_dir ;
inout [1:0] LP_DATA0 /* synthesis syn_tristate = 1 */ ;
input [1:0] lp_data0_out ;
output [1:0] lp_data0_in /* synthesis syn_tristate = 1 */ ;
input lp_data0_dir ;
input hs_clk_en ;
input hs_data_en ;
output sclk /* synthesis syn_tristate = 1 */ ;
wire reset_n ;
wire HS_CLK_P ;
wire HS_CLK_N ;
wire clk_bit ;
wire clk_bit_90 ;
wire HS_DATA3_P ;
wire HS_DATA3_N ;
wire HS_DATA2_P ;
wire HS_DATA2_N ;
wire HS_DATA1_P ;
wire HS_DATA1_N ;
wire HS_DATA0_P ;
wire HS_DATA0_N ;
wire lp_clk_dir ;
wire lp_data3_dir ;
wire lp_data2_dir ;
wire lp_data1_dir ;
wire lp_data0_dir ;
wire hs_clk_en ;
wire hs_data_en ;
wire sclk ;
wire [1:0] un1_lp_clk_out;
wire [1:0] un1_lp_data3_out;
wire [1:0] un1_lp_data2_out;
wire [1:0] un1_lp_data1_out;
wire [1:0] un1_lp_data0_out;
wire GND ;
wire VCC ;
wire un2_LP_CLK ;
wire un2_LP_DATA3 ;
wire un2_LP_DATA2 ;
wire un2_LP_DATA1 ;
wire un2_LP_DATA0 ;
  GSR GSR_INST (
	.GSRI(VCC)
);
// @5:277
  IOBUF \un4_LP_DATA0[1]  (
	.O(lp_data0_in[1]),
	.IO(LP_DATA0[1]),
	.I(un1_lp_data0_out[1]),
	.OEN(un2_LP_DATA0)
);
// @5:277
  IOBUF \un4_LP_DATA0[0]  (
	.O(lp_data0_in[0]),
	.IO(LP_DATA0[0]),
	.I(un1_lp_data0_out[0]),
	.OEN(un2_LP_DATA0)
);
// @5:282
  IOBUF \un4_LP_DATA1[1]  (
	.O(lp_data1_in[1]),
	.IO(LP_DATA1[1]),
	.I(un1_lp_data1_out[1]),
	.OEN(un2_LP_DATA1)
);
// @5:282
  IOBUF \un4_LP_DATA1[0]  (
	.O(lp_data1_in[0]),
	.IO(LP_DATA1[0]),
	.I(un1_lp_data1_out[0]),
	.OEN(un2_LP_DATA1)
);
// @5:287
  IOBUF \un4_LP_DATA2[1]  (
	.O(lp_data2_in[1]),
	.IO(LP_DATA2[1]),
	.I(un1_lp_data2_out[1]),
	.OEN(un2_LP_DATA2)
);
// @5:287
  IOBUF \un4_LP_DATA2[0]  (
	.O(lp_data2_in[0]),
	.IO(LP_DATA2[0]),
	.I(un1_lp_data2_out[0]),
	.OEN(un2_LP_DATA2)
);
// @5:292
  IOBUF \un4_LP_DATA3[1]  (
	.O(lp_data3_in[1]),
	.IO(LP_DATA3[1]),
	.I(un1_lp_data3_out[1]),
	.OEN(un2_LP_DATA3)
);
// @5:292
  IOBUF \un4_LP_DATA3[0]  (
	.O(lp_data3_in[0]),
	.IO(LP_DATA3[0]),
	.I(un1_lp_data3_out[0]),
	.OEN(un2_LP_DATA3)
);
// @5:272
  IOBUF \un6_LP_CLK[1]  (
	.O(lp_clk_in[1]),
	.IO(LP_CLK[1]),
	.I(un1_lp_clk_out[1]),
	.OEN(un2_LP_CLK)
);
// @5:272
  IOBUF \un6_LP_CLK[0]  (
	.O(lp_clk_in[0]),
	.IO(LP_CLK[0]),
	.I(un1_lp_clk_out[0]),
	.OEN(un2_LP_CLK)
);
  \~DPHY_TX.DPHY_TX_TOP_  DPHY_TX_INST (
	.lp_clk_out(lp_clk_out[1:0]),
	.un1_lp_clk_out(un1_lp_clk_out[1:0]),
	.lp_data0_out(lp_data0_out[1:0]),
	.un1_lp_data0_out(un1_lp_data0_out[1:0]),
	.lp_data1_out(lp_data1_out[1:0]),
	.un1_lp_data1_out(un1_lp_data1_out[1:0]),
	.lp_data2_out(lp_data2_out[1:0]),
	.un1_lp_data2_out(un1_lp_data2_out[1:0]),
	.lp_data3_out(lp_data3_out[1:0]),
	.un1_lp_data3_out(un1_lp_data3_out[1:0]),
	.data_in0(data_in0[7:0]),
	.data_in1(data_in1[7:0]),
	.data_in2(data_in2[7:0]),
	.data_in3(data_in3[7:0]),
	.hs_data_en(hs_data_en),
	.hs_clk_en(hs_clk_en),
	.lp_clk_dir(lp_clk_dir),
	.un2_LP_CLK(un2_LP_CLK),
	.lp_data3_dir(lp_data3_dir),
	.un2_LP_DATA3(un2_LP_DATA3),
	.lp_data2_dir(lp_data2_dir),
	.un2_LP_DATA2(un2_LP_DATA2),
	.lp_data1_dir(lp_data1_dir),
	.un2_LP_DATA1(un2_LP_DATA1),
	.lp_data0_dir(lp_data0_dir),
	.un2_LP_DATA0(un2_LP_DATA0),
	.reset_n(reset_n),
	.sclk(sclk),
	.HS_DATA0_P(HS_DATA0_P),
	.HS_DATA0_N(HS_DATA0_N),
	.HS_DATA1_P(HS_DATA1_P),
	.HS_DATA1_N(HS_DATA1_N),
	.HS_DATA2_P(HS_DATA2_P),
	.HS_DATA2_N(HS_DATA2_N),
	.HS_DATA3_P(HS_DATA3_P),
	.HS_DATA3_N(HS_DATA3_N),
	.HS_CLK_P(HS_CLK_P),
	.HS_CLK_N(HS_CLK_N),
	.clk_bit(clk_bit),
	.clk_bit_90(clk_bit_90)
);
  GND GND_cZ (
	.G(GND)
);
  VCC VCC_cZ (
	.V(VCC)
);
endmodule /* DPHY_TX_TOP */


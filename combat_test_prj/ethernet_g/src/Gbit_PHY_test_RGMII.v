// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2016 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] sdrc_top.v
//   \ \  / /\ \  / /    [Description ] SDRAM Controller
//    \ \/ /  \ \/ /     [Timestamp   ] Wednesday June 22 10:00:30 2016
//     \  /    \  /      [version     ] 1.0.0
//      \/      \/       
//
// ===========Oooo==========================================Oooo========
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author |Mod. Date |Changes Made:
// V1.0 | XX     |06/22/16  |Initial version
// ===========Oooo==========================================Oooo========

`timescale 1 ns / 1 ps
//`define DISABLE_CPU_IO_BUS 0

module Gbit_PHY_test_RGMII (
                input clk,
                input I_rst_n,
                //MDC
                output	O_phy_mdc,
                output	IO_phy_mdio,
				// PHY1
				output	[3:0] O_phy1_txd,
				output	O_phy1_txen, 
				output	O_phy1_gtxclk, 

				input	[3:0] I_phy1_rxd,
				input	I_phy1_rxdv, 
				input	I_phy1_rxc, 

				output	reg [7:0] test_d,
				output	reg test_dv,


                output  O_rst_n//phy rst

            );
/*******************************************************************************
 *******************************************************************************/
  parameter  DELAY_VALUE=50;//;0~127
	/*******************************************************************************
	 * reg and wire definintion
	 *******************************************************************************/
	reg [7:0]  Phy1_rxd;  
	wire [7:0]  Phy1_rxd0;   
 
	reg Phy1_rxdv;  
	wire Phy1_rxdv0;   
 
   reg  [31:0]   clk_cnt1=0;
	/*******************************************************************************/
    assign   IO_phy_mdio=0;
    assign   O_phy_mdc=0;
    assign   O_rst_n=I_rst_n;

/*********************PHY1 INPUT*******************************************/

///////////////////
   generate
	genvar m ;
		for(m=0;m<=3;m=m+1) 
		begin
                IODELAY #(.C_STATIC_DLY(DELAY_VALUE))//integer,0~127
                IODELAY_inst_dq1(
                .DO(Phy1_rxd0[m]), 
                .DF(), 
                .DI(I_phy1_rxd[m]), 
                .SDTAP(0), 
                .SETN(0), 
                .VALUE(0)
                );

		end
   endgenerate

   generate
	genvar i ;
		for(i=0;i<=3;i=i+1) 
		begin
		IDDR	  U_IDDR_dq1
						(.Q0(Phy1_rxd[i]), 
						.Q1(Phy1_rxd[i+4]), 
						.D(Phy1_rxd0[i]), 
						.CLK(I_phy1_rxc) 
						);
		end
   endgenerate
///////////////////
IODELAY #(.C_STATIC_DLY(DELAY_VALUE))//integer,0~127
        IODELAY_inst_dv1(
        .DO(Phy1_rxdv0), 
        .DF(), 
        .DI(I_phy1_rxdv), 
        .SDTAP(0), 
        .SETN(0), 
        .VALUE(0)
        );

		IDDR	  U_IDDR_dv1
						(.Q0(Phy1_rxdv), 
						.Q1(), 
						.D(Phy1_rxdv0), 
						.CLK(I_phy1_rxc) 
						);


/*********************PHY1 OUTPUT*******************************************/
  generate
	genvar j ;
		for(j=0;j<=3;j=j+1) 
		begin
		ODDR	  U_ODDR_dq1
						(.Q0(O_phy1_txd[j]), 
						.Q1(),
						.D0(0), 
						.D1(0), 
						.TX(1),
						.CLK(I_phy1_rxc) 
						);
		end
   endgenerate
		ODDR	  U_ODDR_en1
						(.Q0(O_phy1_txen), 
						.Q1(),

						.D0(0), 
						.D1(0), 
						.TX(1),

						.CLK(I_phy1_rxc) 
						);
		ODDR	  U_ODDR_clk1
						(.Q0(O_phy1_gtxclk), 
						.Q1(),

						.D0(1), 
						.D1(0), 
						.TX(1),

						.CLK(I_phy1_rxc) 
						);
always@(posedge I_phy1_rxc)
begin
	test_d<=Phy1_rxd;
	test_dv<=Phy1_rxdv;
end
endmodule // sdram_controller

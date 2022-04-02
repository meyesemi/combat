//========Oooo=========================================Oooo========
//=     Copyright ©2015-2016 Gowin Semiconductor Corporation.     =
//=                     All rights reserved.                      =
//========Oooo=========================================Oooo========

// gwModGen version: 1.6.2Beta
// Thu Nov 10 18:07:47 2016

module GW_PLL (clkout, lock, clkoutp, clkin);

output clkout;
output lock;
output clkoutp;
input clkin;

wire clkoutd_o;
wire clkoutd3_o;
wire sg12_tilo;

assign sg12_tilo = 1'b0;

PLL pll_inst (
    .CLKOUT(clkout),
    .LOCK(lock),
    .CLKOUTP(clkoutp),
    .CLKOUTD(clkoutd_o),
    .CLKOUTD3(clkoutd3_o),
    .RESET(sg12_tilo),
    .RESET_P(sg12_tilo),
    .RESET_I(sg12_tilo),
    .RESET_S(sg12_tilo),
    .CLKIN({clkin,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo}),
    .CLKFB(sg12_tilo),
    .INSEL({sg12_tilo,sg12_tilo,sg12_tilo}),
    .FBDSEL({sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo}),
    .IDSEL({sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo}),
    .PSDA({sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo}),
    .DUTYDA({sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo}),
    .FDLY({sg12_tilo,sg12_tilo,sg12_tilo,sg12_tilo})
);

defparam pll_inst.FCLKIN = "125";
defparam pll_inst.DYN_IN_SEL = "false";
defparam pll_inst.IN_SEL = 0;
defparam pll_inst.DYN_IDIV_SEL = "false";
defparam pll_inst.IDIV_SEL = 4;
defparam pll_inst.DYN_FBDIV_SEL = "false";
defparam pll_inst.FBDIV_SEL = 15;
defparam pll_inst.ODIV_SEL = 2;
defparam pll_inst.PSDA_SEL = "1011";
defparam pll_inst.DYN_DA_EN = "false";
defparam pll_inst.DUTYDA_SEL = "1000";
defparam pll_inst.CLKOUT_FT_DIR = 1'b1;
defparam pll_inst.CLKOUTP_FT_DIR = 1'b1;
defparam pll_inst.CLKOUT_DLY_STEP = 0;
defparam pll_inst.CLKOUTP_DLY_STEP = 0;
defparam pll_inst.CLKFB_SEL = 2;
defparam pll_inst.CLKOUT_BYPASS = "false";
defparam pll_inst.CLKOUTP_BYPASS = "false";
defparam pll_inst.CLKOUTD_BYPASS = "false";
defparam pll_inst.DYN_SDIV_SEL = 2;
defparam pll_inst.CLKOUTD_SRC = "CLKOUT";
defparam pll_inst.CLKOUTD3_SRC = "CLKOUT";

endmodule //GW_PLL

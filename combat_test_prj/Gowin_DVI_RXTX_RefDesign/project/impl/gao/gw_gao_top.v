module gw_gao(
    rx0_de,
    rx0_hsync,
    rx0_vsync,
    \rx0_b[7] ,
    \rx0_b[6] ,
    \rx0_b[5] ,
    \rx0_b[4] ,
    \rx0_b[3] ,
    \rx0_b[2] ,
    \rx0_b[1] ,
    \rx0_b[0] ,
    \rx0_g[7] ,
    \rx0_g[6] ,
    \rx0_g[5] ,
    \rx0_g[4] ,
    \rx0_g[3] ,
    \rx0_g[2] ,
    \rx0_g[1] ,
    \rx0_g[0] ,
    \rx0_r[7] ,
    \rx0_r[6] ,
    \rx0_r[5] ,
    \rx0_r[4] ,
    \rx0_r[3] ,
    \rx0_r[2] ,
    \rx0_r[1] ,
    \rx0_r[0] ,
    rx0_pclk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input rx0_de;
input rx0_hsync;
input rx0_vsync;
input \rx0_b[7] ;
input \rx0_b[6] ;
input \rx0_b[5] ;
input \rx0_b[4] ;
input \rx0_b[3] ;
input \rx0_b[2] ;
input \rx0_b[1] ;
input \rx0_b[0] ;
input \rx0_g[7] ;
input \rx0_g[6] ;
input \rx0_g[5] ;
input \rx0_g[4] ;
input \rx0_g[3] ;
input \rx0_g[2] ;
input \rx0_g[1] ;
input \rx0_g[0] ;
input \rx0_r[7] ;
input \rx0_r[6] ;
input \rx0_r[5] ;
input \rx0_r[4] ;
input \rx0_r[3] ;
input \rx0_r[2] ;
input \rx0_r[1] ;
input \rx0_r[0] ;
input rx0_pclk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire rx0_de;
wire rx0_hsync;
wire rx0_vsync;
wire \rx0_b[7] ;
wire \rx0_b[6] ;
wire \rx0_b[5] ;
wire \rx0_b[4] ;
wire \rx0_b[3] ;
wire \rx0_b[2] ;
wire \rx0_b[1] ;
wire \rx0_b[0] ;
wire \rx0_g[7] ;
wire \rx0_g[6] ;
wire \rx0_g[5] ;
wire \rx0_g[4] ;
wire \rx0_g[3] ;
wire \rx0_g[2] ;
wire \rx0_g[1] ;
wire \rx0_g[0] ;
wire \rx0_r[7] ;
wire \rx0_r[6] ;
wire \rx0_r[5] ;
wire \rx0_r[4] ;
wire \rx0_r[3] ;
wire \rx0_r[2] ;
wire \rx0_r[1] ;
wire \rx0_r[0] ;
wire rx0_pclk;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;
wire tdo_er2;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(tdo_er2)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i(rx0_de),
    .data_i({rx0_de,rx0_hsync,rx0_vsync,\rx0_b[7] ,\rx0_b[6] ,\rx0_b[5] ,\rx0_b[4] ,\rx0_b[3] ,\rx0_b[2] ,\rx0_b[1] ,\rx0_b[0] ,\rx0_g[7] ,\rx0_g[6] ,\rx0_g[5] ,\rx0_g[4] ,\rx0_g[3] ,\rx0_g[2] ,\rx0_g[1] ,\rx0_g[0] ,\rx0_r[7] ,\rx0_r[6] ,\rx0_r[5] ,\rx0_r[4] ,\rx0_r[3] ,\rx0_r[2] ,\rx0_r[1] ,\rx0_r[0] }),
    .clk_i(rx0_pclk)
);

endmodule

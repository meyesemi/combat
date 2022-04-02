module gw_gao(
    test_dv_c,
    \test_d_c[7] ,
    \test_d_c[6] ,
    \test_d_c[5] ,
    \test_d_c[4] ,
    \test_d_c[3] ,
    \test_d_c[2] ,
    \test_d_c[1] ,
    \test_d_c[0] ,
    I_phy1_rxc_c,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input test_dv_c;
input \test_d_c[7] ;
input \test_d_c[6] ;
input \test_d_c[5] ;
input \test_d_c[4] ;
input \test_d_c[3] ;
input \test_d_c[2] ;
input \test_d_c[1] ;
input \test_d_c[0] ;
input I_phy1_rxc_c;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire test_dv_c;
wire \test_d_c[7] ;
wire \test_d_c[6] ;
wire \test_d_c[5] ;
wire \test_d_c[4] ;
wire \test_d_c[3] ;
wire \test_d_c[2] ;
wire \test_d_c[1] ;
wire \test_d_c[0] ;
wire I_phy1_rxc_c;
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
    .trig0_i(test_dv_c),
    .data_i({test_dv_c,\test_d_c[7] ,\test_d_c[6] ,\test_d_c[5] ,\test_d_c[4] ,\test_d_c[3] ,\test_d_c[2] ,\test_d_c[1] ,\test_d_c[0] }),
    .clk_i(I_phy1_rxc_c)
);

endmodule

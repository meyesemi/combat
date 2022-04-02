module gw_gao(
    \cmos_d[7] ,
    \cmos_d[6] ,
    \cmos_d[5] ,
    \cmos_d[4] ,
    \cmos_d[3] ,
    \cmos_d[2] ,
    \cmos_d[1] ,
    \cmos_d[0] ,
    \cmos_d_16bit[15] ,
    \cmos_d_16bit[14] ,
    \cmos_d_16bit[13] ,
    \cmos_d_16bit[12] ,
    \cmos_d_16bit[11] ,
    \cmos_d_16bit[10] ,
    \cmos_d_16bit[9] ,
    \cmos_d_16bit[8] ,
    \cmos_d_16bit[7] ,
    \cmos_d_16bit[6] ,
    \cmos_d_16bit[5] ,
    \cmos_d_16bit[4] ,
    \cmos_d_16bit[3] ,
    \cmos_d_16bit[2] ,
    \cmos_d_16bit[1] ,
    \cmos_d_16bit[0] ,
    cmos_href_16bit,
    cmos_href,
    cmos_pclk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \cmos_d[7] ;
input \cmos_d[6] ;
input \cmos_d[5] ;
input \cmos_d[4] ;
input \cmos_d[3] ;
input \cmos_d[2] ;
input \cmos_d[1] ;
input \cmos_d[0] ;
input \cmos_d_16bit[15] ;
input \cmos_d_16bit[14] ;
input \cmos_d_16bit[13] ;
input \cmos_d_16bit[12] ;
input \cmos_d_16bit[11] ;
input \cmos_d_16bit[10] ;
input \cmos_d_16bit[9] ;
input \cmos_d_16bit[8] ;
input \cmos_d_16bit[7] ;
input \cmos_d_16bit[6] ;
input \cmos_d_16bit[5] ;
input \cmos_d_16bit[4] ;
input \cmos_d_16bit[3] ;
input \cmos_d_16bit[2] ;
input \cmos_d_16bit[1] ;
input \cmos_d_16bit[0] ;
input cmos_href_16bit;
input cmos_href;
input cmos_pclk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \cmos_d[7] ;
wire \cmos_d[6] ;
wire \cmos_d[5] ;
wire \cmos_d[4] ;
wire \cmos_d[3] ;
wire \cmos_d[2] ;
wire \cmos_d[1] ;
wire \cmos_d[0] ;
wire \cmos_d_16bit[15] ;
wire \cmos_d_16bit[14] ;
wire \cmos_d_16bit[13] ;
wire \cmos_d_16bit[12] ;
wire \cmos_d_16bit[11] ;
wire \cmos_d_16bit[10] ;
wire \cmos_d_16bit[9] ;
wire \cmos_d_16bit[8] ;
wire \cmos_d_16bit[7] ;
wire \cmos_d_16bit[6] ;
wire \cmos_d_16bit[5] ;
wire \cmos_d_16bit[4] ;
wire \cmos_d_16bit[3] ;
wire \cmos_d_16bit[2] ;
wire \cmos_d_16bit[1] ;
wire \cmos_d_16bit[0] ;
wire cmos_href_16bit;
wire cmos_href;
wire cmos_pclk;
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
    .trig0_i(cmos_href),
    .data_i({\cmos_d[7] ,\cmos_d[6] ,\cmos_d[5] ,\cmos_d[4] ,\cmos_d[3] ,\cmos_d[2] ,\cmos_d[1] ,\cmos_d[0] ,\cmos_d_16bit[15] ,\cmos_d_16bit[14] ,\cmos_d_16bit[13] ,\cmos_d_16bit[12] ,\cmos_d_16bit[11] ,\cmos_d_16bit[10] ,\cmos_d_16bit[9] ,\cmos_d_16bit[8] ,\cmos_d_16bit[7] ,\cmos_d_16bit[6] ,\cmos_d_16bit[5] ,\cmos_d_16bit[4] ,\cmos_d_16bit[3] ,\cmos_d_16bit[2] ,\cmos_d_16bit[1] ,\cmos_d_16bit[0] ,cmos_href_16bit,cmos_href}),
    .clk_i(cmos_pclk)
);

endmodule

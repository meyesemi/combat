
#Begin clock constraint
define_clock -name {video_top|I_clk} {p:video_top|I_clk} -period 7.002 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 3.501 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~dvi2rgb_DVI_RX_Top__|O_rgb_clk_inferred_clock} {n:_~dvi2rgb_DVI_RX_Top__|O_rgb_clk_inferred_clock} -period 11.057 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 5.529 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~rgb2dvi_DVI_TX_Top__|serial_clk_inferred_clock} {n:_~rgb2dvi_DVI_TX_Top__|serial_clk_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~dvi2rgb_DVI_RX_Top__|hdmi_dclk_inferred_clock} {n:_~dvi2rgb_DVI_RX_Top__|hdmi_dclk_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

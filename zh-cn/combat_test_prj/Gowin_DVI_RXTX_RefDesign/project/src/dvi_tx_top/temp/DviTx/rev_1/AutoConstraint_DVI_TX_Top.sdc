
#Begin clock constraint
define_clock -name {DVI_TX_Top|I_rgb_clk} {p:DVI_TX_Top|I_rgb_clk} -period 11.057 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 5.529 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~rgb2dvi_DVI_TX_Top_|serial_clk_inferred_clock} {n:_~rgb2dvi_DVI_TX_Top_|serial_clk_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

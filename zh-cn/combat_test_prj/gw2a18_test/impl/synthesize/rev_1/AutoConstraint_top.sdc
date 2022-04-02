
#Begin clock constraint
define_clock -name {hdmi_out_top|clk_in_inferred_clock} {n:hdmi_out_top|clk_in_inferred_clock} -period 5.934 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 2.967 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {TMDS_pll|clkout_inferred_clock} {n:TMDS_pll|clkout_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {hdmi_out_top|clk_in1_inferred_clock} {n:hdmi_out_top|clk_in1_inferred_clock} -period 5.753 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 2.876 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {top|clk_50} {p:top|clk_50} -period 3.850 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 1.925 -route 0.000 
#End clock constraint

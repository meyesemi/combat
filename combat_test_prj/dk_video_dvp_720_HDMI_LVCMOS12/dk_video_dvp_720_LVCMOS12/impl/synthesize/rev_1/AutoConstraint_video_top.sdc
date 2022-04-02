
#Begin clock constraint
define_clock -name {video_top|cmos_pclk} {p:video_top|cmos_pclk} -period 5.244 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 2.622 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {video_top|pix_clk} {n:video_top|pix_clk} -period 9.662 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 4.831 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {video_top|I_clk} {p:video_top|I_clk} -period 5.547 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 2.773 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {TMDS_PLL|clkout_inferred_clock} {n:TMDS_PLL|clkout_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_top_DDR3_Memory_Interface_Top_|clk_out_inferred_clock} {n:_~ddr_phy_top_DDR3_Memory_Interface_Top_|clk_out_inferred_clock} -period 8502.420 -clockgroup Autoconstr_clkgroup_4 -rise 0.000 -fall 4251.210 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_top_DDR3_Memory_Interface_Top_|clk_x4i_inferred_clock} {n:_~ddr_phy_top_DDR3_Memory_Interface_Top_|clk_x4i_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_5 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsw0_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsw0_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_6 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsw270_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsw270_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_7 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsr90_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_0_|dqsr90_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_8 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsw0_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsw0_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_9 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsw270_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsw270_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_10 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsr90_inferred_clock} {n:_~ddr_phy_data_io_DDR3_Memory_Interface_Top_|dqsr90_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_11 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {video_top|I_clk_27M} {p:video_top|I_clk_27M} -period 5.148 -clockgroup Autoconstr_clkgroup_12 -rise 0.000 -fall 2.574 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {reg_config|clock_20k_derived_clock} {n:reg_config|clock_20k_derived_clock} -period 5.148 -clockgroup Autoconstr_clkgroup_12 -rise 0.000 -fall 2.574 -route 0.000 
#End clock constraint

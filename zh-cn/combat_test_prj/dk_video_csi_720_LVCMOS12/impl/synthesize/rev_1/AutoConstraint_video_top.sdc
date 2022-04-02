
#Begin clock constraint
define_clock -name {video_top|pix_clk} {n:video_top|pix_clk} -period 10.109 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 5.054 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {video_top|I_clk} {p:video_top|I_clk} -period 5.601 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 2.800 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {TMDS_PLL|clkout_inferred_clock} {n:TMDS_PLL|clkout_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top|clk_out_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top|clk_out_inferred_clock} -period 8502.420 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 4251.210 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw0_0_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw0_0_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_4 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top|clk_x4i_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top|clk_x4i_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_5 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw270_0_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw270_0_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_6 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsr90_1_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[0]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsr90_1_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_7 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw0_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw0_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_8 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw270_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsw270_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_9 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsr90_inferred_clock} {n:_DDR3_Memory_Interface_Top/gw3mc_top/u_ddr_phy_top/u_ddr_phy_wd/data_lane_gen[1]_u_ddr_phy_data_lane/u_ddr_phy_data_io_|dqsr90_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_10 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {pll_8bit_2lane|clkout_inferred_clock} {n:pll_8bit_2lane|clkout_inferred_clock} -period 8500.713 -clockgroup Autoconstr_clkgroup_11 -rise 0.000 -fall 4250.357 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~idesx4_DPHY_RX_TOP__|clk_byte_out_inferred_clock} {n:_~idesx4_DPHY_RX_TOP__|clk_byte_out_inferred_clock} -period 6.586 -clockgroup Autoconstr_clkgroup_12 -rise 0.000 -fall 3.293 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~idesx4_DPHY_RX_TOP__|eclko_inferred_clock} {n:_~idesx4_DPHY_RX_TOP__|eclko_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_13 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~DPHY_RX_DPHY_RX_TOP__|HS_CLK_inferred_clock} {n:_~DPHY_RX_DPHY_RX_TOP__|HS_CLK_inferred_clock} -period 1.635 -clockgroup Autoconstr_clkgroup_14 -rise 0.000 -fall 0.817 -route 0.000 
#End clock constraint

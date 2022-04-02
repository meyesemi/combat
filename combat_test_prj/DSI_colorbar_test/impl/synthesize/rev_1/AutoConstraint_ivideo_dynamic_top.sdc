
#Begin clock constraint
define_clock -name {ivideo_dynamic_top|I_clk} {p:ivideo_dynamic_top|I_clk} -period 3.204 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 1.602 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {_~oserx4_DPHY_TX_TOP__|sclk_0_inferred_clock} {n:_~oserx4_DPHY_TX_TOP__|sclk_0_inferred_clock} -period 5.154 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 2.577 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {ivideo_dynamic_top|O_lcd_clkos_wire_inferred_clock} {n:ivideo_dynamic_top|O_lcd_clkos_wire_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {ivideo_dynamic_top|O_lcd_clkop_wire_inferred_clock} {n:ivideo_dynamic_top|O_lcd_clkop_wire_inferred_clock} -period 66667.000 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 33333.500 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {GW_PLL|clkout_inferred_clock} {n:GW_PLL|clkout_inferred_clock} -period 5.419 -clockgroup Autoconstr_clkgroup_4 -rise 0.000 -fall 2.709 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {mipi_dsi_top|I_mipi_init_clk_derived_clock} {n:mipi_dsi_top|I_mipi_init_clk_derived_clock} -period 192656.075 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 96328.037 -route 0.000 
#End clock constraint

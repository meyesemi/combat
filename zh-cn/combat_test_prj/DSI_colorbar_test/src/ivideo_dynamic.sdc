create_clock -name user_clk -period 8 -waveform {0 6.667} [get_nets {I_userclk}]
create_clock -name sclk -period 13.333 -waveform {0 6.667} [get_nets {sclk}]
create_clock -name sclk1 -period 13.333 -waveform {0 6.667} [get_nets {sclk1}]
set_operating_conditions -grade c -model fast -speed 6 -setup

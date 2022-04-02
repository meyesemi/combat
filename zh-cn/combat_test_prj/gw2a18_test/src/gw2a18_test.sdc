//Copyright (C)2014-2020 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.6.01 Beta
//Created Time: 2020-08-06 16:49:40
create_clock -name clk_27 -period 37.037 -waveform {0 18.518} [get_ports {clk}]
create_clock -name pix_clk -period 13.468 -waveform {0 6.734} [get_nets {lcd_clk}]

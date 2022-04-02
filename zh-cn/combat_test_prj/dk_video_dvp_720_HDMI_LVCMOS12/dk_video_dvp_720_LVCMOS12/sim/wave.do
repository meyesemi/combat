onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/cmos_pclk
add wave -noupdate /tb/cmos_d_16bit
add wave -noupdate /tb/cmos_href_16bit
add wave -noupdate /tb/cmos_d_d0
add wave -noupdate /tb/cmos_href_d0
add wave -noupdate /tb/cmos_vsync_d0
add wave -noupdate /tb/cmos_hblank
add wave -noupdate /tb/pixel_clk_16bit
add wave -noupdate /tb/cmos_8_16bit_m0/rst
add wave -noupdate /tb/cmos_8_16bit_m0/pclk
add wave -noupdate /tb/cmos_8_16bit_m0/pdata_i
add wave -noupdate /tb/cmos_8_16bit_m0/de_i
add wave -noupdate /tb/cmos_8_16bit_m0/pixel_clk
add wave -noupdate /tb/cmos_8_16bit_m0/pdata_o
add wave -noupdate /tb/cmos_8_16bit_m0/hblank
add wave -noupdate /tb/cmos_8_16bit_m0/pixel_clk_reg1
add wave -noupdate /tb/cmos_8_16bit_m0/de_o
add wave -noupdate /tb/cmos_8_16bit_m0/pdata_i_d0
add wave -noupdate /tb/cmos_8_16bit_m0/pdata_i_d1
add wave -noupdate /tb/cmos_8_16bit_m0/de_i_d0
add wave -noupdate /tb/cmos_8_16bit_m0/pixel_clk_reg
add wave -noupdate /tb/cmos_8_16bit_m0/x_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1015000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {953984 ps} {1036016 ps}

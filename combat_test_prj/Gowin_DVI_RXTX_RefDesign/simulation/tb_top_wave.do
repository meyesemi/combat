onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {input paramters}
add wave -noupdate -radix ascii       /tb_top/BMP_VIDEO_FORMAT   
add wave -noupdate                    /tb_top/BMP_PIXEL_CLK_FREQ 
add wave -noupdate -radix unsigned    /tb_top/BMP_WIDTH      
add wave -noupdate -radix unsigned    /tb_top/BMP_HEIGHT     
add wave -noupdate -radix ascii       /tb_top/BMP_OPENED_NAME
add wave -noupdate -radix unsigned    /tb_top/BMP_REPEAT      
add wave -noupdate -radix unsigned    /tb_top/BMP_LINK 
                                                      
add wave -noupdate -divider {output paramters}        
add wave -noupdate -radix unsigned    /tb_top/BMP_OUTPUTED_WIDTH   
add wave -noupdate -radix unsigned    /tb_top/BMP_OUTPUTED_HEIGHT  
add wave -noupdate -radix ascii       /tb_top/BMP_OUTPUTED_NAME 
add wave -noupdate -radix unsigned    /tb_top/BMP_OUTPUTED_NUMBER   
                                                      
add wave -noupdate -divider {scaler paramters} 
add wave -noupdate                    /tb_top/REF_CLK_FREQ

add wave -noupdate -divider {driver_inst output}
add wave -noupdate                    /tb_top/rst_n
add wave -noupdate                    /tb_top/pixel_clock
add wave -noupdate                    /tb_top/vsync
add wave -noupdate                    /tb_top/hsync
add wave -noupdate                    /tb_top/data_valid
add wave -noupdate -radix hexadecimal /tb_top/data0_r
add wave -noupdate -radix hexadecimal /tb_top/data0_g
add wave -noupdate -radix hexadecimal /tb_top/data0_b
add wave -noupdate -radix unsigned    /tb_top/driver_inst/u_video_gen/u_video_gen_syn/Vs_cnt
add wave -noupdate -radix unsigned    /tb_top/driver_inst/u_video_gen/u_video_gen_syn/Hs_cnt

add wave -noupdate -divider {output channel signals}
add wave -noupdate                    /tb_top/tmds_clk_p 
add wave -noupdate                    /tb_top/tmds_clk_n        
add wave -noupdate                    /tb_top/tmds_data_p
add wave -noupdate                    /tb_top/tmds_data_n

add wave -noupdate -divider {output channel signals}
add wave -noupdate                    /tb_top/rx0_pclk 
add wave -noupdate                    /tb_top/rx0_vsync       
add wave -noupdate                    /tb_top/rx0_hsync
add wave -noupdate                    /tb_top/rx0_de   
add wave -noupdate                    /tb_top/rx0_r
add wave -noupdate                    /tb_top/rx0_g
add wave -noupdate                    /tb_top/rx0_b 

add wave -noupdate -divider {monitor input}
add wave -noupdate                    /tb_top/m_clk
add wave -noupdate                    /tb_top/m_vs_rgb
add wave -noupdate                    /tb_top/m_hs_rgb
add wave -noupdate                    /tb_top/m_de_rgb
add wave -noupdate -radix hexadecimal /tb_top/m_data0_r
add wave -noupdate -radix hexadecimal /tb_top/m_data0_g
add wave -noupdate -radix hexadecimal /tb_top/m_data0_b

add wave -noupdate -divider {monitor signal}
add wave -noupdate -radix unsigned    /tb_top/monitor_inst/u_video2bmp/bmp_outputed_number
add wave -noupdate                    /tb_top/monitor_inst/u_video2bmp/vs_i_fall

add wave -noupdate -divider {End signal}

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {912366093 ps} 0}
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {891247063 ps} {925431255 ps}

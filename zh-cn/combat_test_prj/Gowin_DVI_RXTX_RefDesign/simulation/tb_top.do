#不需要新建modelsim工程，直接运行.do文件就可以仿真
quit -sim
#新建work库
vlib work  

#将work库映射到当前工作目录
#vmap [-help] [-c] [-del] [<logical_name>] [<path>]
vmap work  

#编译所有.v文件到work工作库
#-work <path>       Specify library WORK
#-vlog01compat      Ensure compatibility with Std 1364-2001
#-incr              Enable incremental compilation
#"rtl/*.v"          当前工作目录下的rtl文件夹中的所有.v文件，支持相对路径，但是要加双引号“”
#vlog

vlog -work work -vlog01compat -incr ../project/src/dvi_rx_top/dvi_rx_top.vo
vlog -work work -vlog01compat -incr ../project/src/dvi_tx_top/dvi_tx_top.vo

#testbench
vlog -work work -vlog01compat -incr "../tb/driver/*.v"
vlog -work work -vlog01compat -incr "../tb/monitor/*.v"
vlog -work work -vlog01compat -incr ../tb/prim_sim.v

vlog -work work -vlog01compat -incr "../tb/tb_top.v"

#编译所有.vhd文件
#-work <path>       Specify library WORK
#-93                Enable support for VHDL 1076-1993
#-2002              Enable support for VHDL 1076-2002
#vcom


#启动仿真顶层文件
#-L <libname>                     Search library for design units instantiated from Verilog and for VHDL default component binding
#+nowarn<CODE | Number>           Disable specified warning message  (Example: +nowarnTFMPC)                      
#-t [1|10|100]fs|ps|ns|us|ms|sec  Time resolution limit VHDL default: resolution setting from .ini file) 
#                                 (Verilog default: minimum time_precision in the design)
#-novopt                          Force incremental mode (pre-6.0 behavior)
vsim +nowarnTFMPC -L work  -novopt -l tb_top.log work.tb_top 

#产生一个wave log format(WLF)......
log -r /*

#打开wave窗口
view wave

#添加仿真信号
#在已经添加好信号和设置好格式的wave窗口，点击【File】->【Save Fomat】
#存为任意名字的.do文件，该文件包含了加载哪些信号及其显示格式的命令
do tb_top_wave.do

#设置运行时间
run  -all

#dataflow调试
#具体方法是在仿真后执行命令  view dataflow 就可以打开dataflow文件，
#在dataflow的窗口菜单中点击add中的view all nets就可以观察到各个模块之间的逻辑联系，
#模块一般都为initial模块、always模块、assign模块等等。点击中一个模块，则这个模块变为红色。
#这时候在view菜单下点击show wave就可以在窗口下方弹出wave窗口，
#不同的是这个wave窗口所显示的信号变量仅为点击中的模块所包括的信号变量，
#这时候也可以点击仿真run –all小图标来仿真有关这个模块的输入输出关系。
#view dataflow




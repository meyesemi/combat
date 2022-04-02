#����Ҫ�½�modelsim���̣�ֱ������.do�ļ��Ϳ��Է���
quit -sim
#�½�work��
vlib work  

#��work��ӳ�䵽��ǰ����Ŀ¼
#vmap [-help] [-c] [-del] [<logical_name>] [<path>]
vmap work  

#��������.v�ļ���work������
#-work <path>       Specify library WORK
#-vlog01compat      Ensure compatibility with Std 1364-2001
#-incr              Enable incremental compilation
#"rtl/*.v"          ��ǰ����Ŀ¼�µ�rtl�ļ����е�����.v�ļ���֧�����·��������Ҫ��˫���š���
#vlog

vlog -work work -vlog01compat -incr ../project/src/dvi_rx_top/dvi_rx_top.vo
vlog -work work -vlog01compat -incr ../project/src/dvi_tx_top/dvi_tx_top.vo

#testbench
vlog -work work -vlog01compat -incr "../tb/driver/*.v"
vlog -work work -vlog01compat -incr "../tb/monitor/*.v"
vlog -work work -vlog01compat -incr ../tb/prim_sim.v

vlog -work work -vlog01compat -incr "../tb/tb_top.v"

#��������.vhd�ļ�
#-work <path>       Specify library WORK
#-93                Enable support for VHDL 1076-1993
#-2002              Enable support for VHDL 1076-2002
#vcom


#�������涥���ļ�
#-L <libname>                     Search library for design units instantiated from Verilog and for VHDL default component binding
#+nowarn<CODE | Number>           Disable specified warning message  (Example: +nowarnTFMPC)                      
#-t [1|10|100]fs|ps|ns|us|ms|sec  Time resolution limit VHDL default: resolution setting from .ini file) 
#                                 (Verilog default: minimum time_precision in the design)
#-novopt                          Force incremental mode (pre-6.0 behavior)
vsim +nowarnTFMPC -L work  -novopt -l tb_top.log work.tb_top 

#����һ��wave log format(WLF)......
log -r /*

#��wave����
view wave

#��ӷ����ź�
#���Ѿ���Ӻ��źź����úø�ʽ��wave���ڣ������File��->��Save Fomat��
#��Ϊ�������ֵ�.do�ļ������ļ������˼�����Щ�źż�����ʾ��ʽ������
do tb_top_wave.do

#��������ʱ��
run  -all

#dataflow����
#���巽�����ڷ����ִ������  view dataflow �Ϳ��Դ�dataflow�ļ���
#��dataflow�Ĵ��ڲ˵��е��add�е�view all nets�Ϳ��Թ۲쵽����ģ��֮����߼���ϵ��
#ģ��һ�㶼Ϊinitialģ�顢alwaysģ�顢assignģ��ȵȡ������һ��ģ�飬�����ģ���Ϊ��ɫ��
#��ʱ����view�˵��µ��show wave�Ϳ����ڴ����·�����wave���ڣ�
#��ͬ�������wave��������ʾ���źű�����Ϊ����е�ģ�����������źű�����
#��ʱ��Ҳ���Ե������run �CallСͼ���������й����ģ������������ϵ��
#view dataflow




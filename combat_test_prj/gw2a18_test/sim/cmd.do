## part 1: new lib
vlib work
vmap work work

## part 2: load design
vlog -novopt -incr -work work "../../tb/MIPI_tb.v"
vlog -novopt -incr -work work "prim_sim.v"

## part 3: sim design
vsim -novopt work.MIPI_tb

## part 4: add signals
add wave *
#do wave.do

## part 6: run 
run -all
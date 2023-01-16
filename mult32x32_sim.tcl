vdel -all -lib work
vlib work

vlog mult32x32_fsm.sv
vlog mult32x32_arith.sv
vlog mult32x32.sv
vlog mult32x32_autotest.sv

vsim mult32x32_autotest

add wave sim:/mult32x32_autotest/uut/*
run -a
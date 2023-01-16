vlib work

vlog mult32x32_fast_fsm.sv
vlog mult32x32_fast_arith.sv
vlog mult32x32_fast.sv
vlog mult32x32_fast_autotest.sv

vsim mult32x32_fast_autotest

add wave sim:/mult32x32_fast_autotest/uut/*
run -a
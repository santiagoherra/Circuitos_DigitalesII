verilog:
	iverilog -o calculadora.out testbench.v
	vvp calculadora.out
	gtkwave tb_calculadora8bit.vcd

borrar:
	rm tb_calculadora8bit.v
	rm testbench.v
	rm tester.v
	rm calculadora.out
	rm calculadora8bit.v
	rm synth.out
	rm synth.v
	rm tester_sint.v
	rm testbench_synth.v
	rm tb_synth.vcd

verilog_synth:
	iverilog -o synth.out testbench_synth.v
	vvp synth.out
	gtkwave tb_synth.vcd

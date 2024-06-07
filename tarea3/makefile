all:
	iverilog testbench.v
	vvp a.out
	gtkwave tb_top.vcd

rm:
	rm master.v
	rm slave1.v
	rm slave2.v
	rm top.v
	rm testbench.v
	rm a.out
	rm tb_top.vcd
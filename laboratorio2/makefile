# Laboratorio 2 
# Santiago Herra Castro C13721
# Evelyn Feng Wu B82870
# Circuitos Digitales II

# Prof. Ing. Ana Eugenia Sanchez Villalobos

# Este es el makefile del Lab 2

verilog:
	iverilog -o tb.vvp testbench.v 
	vvp tb.vvp
	gtkwave gtk_controlador.vcd
clean:
	rm -rf gtk_controlador.vcd tb.vvp


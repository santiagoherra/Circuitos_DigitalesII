#Tarea 2 Evelyn Feng Wu B82870
##Circuitos Digitales II
##Archivo: calculadora.v
##Prof. Ing. Ana Eugenia Sanchez Villalobos

#Este es el makefile de la Tarea 2

verilog:
	iverilog -o tb.vvp testbench.v 
	vvp tb.vvp
	gtkwave gtk_controlador.vcd
clean:
	rm -rf gtk_controlador.vcd tb.vvp


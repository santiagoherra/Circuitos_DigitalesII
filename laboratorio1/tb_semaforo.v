//Laboraotorio de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR

`include "semaforo.v"
`include "tester_semaforo.v"

`timescale 1ms/1ms

module tb;

    wire clk, RST, ENB, Apeatonal, Bpeatonal;
    wire [1:0] SemaforoA, SemaforoB;
//Inicializando el DUT y reset
semaforo DUT(
    .clk(clk),
    .RST(RST),
    .ENB(ENB),
    .SemaforoA(SemaforoA),
    .SemaforoB(SemaforoB),
    .Apeatonal(Apeatonal),
    .Bpeatonal(Bpeatonal)
);

tester test(
    .clk(clk),
    .RST(RST),
    .ENB(ENB),
    .SemaforoA(SemaforoA),
    .SemaforoB(SemaforoB),
    .Apeatonal(Apeatonal),
    .Bpeatonal(Bpeatonal)
);

//generando ondas y visualizar en GTKWave

initial begin
    $dumpfile("gtkwave_semaforo.vcd");
    $dumpvars;
end


endmodule

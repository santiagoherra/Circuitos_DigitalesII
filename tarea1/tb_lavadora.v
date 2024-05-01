//Tarea de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR
//Este es el testbench de la lavadora

`include "lavadora.v"
`include "tester_lavadora.v"


module tb;
    wire clk, reset, finalizar_pago, intro_moneda, SECADO, LAVADO, LAVADO_PESADO, INSUFICIENTE;

//Inicializando el test y el DUT
lavadora DUT(
    .clk(clk),
    .reset(reset),
    .finalizar_pago(finalizar_pago),
    .intro_moneda(intro_moneda),
    .SECADO(SECADO),
    .LAVADO(LAVADO),
    .LAVADO_PESADO(LAVADO_PESADO),
    .INSUFICIENTE(INSUFICIENTE)
);

tester test(
    .clk(clk),
    .reset(reset),
    .finalizar_pago(finalizar_pago),
    .intro_moneda(intro_moneda),
    .SECADO(SECADO),
    .LAVADO(LAVADO),
    .LAVADO_PESADO(LAVADO_PESADO),
    .INSUFICIENTE(INSUFICIENTE)
);

//generar ondas y visualizar en GTKwave

initial begin
    $dumpfile("gtkwave_lavadora.vcd");
    $dumpvars;
end


endmodule
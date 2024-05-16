`include "controlador.v"
`include "tester.v"

module tb;
    wire clk, rst, tarjeta_recibida, tipo_tarjeta;
    wire [15:0] pin;
    wire [3:0] digito;
    wire digito_stb, tipo_transaccion;
    wire [31:0] monto;
    wire monto_stb, balance_actualizado, entregar_dinero;
    wire fondos_insuficientes, pin_incorrecto, bloqueo, advertencia, comision;

controlador DUT(
    .clk(clk),
    .rst(rst),
    .tarjeta_recibida(tarjeta_recibida),
    .tipo_tarjeta(tipo_tarjeta),
    .pin(pin [15:0]),
    .digito(digito [3:0]),
    .digito_stb(digito_stb),
    .tipo_transaccion(tipo_transaccion),
    .monto(monto [31:0]),
    .monto_stb(monto_stb),
    .balance_actualizado(balance_actualizado),
    .entregar_dinero(entregar_dinero),
    .fondos_insuficientes(fondos_insuficientes),
    .pin_incorrecto(pin_incorrecto),
    .bloqueo(bloqueo),
    .advertencia(advertencia),
    .comision(comision)
);

tester test(
    .clk(clk),
    .rst(rst),
    .tarjeta_recibida(tarjeta_recibida),
    .tipo_tarjeta(tipo_tarjeta),
    .pin(pin [15:0]),
    .digito(digito [3:0]),
    .digito_stb(digito_stb),
    .tipo_transaccion(tipo_transaccion),
    .monto(monto [31:0]),
    .monto_stb(monto_stb),
    .balance_actualizado(balance_actualizado),
    .entregar_dinero(entregar_dinero),
    .fondos_insuficientes(fondos_insuficientes),
    .pin_incorrecto(pin_incorrecto),
    .bloqueo(bloqueo),
    .advertencia(advertencia),
    .comision(comision)
);


initial begin
    $dumpfile("gtk_controlador.vcd");
    $dumpvars;
end


endmodule
/****************

Laboratorio 2 
Santiago Herra Castro C13721
Evelyn Feng Wu B82870
Circuitos Digitales II
Archivo: controlador.v
Prof. Ing. Ana Eugenia Sanchez Villalobos
Archivo: testbench.v une controlador.v y tester.v

DUT de la Controlador de tarjetas del banco para retiros y depósitos

*********************/

module controlador(
    input clk,
    input rst,
    input tarjeta_recibida,
    input tipo_tarjeta,
    input [15:0] pin,
    input [3:0] digito,
    input digito_stb,
    input tipo_transaccion,
    input [31:0] monto,
    input monto_stb,

    output reg [63:0] balance_actualizado,
    output reg entregar_dinero,
    output reg fondos_insuficientes,
    output reg pin_incorrecto,
    output reg bloqueo,
    output reg advertencia
);

reg [63:0] balance;
reg [2:0] contador; //cuenta fallos de bits


parameter introduce_tarjeta = 0;
parameter bcr_tarjeta = 1;
parameter otra_tarjeta =2;
parameter tipo_de_transaccion =3;
parameter intro_pin = 4;
parameter intro_monto=5;



endmodule
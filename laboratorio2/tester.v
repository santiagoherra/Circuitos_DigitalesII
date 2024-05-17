/****************

Laboratorio 2 
Santiago Herra Castro C13721
Evelyn Feng Wu B82870
Circuitos Digitales II
Archivo: tester.v 
Prof. Ing. Ana Eugenia Sanchez Villalobos
Archivo: testbench.v une controlador.v y tester.v

Probador del controlador de tarjetas

*********************/

module tester(
    output reg clk,
    output reg rst,
    output reg tarjeta_recibida,
    output reg tipo_de_tarjeta,
    output reg [15:0] pin,
    output reg [3:0] digito,
    output reg digito_stb,
    output reg tipo_trans,
    output reg [31:0] monto,
    output reg monto_stb, 
    output reg entregar_dinero,
    output reg fondos_insuficientes,

    input balance_actualizado, //se;al
    input pin_incorrecto,
    input bloqueo,
    input advertencia,
    input comision
);

always begin 
    #5 clk = ~clk;  
end
    initial begin
    clk=0;
    rst=1;

    tipo_de_tarjeta=0;
    tarjeta_recibida=0;
    entregar_dinero=0;
    fondos_insuficientes=0;
    pin=0;
    digito=0;
    digito_stb =0;
    tipo_trans =0;
    monto=0;
    monto_stb =0;
    
    #20
    rst=0;
    pin=16'b1101010011011101;
    //caso1: pin correcto
    #10
    tarjeta_recibida=1;
    tipo_de_tarjeta=1; //cobra comision
    #25
   
    digito=4'b1101; //digito 1
    #10
    digito_stb=1;
    #10
    digito_stb=0;
    #10
 
    digito=4'b0100; //digito 2
    #10
    digito_stb=1;
    #10
    digito_stb=0;   
    #10

    digito=4'b1101; //digito 3
    #10
    digito_stb=1;
    #10
    digito_stb=0;
    #10

    digito=4'b1101; //digito 4
    #10
    digito_stb=1;
    #10
    digito_stb=0;
    #10

    tipo_trans =0; //deposito
    monto=32'b000000000000100111000100000; //20000
    #10
    monto_stb=1;
    #10
    monto_stb =0;
    #40
    rst=1;
    tipo_de_tarjeta=0;
    tarjeta_recibida=0;
    tipo_de_tarjeta =0;
    pin=0;
    digito=0;
    digito_stb =0;
    tipo_trans =0;
    monto=0;
    #10
    rst=0;
    #10

  
    $finish; 
    end
endmodule
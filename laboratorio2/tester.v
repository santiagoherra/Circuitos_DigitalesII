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
    output reg tipo_tarjeta,
    output reg [15:0] pin,
    output reg [3:0] digito,
    output reg digito_stb,
    output reg tipo_transaccion,
    output reg [31:0] monto,
    output reg monto_stb,

    input balance_actualizado, //se;al
    input entregar_dinero,
    input fondos_insuficientes,
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
        rst=0;
        tipo_tarjeta=0;
        tarjeta_recibida=0;
        tipo_tarjeta =0;
        pin=0;
        digito=0;
        digito_stb =0;
        tipo_transaccion =0;
        monto=0;
        monto_stb =0;

    //caso1
    #10
    tarjeta_recibida=1;
    tipo_tarjeta=1; //cobra comision
    pin=1150284387653948;
    //pone mal el pin 3 veces y se bloquea    
    #10
    digito_stb=1;
    digito=6539;
    #40
    digito_stb=1;
    digito=1233;
    #40
    digito_stb=1;
    digito=2222;
    #40
    rst=1;
        tipo_tarjeta=0;
        tarjeta_recibida=0;
        tipo_tarjeta =0;
        pin=0;
        digito=0;
        digito_stb =0;
        tipo_transaccion =0;
        monto=0;
        monto_stb =0;
    #10
    rst=0;
    #10

    //caso 2
    tarjeta_recibida=1;
    tipo_tarjeta=0; //no cobra comision
    pin=7129479238212222;
    //pone mal el pin 2 veces, pone el correcto y va a realizar un deposito    
    #10
    digito_stb=1;
    digito=6539;
    #40
    digito_stb=1;
    digito=1233;
    #40
    digito_stb=1;
    digito=2222; //pin correcto
    #40
    tipo_transaccion =0;
    monto_stb=1;
    monto=20000;
    #10
    monto_stb=0;
    #10
    rst=1;
        tipo_tarjeta=0;
        tarjeta_recibida=0;
        tipo_tarjeta =0;
        pin=0;
        digito=0;
        digito_stb =0;
        tipo_transaccion =0;
        monto=0;
        monto_stb =0;
    #10
    rst=0;
    

    //caso  3
    tarjeta_recibida=1;
    tipo_tarjeta=0; //no cobra comision
    pin=7192831732111123;
    //pone bien el pin y realiza retiro fondos insuficientes
    #10
    digito_stb=1;
    digito=1123;
    #40
    tipo_transaccion =1;
    monto_stb=1;
    monto=60000;
    #10
    monto_stb=0;
    #10
    rst=1;
        tipo_tarjeta=0;
        tarjeta_recibida=0;
        tipo_tarjeta =0;
        pin=0;
        digito=0;
        digito_stb =0;
        tipo_transaccion =0;
        monto=0;
        monto_stb =0;
    #10
    rst=0;


    //caso  4
    tarjeta_recibida=1;
    tipo_tarjeta=1; //cobra comision
    pin=7192831732111123;
    //pone bien el pin y realiza retiro fondos insuficientes
    #10
    digito_stb=1;
    digito=1123;
    #40
    tipo_transaccion =1;
    monto_stb=1;
    monto=20000;
    #10
    monto_stb=0;
    #10
    rst=1;
        tipo_tarjeta=0;
        tarjeta_recibida=0;
        tipo_tarjeta =0;
        pin=0;
        digito=0;
        digito_stb =0;
        tipo_transaccion =0;
        monto=0;
        monto_stb =0;
    $finish; 
    end
endmodule
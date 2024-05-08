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

    output reg [63:0] balance_actualizado, //se;al
    output reg entregar_dinero,
    output reg fondos_insuficientes,
    output reg pin_incorrecto,
    output reg bloqueo,
    output reg advertencia
    output reg comsion,
);

reg [63:0] balance;
reg [2:0] contador; //cuenta fallos de bits
reg [2:0] digitos_pin; // almacena los 4 ultimos digitos del pin


//parameter introduce_tarjeta = 0;
//parameter bcr_tarjeta = 1;
//parameter otra_tarjeta =2;
//parameter tipo_de_transaccion =3;
//parameter intro_pin = 4;
//parameter intro_monto=5;

always@(posedge clk) begin
  if (rst) begin
    balance =0;
    contador=0;
    balance_actualizado=0;
    entregar_dinero=0;
    pin_incorrecto=0;
    fondos_insuficientes=0;
    bloqueo=0;
    advertencia=0;
  end   

end

always@(*) begin
    if (tarjeta_recibida =1) begin
        if (tipo_tarjeta=1)
            comsion=1;

        //for para revisar pin

        if (tipo_transaccion)=0 begin //deposito
            balance = balance + monto;
            balance_actualizado=1;
        end
        else if (tipo_transaccion)=1 begin //retiro
            if (monto)> balance begin
                fondos_insuficientes=1;
                balance_actualizado=0;
            end
            else begin
                balance_actualizado=1;
                balance=balance-monto;
            end
        end

    end
end    
endmodule
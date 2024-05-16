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

    output reg balance_actualizado, //se;al
    output reg entregar_dinero,
    output reg fondos_insuficientes,
    output reg pin_incorrecto,
    output reg bloqueo,
    output reg advertencia,
    output reg comision
);

parameter PIN_BUENO = 3721; //numeros finales de mi carne que es el PIn de la tarjeta
reg [63:0] balance = 5000; //valor de balance original
reg [2:0] contador_fallos; //cuenta fallos de bits
reg [3:0] digitos_pin; // almacena los 4 ultimos digitos del pin
reg [2:0] contador_digitos; //cuenta los digitos de las veces que se acerto el pin
reg sigue_bucle = 1; //condicion para hacer break
integer i, j; //inetegers de for

//parameter introduce_tarjeta = 0;
//parameter bcr_tarjeta = 1;
//parameter otra_tarjeta =2;
//parameter tipo_de_transaccion =3;
//parameter intro_pin = 4;
//parameter intro_monto=5;

//bloque de funcionamiento de reset
always@(posedge clk or negedge clk) begin
  if (rst) begin
    contador_digitos = 0;
    contador_fallos = 0;
    balance_actualizado = 0;
    entregar_dinero = 0;
    pin_incorrecto = 0;
    fondos_insuficientes = 0;
    bloqueo = 0;
    advertencia = 0;
    end   
end

//bloque always para las salidas del pin incorrecto
always@(posedge clk or negedge clk)begin
    if(contador_fallos == 2)begin
        advertencia <= 1; //si falla 2 veces sale advertencia
    end else if(contador_fallos == 3) begin
        bloqueo <= 1;//si falla 3 veces sale bloqueo
        //reset <= 1; //preguntar como hacer para que reset tambien funcione como una salida
    end 
end


always@(posedge clk or negedge clk) begin
    if (tarjeta_recibida <= 1) begin
        if (tipo_tarjeta <= 1)
            comision = 1;

        if(digito_stb)begin
            for(j = 0; j < 3; j = j + 1)begin//Este es el for para que se repita la accion del digito 3 veces
                if(sigue_bucle)begin
                    for(i = 0; i < 4; i = i+ 1)begin
                        if(digito == digitos_pin)begin //si el digito de entrada coincide con el carne
                            contador_digitos += 1;
                        end
                    end
                    if(contador_digitos == 4)begin//significa que el pin ingresa esta bueno
                        sigue_bucle <= 0;
                    end else begin
                        pin_incorrecto <= 1; //salida 
                        contador_fallos += 1;
                    end
                end
            end
        end

        if (!tipo_transaccion) begin //deposito
            if(monto_stb)begin //cuando se detecta la entrada de monton se ejecuta la acccion
                balance = balance + monto;
                balance_actualizado = 1;
            end
        end
        else if (tipo_transaccion)begin //retiro
            if(monto_stb)begin
                if (monto >= balance) begin
                    balance = balance - monto;
                    balance_actualizado = 1;
                    entregar_dinero = 1;
                    fondos_insuficientes = 0;
                end
                else begin
                    fondos_insuficientes = 1;
                    balance_actualizado = 0;
                end
            end
        end

    end
end    

endmodule


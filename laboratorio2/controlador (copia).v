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

    output reg balance_actualizado, //señal
    output reg entregar_dinero,
    output reg fondos_insuficientes,
    output reg pin_incorrecto,
    output reg bloqueo,
    output reg advertencia,
    output reg comision
);

reg [3:0] digitos_pin; //almacena los 4 ultimos digitos del pin
reg [63:0] balance = 50000; //valor de balance original
reg [63:0] monto_comision = 3000; //valor de balance original
reg [2:0] contador_fallos; //cuenta fallos de bits
reg [2:0] contador_digitos; //cuenta los digitos de las veces que se acerto el pin
reg sigue_bucle = 1; //condicion para hacer break
integer i, j; //inetegers de for
integer temp_pin;
reg [15:0] ultimos_cuatro_digitos;

//bloque de funcionamiento de reset
always@(posedge clk or negedge clk) begin
  if (rst) begin
    balance_actualizado=0;
    entregar_dinero=0;
    fondos_insuficientes=0;
    pin_incorrecto=0;
    bloqueo=0;
    advertencia=0;
    comision=0;
    contador_digitos = 0;
    contador_fallos = 0;
    end   
end

//bloque always para las salidas del pin incorrecto
always@(posedge clk or negedge clk)begin
    if(contador_fallos == 2)begin
        advertencia <= 1; //si falla 2 veces sale advertencia
    end 
    else if(contador_fallos == 3) begin
        bloqueo <= 1;//si falla 3 veces sale bloqueo

    end 
end


always@(posedge clk) begin
    if (tarjeta_recibida <= 1) begin
        //validacion de comision
        if (tipo_tarjeta <= 1)
            comision = 1;
            
            digitos_pin = pin[3:0]; //extrae los últimos 4 bits de la entrada 


            if (digito_stb && sigue_bucle) begin
                contador_digitos <= 0;
                digitos_pin= pin[3:0]; // Obtiene el último dígito por separado
                for (i = 0; i < 4; i = i + 1) begin
                    if (digito == digitos_pin[i]) begin // si el dígito de entrada coincide con algún dígito del PIN
                        contador_digitos <= contador_digitos + 1;
                        pin_incorrecto <= 0; //salida 
                    end
                    else 
                        pin_incorrecto <= 1; //salida 
                        sigue_bucle <= 0;
                        contador_fallos <= contador_fallos + 1;
                end
            end

            if (!tipo_transaccion) begin //deposito
                if(monto)begin //cuando se detecta la entrada de monton se ejecuta la acccion
                    balance = balance + monto;
                    balance_actualizado = 1;
                end
            end
            else if (tipo_transaccion)begin //retiro
                    if (monto >= balance) begin
                    
                            balance = balance - monto - monto_comision;
                            balance_actualizado = 1;
                            entregar_dinero = 1;
                            fondos_insuficientes = 0;

                    end
                    else begin
                        fondos_insuficientes = 1;
                        balance_actualizado = 0;
                    end
            end

        else
            comision = 0;

	        digitos_pin = pin[3:0]; //extrae los últimos 4 bits de la entrada 


            if (digito_stb) begin
                contador_digitos <= 0;
                digitos_pin= pin[3:0]; // Obtiene el último dígito por separado
                for (i = 0; i < 4; i = i + 1) begin
                    if (digito == digitos_pin[i]) begin // si el dígito de entrada coincide con algún dígito del PIN
                        contador_digitos <= contador_digitos + 1;
                        pin_incorrecto <= 0; //salida 
                    end
                    else 
                        pin_incorrecto <= 1; //salida 
                        sigue_bucle <= 0;
                        contador_fallos <= contador_fallos + 1;
                end
            end

            if (!tipo_transaccion) begin //deposito
                if(monto)begin //cuando se detecta la entrada de monton se ejecuta la acccion
                    balance = balance + monto;
                    balance_actualizado = 1;
                end
            end
            else if (tipo_transaccion)begin //retiro
                    if (monto >= balance) begin
                    
                            balance = balance - monto - monto_comision;
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

   

endmodule


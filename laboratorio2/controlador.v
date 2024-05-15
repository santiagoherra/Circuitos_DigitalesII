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
    output reg comision,
);

parameter PIN_BUENO = 3721 //numeros finales de mi carne que es el PIn de la tarjeta
reg [63:0] balance;
reg [2:0] contador_fallos; //cuenta fallos de bits
reg [3:0] digitos_pin; // almacena los 4 ultimos digitos del pin
reg [2:0] contador_digitos; //cuenta los digitos de las veces que se acerto el pin

//Agregar la inicializacion de los contadores,
//archivo que se realizo en la semana 1



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
    if (tarjeta_recibida <= 1) begin
        if (tipo_tarjeta <= 1)
            comision = 1;

        //for para revisar pin (DIGITO
        

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

//Version de maquina de esatdos con switch case
always@(*)begin
    case(estado)
        DIGITO:begin
            for(i = 0, i < 4, i++)begin
                //falta la parte de dividir el pin de la entrada en cada digitos
                //osea pimero 3 -> 7 ... separarlo en el registro digitos_pin
                if(digito)begin
                    #1 digito_stb <= 1; //duracion de salida
                    if(digito == digitos_pin)begin //si el digito de entrada coincide con el carne
                        contador_digitos += 1;
                    end
                end
            end
            if(contador_digitos == 4)begin//significa que el pin ingresa esta bueno
                next_state = TIPO_TRANSACCION;
            end else begin
                pin_incorrecto <= 1; //salida 
                contador_fallos += 1;
                next_state = DIGITO; //si falla vuelve a digito
            end

        end

    endcase
end

//bloque always para las salidas del pin incorrecto
always@(posedge clk or negedge clk)begin
    if(contador_fallos == 2)begin
        advertencia <= 1; //si falla 2 veces sale advertencia
    end else if(contador_fallos == 3) begin
        bloqueo <= 1;//si falla 3 veces sale bloqueo
        reset <= 1; //preguntar como hacer para que reset tambien funcione como una salida
    end 
end





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
    input tipo_de_tarjeta,
    input [15:0] pin,
    input [3:0] digito,
    input digito_stb,
    input tipo_trans,
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

// Comprueba que el pin es correcto
reg [2:0] correcto; 
// Valor de balance original 50.000
reg [63:0] balance = 50000; 
// Cuenta los intentos fallidos
reg [2:0] contador_fallos; 
// Cuenta la cantidad de dígitos ingresados
reg [2:0] contador_digitos; 

reg coincidencia;

// Bloque de funcionamiento de reset, inicializa en 0
always @(posedge clk) begin
    if (rst) begin
        balance_actualizado <= 0;
        entregar_dinero <= 0;
        fondos_insuficientes <= 0;
        pin_incorrecto <= 0;
        bloqueo <= 0;
        advertencia <= 0;
        comision <= 0;
        contador_digitos <= 0;
        contador_fallos <= 0;
        correcto <= 0;
        coincidencia = 0;
    end   
end

always @(*) begin
    if (tarjeta_recibida == 1 && tipo_de_tarjeta == 1) begin
        comision = 1;
    end else begin
        comision = 0;
    end

    if (correcto == 3'b100 && monto_stb) begin 
        if (tipo_trans == 1) begin
            if (monto > balance) begin
                fondos_insuficientes = 1;
            end else begin              
                balance = balance - monto;
                balance_actualizado = 1;
                entregar_dinero = 1;
            end
        end else if (!tipo_trans) begin
            balance = balance + monto;
            balance_actualizado = 1;
        end
    end

    if (digito_stb && contador_digitos != 4) begin
        contador_digitos = contador_digitos + 1;

        // Bandera para controlar si ya se encontró una coincidencia
        coincidencia = 0;
        for (integer i = 0; i < 4; i = i + 1) begin
            if (!coincidencia && pin[i*4 +: 4] == digito) begin // Comprueba cada 4 bits
                correcto = correcto + 1;
                coincidencia = 1; // Se ha encontrado una coincidencia
            end
        end
    end

    // Contador correcto es menor a 4 entonces pin incorrecto
    if (digito_stb && correcto != 4 && contador_digitos == 4) begin
            contador_fallos = contador_fallos + 1;
            pin_incorrecto = 1; // Salida 
            #10
            contador_digitos = 0;
            correcto = 0;
            pin_incorrecto = 0;
    end    

    // Con dos fallos se enciende advertencia
    if (contador_fallos == 2)
        advertencia = 1;

    // Bloquea si 3 intentos fallidos
    if (contador_fallos == 3) begin
        advertencia = 0;
        bloqueo = 1;
    end

    // Tercer intento incorrecto
    if (correcto != 4 && contador_digitos == 4 && contador_fallos == 2) begin
        pin_incorrecto = 1;
        advertencia = 1;
        contador_fallos = contador_fallos + 1;
        #10
        pin_incorrecto = 0;
        advertencia = 0;     
        bloqueo = 1;   
        contador_digitos = 0;
        correcto = 0;     
    end    
end

always@(posedge clk or negedge clk)begin
    if(contador_fallos == 1)begin
        pin_incorrecto <= 1;
    end else if(contador_fallos == 2)begin
        advertencia <= 1; //si falla 2 veces sale advertencia
    end 
    else if(contador_fallos == 3) begin
        bloqueo <= 1;//si falla 3 veces sale bloqueo

    end 
end

endmodule
 
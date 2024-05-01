//Tarea de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR
//Este es el modulo de la lavadora, el principal

`include "contador_lavadora.v"

module lavadora(//modulo de la lavadora
    input clk,
    input reset,
    input finalizar_pago,
    input intro_moneda,
    output reg SECADO,
    output reg LAVADO,
    output reg LAVADO_PESADO,
    output reg INSUFICIENTE 
);

//variables internas
wire [3:0] VERIFICACION_PAGO;

//inicializar los contadores
contador contador1(.clk(clk), .reset(reset), .enable(intro_moneda), .count(VERIFICACION_PAGO[3:0]));

//logica de las funciones de salidas, caso de las salidas segun la cantidad de monedas ingresadas
always@(posedge clk)
begin
    if(finalizar_pago)begin
        if(VERIFICACION_PAGO == 3) begin 
            SECADO <= 1;
        end else if(VERIFICACION_PAGO == 4) begin
            LAVADO <= 1;
        end else if(VERIFICACION_PAGO == 9) begin
            LAVADO_PESADO <= 1;
        end else begin
            INSUFICIENTE <= 1;
        end
    end
end 

always@(posedge clk)//volver a poner las salidas en 0 cuando se genera un reset
begin
    if(reset)begin
        SECADO <= 0;
        LAVADO <= 0;
        LAVADO_PESADO <= 0;
        INSUFICIENTE <= 0;
    end

end


endmodule
//Tarea de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR
//modulo de contador para la lavadora.

module contador(
    input clk,     // Entrada de reloj
    input reset,   // Entrada de reset
    input enable,  // Entrada de habilitación
    output reg [3:0] count  // Salida del contador
);

reg [3:0] registros_internos; // Registros internos para el contador


always @(posedge clk)
begin
    if (reset) begin // Si hay un reset, se reinicia el contador
        registros_internos <= 3'b000;
    end
    else if (enable) begin // Si la habilitación está activa, se incrementa el contador
        registros_internos <= registros_internos + 1;
    end
    
    assign count = registros_internos;

end


endmodule



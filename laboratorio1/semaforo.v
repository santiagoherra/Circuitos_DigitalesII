//Laboratorio de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR
//El DUT del laboratorio.

module semaforo(//entradas y salidas del modulo.
    input clk,
    input ENB,
    input RST,
    input [1:0]SemaforoA,
    input [1:0]SemaforoB,
    output reg Apeatonal,
    output reg Bpeatonal
);

//Colores del semafoto:
//Rojo = 0
//Amarillo = 1
//Verde = 2

//Comportamiento del semaforo A
always@(posedge clk)
begin
    if (ENB)begin
        if(SemaforoA == 2'b00)begin
            Apeatonal <= 1;
        end else begin// todo lo que no sea verde para el peatonal debe ser 0
            Apeatonal <= 0;
        end
    end 
    else if(RST)begin 
        Apeatonal <= 0;
    end
end

//comportamiento del semaforo B
always@(posedge clk)
begin
    if (ENB)begin
        if(SemaforoB == 2'b00)begin
            Bpeatonal <= 1;
        end else begin // todo lo que no sea verde para el peatonal debe ser 0
            Bpeatonal <= 0;
        end
    end 
    else if(RST)begin 
        Bpeatonal <= 0;
    end
end


endmodule
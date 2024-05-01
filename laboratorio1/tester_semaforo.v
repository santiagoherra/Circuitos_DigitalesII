//Laboratorio de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR

`timescale 1ms/1ms

module tester(
    output reg clk,
    output reg ENB,
    output reg RST,
    output reg [1:0] SemaforoA,
    output reg [1:0] SemaforoB,
    input Apeatonal,
    input Bpeatonal
    
);

always begin
    #2 clk = !clk; //inicializando el reloj
end

initial begin
    clk = 0;
    RST = 1;

    #4

    RST = 0;

    #4

    //pruebas de los dos semaforos color rojo

    ENB = 1;
    SemaforoA = 0;
    SemaforoB = 0;

    #4 

    //prueba de los dos semaforos color amarillo

    SemaforoA = 1;
    SemaforoB = 1;

    #4

    //prueba de los dos semaforos color verde

    SemaforoA = 2;
    SemaforoB = 2;

    
    #12//Prueba que pasa si se quita el ENB

    SemaforoA = 0;
    SemaforoB = 0;

    #12

    ENB = 0;

    #4
    
    SemaforoA = 1;
    SemaforoB = 1;

    #12//Prueba de RST

    ENB = 1;

    #12

    RST = 1;//se pone RST para ver las salidas


    #50 //tiempo para terminar prueba

    $finish;

end
endmodule
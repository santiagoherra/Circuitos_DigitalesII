module tester(
    output reg clk, en, rst,
    output reg [7:0] a, b,
    output reg [1:0] MODO,
    input [7:0] c

);

always begin
#2  clk = ~clk;
end

initial begin
    //Valores iniciales
    clk = 0;
    en = 1;

    #8 //Esperar



    // Configuración para suma
    MODO = 2'b00; // Suma

    a = 8'h0A; // 10 en decimal
    b = 8'h05; // 5 en decimal
    #16; // Esperar

    // Configuración para suma
    a = 8'h09; // 10 en decimal
    b = 8'h03; // 5 en decimal
    #16; // Esperar

    en = 0; //haciendo reset
    rst = 1;

    #16//Esperar

    en = 1;//Quitando reset
    rst = 0;

    #16//Esperar

    // Configuración para resta
    MODO = 2'b01; // Resta

    a = 8'h0A; // 10 en decimal
    b = 8'h05; // 5 en decimal
    #16; // Esperar

    // Configuración para resta
    a = 8'h09; // 9 en decimal
    b = 8'h03; // 3 en decimal
    #16; // 
    
    en = 0; //haciendo reset
    rst = 1;

    #16//Esperar

    en = 1;//Quitando reset
    rst = 0;

    #16//Esperar

    // Configuración para multiplicacion
    MODO = 2'b10; // Multiplicacion

    a = 8'h0A; // 10 en decimal
    b = 8'h05; // 5 en decimal
    #16; // Esperar

    // Configuración para multiplicacion
    a = 8'h09; // 9 en decimal
    b = 8'h03; // 3 en decimal
    #16; // Esperar

    en = 0; //haciendo reset
    rst = 1;

    #16//Esperar

    en = 1;//Quitando reset
    rst = 0;

    #16//Esperar

    // Configuración para shift left
    MODO = 2'b11; // shiftleft

    a = 8'h0A; // 10 en decimal
    b = 8'h05; // 5 en decimal
    #16; // Esperar

    // Configuración para shiftleft
    b = 8'h03; // 3 en decimal
    a = 8'h09; // 9 en decimal
    #16; // Esperar

    en = 0; //haciendo reset
    rst = 1;

    #16//Esperar

    en = 1;//Quitando reset
    rst = 0;

    #16//Esperar

    
    $finish; // Finalizar simulación
  end

endmodule
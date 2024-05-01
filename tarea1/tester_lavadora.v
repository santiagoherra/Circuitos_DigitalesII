//Tarea de verilog
//Santiago Herra Castro C13721
//Curso: Circuitos Digitales II, UCR
//Tester de la lavadora

module tester(
    output reg clk,
    output reg reset,
    output reg finalizar_pago,
    output reg intro_moneda,
    input SECADO,
    input LAVADO,
    input LAVADO_PESADO,
    input INSUFICIENTE
);

always begin
    #2 clk = !clk;
end

//iniciando pruebas
initial begin
    clk = 0;
    reset = 1;
    finalizar_pago = 0;
    intro_moneda = 0;

    #4//espero 4 segundos para comenzar las pruebas.
    //Prueba 1: SECADO.

    reset = 0;
    intro_moneda = 1;
    
    #12 //tiempo para que se active SECADO 3 ciclos

    finalizar_pago = 1;
    intro_moneda = 0;

    #16 //tiempo de salida de SECADO

    finalizar_pago = 0;
    reset  = 1;

    #4//tiempo para reset

    reset = 0;

    //comienza prueba 2: LAVADO.
    intro_moneda = 1;
    
    #16 //tiempo para que se active LAVADO 4 ciclos

    finalizar_pago = 1;
    intro_moneda = 0;

    #16 //tiempo de salida de LAVADO

    finalizar_pago = 0;
    reset  = 1;

    #4//tiempo para reset

    reset = 0;

    //comienza prueba 3: LAVADO_PESADO

    intro_moneda = 1;
    
    #36 //tiempo para que se active LAVADO_PESADO 9 ciclos

    finalizar_pago = 1;
    intro_moneda = 0;

    #16 //tiempo de salida de LAVADO_PESADO

    finalizar_pago = 0;
    reset  = 1;

    #4//tiempo para reset

    reset = 0;

    // Comienza prueba 4: INSUFICIENTE.

    intro_moneda = 1;
    
    #20 //tiempo para que se active INSUFICIENTE 5 ciclos

    finalizar_pago = 1;
    intro_moneda = 0;

    #16 //tiempo de salida de INSUFICIENTE

    finalizar_pago = 0;
    reset  = 1;

    #4//tiempo para reset

    reset = 0;

    #50//finalizando prueba






    $finish;

end


endmodule
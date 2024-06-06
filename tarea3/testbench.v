`include "top.v"

module tb_top;

    reg clk;
    reg reset;
    reg SLAVE_SELECT;

    // Instancia del módulo top
    top uut (
        .clk(clk),
        .reset(reset),
        .SLAVE_SELECT(SLAVE_SELECT)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        reset = 1;
        SLAVE_SELECT = 0;
        
        // Esperar un ciclo de reloj
        #10;
        
        // Liberar reset
        reset = 0;
        
        // Simulación de selección de slave
        SLAVE_SELECT = 0; // Seleccionar slave 1
        #10
    
        #100;
        SLAVE_SELECT = 1; // Seleccionar slave 2
        #100;
        
        // Finalizar simulación
        $stop;
    end

endmodule

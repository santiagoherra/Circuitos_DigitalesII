`include "top.v"

module tb_top;

    reg clk;
    reg reset;
    reg SLAVE_SELECT;
    reg [15:0] master_mosi;
    reg [15:0] datain_tb;

    // Instancia del módulo top
    top uut (
        .clk(clk),
        .reset(reset),
        .SLAVE_SELECT(SLAVE_SELECT),
        .dataintop(datain_tb)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $monitor("Time = %0t | clk = %b | reset = %b | SLAVE_SELECT = %b | state = %b | SCLK = %b | CS_SLAVE1 = %b | CS_SLAVE2 = %b | MOSI = %h | MISO_SLAVE1 = %h | MISO_SLAVE2 = %h",
                 $time, clk, reset, SLAVE_SELECT, uut.master_inst.state, uut.SCLK, uut.CS_SLAVE1, uut.CS_SLAVE2, uut.MOSI, uut.slave1_inst.MISO, uut.slave2_inst.MISO);
    end

    initial begin
        // Inicialización
        clk = 0;
        reset = 1;
        datain_tb = 16'hAAAA;
        
        // Esperar un ciclo de reloj
        #10;
        
        // Liberar reset
        reset = 0;
        
        #10
        // Simulación de selección de slave
        SLAVE_SELECT = 1; // Seleccionar slave 1
        #10
    
        #400;

        reset = 1;

        #20

        reset = 0;   
        SLAVE_SELECT = 0; // Seleccionar slave 2

        
        #400;
        
        // Finalizar simulación
        $finish;
    end

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

endmodule

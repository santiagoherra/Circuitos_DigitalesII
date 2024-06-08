module slave1(
    input SCLK,
    input [15:0] MOSI,
    input CS,
    input [15:0] count_master,
    output reg [15:0] MISO
);

reg [1:0] termino;
reg [15:0] count_slave;
reg activador;
reg [15:0] datos_guardados;

always @(posedge SCLK) begin
    if (CS) begin
        // Reiniciar variables cuando CS está activo
        termino <= termino + 1;
        count_slave <= 16;
        activador <= 0;
    end else begin
        // Capturar datos desde MOSI
        if (count_master < 16) begin
            datos_guardados[count_master] <= MOSI[count_master];
        end 

        // Activar el envío de datos a MISO
        if (count_master == 0) begin
            activador <= 1;
        end

        if (activador) begin
            if (count_slave != 0) begin
                MISO <= datos_guardados[count_slave - 1]; // little endian
                count_slave <= count_slave - 1;
            end
        end
    end
end

endmodule

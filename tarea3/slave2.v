module slave2(
    input SCLK,
    input [15:0] MOSI,
    input CS,
    input [15:0] count_master,
    output reg [15:0] MISO
);

reg [1:0] termino = 0;
reg [15:0] count_slave = 16;
reg activador;
reg [15: 0] datos_guardados;

always @(posedge SCLK) begin //polaridad positiva
    if(count_master < 17)begin
        datos_guardados[count_master] = MOSI
    end 

    if(CS)begin
        termino <= termino + 1;
    end

    if(count_slave != 0)
        if(count_master == 0)begin 
            activador = 1;
        end

        if(termino != 2)begin
            if(activador)begin
                MISO <= datos_guardados[count_slave - 1]; //little endian
                count_slave = count_slave - 1;
            end
        end
    end

endmodule   
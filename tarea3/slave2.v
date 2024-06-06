module slave2(
    input SCLK,
    input [15:0] MOSI,
    input CS,
    input [15:0] count_master,
    output reg [15:0] MISO
);

reg termino;
reg [15:0] count_slave = 16'd16;

always @(posedge SCLK) begin //polaridad positiva
    if(CS)begin
        termino <= termino - 1;
    end

    if(termino != 1)begin
        if(count_master == 0)begin
            MISO <= MOSI[count_slave - 1]; //little endian
            count_slave = count_slave - 1;
        end
    end
end

endmodule
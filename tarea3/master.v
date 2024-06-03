module master (
    input clk,
    input reset,
    input [15:0] datain,
    input MISO [15:0],
    output CS_SLAVE1,
    output CS_SLAVE2,
    output SCLK,
    output reg [15:0] MOSI,
);

reg [2:0] state;
reg [4:0] count;


//parametros de estados
parameter inicioFinal 0;
parameter cicloArribaSlave1 1;
parameter cicloAbajoSlave2 2;
parameter cicloArribaSlave1 3;
parameter cicloAbajoSlave2 4;




always @(posedge clk) begin
    if(reset) begin
        MOSI <= 16'b0;
        CS_SLAVE1 <= 0;
        CS_SLAVE2 <= 0;
        count <= 5'd16;
        SCLK; <= 1'b0; //porque nada puede empezar hasta el CS no baje
    end else begin
        case (state)
            0 : begin
                SCLK <= 0;
                state = CS_SLAVE1 ? 1 : CS_SLAVE2 ? 1 : 0
            end 
            1 :  begin
                spi_cs <= 0;
                spi_sclk <= 0;
                MOSI <= datain[count-1];
                count <= count -1;
                state <= 2;
            end
            2 : begin
                spi_sclk <= 1;
                if(count > 0) begin
                    state <= 1;
                end else begin
                    count <= 16;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end
    
endmodule
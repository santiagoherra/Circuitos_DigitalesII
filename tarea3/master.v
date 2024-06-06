module master (
    input clk,
    input reset,
    input [15:0] MISO,
    input SLAVE_SELECT,
    output reg CS_SLAVE1,
    output reg CS_SLAVE2,
    output reg SCLK,
    output reg [15:0] MOSI,
    output reg [15:0] count
);

reg [2:0] state;

//parametros de estados
parameter inicioFinal = 0;
parameter inicioFinal_slave1 = 1;
parameter inicioFinal_slave2 = 2;
parameter cicloArribaSlave1 = 3;
parameter cicloAbajoSlave1 = 4;
parameter cicloArribaSlave2 = 5;
parameter cicloAbajoSlave2 = 6;

always @(posedge clk) begin
    if(reset) begin
        MOSI <= 16'b0;
        CS_SLAVE1 <= 1'b0;
        CS_SLAVE2 <= 1'b0;
        count <= 16'd16;
        SCLK <= 1'b0; //porque nada puede empezar hasta el CS no baje
        state <= 0;
    
    end else begin
        case (state)
            inicioFinal : begin
                SCLK <= 0;
                state = SLAVE_SELECT ? inicioFinal_slave1 : inicioFinal_slave2;
            end 

            inicioFinal_slave1 : begin
                SCLK <= 0;
                CS_SLAVE1 <= 1;
                if(count == 0)begin
                    state <= inicioFinal;
                    CS_SLAVE1 <= 0;
                end 
                count <= 16;
                state <= cicloArribaSlave1;
            end 

            cicloArribaSlave1 :  begin
                SCLK <= 0;
                CS_SLAVE1 <= 0;
                MOSI <= MISO[count - 1];
                count <= count - 1;
                state <= cicloAbajoSlave1;

            end
            cicloAbajoSlave1 : begin
                SCLK <= 1;
                if(count > 0) begin
                    state <= cicloArribaSlave1;
                end else begin
                    CS_SLAVE1 <= 1;
                    state <= inicioFinal_slave1;
                end
            end
            
            inicioFinal_slave2 : begin
                SCLK <= 0;
                CS_SLAVE2 <= 1;
                if(count == 0)begin
                    state <= inicioFinal;
                    CS_SLAVE2 <= 0;
                end
                count <= 16;
                state <= cicloArribaSlave2;
            end 

            cicloArribaSlave2 :  begin
                SCLK <= 0;
                CS_SLAVE2 <= 0;
                MOSI <= MISO[count - 1];
                count <= count - 1;
                state <= cicloAbajoSlave2;

            end
            cicloAbajoSlave2 : begin
                SCLK <= 1;
                if(count > 0) begin
                    state <= cicloArribaSlave2;
                end else begin
                    CS_SLAVE2 <= 1;
                    state <= inicioFinal_slave2;
                end
            end

            default: state <= 0;
        endcase
    end
end
    
endmodule
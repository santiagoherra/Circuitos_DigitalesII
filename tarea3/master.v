module master (
    input clk,
    input reset,
    input [15:0] MISO,
    input SLAVE_SELECT,
    input [15:0] datain,
    output reg CS_SLAVE1,
    output reg CS_SLAVE2,
    output reg SCLK,
    output reg [15:0] MOSI,
    output reg [15:0] count
);

reg [2:0] state;
reg [4:0] contador_final;

//parametros de estados
parameter inicioFinal = 0;
parameter inicioFinal_slave1 = 1;
parameter inicioFinal_slave2 = 2;
parameter cicloArribaSlave1 = 3;
parameter cicloAbajoSlave1 = 4;
parameter cicloArribaSlave2 = 5;
parameter cicloAbajoSlave2 = 6;

always @(negedge clk or posedge clk) begin
    if(reset) begin
        MOSI <= 16'b0;
        CS_SLAVE1 <= 1'b0;
        CS_SLAVE2 <= 1'b0;
        count <= 16'd16;
        SCLK <= 1'b0; //porque nada puede empezar hasta el CS no baje
        state <= 0;
        contador_final <= 0;
    
    end else begin
        case (state)
            //Inicio para elegir el slave que se desea usar.
            inicioFinal : begin
                SCLK <= 0;
                state = SLAVE_SELECT ? inicioFinal_slave1 : inicioFinal_slave2;
            end 

            //estados necesarios para el slave 1
           
           inicioFinal_slave1 : begin
                SCLK <= 0;
                if(contador_final == 31 || contador_final == 0)begin
                    CS_SLAVE1 <= 1;
                end
                state <= (contador_final == 31) ? inicioFinal_slave1 : cicloArribaSlave1;
            end 

            cicloArribaSlave1 :  begin
                SCLK <= 1;
                CS_SLAVE1 <= 0;
                contador_final = contador_final + 1;
                MOSI <= datain[count - 1];
                count <= count - 1;
                state <= cicloAbajoSlave1;

            end
            cicloAbajoSlave1 : begin
                SCLK <= 0;
                if(16 > count > 0) begin
                    state <= cicloArribaSlave1;
                end else begin
                    state <= inicioFinal_slave1;
                end
            end
            
            //estados necesarios para el slave 2

            inicioFinal_slave2 : begin
                SCLK <= 0;
                if(contador_final == 31 || contador_final == 0)begin
                    CS_SLAVE2 <= 1;
                end
                state <= (contador_final == 31) ? inicioFinal_slave2 : cicloArribaSlave2;
            end 

            cicloArribaSlave2 :  begin
                SCLK <= 1;
                CS_SLAVE2 <= 0;
                contador_final = contador_final + 1;
                MOSI <= datain[count - 1];
                count <= count - 1;
                state <= cicloAbajoSlave2;

            end
            cicloAbajoSlave2 : begin
                SCLK <= 0;
                if(31 > contador_final > 0) begin
                    state <= cicloArribaSlave2;
                end else begin
                    state <= inicioFinal_slave2;
                end
            end

            default: state <= inicioFinal;
        endcase
    end
end
    
endmodule
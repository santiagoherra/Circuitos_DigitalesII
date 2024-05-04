module calculadora8bit(
    input clk, en, rst,
    input [7:0] a, b, 
    input [1:0] MODO,
    output reg [7: 0] c
);

parameter SUMA = 2'b00;
parameter RESTA = 2'b01;
parameter MULTIPLICA = 2'b10;
parameter LEFTSHIFT = 2'b11;

always@(posedge clk)
begin
    if(en)begin
    case (MODO)
        SUMA: begin
            c <= a + b;
            end
        
        RESTA: begin
            c <= a - b;
                end
        
        MULTIPLICA: begin
            c <= a * b;
                    end

        LEFTSHIFT: begin
            c <= a >> b;
                    end

        default: 
            c <=0;

    endcase
    end
    if(rst)begin
        c <= 0;
    end
end
    
endmodule
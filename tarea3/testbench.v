`include "master.v"

module testbench (
    output reg clk,
    output reg reset,
    output reg [15:0] datain,
    input spi_cs_l,
    input sclk,
    input spi_data,
    input [15:0] counter
);

master uut (
    .clk(clk),
    .reset(reset),
    .datain(datain),
    .spi_cs_l(spi_cs_l),
    .sclk(sclk),
    .spi_data(spi_data),
    .counter(counter)
);

always #5 clk = !clk;

initial begin
    reset = 1;
    clk = 0;
    datain = 0;
    #10;
    reset = 0;
    #10;
    datain = 16'hA569;
    #335;
    $finish;
end

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end

    
endmodule
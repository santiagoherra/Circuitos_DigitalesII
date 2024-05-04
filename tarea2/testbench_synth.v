`include "synth.v"
`include "../trabajo_clase/yosys/cmos_cells_delay.v"
`include "tester.v"

module tb;
    wire  clk, en, rst;
    wire [7:0] a, b, c;
    wire [1:0] MODO;

calculadora8bit DUT(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a(a [7:0]),
    .b(b [7:0]),
    .MODO(MODO [1:0]),
    .c(c [7:0])
);

tester test(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a(a),
    .b(b),
    .MODO(MODO),
    .c(c)
);

initial begin
    $dumpfile("tb_synth.vcd");
    $dumpvars;
end


endmodule
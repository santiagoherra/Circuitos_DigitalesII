`include "calculadora8bit.v"
`include "tester.v"

module tb_;
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
    $dumpfile("tb_calculadora8bit.vcd");
    $dumpvars;
end


endmodule
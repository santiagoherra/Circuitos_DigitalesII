`include "master.v"
`include "slave1.v"
`include "slave2.v"


module top (
    input clk,
    input reset,
    input SLAVE_SELECT,
    input [15:0] dataintop
);

// Interconexión de señales
wire [15:0] MOSI;
wire SCLK;
wire CS_SLAVE1;
wire CS_SLAVE2;
wire [15:0] count;
wire [15:0] MISO_SLAVE1;
wire [15:0] MISO_SLAVE2;
wire [15:0] MISO_MASTER;

// Selección de MISO del master basado en cuál slave está activo
assign MISO_MASTER = (SLAVE_SELECT) ? MISO_SLAVE1 : MISO_SLAVE2;

// Instancia del master
master master_inst (
    .clk(clk),
    .reset(reset),
    .MISO(MISO_MASTER),
    .SLAVE_SELECT(SLAVE_SELECT),
    .datain(dataintop),
    .CS_SLAVE1(CS_SLAVE1),
    .CS_SLAVE2(CS_SLAVE2),
    .SCLK(SCLK),
    .MOSI(MOSI),
    .count(count)
);

// Instancia del slave1
slave1 slave1_inst (
    .SCLK(SCLK),
    .MOSI(MOSI),
    .CS(CS_SLAVE1),
    .count_master(count),
    .MISO(MISO_SLAVE1)
);

// Instancia del slave2
slave2 slave2_inst (
    .SCLK(SCLK),
    .MOSI(MOSI),
    .CS(CS_SLAVE2),
    .count_master(count),
    .MISO(MISO_SLAVE2)
);

endmodule

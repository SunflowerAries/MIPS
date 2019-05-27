`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 17:03:35
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module clkdiv(
    input mclk,
    output clk,   // 0.33s, // 0.02s
    output clk190, // 0.00125s 
    input choice
    );
    reg[27:0] q;
    wire clk1, clk2;
    initial
        q <= 0;
    always@(posedge mclk)
        q <= q + 1;
    assign clk1 = q[0]; //1.32s 26
    assign clk2 = q[0]; //0.16s 23
    assign clk = !choice & clk1 | choice & clk2;
    assign clk190 = q[16];
endmodule

module top(input CLK100MHZ,
           input [6:0] SW,
           output [6:0] S,
           output [7:0] AN);
    wire [31:0] writedata, dataadr;
    wire clock, clock190;
    wire [31:0] pc, instr, readdata;
    wire memwrite;
    clkdiv myClk(CLK100MHZ, clock, clock190, SW[6]);
    mips mips(clock, clock190, SW[0], pc, instr, memwrite, dataadr, writedata, readdata, SW[5:1], S, AN);
    imem imem(pc[7:2], instr);
    dmem dmem(clock, memwrite, dataadr, writedata, readdata);
endmodule

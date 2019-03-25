`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 18:44:11
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
    output clk,   // 0.33s
    output clk48, // 0.02s
    output clk190, // 0.00125s 
    input choice
    );
    reg[27:0] q;
    wire clk1, clk2;
    always@(posedge mclk)
        q <= q + 1;
    assign clk1 = q[26]; //1.32s
    assign clk2 = q[23]; //0.16s
    assign clk = !choice & clk1 | choice & clk2;
    assign clk190 = q[16];
    assign clk48 = q[20];
endmodule

module top(input CLK100MHZ,
           input [6:0] SW,
           output [6:0] S,
           output [7:0] AN);
    wire [31:0] pc, instr, readdata;
    wire clock, clock48, clock190;
    wire [31:0] writedata, dataadr;
    wire memwrite;
    clkdiv myClk(CLK100MHZ, clock, clock48, clock190, SW[6]);
    mips mips(clock, clock190, SW[0], pc, instr, memwrite, dataadr, writedata, readdata, SW[5:1], S, AN);
    imem imem(pc[7:2], instr);
    dmem dmem(clock, memwrite, dataadr, writedata, readdata);
    
endmodule

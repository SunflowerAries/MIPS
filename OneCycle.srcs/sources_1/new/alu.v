`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:45:32
// Design Name: 
// Module Name: mips
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
module ALU(input [31:0] a, b,
           input [0:0] F,
           output [31:0] c,
           output SLT);
    assign c = a + b + F;
    assign SLT = (c[31] == 1) ? 1 : 0;
endmodule
module alu(input [31:0] a, b,
           input [2:0] alucont,
           output reg [31:0] result,
           output zero);
    wire [31:0] b_n;
    wire [31:0] c0, c1, c2, c3;
    wire SLT;
    assign b_n = (alucont[2] == 0) ? b : ~b; 
    assign c0 = a & b_n;
    assign c1 = a | b_n;
    ALU cal(a, b_n, alucont[2],c2, SLT);
    assign c3 = {{31{1'b0}}, SLT};
    always@(*)
        begin
            case(alucont[1:0])
                2'b00:   result <= c0;
                2'b01:   result <= c1;
                2'b10:   result <= c2;
                2'b11:   result <= c3;
                default: result <= c0;
            endcase
        end
    assign zero = result == 0;
endmodule

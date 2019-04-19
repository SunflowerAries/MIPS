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
           input F,
           output [31:0] c,
           output SLT);
    assign c = a + b + F;
    assign SLT = (c[31] == 1) ? 1 : 0;
endmodule

module alu(input [31:0] a, b,
           input [3:0] alucont,
           output reg [31:0] result,
           output zero,
           input [4:0] shamt);
    wire [31:0] b_n;
    wire [31:0] c0, c1, c2, c3, c4, c5, c6;
    wire SLT;
    assign b_n = (alucont[2] == 0) ? b : ~b;
    assign c0 = a & b_n;
    assign c1 = a | b_n;
    ALU cal(a, b_n, alucont[2], c2, SLT);
    assign c3 = {{31{1'b0}}, SLT};
    assign c4 = b << shamt;
    assign c5 = b >> shamt;
    assign c6 = ({{31{b[31]}}, 1'b0} << (~shamt) )| (b >> shamt);//~shamt = 32 - shamt - 1
    
    always@(*)
        begin
            case({alucont[3],alucont[1:0]})
                3'b000:   result <= c0; // a & b
                3'b001:   result <= c1; // a | b
                3'b010:   result <= c2; // add sub 
                3'b011:   result <= c3; // slt
                3'b100:   result <= c4; // sll
                3'b101:   result <= c5; // srl
                3'b110:   result <= c6; // sra
                default: result <= c0;
            endcase
        end
    assign zero = result == 0;
endmodule

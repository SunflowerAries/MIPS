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
           input [4:0] alucont,
           output reg [63:0] result,
           output zero,
           input [4:0] shamt);
    wire [31:0] b_n, a_n_1;
    wire [31:0] c0, c1, c2, c3, c4, c5, c6;
    wire SLT;
    reg [64:0] c7;
    integer i;
    assign b_n = (alucont[2] == 0) ? b : ~b;
    assign c0 = a & b_n;
    assign c1 = a | b_n;
    assign a_n_1 = ~a + 1;
    ALU cal(a, b_n, alucont[2], c2, SLT);
    assign c3 = {{31{1'b0}}, SLT};
    assign c4 = b << shamt;
    assign c5 = b >> shamt;
    assign c6 = ({{31{b[31]}}, 1'b0} << (~shamt) )| (b >> shamt);//~shamt = 32 - shamt - 1
    always@(*)
        begin
            c7  =0;
            c7[32:0] = {b,1'b0};
            for(i = 0; i < 32; i = i + 1)
                begin
                    case(c7[1:0])
                        2'b00, 2'b11:  c7 = {c7[64], c7[64:1]};
                        2'b01: begin c7[64:33] = c7[64:33] + a; c7 = {c7[64], c7[64:1]}; end
                        2'b10: begin c7[64:33] = c7[64:33] + a_n_1; c7 = {c7[64], c7[64:1]}; end
                    endcase
                end
            case({alucont[4:3],alucont[1:0]})
                4'b0000:   result[31:0] <= c0; // a & b
                4'b0001:   result[31:0] <= c1; // a | b
                4'b0010:   result[31:0] <= c2; // add sub 
                4'b0011:   result[31:0] <= c3; // slt
                4'b0100:   result[31:0] <= c4; // sll
                4'b0101:   result[31:0] <= c5; // srl
                4'b0110:   result[31:0] <= c6; // sra
                4'b1000:   result <= c7[64:1]; // mul
                default: result[31:0] <= c0;
            endcase
        end
    assign zero = result[31:0] == 0;
endmodule

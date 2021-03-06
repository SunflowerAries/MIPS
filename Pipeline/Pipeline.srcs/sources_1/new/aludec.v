`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 19:50:41
// Design Name: 
// Module Name: aludec
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


module aludec(input [5:0] funct,
              input [2:0] aluop,
              output reg [3:0] alucontrol,
              output reg ret);
    always@(*)
        begin
            ret = 0;
            case(aluop)
                3'b000: alucontrol = 4'b0010; //add
                3'b001: alucontrol = 4'b0110; //sub
                3'b011: alucontrol = 4'b0000; //and
                3'b100: alucontrol = 4'b0001; //or
                3'b101: alucontrol = 4'b0111; //slt
                default: 
                    case(funct)
                        6'b100000: alucontrol = 4'b0010;//ADD
                        6'b100010: alucontrol = 4'b0110;//SUB
                        6'b100100: alucontrol = 4'b0000;//AND
                        6'b100101: alucontrol = 4'b0001;//OR
                        6'b101010: alucontrol = 4'b0111;//SLT
                        6'b000000: alucontrol = 4'b1000;//sll
                        6'b000010: alucontrol = 4'b1001;//srl
                        6'b000011: alucontrol = 4'b1010;//sll
                        6'b001000: begin alucontrol = 4'b1011; ret = 1; end//jr
                        default:   alucontrol = 4'bxxxx;
                    endcase
            endcase
        end
endmodule

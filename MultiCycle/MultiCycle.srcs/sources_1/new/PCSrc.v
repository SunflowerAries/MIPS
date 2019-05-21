`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:33:39
// Design Name: 
// Module Name: pcsrc
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


module PCSrc(input [31:0] nextaluout, aluout, pcjump,
             input [1:0] pcsrc,
             output reg [31:0] pcnext);
always@(*)
    case(pcsrc)
        2'b00: pcnext <= nextaluout;
        2'b01: pcnext <= aluout;
        2'b10: pcnext <= pcjump;
    endcase
endmodule

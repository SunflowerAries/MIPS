`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 16:10:33
// Design Name: 
// Module Name: mux2
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
module mux2 #(parameter WIDTH = 8)
             (input [WIDTH - 1:0] d0, d1,
              input s,
              output [WIDTH - 1:0] y);
    assign y = s ? d1 : d0;//8λ�� 4λ��
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 19:29:58
// Design Name: 
// Module Name: flopenrpred
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

module flopenrpred #(parameter WIDTH = 8)
                    (input clk, reset,
                     input en, predmiss, 
                     input [WIDTH - 1 : 0] d, pcplus4D,
                     output reg [WIDTH - 1 : 0] q);
    //reg 
    always@(posedge clk)
        if(reset)           q <= 0;
        else if(predmiss)   q <= pcplus4D;
        else if(en)         q <= d;
endmodule

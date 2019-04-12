`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:27:42
// Design Name: 
// Module Name: flopr
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


module flopr  (input clk, reset, en,
               input [31:0] d,
               output reg [31:0] q);
    initial
        q <= 0;
    always@(posedge clk)
        if (reset)  q <= 0;
        else if(en) q <= d;
        else q <= q;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 11:19:20
// Design Name: 
// Module Name: sim
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


module sim();
    reg clk, reset;
    wire [31:0] writedata;
    wire memwrite;
    top sim(clk, reset, writedata, memwrite);
    
    initial 
        begin
            clk = 0;
            reset = 1;
        end
    initial
        #6 reset = 0;
    always #5 clk = ~clk;
endmodule

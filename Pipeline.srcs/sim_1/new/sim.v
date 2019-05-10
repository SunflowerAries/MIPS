`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 14:37:35
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
    reg clk;
    reg reset;
    wire [31:0] writedata, dataadr;
    wire memwrite;
    
    top sim(clk, reset, writedata, dataadr, memwrite);
    initial
        begin
            reset = 1;
            clk = 0;
        end
    initial
        #13 reset = 0;
    always #5 clk = ~clk;
endmodule

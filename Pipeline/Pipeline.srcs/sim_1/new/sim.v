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
    wire [6:0] S;
    wire [7:0] AN;
    reg [6:0] SW;
    
    top sim(clk, SW, S, AN);
    initial
        begin 
            SW[0] = 1;
            clk = 0;
        end
    initial
        begin
            #13  SW[0] = 0;
            SW[6] = 0;
        end
    always #5 clk = ~clk;
endmodule


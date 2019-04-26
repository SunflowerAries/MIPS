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
    reg clk;
    reg [6:0] SW;
    wire [6:0] S;
    wire [7:0] AN;
    top sim(clk, SW, S, AN);
    
    initial 
        begin
            clk = 0;
            SW[0] = 1;
        end
    initial
        begin
            #13 SW[0] = 0;
            SW[6] = 0;
        end
        
    always #5 clk = ~clk;
endmodule

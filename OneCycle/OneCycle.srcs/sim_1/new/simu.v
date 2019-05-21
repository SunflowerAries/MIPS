`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 15:32:05
// Design Name: 
// Module Name: simu
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


module simu();
    reg clk;
    wire [6:0] S;
    wire [7:0] AN;
    reg [6:0] SW;
    
    top sim1(clk, SW, S, AN);
    
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

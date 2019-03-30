`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 15:37:44
// Design Name: 
// Module Name: test_maindec
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


module test_maindec();
    reg [5:0] op;
    wire mem2reg, memwrite;
    wire branch, alusrc;
    wire regdst, regwrite, jump;
    wire [1:0] aluop;
    
    maindec MUT(op, mem2reg, memwrite, branch, alusrc, regdst, 
                regwrite, jump, aluop);
    initial begin
    op = 0;
    #20 op = 6'b000000;
    #20 op = 6'b100011;
    #20 op = 6'b101011;
    #20 op = 6'b000100;
    #20 op = 6'b001000;
    #20 op = 6'b000010;
    #20 op = 6'b011110;
    end
endmodule

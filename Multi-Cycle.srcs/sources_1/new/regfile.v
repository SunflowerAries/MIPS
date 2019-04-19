`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:33:39
// Design Name: 
// Module Name: regfile
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


module regfile(input clk, reset,
               input regWriteEn, jal,
               input [4:0] RsAddr, RtAddr,
               input [4:0] regWriteAddr,
               input [31:0] regWriteData, pc,
               output [31:0] RsData, RtData);
    reg [31:0] rf [31:0];
    integer i;
    always @ (posedge clk)
        begin
            if(regWriteEn) rf[regWriteAddr] <= regWriteData;
            if(reset)
                for(i = 0; i < 32; i = i + 1)
                    rf[i] = 0;
            if(jal) rf[31] <= pc;
        end
        
    assign RsData = (RsAddr != 0) ? rf[RsAddr] : 0;
    assign RtData = (RtAddr != 0) ? rf[RtAddr] : 0;
endmodule

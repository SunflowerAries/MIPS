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


module regfile(input clk,
               input regWriteEn,
               input [4:0] RsAddr, RtAddr,
               input [4:0] regWriteAddr,
               input [31:0] regWriteData,
               output [31:0] RsData, RtData);
    reg [31:0] rf [31:0];
    
    always @ (posedge clk)
        if(regWriteEn) rf[regWriteAddr] <= regWriteData;
        
    assign RsData = (RsAddr != 0) ? rf[RsAddr] : 0;
    assign RtData = (RtAddr != 0) ? rf[RtAddr] : 0;
endmodule

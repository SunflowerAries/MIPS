`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/27 08:34:04
// Design Name: 
// Module Name: Display
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


module Display(input clk190,
               input [31:0] in,
               output reg [6:0] hex,
               output reg [7:0] SW,
               input reset);
    
    reg [2:0] tim;
    reg [3:0] bi;

    always @ (posedge clk190)
    begin
        case (tim)
            3'b000: begin SW = 8'b11111110; bi = in[3:0]; end
            3'b001: begin SW = 8'b11111101; bi = in[7:4]; end
            3'b010: begin SW = 8'b11111011; bi = in[11:8]; end
            3'b011: begin SW = 8'b11110111; bi = in[15:12]; end
            3'b100: begin SW = 8'b11101111; bi = in[19:16]; end
            3'b101: begin SW = 8'b11011111; bi = in[23:20]; end
            3'b110: begin SW = 8'b10111111; bi = in[27:24]; end
            3'b111: begin SW = 8'b01111111; bi = in[31:28]; end
            default: begin SW = 8'b11111110; bi = in[3:0]; end
        endcase
        case(bi)
            4'b0000: hex = 7'b1_0_0_0_0_0_0;
            4'b0001: hex = 7'b1_1_1_1_0_0_1;
            4'b0010: hex = 7'b0_1_0_0_1_0_0;
            4'b0011: hex = 7'b0_1_1_0_0_0_0;
            4'b0100: hex = 7'b0_0_1_1_0_0_1;
            4'b0101: hex = 7'b0_0_1_0_0_1_0; 
            4'b0110: hex = 7'b0_0_0_0_0_1_0;    
            4'b0111: hex = 7'b1_1_1_1_0_0_0;
            4'b1000: hex = 7'b0_0_0_0_0_0_0;
            4'b1001: hex = 7'b0_0_1_0_0_0_0;
            4'b1010: hex = 7'b0_0_0_1_0_0_0;
            4'b1011: hex = 7'b0_0_0_0_0_1_1;
            4'b1100: hex = 7'b1_0_0_0_1_1_0;
            4'b1101: hex = 7'b0_1_0_0_0_0_1;
            4'b1110: hex = 7'b0_0_0_0_1_1_0;
            4'b1111: hex = 7'b0_0_0_1_1_1_0;
            default: hex = 7'b1_0_0_0_0_0_0;
        endcase
        if(tim != 3'b111) tim = tim + 1;
        else tim = 0;
    end
endmodule

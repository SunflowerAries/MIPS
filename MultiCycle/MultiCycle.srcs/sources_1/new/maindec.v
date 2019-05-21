`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:33:39
// Design Name: 
// Module Name: maindec
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


module maindec(input [5:0] op,
               input reset, clk,
               output memtoreg, memwrite, 
               output [1:0] branch,
               output regdst, regwrite, alusrca, exp,
               output [1:0] alusrcb, 
               output [2:0] aluop,
               output [1:0] pcsrc,
               output IRWrite, IorD, pcwrite, jal);
    reg [18:0] controls;
    assign {jal, exp, pcwrite, memwrite, IRWrite, regwrite, alusrca, branch, IorD, memtoreg, 
    regdst, alusrcb, pcsrc, aluop} = controls;
    
    parameter fetch = 5'b00000;
    parameter decode = 5'b00001;
    parameter memadr = 5'b00010;
    parameter memrd = 5'b00011;
    parameter memwb = 5'b00100;
    parameter memwr = 5'b00101;
    parameter rtypeex = 5'b00110;
    parameter rtypewb = 5'b00111;
    parameter beqex = 5'b01000;
    parameter addiex = 5'b01001;
    parameter itypewb = 5'b01010;
    parameter jex = 5'b01011;
    parameter bneex = 5'b01100;
    parameter andiex = 5'b01101;
    parameter oriex = 5'b01110;
    parameter sltiex = 5'b01111;
    parameter link = 5'b10000;
    parameter jr = 5'b10001;
    
    parameter Rtype = 6'b000000;
    parameter SW = 6'b101011;
    parameter LW = 6'b100011;
    parameter BEQ = 6'b000100;
    parameter ADDI = 6'b001000;
    parameter J = 6'b000010;
    parameter BNE = 6'b000101;
    parameter ANDI = 6'b001100;
    parameter ORI = 6'b001101;
    parameter SLTI = 6'b001010;
    parameter JAL = 6'b000011;
    
    reg [4:0] state, nextstate;
    always@(posedge clk, posedge reset)
        if(reset) state <= fetch;
        else      state <= nextstate;
        
    always@(*)
        case(state)
            fetch: nextstate <= decode;
            decode: 
                case(op)
                    LW:    nextstate <= memadr;
                    SW:    nextstate <= memadr;
                    Rtype: nextstate <= rtypeex;
                    BEQ:   nextstate <= beqex;
                    ADDI:  nextstate <= addiex;
                    J:     nextstate <= jex;
                    BNE:   nextstate <= bneex;
                    ANDI:  nextstate <= andiex;
                    ORI:   nextstate <= oriex;
                    SLTI:  nextstate <= sltiex;
                    JAL:   nextstate <= link;
                    default: nextstate <= 5'bxxxxx;
                endcase
            memadr:
                case(op)
                    LW: nextstate <= memrd;
                    SW: nextstate <= memwr;
                    default: nextstate <= 5'bxxxxx;
                endcase
            memrd:   nextstate <= memwb;
            memwb:   nextstate <= fetch;
            memwr:   nextstate <= fetch;
            rtypeex: nextstate <= rtypewb;
            rtypewb: nextstate <= fetch;
            beqex:   nextstate <= fetch;
            bneex:   nextstate <= fetch;
            addiex:  nextstate <= itypewb;
            andiex:  nextstate <= itypewb;
            oriex:   nextstate <= itypewb;
            sltiex:  nextstate <= itypewb;
            itypewb: nextstate <= fetch;
            jex:     nextstate <= fetch;
            link:    nextstate <= jex;
            default: nextstate <= 5'bxxxxx;
        endcase
        
    always@(*)
        case(state)
            fetch:   controls <= 19'b0110100000000100000;
            decode:  controls <= 19'b0100000000001100000;
            memadr:  controls <= 19'b0100001000001000000;
            memrd:   controls <= 19'b0100000001000000000;
            memwb:   controls <= 19'b0100010000100000000;
            memwr:   controls <= 19'b0101000001000000000;
            rtypeex: controls <= 19'b0100001000000000010;
            rtypewb: controls <= 19'b0100010000010000000;
            beqex:   controls <= 19'b0100001010000001001;
            bneex:   controls <= 19'b0100001100000001001;
            addiex:  controls <= 19'b0100001000001000000;
            andiex:  controls <= 19'b0000001000001000011;
            oriex:  controls <= 19'b0000001000001000100;
            sltiex:  controls <= 19'b0100001000001000101;
            itypewb:  controls <= 19'b0100010000000000000;
            link:  controls <= 19'b1100000000000000000;
            jex:     controls <= 19'b0110000000000010000;
default: controls <= 19'bxxxxxxxxxxxxxxxxxxx;
        endcase
endmodule

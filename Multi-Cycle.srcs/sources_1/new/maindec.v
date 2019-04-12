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
               output branch,
               output regdst, regwrite, alusrca, exp,
               output [1:0] alusrcb, 
               output [2:0] aluop,
               output [1:0] pcsrc,
               output IRWrite, IorD, pcwrite);
    reg [16:0] controls;
    assign {exp, pcwrite, memwrite, IRWrite, regwrite, alusrca, branch, IorD, memtoreg, 
    regdst, alusrcb, pcsrc, aluop} = controls;
    
    parameter fetch = 4'b0000;
    parameter decode = 4'b0001;
    parameter memadr = 4'b0010;
    parameter memrd = 4'b0011;
    parameter memwb = 4'b0100;
    parameter memwr = 4'b0101;
    parameter rtypeex = 4'b0110;
    parameter rtypewb = 4'b0111;
    parameter beqex = 4'b1000;
    parameter addiex = 4'b1001;
    parameter addiwb = 4'b1010;
    parameter jex = 4'b1011;
    
    parameter Rtype = 6'b000000;
    parameter SW = 6'b101011;
    parameter LW = 6'b100011;
    parameter BEQ = 6'b000100;
    parameter ADDI = 6'b001000;
    parameter J = 6'b000010;
    
    reg [3:0] state, nextstate;
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
                    default: nextstate <= 4'bxxxx;
                endcase
            memadr:
                case(op)
                    LW: nextstate <= memrd;
                    SW: nextstate <= memwr;
                    default: nextstate <= 4'bxxxx;
                endcase
            memrd:   nextstate <= memwb;
            memwb:   nextstate <= fetch;
            memwr:   nextstate <= fetch;
            rtypeex: nextstate <= rtypewb;
            rtypewb: nextstate <= fetch;
            beqex:   nextstate <= fetch;
            addiex:  nextstate <= addiwb;
            addiwb:  nextstate <= fetch;
            jex:     nextstate <= fetch;
            default: nextstate <= 4'bxxxx;
        endcase
        
    always@(*)
        case(state)
            fetch:   controls <= 17'b11010000000100000;
            decode:  controls <= 17'b10000000001100000;
            memadr:  controls <= 17'b10000100001000000;
            memrd:   controls <= 17'b10000001000000000;
            memwb:   controls <= 17'b10001000100000000;
            memwr:   controls <= 17'b10100001000000000;
            rtypeex: controls <= 17'b10000100000000010;
            rtypewb: controls <= 17'b10001000010000000;
            beqex:   controls <= 17'b10000110000001001;
            addiex:  controls <= 17'b10000100001000000;
            addiwb:  controls <= 17'b10001000000000000;
            jex:     controls <= 17'b11000000000010000;
            default: controls <= 17'bxxxxxxxxxxxxxxxxx;
        endcase
    //always @ (*)
     //   case(op)
       //     6'b001100: controls <= 13'b1010000001100; //andi
         //   6'b001101: controls <= 13'b1010000010000; //ori
           // 6'b001010: controls <= 13'b1011000010100; //slti
            //nop
            //6'b000101: controls <= 13'b0001010000100; //bne
            //6'b000011: controls <= 13'b0xxxxx0xxxx11; //jal
            //default:   controls <= 13'bxxxxxxxxxxxx;
        //endcase
endmodule

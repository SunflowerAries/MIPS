`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 16:13:33
// Design Name: 
// Module Name: datapath
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


module datapath(input clk, reset, memtoreg, pcen, jal, ret,
                input [1:0] pcsrc, alusrcb, 
                input alusrca, regdst, regwrite, IRWrite, IorD, exp,
                input [3:0] alucontrol,
                output zero,
                output [31:0] pc,
                input [31:0] nextinstr, 
                output [31:0] srcB, address, instr);
                
     wire [4:0] writereg, shamt;
     wire [31:0] pcnext, pcnextjr;
     wire [31:0] signimm, signimmsh, nextaluout, aluout;
     wire [31:0] nextsrca, srca, nextsrcb, srcb, regwritedata, srcA;
     wire [31:0] result;
     //TODO, 通过区别地址编码实现指令区域与数据区域的分离, IorD 标志是读指令还是对内存数据进行操作
     
     flopr #(32) pcreg(clk, reset, pcen, ret, pcnext, pc);
     mux2 #(32) Adr(pc, aluout, IorD, address);
     IRreg IRreg(clk, IRWrite, nextinstr, instr);
     Reg Datareg(clk, nextinstr, regwritedata);//nextinstr = nextwritedata for regfile
     regfile rf(clk, reset, regwrite, jal, instr[25:21], instr[20:16], writereg, result, pc, nextsrca, nextsrcb);
     signext se(instr[15:0], signimm);
     Reg Areg(clk, nextsrca, srca);
     Reg Breg(clk, nextsrcb, srcb);
     Reg shamtreg(clk, instr[10:6], shamt);
     mux2 #(32) alusrcA(pc, srca, alusrca, srcA);
     sl2 immsh(signimm, signimmsh);
     alusrcB alusrcB(exp, alusrcb, srcb, 4, signimm, signimmsh, srcB);
     alu alu(srcA, srcB, alucontrol, nextaluout, zero, shamt);
     Reg aluresult(clk, nextaluout, aluout);
     
     PCSrc PCSrc(nextaluout, aluout, {pc[31:28], instr[25:0], 2'b00}, pcsrc, pcnextjr);
     mux2 #(32) pcmux(pcnextjr, srcA, ret, pcnext);
     mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
     mux2 #(32) resmux(aluout, regwritedata, memtoreg, result);
     
endmodule

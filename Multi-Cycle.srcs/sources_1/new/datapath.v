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


module datapath(input clk, clk190, reset, memtoreg, pcen, jal, ret, nextdouble,
                input [1:0] pcsrc, alusrcb, 
                input alusrca, regdst, regwrite, IRWrite, IorD, exp,
                input [4:0] alucontrol,
                output zero,
                output [31:0] pc,
                input [31:0] nextinstr, 
                output [31:0] srcB, address, instr,
                input [4:0] switch,
                output [6:0] S,
                output [7:0] AN);
     wire double;
     wire [4:0] writereg, shamt;
     wire [31:0] pcnext, pcnextjr;
     wire [31:0] signimm, signimmsh;
     wire [31:0] nextsrca, srca, nextsrcb, srcb, regwritedata, srcA;
     wire [15:0] regtoshow;
     wire [63:0] doublenextaluout, doublealuout, result;
     //TODO, 通过区别地址编码实现指令区域与数据区域的分离, IorD 标志是读指令还是对内存数据进行操作
     Display display(clk190, {pc[15:0], regtoshow}, S, AN, reset);
     flopr pcreg(clk, reset, pcen, ret, pcnext, pc);
     mux2 #(32) Adr(pc, doublealuout[31:0], IorD, address);
     IRreg IRreg(clk, IRWrite, nextinstr, instr);
     Reg #(32) Datareg(clk, nextinstr, regwritedata);//nextinstr = nextwritedata for regfile
     regfile rf(clk, reset, double, regwrite, jal, instr[25:21], instr[20:16], writereg, result, pc, nextsrca, nextsrcb, switch, regtoshow);
     signext se(instr[15:0], signimm);
     Reg #(32) Areg(clk, nextsrca, srca);
     Reg #(32) Breg(clk, nextsrcb, srcb);
     Reg #(32) shamtreg(clk, instr[10:6], shamt);
     mux2 #(32) alusrcA(pc, srca, alusrca, srcA);
     sl2 immsh(signimm, signimmsh);
     alusrcB alusrcB(exp, alusrcb, srcb, 4, signimm, signimmsh, srcB);
     alu alu(srcA, srcB, alucontrol, doublenextaluout, zero, shamt);
     Reg #(64) aluresult(clk, doublenextaluout, doublealuout);
     Reg #(1) Double(clk, nextdouble, double);
     PCSrc PCSrc(doublenextaluout[31:0], doublealuout[31:0], {pc[31:28], instr[25:0], 2'b00}, pcsrc, pcnextjr);
     mux2 #(32) pcmux(pcnextjr, srcA, ret, pcnext);
     mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
     mux2 #(64) resmux(doublealuout, {{32{1'b0}},regwritedata}, memtoreg, result);
     
endmodule

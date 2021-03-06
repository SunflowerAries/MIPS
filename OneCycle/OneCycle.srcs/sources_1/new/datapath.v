module datapath(input clk, clk190, reset,
                input memtoreg, pcsrc,
                input alusrc, regdst,
                input regwrite,
                input [1:0] jump,
                input exp,
                input [3:0] alucontrol,
                output zero,
                output [31:0] pc,
                input [31:0] instr,
                output [31:0] aluout, writedata,
                input [31:0] readdata,
                input [4:0] switch,
                output [6:0] S,
                output [7:0] AN,
                input ret);
     wire [4:0] writereg;
     wire [31:0] pcnextj, pcnextbr, pcplus4, pcbranch, pcnext;
     wire [31:0] signimm, signimmsh;
     wire [31:0] srca, srcb;
     wire [15:0] Real;
     wire [31:0] result;
     reg [6:0] hex;
     reg [7:0] SW;
     wire [31:0] ra;
     
     display Display(clk190, {pc[15:0], Real}, S, AN, reset);
     flopr #(32) pcreg(clk, reset, pcnext, pc);
     adder pcadd1(pc, 32'b100, pcplus4);
     sl2 immsh(signimm, signimmsh);
     adder pcadd2(pcplus4, signimmsh, pcbranch);
     mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
     mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump[1], pcnextj);
     mux2 #(32) pcjrmux(pcnextj, ra, ret, pcnext);
     regfile rf(clk, regwrite, switch, instr[25:21], instr[20:16], writereg, result, srca, writedata, Real, reset, pcplus4, jump[0], ra);
     mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
     mux2 #(32) resmux(aluout, readdata, memtoreg, result);
     signext se(exp, instr[15:0], signimm);
     
     mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);

     alu alu(srca, srcb, alucontrol, aluout, zero, instr[10:6]);
endmodule
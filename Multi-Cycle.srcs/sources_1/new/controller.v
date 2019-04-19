module controller(input [5:0] op, funct,
                  input reset, zero, clk,
                  output memtoreg, memwrite, IRWrite, IorD,
                  output pcen, alusrca,
                  output [1:0] alusrcb, pcsrc,
                  output regdst, regwrite, exp, jal, ret,
                  output [3:0] alucontrol);
    wire [2:0] aluop;
    wire [1:0] branch;
    wire pcwrite;
    maindec md(op, reset, clk, memtoreg, memwrite, branch, regdst, regwrite, alusrca, exp, alusrcb, aluop, pcsrc, IRWrite, IorD, pcwrite, jal);
    aludec ad(funct, aluop, alucontrol, ret);
    assign pcen = ((branch[0] & zero) | (branch[1]) & (~zero))| pcwrite;
endmodule
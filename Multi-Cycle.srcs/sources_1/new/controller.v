module controller(input [5:0] op, funct,
                  input reset, zero, clk,
                  output memtoreg, memwrite, IRWrite, IorD,
                  output pcen, alusrca,
                  output [1:0] alusrcb, pcsrc,
                  output regdst, regwrite, exp,
                  output [2:0] alucontrol);
    wire [2:0] aluop;
    wire branch, pcwrite;
    maindec md(op, reset, clk, memtoreg, memwrite, branch, regdst, regwrite, alusrca, exp, alusrcb, aluop, pcsrc, IRWrite, IorD, pcwrite);
    aludec ad(funct, aluop, alucontrol);
    assign pcen = (branch & zero) | pcwrite;
endmodule
module controller(input [5:0] op, funct,
                  input zero,
                  output memtoreg, memwrite,
                  output pcsrc, alusrc,
                  output regdst, regwrite,
                  output jump, exp,
                  output [2:0] alucontrol);
    wire [2:0] aluop;
    wire [1:0] branch;
    maindec md(op, memtoreg, memwrite, branch, regdst, regwrite, jump, alusrc, exp, aluop);
    aludec ad(funct, aluop, alucontrol);
    assign pcsrc = (branch[1] & zero) | (branch[0] & (~zero));
endmodule
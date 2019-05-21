module controller(input [5:0] op, funct,
                  input zero,
                  output memtoreg, memwrite,
                  output pcsrc, alusrc,
                  output regdst, regwrite,
                  output [1:0] jump,
                  output exp,
                  output [3:0] alucontrol,
                  output ret);
    wire [2:0] aluop;
    wire [1:0] branch;
    maindec md(op, memtoreg, memwrite, branch, jump, regdst, regwrite, alusrc, exp, aluop);
    aludec ad(funct, aluop, alucontrol, ret);
    assign pcsrc = (branch[1] & zero) | (branch[0] & (~zero));
endmodule
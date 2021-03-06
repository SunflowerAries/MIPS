module mips(input clk, clk190, reset,
            output [31:0] pc,
            input [31:0] instr,
            output memwrite,
            output [31:0] aluout, writedata,
            input [31:0] readdata,
            input [4:0] switch,
            output [6:0] S,
            output [7:0] AN);
            
    wire memtoreg, branch, pcsrc, zero, alusrc, regdst, regwrite, exp, ret;
    wire [3:0] alucontrol;
    wire [1:0] jump;
    controller c(instr[31:26], instr[5:0], zero, memtoreg, memwrite, pcsrc,
                 alusrc, regdst, regwrite, jump, exp, alucontrol, ret);
    datapath dp(clk, clk190, reset, memtoreg, pcsrc, alusrc, regdst, regwrite,
                jump, exp, alucontrol, zero, pc, instr, aluout, writedata, readdata, switch, S, AN, ret);
endmodule
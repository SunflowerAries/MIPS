module mips(input clk, reset,
            output [31:0] pc,
            input [31:0] nextinstr,
            output memwrite,
            output [31:0] writedata, address);
            
    wire memtoreg, branch, zero, alusrca, regdst, regwrite, exp, jump, pcen, IorD, IRWrite;
    wire [2:0] alucontrol;
    wire [1:0] alusrcb, pcsrc;
    wire [31:0] instr;
    controller c(instr[31:26], instr[5:0], reset, zero, clk, memtoreg, memwrite, IRWrite, IorD, pcen, 
                alusrca, alusrcb, pcsrc, regdst, regwrite, exp, alucontrol);
    datapath dp(clk, reset, memtoreg, pcen, pcsrc, alusrcb, alusrca, regdst, regwrite, IRWrite, IorD,
                exp, branch, alucontrol, zero, pc, nextinstr, writedata, address, instr);
endmodule
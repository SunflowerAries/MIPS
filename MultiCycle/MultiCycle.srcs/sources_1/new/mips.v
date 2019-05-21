module mips(input clk, clk190, reset,
            output [31:0] pc,
            input [31:0] nextinstr,
            output memwrite,
            output [31:0] writedata, address,
            input [4:0] switch,
            output [6:0] S,
            output [7:0] AN);
            
    wire memtoreg, zero, alusrca, regdst, regwrite, exp, jump, pcen, IorD, IRWrite, jal, ret, double;
    wire [4:0] alucontrol;
    wire [1:0] alusrcb, pcsrc;
    wire [31:0] instr;
    controller c(instr[31:26], instr[5:0], reset, zero, clk, memtoreg, memwrite, IRWrite, IorD, pcen, 
                alusrca, alusrcb, pcsrc, regdst, regwrite, exp, jal, ret, double, alucontrol);
    datapath dp(clk, clk190, reset, memtoreg, pcen, jal, ret, double, pcsrc, alusrcb, alusrca, regdst, regwrite, IRWrite, IorD,
                exp, alucontrol, zero, pc, nextinstr, writedata, address, instr, switch, S, AN);
endmodule
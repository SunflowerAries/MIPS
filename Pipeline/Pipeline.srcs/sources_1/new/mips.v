module mips(input clk, clk190, reset, waitinstr, waitdata,
            output [31:0] pcF,
            input [31:0] instrF,
            output memwriteM, atom_memwriteM, memtoregM, lockM,
            output [31:0] aluoutM, writedataM,
            input [31:0] readdataM,
            input [4:0] switch,
            output [6:0] S,
            output [7:0] AN);
    wire [5:0] opD, functD;
    wire regdstE, alusrcE, pcsrcD, 
    memtoregE, memtoregW,
    regwriteE, regwriteM, regwriteW, expD;
    wire [1:0] jumpD;
    wire [3:0] alucontrolE;
    wire flushE, equalD, stallE, stallM, stallW, ret, atom_memwriteE, push_regD;
    wire [1:0] branchD;
    controller c(clk, reset, opD, functD, flushE, equalD, stallE, stallM, stallW, 
                 memtoregE, memtoregM, memtoregW, memwriteM, atom_memwriteE, atom_memwriteM, pcsrcD, branchD,
                 alusrcE, regdstE, regwriteE, regwriteM, regwriteW, jumpD, expD, ret, push_regD, alucontrolE);
    datapath dp(clk, clk190, reset, waitinstr, waitdata, memtoregE, memtoregM, memtoregW, pcsrcD, push_regD, branchD,
                alusrcE, regdstE, regwriteE, regwriteM, regwriteW, jumpD, expD, ret, atom_memwriteE, alucontrolE,
                equalD, stallE, stallM, stallW, pcF, instrF, aluoutM, writedataM, readdataM, opD, functD, flushE, lockM, switch, S, AN);
endmodule
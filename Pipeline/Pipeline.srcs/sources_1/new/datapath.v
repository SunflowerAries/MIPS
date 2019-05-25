module datapath(input clk, reset, 
                input memtoregE, memtoregM, memtoregW, 
                input pcsrcD, 
                input [1:0] branchD,
                input alusrcE, regdstE, 
                input regwriteE, regwriteM, regwriteW, 
                input [1:0] jumpD, 
                input expD, ret,
                input [3:0] alucontrolE,
                output equalD, 
                output [31:0] pcF, 
                input [31:0] instrF, 
                output [31:0] aluoutM, writedataM, 
                input [31:0] readdataM, 
                output [5:0] opD, functD, 
                output flushE);

wire forwardaD, forwardbD;
wire [1:0] forwardaE, forwardbE;
wire stallF, stallD;
wire [4:0] rsD, rtD, rdD, shamtD, rsE, rtE, rdE, shamtE;
wire [4:0] writeregE, writeregM, writeregW;
wire flushF, flushD, branpredF, branpredD;
wire [31:0] pcnextFD, pcnextbrFD, pcplus4F, pcbranchD, pcnextjmpFD, pcnextFDbefp;
wire [31:0] signimmD, signimmE, signimmshD;
wire [31:0] srcaD, srca2D, srcaE, srca2E;
wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
wire [31:0] pcplus4D, instrD, pcbrpred;
wire [31:0] aluoutE, aluoutW;
wire [31:0] readdataW, resultW;

hazard haz(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW,
           regwriteE, regwriteM, regwriteW,
           memtoregE, memtoregM, branchD,
           forwardaD, forwardbD, forwardaE, forwardbE,
           stallF, stallD, flushE);
           
BPB BPB(clk, reset, stallD, instrF[31:27], pcF[7:0], pcbranchD, pcsrcD, branpredF, pcbrpred);

mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pcsrcD & (~branpredD), pcnextbrFD);
mux2 #(32) pcmux(pcnextbrFD, {pcplus4D[31:28], instrD[25:0], 2'b00}, jumpD[1], pcnextjmpFD);

regfile rf(clk, regwriteW, jumpD[0], rsD, rtD, writeregW, resultW, pcF, srcaD, srcbD, reset);
mux2 #(32) pcjrmux(pcnextjmpFD, srca2D, ret, pcnextFDbefp);
mux2 #(32) pcpred(pcnextFDbefp, pcbrpred, branpredF, pcnextFD);

flopenrpred #(32) pcreg(clk, reset, ~stallF, (~pcsrcD & branpredD & ~stallD), pcnextFD, pcplus4D, pcF);
adder pcadd1(pcF, 32'b100, pcplus4F);

flopenr #(33) r1D(clk, reset, ~stallD, {pcplus4F, branpredF}, {pcplus4D, branpredD});
flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);

signext se(expD, instrD[15:0], signimmD);
sl2 immsh(signimmD, signimmshD);
adder pcadd2(pcplus4D, signimmshD, pcbranchD);
mux2 #(32) forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
mux2 #(32) forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
eqcmp comp(srca2D, srcb2D, equalD);

assign opD = instrD[31:26];
assign functD = instrD[5:0];
assign rsD = instrD[25:21];
assign rtD = instrD[20:16];
assign rdD = instrD[15:11];
assign shamtD = instrD[10:6];

assign flushD = (pcsrcD & ~stallD & ~branpredD) | jumpD[0] | jumpD[1] | ret | (~pcsrcD & branpredD & ~stallD);

floprc #(32) r1E(clk, reset, flushE, srcaD, srcaE);
floprc #(32) r2E(clk, reset, flushE, srcbD, srcbE);
floprc #(32) r3E(clk, reset, flushE, signimmD, signimmE);
floprc #(5) r4E(clk, reset, flushE, rsD, rsE);
floprc #(5) r5E(clk, reset, flushE, rtD, rtE);
floprc #(5) r6E(clk, reset, flushE, rdD, rdE);
floprc #(5) r7E(clk, reset, flushE, shamtD, shamtE);

mux3 #(32) forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E); // aluoutM -- rtype
mux3 #(32) forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E); // resultW -- load
mux2 #(32) srcbmux(srcb2E, signimmE, alusrcE, srcb3E);
alu alu(srca2E, srcb3E, alucontrolE, aluoutE, shamtE);
mux2 #(5) wrmux(rtE, rdE, regdstE, writeregE);

flopr #(32) r1M(clk, reset, srcb2E, writedataM); //store
flopr #(32) r2M(clk, reset, aluoutE, aluoutM);
flopr #(5) r3M(clk, reset, writeregE, writeregM);

flopr #(32) r1W(clk, reset, aluoutM, aluoutW);
flopr #(32) r2W(clk, reset, readdataM, readdataW);
flopr #(5) r3W(clk, reset, writeregM, writeregW);
mux2 #(32) resmux(aluoutW, readdataW, memtoregW, resultW);
endmodule
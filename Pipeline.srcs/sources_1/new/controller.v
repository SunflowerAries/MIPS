module controller(input clk, reset, 
                  input [5:0] opD, functD, 
                  input flushE, equalD, 
                  output memtoregE, memtoregM, memtoregW, memwriteM, 
                  output pcsrcD, 
                  output [1:0] branchD, 
                  output alusrcE, 
                  output regdstE, regwriteE, regwriteM, regwriteW, 
                  output [1:0] jumpD, 
                  output expD, ret,
                  output [3:0] alucontrolE);
                  
wire [2:0] aluopD;
wire memtoregD, memwriteD, alusrcD, regdstD, regwriteD;
wire [3:0] alucontrolD;
wire memwriteE;

maindec md(opD, memtoregD, memwriteD, branchD, 
           alusrcD, regdstD, regwriteD, jumpD, expD,
           aluopD);
aludec ad(functD, aluopD, alucontrolD, ret);
assign pcsrcD = (branchD[0] & equalD) | (branchD[1] & (~equalD));

floprc #(9) regE(clk, reset, flushE,
                {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
                {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE});
                
flopr #(3) regM(clk, reset, 
               {memtoregE, memwriteE, regwriteE},
               {memtoregM, memwriteM, regwriteM});
               
flopr #(2) regW(clk, reset, 
               {memtoregM, regwriteM},
               {memtoregW, regwriteW});

endmodule
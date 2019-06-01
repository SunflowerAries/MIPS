module controller(input clk, reset, 
                  input [5:0] opD, functD, 
                  input flushE, equalD, stallE, stallM, stallW, 
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

flopenrc #(9) regE(clk, reset, ~stallE, flushE,
                {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
                {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE});
                
flopenr #(3) regM(clk, reset, ~stallM,
               {memtoregE, memwriteE, regwriteE},
               {memtoregM, memwriteM, regwriteM});
               
flopenr #(2) regW(clk, reset, ~stallW,
               {memtoregM, regwriteM},
               {memtoregW, regwriteW});

endmodule
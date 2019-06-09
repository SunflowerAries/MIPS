module controller(input clk, reset, 
                  input [5:0] opD, functD, 
                  input flushE, equalD, stallE, stallM, stallW, 
                  output memtoregE, memtoregM, memtoregW, memwriteM, atom_memwriteE, atom_memwriteM,
                  output pcsrcD, 
                  output [1:0] branchD, 
                  output alusrcE, 
                  output regdstE, regwriteE, regwriteM, regwriteW, 
                  output [1:0] jumpD, 
                  output expD, ret, push_regD,
                  output [3:0] alucontrolE);
                  
wire [2:0] aluopD;
wire memtoregD, memwriteD, alusrcD, regdstD, regwriteD, atom_memwriteD;
wire [3:0] alucontrolD;
wire memwriteE;

maindec md(opD, memtoregD, memwriteD, atom_memwriteD, branchD, 
           alusrcD, regdstD, regwriteD, push_regD, jumpD, expD,
           aluopD);
           
aludec ad(functD, aluopD, alucontrolD, ret);
assign pcsrcD = (branchD[0] & equalD) | (branchD[1] & (~equalD));

flopenrc #(10) regE(clk, reset, ~stallE, flushE,
                {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, atom_memwriteD, alucontrolD},
                {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, atom_memwriteE, alucontrolE});
                
flopenr #(4) regM(clk, reset, ~stallM,
               {memtoregE, memwriteE, regwriteE, atom_memwriteE},
               {memtoregM, memwriteM, regwriteM, atom_memwriteM});
               
flopenr #(2) regW(clk, reset, ~stallW,
               {memtoregM, regwriteM},
               {memtoregW, regwriteW});

endmodule
module hazard(input [4:0] rsD, rtD, rsE, rtE, 
              input [4:0] writeregE, writeregM, writeregW,
              input regwriteE, regwriteM, regwriteW, waitinstr, waitdata,
              input memtoregE, memtoregM, 
              input [1:0] branchD,
              output forwardaD, forwardbD,
              output reg [1:0] forwardaE, forwardbE,
              output stallF, stallD, stallE, stallM, flushE, stallW);

wire lwstallD, branchstallD;
assign forwardaD = (rsD != 0 & rsD == writeregM & regwriteM);//surely, if memory phase is load, the forward is the address
assign forwardbD = (rtD != 0 & rtD == writeregM & regwriteM);//and we will forward the real value in the next clock
//here the load is 2 clocks before the instruction
always@(*)
    begin//Mem's priority is higher than Write's  
        forwardaE = 2'b00; forwardbE = 2'b00;
        if(rsE != 0)
            if(rsE == writeregM & regwriteM) forwardaE = 2'b10;
            else if(rsE == writeregW & regwriteW) forwardaE = 2'b01;
        if(rtE != 0)
            if(rtE == writeregM & regwriteM) forwardbE = 2'b10;
            else if(rtE == writeregW & regwriteW) forwardbE = 2'b01;
    end

assign lwstallD = memtoregE & (rtE == rsD | rtE == rtD);//the load is only one clock before
assign branchstallD = (branchD[0] | branchD[1]) & ((regwriteE & ((writeregE == rsD) | (writeregE == rtD))) |//rtype and so on before branch
                            (memtoregM & ((writeregM == rsD) | (writeregM == rtD))));//load before branch
assign stallW = stallM;
assign stallM = waitdata;
assign stallE = stallM;
assign stallD = lwstallD | branchstallD | stallE;
assign stallF = stallD | waitinstr;
assign flushE = stallD & (~stallE);
endmodule
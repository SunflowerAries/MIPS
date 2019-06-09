module regfile(input clk,
               input regWriteEn,
               input jal, push_regD, atom_memwriteE,
               //input [4:0] show,
               input [4:0] RsAddr, RtAddr,
               input [4:0] regWriteAddr,
               input [31:0] regWriteData, pcnextFD,
               output [31:0] RsData, RtData,
               //output [15:0] Display,
               input reset,
               input [4:0] switch,
               output [15:0] Display,
               output reg lock);
    reg [31:0] rf [31:0];
    integer i;
    always@(negedge clk)
        begin
            if(reset)   
                begin
                    for(i = 0; i < 32; i = i + 1)
                        rf[i] = 0;
                    lock = 1'b0;
                end
            else if(regWriteEn)
                rf[regWriteAddr] = regWriteData;
            if(jal)
                rf[31] = pcnextFD;
            if(push_regD)
                lock = 1'b1;
            if(atom_memwriteE)
                lock = 1'b0;
        end
    assign Display = rf[switch][15:0];
    assign RsData = (RsAddr != 0) ? rf[RsAddr] : 0;
    assign RtData = (RtAddr != 0) ? rf[RtAddr] : 0;
    //assign Display = rf[show][15:0];;
endmodule
module regfile(input clk,
               input regWriteEn,
               //input [4:0] show,
               input [4:0] RsAddr, RtAddr,
               input [4:0] regWriteAddr,
               input [31:0] regWriteData,
               output [31:0] RsData, RtData,
               //output [15:0] Display,
               input reset);
               //input jal);
    reg [31:0] rf [31:0];
    integer i;
    always@(negedge clk)
        begin
            if(reset)
                for(i = 0; i < 32; i = i + 1)
                    rf[i] = 0;
            else if(regWriteEn) rf[regWriteAddr] = regWriteData;
        end
    assign RsData = (RsAddr != 0) ? rf[RsAddr] : 0;
    assign RtData = (RtAddr != 0) ? rf[RtAddr] : 0;
    //assign Display = rf[show][15:0];;
endmodule
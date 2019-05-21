module alusrcB(input exp,
               input [1:0] alusrcb,
               input [31:0] data1, data2, data3, data4,
               output reg [31:0] srcb);
    reg [31:0] truedata3;
always@(*)
    begin
    truedata3 = {{16{data3[15] & exp}}, data3[15:0]};
    case(alusrcb)
        2'b00: srcb = data1;
        2'b01: srcb = data2;
        2'b10: srcb = truedata3;
        2'b11: srcb = data4;
        default: srcb = data2;
    endcase
    end
endmodule
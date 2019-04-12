module alusrcB(input [1:0] alusrcb,
            input [31:0] data1, data2, data3, data4,
            output reg [31:0] srcb);
always@(*)
    case(alusrcb)
        2'b00: srcb <= data1;
        2'b01: srcb <= data2;
        2'b10: srcb <= data3;
        2'b11: srcb <= data4;
        default: srcb <= data2;
    endcase
endmodule
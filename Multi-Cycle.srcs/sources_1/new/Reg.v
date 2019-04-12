module Reg #(parameter WIDTH = 32)
            (input clk,
             input [WIDTH - 1:0] Datain,
             output reg [WIDTH - 1:0] Dataout);
    always@(posedge clk)
        Dataout <= Datain;
endmodule
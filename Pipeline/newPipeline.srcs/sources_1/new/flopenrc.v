module flopenrc #(parameter WIDTH = 8)
                (input clk, reset,
                 input en, clear,
                 input [WIDTH - 1 : 0] d,
                 output reg [WIDTH - 1 : 0] q);
    always@(posedge clk)
        if(reset)       q <= 0;
        else if(clear)  q <= 0;
        else if(en)     q <= d;
endmodule

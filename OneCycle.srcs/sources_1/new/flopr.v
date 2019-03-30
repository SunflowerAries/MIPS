module flopr #(parameter WIDTH = 8)
              (input clk, reset,
               input [WIDTH - 1:0] d,
               output reg [WIDTH - 1:0] q);
    initial
        q <= 0;
    always@(posedge clk)
        if (reset)  q <= 0;
        else        q <= d;
endmodule
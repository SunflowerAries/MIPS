module signext(input exp,
               input [15:0] a,
               output [31:0] y);
    assign y = {{16{a[15] & exp}}, a};
endmodule
module eqcmp(input [31:0] a, b,
             output eq);
    assign eq = (a == b);
endmodule
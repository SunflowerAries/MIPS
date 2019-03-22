module dmem(input clk, MemWrite,
            input [31:0] a, WriteData,
            output [31:0] rd);
    reg [31:0] RAM [63:0];
    assign rd = RAM[a[31:2]];
    always @ (posedge clk)
        if(MemWrite)
            RAM[a[31:2]] <= WriteData;
endmodule
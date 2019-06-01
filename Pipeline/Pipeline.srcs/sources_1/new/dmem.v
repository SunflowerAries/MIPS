module dmem(input clk, we,
            input [7:0] a, 
            input [255:0] wd,
            output [255:0] rd);
reg [31:0] RAM[127:0];
assign rd = {RAM[a+7], RAM[a+6], RAM[a+5], RAM[a+4], RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]};
always@(posedge clk)
    if(we)
        {RAM[a+7], RAM[a+6], RAM[a+5], RAM[a+4], RAM[a+3], RAM[a+2], RAM[a+1], RAM[a]} = wd;
endmodule
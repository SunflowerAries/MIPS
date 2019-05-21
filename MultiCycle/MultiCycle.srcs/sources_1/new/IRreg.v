module IRreg(input clk, en,
             input [31:0] rd,
             output reg [31:0] instr);
    always@(posedge clk)
        //TODO IRWrite
        if(en) instr <= rd;
        else instr <= instr;
endmodule
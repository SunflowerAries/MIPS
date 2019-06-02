module dmem(input clk, we,
            input [7:0] rAddr,
            input [7:0] wAddr, 
            input [255:0] wd,
            output [255:0] rd);
reg [31:0] RAM[127:0];
initial
    begin
        RAM[39] <= 32'h1;
        RAM[38] <= 32'h2;
        RAM[37] <= 32'h3;
        RAM[36] <= 32'h4;
        RAM[35] <= 32'h5;
        RAM[34] <= 32'h6;
        RAM[33] <= 32'h7;
        RAM[32] <= 32'h8;
        RAM[31] <= 32'h1;
        RAM[30] <= 32'h1;
        RAM[29] <= 32'h1;
        RAM[28] <= 32'h1;
        RAM[27] <= 32'h1;
        RAM[26] <= 32'h0;
        RAM[25] <= 32'h0;
        RAM[24] <= 32'h0;
        RAM[23] <= 32'h0;
        RAM[22] <= 32'h0;
        RAM[21] <= 32'h0;
        RAM[20] <= 32'h0;
        RAM[19] <= 32'h0;
        RAM[18] <= 32'h0;
        RAM[17] <= 32'h0;
        RAM[16] <= 32'h0;
        RAM[15] <= 32'h0;
        RAM[14] <= 32'h0;
        RAM[13] <= 32'h0;
        RAM[12] <= 32'h0;
        RAM[11] <= 32'h0;
        RAM[10] <= 32'h0;
        RAM[9] <= 32'h0;
        RAM[8] <= 32'h0;
        RAM[7] <= 32'h0;
        RAM[6] <= 32'h0;
        RAM[5] <= 32'h0;
        RAM[4] <= 32'h0;
        RAM[3] <= 32'h0;
        RAM[2] <= 32'h0;
        RAM[1] <= 32'h0;
        RAM[0] <= 32'h0;
    end
assign rd = {RAM[rAddr+7], RAM[rAddr+6], RAM[rAddr+5], RAM[rAddr+4], RAM[rAddr+3], RAM[rAddr+2], RAM[rAddr+1], RAM[rAddr]};
always@(posedge clk)
    if(we)
        {RAM[wAddr+7], RAM[wAddr+6], RAM[wAddr+5], RAM[wAddr+4], RAM[wAddr+3], RAM[wAddr+2], RAM[wAddr+1], RAM[wAddr]} = wd;
endmodule
module imem(input [5:0] a,
            output [31:0] rd);
    reg [31:0] RAM [63:0];
    initial
        begin
            /*RAM[0] <= 32'h201d0080;
            RAM[1] <= 32'h20040005;
            RAM[2] <= 32'h0c000004;
            RAM[3] <= 32'h00021040;
            RAM[4] <= 32'h23bdfff8;
            RAM[5] <= 32'hafa40004;
            RAM[6] <= 32'hafbf0000;
            
            RAM[7] <= 32'h20080002;
            RAM[8] <= 32'h0088402a;
            RAM[9] <= 32'h10080003;
            RAM[10] <= 32'h20020001;
            RAM[11] <= 32'h23bd0008;
            RAM[12] <= 32'h03e00008;
            RAM[13] <= 32'h2084ffff;
            RAM[14] <= 32'h0c000004;
            RAM[15] <= 32'h8fbf0000;
            RAM[17] <= 32'h8fa40004;
            RAM[18] <= 32'h23bd0008;
            RAM[19] <= 32'h00821020;
            RAM[20] <= 32'h03e00008;*/
            RAM[0]<=32'h20020005;
            RAM[1]<=32'h2003000c;
            RAM[2]<=32'h2067fff7;
            RAM[3]<=32'h00e22025;
            RAM[4]<=32'h00642824;
            RAM[5]<=32'h00a42820;
            RAM[6]<=32'h10a7000a;
            RAM[7]<=32'h0064202a;
            RAM[8]<=32'h10800001;
            RAM[9]<=32'h20050000;
            RAM[10]<=32'h00e2202a;
            RAM[11]<=32'h00853820;
            RAM[12]<=32'h00e23822;
            RAM[13]<=32'hac670044;
            RAM[14]<=32'h8c020050;
            RAM[15]<=32'h08000011;
            RAM[16]<=32'h20020001;
            RAM[17]<=32'hac020054;
            //$readmemh("memfile.dat", RAM);
        end
    assign rd = RAM[a];//{RAM[a + 3], RAM[a + 2], RAM[a + 1], RAM[a]};
endmodule
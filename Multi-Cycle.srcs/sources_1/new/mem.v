module mem(input [29:0] a,
            input clk, we, 
            input [31:0] wd,
            output [31:0] rd);
    reg [31:0] RAM [127:0];//ָ��洢�������ݴ洢������
    initial
        begin
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
        end
    always@(posedge clk)
        if(we)  RAM[a] = wd;
    assign rd = RAM[a];
endmodule
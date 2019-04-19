module mem(input [29:0] a,
            input clk, we, 
            input [31:0] wd,
            output [31:0] rd);
    reg [31:0] RAM [127:0];//指令存储器与数据存储器公用
    initial
        begin
            /*RAM[0]<=32'h20020005;
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
            RAM[17]<=32'hac020054;*/
            
            /*RAM[0]<=32'h2010000c;
            RAM[1]<=32'h3212fff8;
            RAM[2]<=32'h3633000a;
            RAM[3]<=32'h2a540005;
            RAM[4]<=32'h00000000;
            RAM[5]<=32'h02114020;
            RAM[6]<=32'h02534022;
            RAM[7]<=32'h02714024;
            RAM[8]<=32'h02324025;
            RAM[9]<=32'h0212402a;
            RAM[10]<=32'hac100064;
            RAM[11]<=32'h8c080064;*/
            
            RAM[0] <= 32'h20080063;
            RAM[1] <= 32'h20090025;
            RAM[2] <= 32'h20100000;
            RAM[3] <= 32'h10090006;
            RAM[4] <= 32'h312a0001;
            RAM[5] <= 32'h100a0001;
            RAM[6] <= 32'h02088020;
            RAM[7] <= 32'h00084040;
            RAM[8] <= 32'h00094842;
            RAM[9] <= 32'h08000003;
            
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
            RAM[16] <= 32'h8fa40004;
            RAM[17] <= 32'h23bd0008;
            RAM[18] <= 32'h00821020;
            RAM[19] <= 32'h03e00008;*/
            
            /*RAM[0]<=32'h20100004;
            RAM[1]<=32'h20110001;
            RAM[2]<=32'h22310003;
            RAM[3]<=32'h12300002;
            RAM[4]<=32'h22310001;
            RAM[5]<=32'h02308822;
            RAM[6]<=32'h02308820;*/
            
            /*RAM[0]<=32'h00008820;
            RAM[1]<=32'h20100000;
            RAM[2]<=32'h2008000a;
            RAM[3]<=32'h11100003;
            RAM[4]<=32'h02308820;
            RAM[5]<=32'h22100001;
            RAM[6]<=32'h08000003;*/
            /*
            RAM[0]<=32'h20100064;
            RAM[1]<=32'h20080014;
            RAM[2]<=32'h15100002;
            RAM[3]<=32'h20110002;
            RAM[4]<=32'h0800000e;
            RAM[5]<=32'h20080032;
            RAM[6]<=32'h15100002;
            RAM[7]<=32'h20110003;
            RAM[8]<=32'h0800000e;
            RAM[9]<=32'h20080064;
            RAM[10]<=32'h15100002;
            RAM[11]<=32'h20110005;
            RAM[12]<=32'h0800000e;
            RAM[13]<=32'h00008820;*/
        end
    always@(posedge clk)
        if(we)  RAM[a] = wd;
    assign rd = RAM[a];
endmodule
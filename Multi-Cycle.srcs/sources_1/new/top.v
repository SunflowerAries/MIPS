module clkdiv(
    input mclk,
    output clk,   // 0.33s
    output clk48, // 0.02s
    output clk190, // 0.00125s 
    input choice
    );
    reg[27:0] q;
    wire clk1, clk2;
    initial
        q <= 0;
    always@(posedge mclk)
        q <= q + 1;
    assign clk1 = q[0]; //if simulate then q[0] else q[26]
    assign clk2 = q[23]; //0.16s
    assign clk = !choice & clk1 | choice & clk2;
    assign clk190 = q[16];
    assign clk48 = q[20];
endmodule

module top(input CLK100MHZ,
           input [6:0] SW,
           output [6:0] S,
           output [7:0] AN);

wire memwrite, clock, clock48, clock190;
wire [31:0] writedata;
wire [31:0] pc, nextinstr, address;

clkdiv myClk(CLK100MHZ, clock, clock48, clock190, SW[6]);
mips mips(clock, clock190, SW[0], pc, nextinstr, memwrite, writedata, address, SW[5:1], S, AN);
mem mem(address[31:2], clock, memwrite, writedata, nextinstr);
endmodule
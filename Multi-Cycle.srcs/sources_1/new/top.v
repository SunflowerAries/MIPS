module top(input clk, reset,
           output [31:0] writedata, 
           output memwrite);
           
wire [31:0] pc, nextinstr, address;

mips mips(clk, reset, pc, nextinstr, memwrite, writedata, address);
mem mem(address[31:2], clk, memwrite, writedata, nextinstr);
endmodule
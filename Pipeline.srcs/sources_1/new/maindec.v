module maindec(input [5:0] op, 
               output memtoreg, memwrite, 
               output [1:0] branch, 
               output alusrc, regdst, regwrite, jump, exp,
               output [2:0] aluop);
reg [11:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, exp, aluop} = controls;
always@(*)
    case(op)
        6'b000000: controls <= 12'b110000001010;//Rtype
        6'b100011: controls <= 12'b101000101000;//LW
        6'b101011: controls <= 12'b001001001000;//SW
        6'b000100: controls <= 12'b000010001001;//BEQ
        6'b001000: controls <= 12'b101000001000;//ADDI
        6'b000010: controls <= 12'b000000011000; //J
        6'b001100: controls <= 12'b101000000011; //andi
        6'b001101: controls <= 12'b101000000100; //ori
        6'b001010: controls <= 12'b101000001101; //slti
        6'b000101: controls <= 12'b000100001001; //bne
        default:   controls <= 12'bxxxxxxxxxxxx;
    endcase
endmodule
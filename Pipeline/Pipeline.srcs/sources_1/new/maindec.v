module maindec(input [5:0] op, 
               output memtoreg, memwrite, 
               output [1:0] branch, 
               output alusrc, regdst, regwrite, 
               output [1:0] jump,
               output exp,
               output [2:0] aluop);
reg [12:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, exp, aluop} = controls;
always@(*)
    case(op)
        6'b000000: controls <= 13'b1100000001010;//Rtype
        6'b100011: controls <= 13'b1010001001000;//LW
        6'b101011: controls <= 13'b0010010001000;//SW
        6'b000100: controls <= 13'b0000100001001;//BEQ
        6'b001000: controls <= 13'b1010000001000;//ADDI
        6'b000010: controls <= 13'b0000000101000; //J
        6'b001100: controls <= 13'b1010000000011; //andi
        6'b001101: controls <= 13'b1010000000100; //ori
        6'b001010: controls <= 13'b1010000001101; //slti
        6'b000101: controls <= 13'b0001000001001; //bne
        6'b000011: controls <= 13'b0000000111000; //jal
        default:   controls <= 13'bxxxxxxxxxxxxx;
    endcase
endmodule
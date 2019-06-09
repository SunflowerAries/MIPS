module maindec(input [5:0] op, 
               output memtoreg, memwrite, atom_memwrite,
               output [1:0] branch, 
               output alusrc, regdst, regwrite, push_reg,
               output [1:0] jump,
               output exp,
               output [2:0] aluop);
reg [14:0] controls;

assign {push_reg, regwrite, regdst, alusrc, branch, memwrite, atom_memwrite, memtoreg, jump, exp, aluop} = controls;
always@(*)
    case(op)
        6'b000000: controls <= 15'b011000000001010; //Rtype
        6'b100011: controls <= 15'b010100001001000; //LW
        6'b101011: controls <= 15'b000100100001000; //SW
        6'b000100: controls <= 15'b000001000001001; //BEQ
        6'b001000: controls <= 15'b010100000001000; //ADDI
        6'b000010: controls <= 15'b000000000101000; //J
        6'b001100: controls <= 15'b010100000000011; //andi
        6'b001101: controls <= 15'b010100000000100; //ori
        6'b001010: controls <= 15'b010100000001101; //slti
        6'b000101: controls <= 15'b000010000001001; //bne
        6'b000011: controls <= 15'b000000000111000; //jal
        6'b110000: controls <= 15'b110100001001000; //LL
        6'b111000: controls <= 15'b010100010001000; //SC
        default:   controls <= 15'bxxxxxxxxxxxxxxx;
    endcase
endmodule
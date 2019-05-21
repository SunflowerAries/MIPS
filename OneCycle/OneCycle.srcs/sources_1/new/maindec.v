module maindec(input [5:0] op,
               output memtoreg, memwrite,
               output [1:0] branch, jump,
               output regdst, regwrite,
               output alusrc, exp,
               output [2:0] aluop);
    reg [12:0] controls;
    assign {regwrite, regdst, alusrc, exp, branch,
            memwrite, memtoreg, aluop, jump} = controls;
            
    always @ (*)
        case(op)
            6'b000000: controls <= 13'b1100000001000; //Rtype
            6'b100011: controls <= 13'b1011000100000; //LW
            6'b101011: controls <= 13'b0011001000000; //SW
            6'b000100: controls <= 13'b0001100000100; //BEQ
            6'b001000: controls <= 13'b1011000000000; //ADDI
            6'b000010: controls <= 13'b0xxxxx0xxxx10; //J
            6'b001100: controls <= 13'b1010000001100; //andi
            6'b001101: controls <= 13'b1010000010000; //ori
            6'b001010: controls <= 13'b1011000010100; //slti
            //nop
            6'b000101: controls <= 13'b0001010000100; //bne
            6'b000011: controls <= 13'b0xxxxx0xxxx11; //jal
            default:   controls <= 13'bxxxxxxxxxxxx;
        endcase
endmodule
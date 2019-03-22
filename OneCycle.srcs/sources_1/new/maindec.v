module maindec(input [5:0] op,
               output memtoreg, memwrite,
               output [1:0] branch, 
               output regdst, regwrite,
               output jump, alusrc, exp,
               output [2:0] aluop);
    reg [11:0] controls;
    assign {regwrite, regdst, alusrc, exp, branch,
            memwrite, memtoreg, aluop, jump} = controls;
            
    always @ (*)
        case(op)
            6'b000000: controls <= 12'b110000000100; //Rtype
            6'b100011: controls <= 12'b101100010000; //LW
            6'b101011: controls <= 12'b001100100000; //SW
            6'b000100: controls <= 12'b000010000010; //BEQ
            6'b001000: controls <= 12'b101100000000; //ADDI
            6'b000010: controls <= 12'b0xxxxx0xxxx1; //J
            6'b001100: controls <= 12'b101000000110; //andi
            6'b001101: controls <= 12'b101000001000; //ori
            6'b001010: controls <= 12'b101100001010; //slti
            //6'b//nop
            6'b000101: controls <= 12'b000001000010; //bne
            default:   controls <= 12'bxxxxxxxxxxxx;
        endcase
endmodule
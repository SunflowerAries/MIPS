module aludec(input [5:0] funct,
              input [2:0] aluop,
              output reg [2:0] alucontrol);
    always @ (*)
        case(aluop)
            3'b000: alucontrol <= 3'b010; //add
            3'b001: alucontrol <= 3'b110; //sub
            3'b011: alucontrol <= 3'b000; //andi
            3'b100: alucontrol <= 3'b001; //or
            3'b101: alucontrol <= 3'b111; //slt
            default: 
                case(funct)
                    6'b100000: alucontrol <= 3'b010; //add
                    6'b100010: alucontrol <= 3'b110; //sub
                    6'b100100: alucontrol <= 3'b000; //and
                    6'b100101: alucontrol <= 3'b001; //or
                    6'b101010: alucontrol <= 3'b111; //slt
                    default:   alucontrol <= 3'bxxx;
                endcase
        endcase
endmodule
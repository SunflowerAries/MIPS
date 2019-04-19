module aludec(input [5:0] funct,
              input [2:0] aluop,
              output reg [3:0] alucontrol,
              output reg ret);
    always @ (*)
        case(aluop)
            3'b000: begin alucontrol <= 4'b0010; ret <= 0; end//add
            3'b001: begin alucontrol <= 4'b0110; ret <= 0; end//sub
            3'b011: begin alucontrol <= 4'b0000; ret <= 0; end//andi
            3'b100: begin alucontrol <= 4'b0001; ret <= 0; end//or
            3'b101: begin alucontrol <= 4'b0111; ret <= 0; end//slt
            default: 
                case(funct)
                    6'b100000: begin alucontrol <= 4'b0010; ret <= 0; end//add
                    6'b100010: begin alucontrol <= 4'b0110; ret <= 0; end//sub
                    6'b100100: begin alucontrol <= 4'b0000; ret <= 0; end//and
                    6'b100101: begin alucontrol <= 4'b0001; ret <= 0; end//or
                    6'b101010: begin alucontrol <= 4'b0111; ret <= 0; end//slt
                    6'b000000: begin alucontrol <= 4'b1000; ret <= 0; end//sll
                    6'b000010: begin alucontrol <= 4'b1001; ret <= 0; end//srl
                    6'b000011: begin alucontrol <= 4'b1010; ret <= 0; end//sll
                    6'b001000: begin alucontrol <= 4'b1011; ret <= 1; end//jr
                    default:   begin alucontrol <= 4'bxxxx; ret <= 0; end
                endcase
        endcase
endmodule
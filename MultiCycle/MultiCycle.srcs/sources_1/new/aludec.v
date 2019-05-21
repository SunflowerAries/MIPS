module aludec(input [5:0] funct,
              input [2:0] aluop,
              output reg [4:0] alucontrol,
              output reg ret, double);
    always @ (*)
        case(aluop)
            3'b000: begin alucontrol <= 5'b00010; ret <= 0; double <= 0; end//add
            3'b001: begin alucontrol <= 5'b00110; ret <= 0; double <= 0; end//sub
            3'b011: begin alucontrol <= 5'b00000; ret <= 0; double <= 0; end//andi
            3'b100: begin alucontrol <= 5'b00001; ret <= 0; double <= 0; end//or
            3'b101: begin alucontrol <= 5'b00111; ret <= 0; double <= 0; end//slt
            default: 
                case(funct)
                    6'b100000: begin alucontrol <= 5'b00010; ret <= 0; double <= 0; end//add
                    6'b100010: begin alucontrol <= 5'b00110; ret <= 0; double <= 0; end//sub
                    6'b100100: begin alucontrol <= 5'b00000; ret <= 0; double <= 0; end//and
                    6'b100101: begin alucontrol <= 5'b00001; ret <= 0; double <= 0; end//or
                    6'b101010: begin alucontrol <= 5'b00111; ret <= 0; double <= 0; end//slt
                    6'b000000: begin alucontrol <= 5'b01000; ret <= 0; double <= 0; end//sll
                    6'b000010: begin alucontrol <= 5'b01001; ret <= 0; double <= 0; end//srl
                    6'b000011: begin alucontrol <= 5'b01010; ret <= 0; double <= 0; end//sll
                    6'b001000: begin alucontrol <= 5'b01011; ret <= 1; double <= 0; end//jr
                    6'b011000: begin alucontrol <= 5'b10000; ret <= 0; double <= 1; end//mul
                    default:   begin alucontrol <= 5'bxxxxx; ret <= 0; double <= 0; end
                endcase
        endcase
endmodule
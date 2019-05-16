`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 16:19:58
// Design Name: 
// Module Name: BPB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BPB(input clk, reset, stallD,
           input [4:0] opF,
           input [7:0] IAdr, 
           input [31:0] Destin,
           input Rbranch,//real
           output reg Pbranch,
           output reg [31:0] Destout);//predict
           
reg [40:0] Table[3:0];
integer i;
reg [1:0] pos,nextstate, choice;
parameter search =  1'b0;
parameter writing = 1'b1;
reg miss, brF, state;

always@(posedge clk)
    if(reset)
        begin
            state <= search;
            for(i = 0; i < 4; i = i + 1)
                Table[i] = 41'b0;
            pos = 2'b0;
            choice = 2'b0;
            miss = 1'b0;
            Pbranch = 1'b0;
        end
    else      
        state <= nextstate;

always@(*)
    begin
        brF = opF == 5'b00010;
        case(state)
            search:
                begin
                    if(brF) nextstate <= writing;
                    else    nextstate <= search;
                end
            writing: 
                begin
                    if(stallD)
                        nextstate <= writing;
                    else
                        nextstate <= search;
                end
        endcase
        
        if(brF)
            case(IAdr)
                Table[0][40:33]: 
                    begin
                        choice = 2'b00;
                        Pbranch = Table[0][32];
                        Destout = Table[0][31:0];
                    end
                Table[1][40:33]: 
                    begin
                        choice = 2'b01;
                        Pbranch = Table[1][32];
                        Destout = Table[1][31:0];
                    end
                Table[2][40:33]: 
                    begin
                        choice = 2'b10;
                        Pbranch = Table[2][32];
                        Destout = Table[2][31:0];
                    end
                Table[3][40:33]: 
                    begin
                        choice = 2'b11;
                        Pbranch = Table[3][32];
                        Destout = Table[3][31:0];
                    end
                default:
                    begin
                        miss = 1'b1;
                        Pbranch = 1'b0;
                        Table[pos][40:33] = IAdr;
                        choice = pos;
                    end
            endcase
    end
    
always@(*)
    if(state == writing)
        begin
            if(Rbranch)
                begin
                    if(miss)
                        begin
                            pos = pos + 1;
                            miss = 1'b0;
                        end
                    Table[choice][32:0] = {1'b1, Destin};
                end
            else
                begin
                    if(miss)
                        begin
                            pos = pos + 1;
                            miss = 1'b0;
                        end
                    Table[choice][32:0] = {1'b0, Destin};
                end
        end
endmodule
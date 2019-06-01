`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 10:01:44
// Design Name: 
// Module Name: cache
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


module icache(input clk, reset, 
             input [7:0] Addr, 
             input [255:0] iblock,
             output waitinstr,
             output reg [31:0] rd);
              // 2 + 1 + 3, 2^6 = 64 addresses
reg [4:0] cachetable [3:0] [1:0]; // 4 sets and 2 lines and 32 bytes per block
reg [31:0] cachedata [3:0] [1:0] [7:0];
integer i, j, k;
reg [2:0] state, nextstate;
parameter cachefetch = 2'b00;
parameter waiting_1  = 2'b01;
parameter waiting_2  = 2'b10;
parameter memfetch   = 2'b11;
reg hit;

initial
    hit = 1'b0;

always@(posedge clk)
    begin
        if(reset)
            begin
                for(i = 0; i < 4; i = i + 1)
                    for(j = 0; j < 2; j = j + 1)
                        cachetable[i][j][4:3] = 2'b0; // only need to set the valid bit to 0
                state = cachefetch;
            end
        else if(state == cachefetch)
            begin
                case(Addr[4:3]) //to locate the set
                    2'b00:
                        begin
                            case(Addr[7:5]) // make sure if we have the block and in which line
                                cachetable[0][0][2:0]:
                                    if(cachetable[0][0][3]) // valid?
                                        begin
                                            cachetable[0][0][4] = 1'b1;
                                            cachetable[0][1][4] = 1'b0;
                                        end
                                cachetable[0][1][2:0]:
                                    if(cachetable[0][1][3]) // valid?
                                        begin
                                            cachetable[0][0][4] = 1'b0;
                                            cachetable[0][1][4] = 1'b1;
                                        end
                            endcase
                        end
                    2'b01:
                        begin
                            case(Addr[7:5])
                                cachetable[1][0][2:0]:
                                    if(cachetable[1][0][3]) // valid?
                                        begin
                                            cachetable[1][0][4] = 1'b1;
                                            cachetable[1][1][4] = 1'b0;
                                        end
                                cachetable[1][1][2:0]:
                                    if(cachetable[1][1][3]) // valid?
                                        begin
                                            cachetable[1][0][4] = 1'b0;
                                            cachetable[1][1][4] = 1'b1;
                                        end
                            endcase
                        end
                    2'b10:
                        begin
                            case(Addr[7:5])
                                cachetable[2][0][2:0]:
                                    if(cachetable[2][0][3]) // valid?
                                        begin
                                            cachetable[2][0][4] = 1'b1;
                                            cachetable[2][1][4] = 1'b0;
                                        end
                                cachetable[2][1][2:0]:
                                    if(cachetable[2][1][3]) // valid?
                                        begin
                                            cachetable[2][0][4] = 1'b0;
                                            cachetable[2][1][4] = 1'b1;
                                        end
                            endcase
                        end
                    2'b11:
                        begin
                            case(Addr[7:5])
                                cachetable[3][0][2:0]:
                                    if(cachetable[3][0][3]) // valid?
                                        begin
                                            cachetable[3][0][4] = 1'b1;
                                            cachetable[3][1][4] = 1'b0;
                                        end
                                cachetable[3][1][2:0]:
                                    if(cachetable[3][1][3]) // valid?
                                        begin
                                            cachetable[3][0][4] = 1'b0;
                                            cachetable[3][1][4] = 1'b1;
                                        end
                            endcase
                        end
                endcase
            end
        else if(state == memfetch)
            begin
                if(~cachetable[Addr[4:3]][0][3])// how to replace, everytime we add a new line
                    begin                       // we have to set the ref site to 1 and the ref site of the other to 0
                        cachetable[Addr[4:3]][0] = {2'b11, Addr[7:5]};
                        cachetable[Addr[4:3]][1][4] = 1'b0;
                        {cachedata[Addr[4:3]][0][7], cachedata[Addr[4:3]][0][6], cachedata[Addr[4:3]][0][5], 
                        cachedata[Addr[4:3]][0][4], cachedata[Addr[4:3]][0][3], cachedata[Addr[4:3]][0][2],
                        cachedata[Addr[4:3]][0][1], cachedata[Addr[4:3]][0][0]} = iblock;
                    end
                else if(~cachetable[Addr[4:3]][1][3])//not valid in the first or second line
                    begin
                        cachetable[Addr[4:3]][1] = {2'b11, Addr[7:5]};// how to replace
                        cachetable[Addr[4:3]][0][4] = 1'b0;
                        {cachedata[Addr[4:3]][1][7], cachedata[Addr[4:3]][1][6], cachedata[Addr[4:3]][1][5], 
                        cachedata[Addr[4:3]][1][4], cachedata[Addr[4:3]][1][3], cachedata[Addr[4:3]][1][2],
                        cachedata[Addr[4:3]][1][1], cachedata[Addr[4:3]][1][0]} = iblock;
                    end
                else//replace through the LRU
                    begin
                        if(cachetable[Addr[4:3]][0][4] == 1'b0)
                            begin
                                cachetable[Addr[4:3]][0] = {2'b11, Addr[7:5]};
                                cachetable[Addr[4:3]][1][4] = 1'b0;
                                {cachedata[Addr[4:3]][0][7], cachedata[Addr[4:3]][0][6], cachedata[Addr[4:3]][0][5], 
                                cachedata[Addr[4:3]][0][4], cachedata[Addr[4:3]][0][3], cachedata[Addr[4:3]][0][2],
                                cachedata[Addr[4:3]][0][1], cachedata[Addr[4:3]][0][0]} = iblock;
                            end
                        else
                            begin
                                cachetable[Addr[4:3]][1] = {2'b11, Addr[7:5]};
                                cachetable[Addr[4:3]][0][4] = 1'b0;
                                {cachedata[Addr[4:3]][1][7], cachedata[Addr[4:3]][1][6], cachedata[Addr[4:3]][1][5], 
                                cachedata[Addr[4:3]][1][4], cachedata[Addr[4:3]][1][3], cachedata[Addr[4:3]][1][2],
                                cachedata[Addr[4:3]][1][1], cachedata[Addr[4:3]][1][0]} = iblock;
                            end
                    end
            end
        case(state)
            cachefetch:
                if(hit) state = cachefetch;
                else    state = waiting_1;
            waiting_1:  state = waiting_2;
            waiting_2:  state = memfetch;
            memfetch:   state = cachefetch;
        endcase
    end
    
always@(negedge clk)
if(state == cachefetch)
    begin
        case(Addr[4:3]) //to locate the set
            2'b00:
                begin
                    case(Addr[7:5]) // make sure if we have the block and in which line
                        cachetable[0][0][2:0]:
                            if(cachetable[0][0][3]) // valid?
                                begin
                                    rd = cachedata[0][0][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        cachetable[0][1][2:0]:
                            if(cachetable[0][1][3]) // valid?
                                begin
                                    rd = cachedata[0][1][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        default:    hit = 1'b0;
                    endcase
                end
            2'b01:
                begin
                    case(Addr[7:5])
                        cachetable[1][0][2:0]:
                            if(cachetable[1][0][3]) // valid?
                                begin
                                    rd = cachedata[1][0][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        cachetable[1][1][2:0]:
                            if(cachetable[1][1][3]) // valid?
                                begin
                                    rd = cachedata[1][1][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        default:    hit = 1'b0;
                    endcase
                end
            2'b10:
                begin
                    case(Addr[7:5])
                        cachetable[2][0][2:0]:
                            if(cachetable[2][0][3]) // valid?
                                begin
                                    rd = cachedata[2][0][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        cachetable[2][1][2:0]:
                            if(cachetable[2][1][3]) // valid?
                                begin
                                    rd = cachedata[2][1][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        default: hit = 1'b0;
                    endcase
                end
            2'b11:
                begin
                    case(Addr[7:5])
                        cachetable[3][0][2:0]:
                            if(cachetable[3][0][3]) // valid?
                                begin
                                    rd = cachedata[3][0][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        cachetable[3][1][2:0]:
                            if(cachetable[3][1][3]) // valid?
                                begin
                                    rd = cachedata[3][1][Addr[2:0]];
                                    hit = 1'b1;
                                end
                            else
                                hit = 1'b0;
                        default:    hit = 1'b0;
                    endcase
                end
        endcase
    end
assign waitinstr = ~hit;
endmodule
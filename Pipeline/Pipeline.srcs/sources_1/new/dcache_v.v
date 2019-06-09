`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 19:04:20
// Design Name: 
// Module Name: dcache_v
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


module dcache_v #(parameter SET = 2, 
                  parameter LINE = 2,
                  parameter OFFSET = 3)
                  (input clk, reset, we, re,
                   input [7:0] Addr,
                   input [31:0] writedata,
                   input [(2**OFFSET) * 32 - 1:0] dblock_m,
                   output waitdata,
                   output reg wm,
                   output reg [31:0] rd,
                   output reg [7:0] Addr_m,
                   output reg [(2**OFFSET) * 32 - 1:0] dblock_c);
reg [8 - SET - OFFSET - 1 + 2 + 4:0] cachetable [2**SET - 1:0] [LINE - 1:0]; //dirty bit[1] + precedence bit of replacement[4] + valid bit[1] + tag[3]
reg [31:0] cachedata [2**SET - 1:0] [LINE - 1:0] [2**OFFSET - 1:0];
integer i, j, k, l;
reg [2:0] state;
parameter cachefetch = 2'b00;
parameter waiting_1  = 2'b01;
parameter waiting_2  = 2'b10;
parameter memfetch   = 2'b11;
reg rhit, whit;
integer times, rep, hits;
reg vacant, hit;
integer sum [LINE - 1:0];

initial
    begin
        rhit = 1'b0;
        whit = 1'b0;
        times = 0;
        hits = 0;
    end

always@(posedge clk)
    begin
        if(reset)
            begin
                for(i = 0; i < 2**SET; i = i + 1)
                    for(j = 0; j < LINE; j = j + 1)
                        cachetable[i][j][13 - SET - OFFSET:3] = 0; // only need to set the valid bit to 0
                state = cachefetch;
            end
        else if(state == cachefetch & (re | we))
            begin
                wm = 1'b0;
                for(k = 0; k < LINE; k = k + 1)
                    begin
                        cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][12 - SET - OFFSET:9 - SET - OFFSET] = {1'b0, cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][12 - SET - OFFSET:10 - SET - OFFSET]};
                        if(cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][7 - SET - OFFSET:0] == Addr[7:SET + OFFSET])
                            if(cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][7 - SET - OFFSET + 1]) // valid?
                                begin
                                    if(we)
                                        begin
                                            cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][13 - SET - OFFSET] = 1'b1;
                                            cachedata[Addr[OFFSET + SET - 1:OFFSET]][k][Addr[OFFSET - 1:0]] = writedata;
                                        end
                                    cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][12 - SET - OFFSET] = 1'b1;
                                end
                    end
            end
        else if(state == memfetch & (re | we))
            begin
                vacant = 0;
                for(k = 0; k < LINE; k = k + 1)
                    begin
                        if(~cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][7 - SET - OFFSET + 1] & vacant == 0)// how to replace, everytime we add a new line
                            begin                       // we have to set the ref site to 1 and the ref site of the other to 0
                                cachetable[Addr[OFFSET + SET - 1:OFFSET]][k] = {6'b010001, Addr[7:SET + OFFSET]};
                                for(l = 0; l < 2**OFFSET; l = l + 1)
                                    cachedata[Addr[OFFSET + SET - 1:OFFSET]][k][l] = dblock_m[l * 32 +:32];
                                vacant = 1;
                            end
                    end
                if(vacant == 0)
                    begin
                        for(k = 0; k < LINE; k = k + 1)
                            begin
                                sum[k] = 0;
                                for(l = 0; l < 4; l = l + 1)
                                    if(cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][12 - SET - OFFSET - l] == 1'b1)
                                        sum[k] = sum[k] + 1;
                            end
                        rep = 0;
                        for(k = 1; k < LINE; k = k + 1)
                            if(sum[rep] > sum[k] | 
                            (sum[rep] == sum[k] && 
                            cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][12 - SET - OFFSET:9 - SET - OFFSET] < 
                            cachetable[Addr[OFFSET + SET - 1:OFFSET]][rep][12 - SET - OFFSET:9 - SET - OFFSET]))   
                                rep = k;
                        if(cachetable[Addr[OFFSET + SET - 1:OFFSET]][rep][13 - SET - OFFSET])
                            begin
                                for(l = 0; l < 2**OFFSET; l = l + 1)
                                    dblock_c[l * 32 +:32] = cachedata[Addr[OFFSET + SET - 1:OFFSET]][rep][l];
                                Addr_m = {cachetable[Addr[OFFSET + SET - 1:OFFSET]][rep][7 - SET - OFFSET:0], Addr[OFFSET + SET - 1:OFFSET], {OFFSET{1'b0}}};
                                wm = 1'b1;
                            end
                        cachetable[Addr[OFFSET + SET - 1:OFFSET]][rep] = {6'b010001, Addr[7:SET + OFFSET]};
                        for(l = 0; l < 2**OFFSET; l = l + 1)
                            cachedata[Addr[OFFSET + SET - 1:OFFSET]][rep][l] = dblock_m[l * 32 +:32];
                    end
            end
        case(state)
            cachefetch:
                if(~waitdata) state = cachefetch;
                else    state = waiting_1;
            waiting_1:  state = waiting_2;
            waiting_2:  state = memfetch;
            memfetch:   state = cachefetch;
        endcase
    end
always@(negedge clk)
if(state == cachefetch & (re | we))
    begin
        hit = 1'b0;
        for(k = 0; k < LINE; k = k + 1)
            begin
                if(hit == 1'b0 & Addr[7:SET + OFFSET] == cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][7 - SET - OFFSET:0])
                    begin
                        hit = 1'b1;
                        if(cachetable[Addr[OFFSET + SET - 1:OFFSET]][k][8 - SET - OFFSET])
                            begin
                                if(we)
                                    begin
                                        whit = 1'b1;
                                        hits = hits + 1;
                                    end
                                else if(re)
                                    begin
                                        rd = cachedata[Addr[OFFSET + SET - 1:OFFSET]][k][Addr[OFFSET - 1:0]];
                                        rhit = 1'b1;
                                        hits = hits + 1;
                                    end
                            end
                        else
                            begin
                                if(we)
                                    begin
                                        whit = 1'b0;
                                        times = times + 1;
                                    end
                                else if(re)
                                    begin
                                        rhit = 1'b0;
                                        times = times + 1;
                                    end
                            end
                    end
            end
        if(~hit)
            begin
                if(we)
                    begin
                        whit = 1'b0;
                        times = times + 1;
                    end
                else if(re)
                    begin
                        rhit = 1'b0;
                        times = times + 1;
                    end
            end
    end
assign waitdata = (~rhit & re) | (~whit & we);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 02:05:42 PM
// Design Name: 
// Module Name: pc_tb
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
 

module pc_tb();

    // Khai báo các tín hi?u k?t n?i
    reg clk;
    reg rst;
    reg ld_pc;
    reg inc_pc;
    reg [31:0] load_data;
    wire [31:0] pc_out;
 
    pc #(.WIDTH(32)) uut (
        .clk(clk),
        .rst(rst),
        .ld_pc(ld_pc),
        .inc_pc(inc_pc),
        .load_data(load_data),
        .pc_out(pc_out)
    );
 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
 
    initial begin 
        rst = 1;
        ld_pc = 0;
        inc_pc = 0;
        load_data = 32'd0;
 
        #20 rst = 0;
 
        #10 inc_pc = 1;
        #30 inc_pc = 0;  
 
        #10 load_data = 32'h0000_00FF; 
            ld_pc = 1;
        #10 ld_pc = 0;
 
        #10 inc_pc = 1;
        #20 inc_pc = 0;
 
        #10 rst = 1;
        #10 rst = 0;
 
        #20 $finish;
    end

endmodule


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

`timescale 1ns / 1ps

module pc_tb();

    // Khai báo các tín hi?u k?t n?i
    reg clk;
    reg rst;
    reg ld_pc;
    reg inc_pc;
    reg [31:0] load_data;
    wire [31:0] pc_out;

    // Kh?i t?o module c?n test (UUT - Unit Under Test)
    pc #(.WIDTH(32)) uut (
        .clk(clk),
        .rst(rst),
        .ld_pc(ld_pc),
        .inc_pc(inc_pc),
        .load_data(load_data),
        .pc_out(pc_out)
    );

    // T?o xung clock chu k? 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // K?ch b?n test
    initial begin
        // Kh?i t?o giá tr? ban ??u
        rst = 1;
        ld_pc = 0;
        inc_pc = 0;
        load_data = 32'd0;

        // Ch? 20ns r?i nh? reset
        #20 rst = 0;

        // Test ??m lên (inc_pc)
        #10 inc_pc = 1;
        #30 inc_pc = 0; // Ch? 3 chu k? clock ?? ??m lên 3

        // Test n?p giá tr? (ld_pc)
        #10 load_data = 32'h0000_00FF; // N?p ??a ch? 255
            ld_pc = 1;
        #10 ld_pc = 0;

        // Ti?p t?c ??m lên t? giá tr? v?a n?p
        #10 inc_pc = 1;
        #20 inc_pc = 0;

        // Reset l?i h? th?ng
        #10 rst = 1;
        #10 rst = 0;

        // K?t thúc mô ph?ng
        #20 $finish;
    end

endmodule


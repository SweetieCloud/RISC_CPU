`timescale 1ns / 1ps

module controller_tb();

    reg clk;
    reg rst;
    reg [2:0] opcode;
    reg is_zero;
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;

    controller uut (
        .clk(clk), .rst(rst), .opcode(opcode), .is_zero(is_zero),
        .sel(sel), .rd(rd), .ld_ir(ld_ir), .halt(halt),
        .inc_pc(inc_pc), .ld_ac(ld_ac), .ld_pc(ld_pc), .wr(wr), .data_e(data_e)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        rst = 1;
        opcode = 3'b010;  
        is_zero = 0;
 
        #12 rst = 0;  
        #80; 
 
        opcode = 3'b001;
        is_zero = 1;
        #80; 
        opcode = 3'b111;
        is_zero = 0;
        #80; 
        opcode = 3'b000;
        #100; 

        $finish;
    end
endmodule
`timescale 1ns / 1ps

module alu_tb();

    reg [2:0] opcode;
    reg [31:0] inA;
    reg [31:0] inB;
    wire [31:0] out;
    wire is_zero;

    alu uut (
        .opcode(opcode),
        .inA(inA),
        .inB(inB),
        .out(out),
        .is_zero(is_zero)
    );

    initial begin
        inA = 32'd0;
        inB = 32'd0;
        opcode = 3'b000;

        #10 inA = 32'd15;
            inB = 32'd20;
            opcode = 3'b010; 
            
        #10 inA = 32'h0000_FFFF;
            inB = 32'hFFFF_0000;
            opcode = 3'b011;

        #10 opcode = 3'b100;

        #10 inA = 32'd0; 
            opcode = 3'b001;
            
        #10 inA = 32'd10;
        
        #10 opcode = 3'b101;
        inB = 32'h9999_9999;
 
        #10 opcode = 3'b110; 
        inA = 32'hAAAA_BBBB;
         
        #10 opcode = 3'b111; 
        inA = 32'h1111_2222;
 
        #10 opcode = 3'b010;
        inA = 32'd0;

        #20 $finish;
        
    end

endmodule

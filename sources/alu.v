`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 01:29:37 PM
// Design Name: 
// Module Name: alu
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
 

module alu (
    input [2:0] opcode,
    input [31:0] inA,  
    input [31:0] inB,  
    output reg [31:0] out,
    output is_zero
);

    assign is_zero = (inA == 32'd0) ? 1'b1 : 1'b0;

    always @(*) begin
        case (opcode)
            3'b000: out = inA;         // HLT 
            3'b001: out = inA;         // SKZ 
            3'b010: out = inA + inB;   // ADD 
            3'b011: out = inA & inB;   // AND 
            3'b100: out = inA ^ inB;   // XOR 
            3'b101: out = inB;         // LDA 
            3'b110: out = inA;         // STO 
            3'b111: out = inA;         // JMP 
            default: out = 32'd0;
        endcase
    end
endmodule
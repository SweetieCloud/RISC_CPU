`timescale 1ns / 1ps

module address_mux #(parameter WIDTH = 32) (  
    input sel,
    input [WIDTH-1:0] inst_addr,   
    input [WIDTH-1:0] operand_addr,  
    output [WIDTH-1:0] mux_out
);
 
    assign mux_out = (sel == 1'b1) ? inst_addr : operand_addr;
    
endmodule
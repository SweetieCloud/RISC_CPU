`timescale 1ns / 1ps

module pc #(parameter WIDTH = 32) ( 
    input clk,
    input rst,
    input ld_pc,
    input inc_pc,
    input [WIDTH-1:0] load_data,
    output reg [WIDTH-1:0] pc_out
);
    always @(posedge clk) begin
        if (rst) begin
            pc_out <= {WIDTH{1'b0}}; 
        end else begin
            if (ld_pc) begin
                pc_out <= load_data; 
            end else if (inc_pc) begin
                pc_out <= pc_out + 1'b1; 
            end
        end
    end
endmodule
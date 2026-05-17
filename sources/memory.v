`timescale 1ns / 1ps

module memory (
    input clk,
    input rd,           
    input wr,           
    input [31:0] addr,
    inout [31:0] data   
);
    reg [31:0] mem [0:31]; 
    assign data = (rd && !wr) ? mem[addr[4:0]] : 32'bz;

    always @(posedge clk) begin
        if (wr && !rd) begin
            mem[addr[4:0]] <= data;  
        end
    end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 01:41:08 PM
// Design Name: 
// Module Name: register
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

module register (
    input clk,
    input rst,       
    input load,        
    input [31:0] in_data,
    output reg [31:0] out_data
);
 
    always @(posedge clk) begin
        if (rst) begin
            out_data <= 32'd0;
        end else if (load) begin
            out_data <= in_data;   
        end 
    end

endmodule

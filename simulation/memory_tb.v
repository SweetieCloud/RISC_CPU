`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 02:20:56 PM
// Design Name: 
// Module Name: memory_tb
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

module memory_tb();

    reg clk;
    reg rd;
    reg wr;
    reg [31:0] addr;
     
    wire [31:0] data;
    reg [31:0] tb_data_out;  
    reg tb_drive_bus;      
    assign data = tb_drive_bus ? tb_data_out : 32'bz;
 
    memory uut (
        .clk(clk),
        .rd(rd),
        .wr(wr),
        .addr(addr),
        .data(data)
    );
 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        rd = 0;
        wr = 0;
        addr = 32'd0;
        tb_drive_bus = 0;
        tb_data_out = 32'd0;
 
        #15 addr = 32'd5;
            tb_data_out = 32'hAABB_CCDD;
            tb_drive_bus = 1;  
            wr = 1;
            rd = 0;
            
        #10 wr = 0;
            tb_drive_bus = 0;  
 
        #10 addr = 32'd10;
            tb_data_out = 32'h1122_3344;
            tb_drive_bus = 1;
            wr = 1;
            
        #10 wr = 0;
            tb_drive_bus = 0;
 
        #10 addr = 32'd5;
            rd = 1;
            wr = 0;   
            
        #10 rd = 0;
 
        #10 addr = 32'd10;
            rd = 1;
            
        #10 rd = 0;

        #20 $finish;
    end

endmodule

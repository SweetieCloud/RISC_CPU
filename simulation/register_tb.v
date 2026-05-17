`timescale 1ns / 1ps

module register_tb();

    reg clk;
    reg rst;
    reg load;
    reg [31:0] in_data;
    wire [31:0] out_data;
 
    register uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .in_data(in_data),
        .out_data(out_data)
    );
 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        rst = 1;
        load = 0;
        in_data = 32'h0000_0000;
 
        #15 rst = 0;
 
        #10 in_data = 32'hDEAD_BEEF;  
 
        #10 load = 1;
        #10 load = 0;  
 
        #10 in_data = 32'h1234_5678;
 
        #10 load = 1;
        #10 load = 0;

        // Reset thanh ghi
        #10 rst = 1;
        #10 rst = 0;

        #20 $finish;
    end

endmodule

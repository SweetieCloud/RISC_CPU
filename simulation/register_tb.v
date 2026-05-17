`timescale 1ns / 1ps

module register_tb();

    reg clk;
    reg rst;
    reg load;
    reg [31:0] in_data;
    wire [31:0] out_data;

    // Kh?i t?o UUT
    register uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .in_data(in_data),
        .out_data(out_data)
    );

    // T?o xung clock chu k? 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Kh?i t?o giá tr?
        rst = 1;
        load = 0;
        in_data = 32'h0000_0000;

        // Nh? reset
        #15 rst = 0;

        // Test tr??ng h?p không có tín hi?u load
        #10 in_data = 32'hDEAD_BEEF; // out_data v?n ph?i gi? nguyên b?ng 0

        // Test n?p d? li?u
        #10 load = 1;
        #10 load = 0; // Kéo load xu?ng 0, out_data ph?i gi? giá tr? DEAD_BEEF

        // ??i in_data khi không có load
        #10 in_data = 32'h1234_5678;

        // N?p d? li?u m?i
        #10 load = 1;
        #10 load = 0;

        // Reset thanh ghi
        #10 rst = 1;
        #10 rst = 0;

        #20 $finish;
    end

endmodule
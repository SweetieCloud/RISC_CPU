`timescale 1ns / 1ps

module address_mux_tb();

    reg sel;
    reg [31:0] inst_addr;
    reg [31:0] operand_addr;
    wire [31:0] mux_out;

    address_mux #(.WIDTH(32)) uut (
        .sel(sel),
        .inst_addr(inst_addr),
        .operand_addr(operand_addr),
        .mux_out(mux_out)
    );

    initial begin
        inst_addr = 32'hAAAA_AAAA;
        operand_addr = 32'h5555_5555;
        sel = 0;
        #10 sel = 0;
        #10 sel = 1;
        #10 inst_addr = 32'h1234_5678;
        #10 sel = 0;
        #20 $finish;
    end

endmodule
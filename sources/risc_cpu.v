`timescale 1ns / 1ps

module cpu (
    input clk,
    input rst,
    output [3:0] led
);  
    wire [31:0] data_bus; 
    wire [31:0] pc_out, mux_out, alu_out, ac_out, ir_out; 
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;
    wire is_zero;
    wire [2:0] opcode = ir_out[7:5];
    wire [31:0] operand_addr = {27'd0, ir_out[4:0]}; 
    assign led = ac_out[3:0];
    assign data_bus = (data_e) ? ac_out : 32'bz;

    pc #(.WIDTH(32)) u_pc (
        .clk(clk),
        .rst(rst),
        .ld_pc(ld_pc),
        .inc_pc(inc_pc),
        .load_data(operand_addr), 
        .pc_out(pc_out)
    );

    address_mux #(.WIDTH(32)) u_addr_mux (
        .sel(sel),
        .inst_addr(pc_out),
        .operand_addr(operand_addr),
        .mux_out(mux_out)
    );

    register u_ir (
        .clk(clk),
        .rst(rst),
        .load(ld_ir),
        .in_data(data_bus), 
        .out_data(ir_out)
    );

    register u_ac (
        .clk(clk),
        .rst(rst),
        .load(ld_ac),
        .in_data(alu_out), 
        .out_data(ac_out)
    );

    alu u_alu (
        .opcode(opcode),
        .inA(ac_out),     
        .inB(data_bus),  
        .out(alu_out),
        .is_zero(is_zero)
    );

    memory u_memory (
        .clk(clk),
        .rd(rd),
        .wr(wr),
        .addr(mux_out),
        .data(data_bus)
    );

    controller u_controller (
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .is_zero(is_zero),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .ld_ac(ld_ac),
        .ld_pc(ld_pc),
        .wr(wr),
        .data_e(data_e)
    );

endmodule



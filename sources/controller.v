`timescale 1ns / 1ps

module controller (
    input clk,
    input rst,        
    input [2:0] opcode,  
    input is_zero,      
    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg ld_ac,
    output reg ld_pc,
    output reg wr,
    output reg data_e
);
    // FSM
    localparam INST_ADDR  = 3'd0;
    localparam INST_FETCH = 3'd1;
    localparam INST_LOAD  = 3'd2;
    localparam IDLE       = 3'd3;
    localparam OP_ADDR    = 3'd4;
    localparam OP_FETCH   = 3'd5;
    localparam ALU_OP     = 3'd6;
    localparam STORE      = 3'd7;

    // Opcodes
    localparam HLT = 3'b000;
    localparam SKZ = 3'b001;
    localparam ADD = 3'b010;
    localparam AND = 3'b011;
    localparam XOR = 3'b100;
    localparam LDA = 3'b101;
    localparam STO = 3'b110;
    localparam JMP = 3'b111;

    reg [2:0] current_state, next_state;
    
    wire is_alu_op;
    assign is_alu_op = (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA);
 
    always @(posedge clk) begin
        if (rst) begin
            current_state <= INST_ADDR;
        end else begin
            current_state <= next_state;
        end
    end 
    always @(*) begin
        if (rst) begin
            next_state = INST_ADDR;
        end else begin
            case (current_state)
                INST_ADDR:  next_state = INST_FETCH;
                INST_FETCH: next_state = INST_LOAD;
                INST_LOAD:  next_state = IDLE;
                IDLE:       next_state = OP_ADDR;
                OP_ADDR: begin
                    if (opcode == HLT) 
                        next_state = OP_ADDR;  
                    else 
                        next_state = OP_FETCH;
                end
                OP_FETCH:   next_state = ALU_OP;
                ALU_OP:     next_state = STORE;
                STORE:      next_state = INST_ADDR;  
                default:    next_state = INST_ADDR;
            endcase
        end
    end 
    always @(*) begin 
        sel    = 1'b0; rd     = 1'b0; ld_ir  = 1'b0; halt   = 1'b0;
        inc_pc = 1'b0; ld_ac  = 1'b0; ld_pc  = 1'b0; wr     = 1'b0; data_e = 1'b0;

        case (current_state)
            INST_ADDR: begin
                sel = 1'b1;
            end
            
            INST_FETCH: begin
                sel = 1'b1;
                rd  = 1'b1;
            end
            
            INST_LOAD: begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end
            
            IDLE: begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end
            
            OP_ADDR: begin
                sel = 1'b0;
                if (opcode == HLT) begin
                    halt = 1'b1;
                end else begin
                    inc_pc = 1'b1;  
                end
            end
            
            OP_FETCH: begin
                sel = 1'b0;
                if (is_alu_op) begin
                    rd = 1'b1;  
                end
            end
            
            ALU_OP: begin
                sel = 1'b0;
                if (is_alu_op)  rd = 1'b1;
                if (opcode == JMP) ld_pc = 1'b1;
                if (opcode == SKZ && is_zero) inc_pc = 1'b1; 
            end
            
            STORE: begin
                sel = 1'b0;
                if (is_alu_op) begin
                    rd    = 1'b1;
                    ld_ac = 1'b1;  
                end
                if (opcode == JMP) begin
                    ld_pc = 1'b1;
                end
                if (opcode == STO) begin
                    wr     = 1'b1;
                    data_e = 1'b1;  
                end
            end
            
            default: ;
        endcase
    end
endmodule

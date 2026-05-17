`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 02:32:11 PM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();
    reg clk;
    reg rst;
    
    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
 
        uut.u_memory.mem[20] = 32'hFFFF_FFF1;  
        uut.u_memory.mem[21] = 32'h0000_000F;  
        uut.u_memory.mem[22] = 32'd0;       
        uut.u_memory.mem[0] = 32'h0000_00B4;
        uut.u_memory.mem[1] = 32'h0000_0055;
        uut.u_memory.mem[2] = 32'h0000_0020;
        uut.u_memory.mem[3] = 32'h0000_00E6;
        uut.u_memory.mem[4] = 32'h0000_00B5;
        uut.u_memory.mem[5] = 32'h0000_00D6;
        uut.u_memory.mem[6] = 32'h0000_0000;

        #20 rst = 0; 

        #600;
        
        $display("========================================");
        $display("Expected Mem[22] = 15. Output Mem[22] = %d", uut.u_memory.mem[22]);
        
        if (uut.u_memory.mem[22] == 32'd15)
            $display("=> STATE: PASSED");
        else
            $display("=> STATE: FAILED");
        $display("========================================");
        $finish;
    end

endmodule
`timescale 1ns / 1ps


module data_path_tb;

logic reset_n, clk;
logic reg_write;
logic alu_src;
logic mem_write;
logic [3:0]alu_ctrl;
logic mem_to_reg;
logic branch; 

data_path dut (
.clk(clk),
.reset_n(reset_n)
);



initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin

// Load 10 into t0 ( addi t0, x0, 10)
reset_n = 0;
reg_write = 1'b1;
alu_src = 1'b1;
mem_write = 1'b1;
alu_ctrl = 4'b0010;
mem_to_reg = 1'b0;
branch = 1'b0; 
#10;

reset_n = 1;
reg_write = 1'b1;
alu_src = 1'b1;
mem_write = 1'b1;
alu_ctrl = 4'b0010;
mem_to_reg = 1'b0;
branch = 1'b0; 
#10;

// Load 5 into t1 ( addi t1, x0, 5)

reg_write = 1'b1;
alu_src = 1'b1;
mem_write = 1'b0;
alu_ctrl = 4'b0010;
mem_to_reg = 1'b0;
branch = 1'b0;
#10;

// Add t2 = t0 + t1 ( add t2, t1, t0)

reg_write = 1'b1;
alu_src = 1'b0;
mem_write = 1'b0;
alu_ctrl = 4'b0010;
mem_to_reg = 1'b0;
branch = 1'b0; 
#10;


$finish;
end
endmodule

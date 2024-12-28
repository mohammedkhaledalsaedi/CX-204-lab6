`timescale 1ns / 1ps


module data_mem_tb;
logic reset_n, mem_write, clk;
logic [31:0]addr, wdata;

logic [1:0]bhw;

logic [31:0]rdata;





data_mem dut (

.clk(clk),
.reset_n(reset_n),
.mem_write(mem_write),
.addr(addr),
.wdata(wdata),
.rdata(rdata)

);



initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin

reset_n = 0; mem_write = 1; addr = 'h00000005; wdata = 'hFF00FF00; bhw = 'b10; #10;
reset_n = 1; mem_write = 1; addr = 'h00000005; wdata = 'hFFFFFFFF; bhw = 'b10; #10;
reset_n = 1; mem_write = 0; addr = 'h00000005; wdata = 'hAAAAAAAA; bhw = 'b10; #10;
reset_n = 1; mem_write = 1; addr = 'h00000005; wdata = 'hBBBBBBBB; bhw = 'b10; #10;




$finish;
end
endmodule

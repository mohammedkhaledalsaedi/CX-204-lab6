`timescale 1ns / 1ps

module control_unit(

input logic [6:0]opcode,
input logic func7,
input logic [2:0]func3,
output logic reg_write,
output logic mem_write,
output logic mem_to_reg,
output logic alu_op,
output logic alu_src,
output logic branch,
output logic [3:0]alu_ctrl
    );
    
        
logic [31:0]instruction; 

    
    main_control MAIN(
        .opcode(opcode),
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg), 
        .alu_src(alu_src),
        .alu_op(alu_op),
        .reg_write(reg_write)
    );
    
    
    
    alu_control(
        .func3(instruction[14:12]),
        .func7(instruction[5]),
        .alu_op(alu_op),
        .alu_ctrl(alu_ctrl)
    );
    
    
endmodule

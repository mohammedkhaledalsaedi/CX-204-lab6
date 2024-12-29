`timescale 1ns / 1ps


module data_path(
input logic clk, reset_n
    );
    
    
    logic [31:0]next_pc;
    logic [31:0]current_pc; 
    logic [31:0]pc_plus_4;  
    logic memtoreg;  
    logic [31:0]instruction;  
    logic reg_write;
    logic [4:0]rs1, rs2, rd;
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];
        
    logic [31:0]reg_rdata1;
    logic [31:0]reg_rdata2;
    logic [31:0]reg_wdata;
    logic [31:0]imm; 
    logic [31:0]pc_jump;
    
    assign pc_jump = current_pc + imm; // alu/adder
    
     logic zero;
     logic branch;
     logic pc_sel;
     assign pc_sel = branch & zero;
     assign next_pc = (pc_sel == 0) ? pc_plus_4 : pc_jump;
    logic [3:0]alu_ctrl;
//    logic zero; moved it up there
    logic [31:0]alu_result;
    
    logic [31:0]alu_op2;
    // logic [31:0]reg_rdata2; its written up there
//    logic [31:0]imm;    also its written up there
    logic alu_src; //conrol bit for the MUX
    
    assign alu_op2 = (alu_src == 0) ? reg_rdata2 : imm;  //<------ MUX
    
    logic mem_write;
    logic [31:0]mem_rdata;
    
    
    assign reg_wdata = (memtoreg == 1) ? mem_rdata : alu_result;
    
    logic [2:0]func3 = instruction[14:12];
    
    
    
    
    
    
    
    
    
    
//    logic memtoreg; // MUX Control
//////////////////////////////////////////////// 
//    logic [31:0]next_pc;
//    logic [31:0]current_pc;
    
    
//    logic [31:0]pc_plus_4; //offset alu/adder
    
    assign pc_plus_4 = current_pc + 4;
    
    
    
    program_counter PC (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(next_pc),
        .data_o(current_pc)
    );
    
    
//////////////////////////////////////////////// 

//    logic [31:0]instruction;
    
    inst_mem ROM(
        .address(current_pc),
        .instruction(instruction)
    );
    
    
//////////////////////////////////////////////// 

    
    
//    logic reg_write;
//    logic [4:0]rs1, rs2, rd;
//    assign rs1 = instruction[19:15];
//    assign rs2 = instruction[24:20];
//    assign rd  = instruction[11:7];
        
//    logic [31:0]reg_rdata1;
//    logic [31:0]reg_rdata2;
//    logic [31:0]reg_wdata;
    
    reg_file Register (
        .clk(clk),
        .reset_n(reset_n),
        .reg_write(reg_write),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd),
        .wdata(reg_wdata),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );
    
////////////////////////////////////////////////
    
    
    
//    logic [31:0]imm;
    
    imm_gen IMM_Generator (
        .instruction(instruction),
        .imm(imm)
    
    );
    
    
    
//    logic [31:0]pc_jump;
    
//    assign pc_jump = current_pc + imm; // alu/adder
    
//     logic zero;
//     logic branch;
//     logic pc_sel;
//     assign pc_sel = branch & zero;
//     assign next_pc = (pc_sel == 0) ? pc_plus_4 : pc_jump;
     
     
    
    
//////////////////////////////////////////////// 

    
//    logic [3:0]alu_ctrl;
////    logic zero; moved it up there
//    logic [31:0]alu_result;
    
//    logic [31:0]alu_op2;
//    // logic [31:0]reg_rdata2; its written up there
////    logic [31:0]imm;    also its written up there
//    logic alu_src; //conrol bit for the MUX
    
//    assign alu_op2 = (alu_src == 0) ? reg_rdata2 : imm;  //<------ MUX
    
    
    
    alu ALU(
        .alu_ctrl(alu_ctrl),
        .op1(reg_rdata1),
        .op2(alu_op2),
        .alu_result(alu_result),
        .zero(zero)
    );
    
////////////////////////////////////////////////



//    logic mem_write;
//    logic [31:0]mem_rdata;
//    logic [1:0]bhw;
    
    data_mem RAM (
        .clk(clk),
        .reset_n(reset_n),
        .mem_write(mem_write),
        .addr(alu_result),
        .wdata(reg_rdata2),
        .rdata(mem_rdata),
        .func3(func3) //to control Byte, Half-word and word
    
    );
    
    
//    logic [31:0]reg_wdata;  //i put it up there
//    logic memtoreg; // MUX Control
    
//    assign reg_wdata = (memtoreg == 1) ? mem_rdata : alu_result; //   <---------- MUX
    
    
    
    
    
    
    
    
endmodule

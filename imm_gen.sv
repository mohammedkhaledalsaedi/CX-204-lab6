`timescale 1ns / 1ps


module imm_gen(

input logic [31:0]inst,
output logic [31:0]imm

    );
    
    logic [6:0]opcode;
    
    assign opcode = inst[6:0];
    
    always_comb begin 
        case (opcode)
        7'b0010011 : imm = { {20{inst[31]}}, inst[31:20]}; //concatination for selection and
        7'b0000011 : imm = { {20{inst[31]}}, inst[31:20]}; //sign extend the last bit 20 times
        7'b0100011 : imm = { {20{inst[31]}}, inst[31:25] , inst[11:7]};
        7'b1100011 : imm = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
        
        default: imm = 32'b0;
        endcase
    end
    
    
endmodule

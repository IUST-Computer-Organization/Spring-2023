module Arithmetic_Logic_Unit #(parameter FLEN = 10) 
(
    input [6 : 0] opcode,
    input [6 : 0] funct7,
    input funct7_valid,

    input [31 : 0] bus_rs1,
    input [31 : 0] bus_rs2,
    input [31 : 0] immediate,

    output reg [31 : 0] alu_output
);
    wire immediate_valid = ~funct7_valid;
    wire [31 : 0] operand_1 = bus_rs1;
    wire [31 : 0] operand_2;
    assign operand_2 = immediate_valid ? immediate : bus_rs2;

    always @(*)
    begin
        casex ({funct7_valid, funct7, opcode})
            15'b1_0000000_0110011 : alu_output = operand_1 + operand_2;         // ADD
            15'b0_xxxxxxx_0010011 : alu_output = operand_1 + operand_2;         // ADDI
            15'b1_0000000_1010011 : alu_output = operand_1 + operand_2;         // FADD
            15'b1_1101000_1010011 : alu_output = operand_1 << FLEN;             // FCVT

            default: alu_output = 32'bz; 
        endcase
    end
    
endmodule
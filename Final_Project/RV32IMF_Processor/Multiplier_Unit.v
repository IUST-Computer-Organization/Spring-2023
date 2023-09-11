module Multiplier_Unit 
(
    input [6 : 0] opcode,
    input [6 : 0] funct7,
    input funct7_valid,

    input [31 : 0] bus_rs1,
    input [31 : 0] bus_rs2,

    output reg [31 : 0] mul_output
);
    
    always @(*)
    begin
        case ({funct7_valid, funct7, opcode})
            15'b1_0000001_0110011 : mul_output = bus_rs1 * bus_rs2;         // MUL
            default: mul_output = 32'bz; 
        endcase
    end
    
endmodule
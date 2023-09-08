`include "Data_Memory.v"

module Load_Unit 
(
    input [1 : 0] stage,
    input [6 : 0] opcode,

    input [31 : 0] bus_rs1,
    input [31 : 0] immediate,

    output reg [31 : 0] load_unit_output
);
    assign stage_3 = stage == 3;
    reg [31 : 0] address; 
    
    always @(stage)
        if (stage == 2)
            address = bus_rs1 + immediate;

    wire memory_read_enable = opcode ==? 7'b0000011 && stage_3;
    wire [31 : 0] memory_read_output;

    Data_Memory Dmem 
    (
        1'b0,
        memory_read_enable,
        address,
        32'bz,
        memory_read_output
    );

    always @(*)
        if (memory_read_enable == 1)
            load_unit_output <= memory_read_output;
        else
            load_unit_output <= 32'bz;
    
endmodule
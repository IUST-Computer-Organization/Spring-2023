`include "Fetch_Unit.v"
`include "Control_Unit.v"
`include "Arithmetic_Logic_Unit.v"

module Core #(
    parameter ADDRESS_WIDTH = 10,
    parameter DATA_WIDTH = 18
) (
    input Reset,
    input CLK,
    output [DATA_WIDTH - 1 : 0] Result
);
    reg [ADDRESS_WIDTH - 1 : 0] ProgramCounter;

    wire    [DATA_WIDTH - 1 : 0] Instruction_S0;
    reg     [DATA_WIDTH - 1 : 0] Instruction_S1;

    wire    [1 : 0] Operation_S1;
    reg     [1 : 0] Operation_S2;

    wire    [7 : 0] Operand_1_S1;
    reg     [7 : 0] Operand_1_S2;

    wire    [7 : 0] Operand_2_S1;
    reg     [7 : 0] Operand_2_S2;

    Fetch_Unit #(ADDRESS_WIDTH, DATA_WIDTH) fetch_unit (
        .Enable(1'b1),
        .Address(ProgramCounter),
        .Data(Instruction_S0)
    );

    Control_Unit control_unit (
        .Instruction(Instruction_S1),
        .Operation(Operation_S1),
        .Operand_1(Operand_1_S1),
        .Operand_2(Operand_2_S1)
    );

    Arithmetic_Logic_Unit #(DATA_WIDTH) alu (
        .Operation(Operation_S2),
        .Operand_1(Operand_1_S2),
        .Operand_2(Operand_2_S2),
        .Result(Result)
    );
    
    always @(posedge CLK)
        ProgramCounter <= Reset ? 'b0 : ProgramCounter + 1;
    
    always @(posedge CLK)
        Instruction_S1 <= Instruction_S0;
    
    always @(posedge CLK)
    begin
        Operation_S2 <= Operation_S1;
        Operand_1_S2 <= Operand_1_S1;
        Operand_2_S2 <= Operand_2_S1;
    end

endmodule
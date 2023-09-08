`timescale  1ns/1ns

`include "Program_Counter.v"
`include "Fetch_Unit.v"
`include "Control_Unit.v"
`include "Register_File.v"
`include "Branch_Unit.v"
`include "Load_Unit.v"
`include "Arithmetic_Logic_Unit.v"
`include "Multiplier_Unit.v"
`include "SQRT_Unit.v"

module Core;
    
    parameter XLEN = 32;
    parameter FLEN = 10;

    reg Reset;

    reg CLK = 1;
    always #1 CLK = ~CLK;
   
    reg [1 : 0] stage;

    always @(negedge CLK) 
        if (stage_enable)
            stage = stage + 1;

    wire ALU_Busy = 0;
    wire MUL_Busy = 0;
    wire SQRT_Busy;
    wire stage_enable;

    nor (stage_enable, ALU_Busy, MUL_Busy, SQRT_Busy);


    wire [31 : 0] PC;
    wire [31 : 0] instruction;

    wire branch_enable;
    wire [31 : 0] immediate;

        
    wire [31 : 0] bus_rs1;
    wire [31 : 0] bus_rs2;
    wire [31 : 0] bus_rd;

    wire branch_instruction;

    wire [6 : 0] opcode;
    wire [6 : 0] funct7;
    wire funct7_valid;

    wire [4 : 0] read_index_1;
    wire [4 : 0] read_index_2;
    wire [4 : 0] write_index;

    wire IRF_read_enable_1;
    wire IRF_read_enable_2;
    wire IRF_write_enable;

    wire FRF_read_enable_1;
    wire FRF_read_enable_2;
    wire FRF_write_enable;

    Program_Counter program_counter (
        CLK, 
        Reset, 
        stage,

        branch_enable,
        immediate,

        PC
    );

    Fetch_Unit fetch_unit (
        stage, 
        PC, 

        instruction
    );

    Control_Unit control_unit (
        instruction,
        stage,

        branch_instruction,
        immediate,

        opcode,
        funct7,
        funct7_valid,

        read_index_1,
        read_index_2,
        write_index,

        IRF_read_enable_1,
        IRF_read_enable_2,
        IRF_write_enable,

        FRF_read_enable_1,
        FRF_read_enable_2,
        FRF_write_enable
    );

    Register_File IRF (
        CLK,

        IRF_read_enable_1, 
        IRF_read_enable_2, 
        IRF_write_enable,

        read_index_1, 
        read_index_2, 
        write_index,

        bus_rd, 
        
        bus_rs1, 
        bus_rs2
    );

    Register_File FRF (
        CLK,

        FRF_read_enable_1, 
        FRF_read_enable_2, 
        FRF_write_enable,

        read_index_1, 
        read_index_2, 
        write_index,

        bus_rd, 
        
        bus_rs1, 
        bus_rs2
    );

    Branch_Unit branch_unit (
        stage,
        branch_instruction,
        bus_rs1,
        bus_rs2,

        branch_enable
    );

    Load_Unit load_unit (
        stage,
        opcode,

        bus_rs1,
        immediate,

        bus_rd
    );

    Arithmetic_Logic_Unit #(FLEN) ALU 
    (
        opcode,
        funct7,
        funct7_valid,

        bus_rs1,
        bus_rs2,
        immediate,

        bus_rd
    );
    
    Multiplier_Unit MUL (
        opcode,
        funct7,
        funct7_valid,

        bus_rs1,
        bus_rs2,

        bus_rd
    );

    SQRT_Unit #(XLEN, FLEN) SQRT (
        CLK,
        stage,
        
        opcode,
        funct7,
        funct7_valid,

        bus_rs1,

        bus_rd,
        SQRT_Busy
    );


    wire [31 : 0] x0 	= IRF.Registers[0];
    wire [31 : 0] x1 	= IRF.Registers[1];
    wire [31 : 0] x2 	= IRF.Registers[2];
    wire [31 : 0] x3 	= IRF.Registers[3];
    wire [31 : 0] x4 	= IRF.Registers[4];
    wire [31 : 0] x5 	= IRF.Registers[5];
    wire [31 : 0] x10 	= IRF.Registers[10];
    wire [31 : 0] x11 	= IRF.Registers[11];
    wire [31 : 0] x12 	= IRF.Registers[12];



    wire [31 : 0] fx2 	= FRF.Registers[2];
    wire [31 : 0] fx5	= FRF.Registers[5];
    wire [31 : 0] fx7	= FRF.Registers[7];

    initial 
    begin
        $dumpfile("Core.vcd");
        $dumpvars(0, Core);

        Reset = 1;

        #9
        Reset = 0;
        stage = 0;   
    end
    
    always @(PC)
        if (PC == 32'h3C)
            $finish;
    
endmodule
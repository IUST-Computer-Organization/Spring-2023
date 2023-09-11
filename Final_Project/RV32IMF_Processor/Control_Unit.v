module Control_Unit 
(
    input [31 : 0] instruction,
    input [1 : 0] stage,

    output branch_instruction,
    output [31 : 0] immediate,

    output [6 : 0] opcode,
    output [6 : 0] funct7,
    output funct7_valid,

    output [4 : 0] read_index_1,
    output [4 : 0] read_index_2,
    output [4 : 0] write_index,

    output IRF_read_enable_1,
    output IRF_read_enable_2,
    output IRF_write_enable,

    output FRF_read_enable_1,
    output FRF_read_enable_2,
    output FRF_write_enable
);

    assign opcode = instruction [6 : 0];

    assign instruction_type_i = instruction[6 : 2] ==? 5'b0000x ||
                                instruction[6 : 2] ==? 5'b001x0 ||
                                instruction[6 : 2] ==? 5'b11001;
    
    assign instruction_type_b = instruction[6 : 2] ==? 5'b11000;

    assign instruction_type_r = instruction[6 : 2] ==? 5'b01100 ||
                                instruction[6 : 2] ==? 5'b10100;

    assign branch_instruction = instruction_type_b;

    assign funct7 = instruction[31 : 25];
    assign funct7_valid = instruction_type_r;

    assign immediate =  instruction_type_i ? { {21{instruction[31]}}, instruction[30 : 20] } :
                        instruction_type_b ? { {20{instruction[31]}}, instruction[7], instruction[30 : 25], instruction[11 : 8], 1'b0} :
                        {32{1'bz}};

    assign read_index_1 = instruction[19 : 15];
    assign read_index_2 = instruction[24 : 20];
    assign write_index  = instruction[11 : 7];

    assign read_1_valid = 1'b1;
    assign read_2_valid =   (instruction_type_r && (funct7 !=? 7'b0101100 && funct7 !=? 7'b1101000)) ||
                            instruction_type_b;
    assign write_valid = ~instruction_type_b;

    // register_file_select -> 0 : Integer RF | 1 : Fixed RF
    assign register_file_read_select = (opcode ==? 7'b1010011 && funct7 !=? 7'b1101000);
    assign register_file_write_select = opcode ==? 7'b1010011;

    // stage counter signals
    assign stage_12 = stage == 1 || stage == 2;
    assign stage_3 = stage == 3;
    
    assign IRF_read_enable_1 = ~register_file_read_select && read_1_valid && stage_12;
    assign IRF_read_enable_2 = ~register_file_read_select && read_2_valid && stage_12;

    assign IRF_write_enable = ~register_file_write_select && write_valid && stage_3;

    assign FRF_read_enable_1 = register_file_read_select && read_1_valid && stage_12;
    assign FRF_read_enable_2 = register_file_read_select && read_2_valid && stage_12;

    assign FRF_write_enable = register_file_write_select && write_valid && stage_3;
    
endmodule
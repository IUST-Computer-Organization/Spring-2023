module Branch_Unit 
(
    input [1 :0] stage,
    input branch_instruction,

    input [31 : 0] bus_rs1,
    input [31 : 0] bus_rs2,

    output reg branch_enable
);
    reg branch_condition;

    always @(stage)
        if (stage == 2)
        begin
            branch_condition = bus_rs1 < bus_rs2;
        end

    always @(*)
    begin
        if (branch_instruction == 1)
        begin
            if (branch_condition)
                branch_enable = 1'b1;
            else
                branch_enable = 1'b0;
        end

        else
            branch_enable = 1'b0;
    end

endmodule
`timescale 1ns/1ns
`include "Core.v"

module Core_Testbench;
    parameter ADDRESS_WIDTH = 10;
    parameter DATA_WIDTH = 18;

    parameter State = 1;
    parameter T = 2;

    reg Reset  = 1;
    reg CLK = 0;
    always #(T / 2) CLK = ~CLK;

    wire [DATA_WIDTH - 1 : 0] Result;

    Core #(ADDRESS_WIDTH, DATA_WIDTH) uut (
        .Reset(Reset),
        .CLK(CLK),
        .Result(Result)
    );

    initial
    begin
        $dumpfile("Core.vcd");
        $dumpvars(0, Core_Testbench);
        #(T)
        Reset = 0;
        for (integer i = 0; i < 100; i = i + 1)
        begin
            # (T * State);
        end
        $finish;
    end
endmodule
`timescale  1ns/100ps
`include "Ripple_Adder.v"

module Ripple_Adder_Testbench;

    parameter LEN = 16;

    reg [LEN - 1 : 0] A = 0;
    reg [LEN - 1 : 0] B = 0;
    reg Carry_in = 0;

    wire [LEN - 1 : 0] Sum;
    wire Carry_out;

    integer i;

    Ripple_Adder #(LEN) RA (A, B, Carry_in, Sum, Carry_out);

    initial begin
        $dumpfile("Ripple_Adder.vcd");
        $dumpvars(0, Ripple_Adder_Testbench);
        
        #10

        for (i = 0; i < 5; i = i + 1)
        begin
            A = $random;
            B = $random;
            #20;
        end

        #100
        $dumpoff;

    end

    
endmodule
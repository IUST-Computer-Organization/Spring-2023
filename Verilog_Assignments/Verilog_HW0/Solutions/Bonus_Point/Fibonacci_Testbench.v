// Computer Organization - IUST Spring 2023
// Verilog HW0 : 2
//-----------------------------------------
// Fibonacci Sequence Testbench

`include "Fibonacci.v"

module Fibonacci_Testbench ();

    reg clk = 0;
    reg reset;

    wire [11:0] result;
    Fibonacci uut (clk, reset, result);

    always #1 clk = ~clk;

    initial 
    begin
        $dumpfile("Fibonacci.vcd");
        $dumpvars(0, Fibonacci_Testbench);

        reset = 1;
        #2 
        reset = 0;
        #40 
        $finish;
    end  
endmodule
// Computer Organization - IUST Spring 2023
// Verilog HW0 : 2
//-----------------------------------------
// Fibonacci Sequence testbench

`include "Fibonacci_Sequence.v"
module fibonacci_tb ();
  
  reg clk, en, rst;
  wire [11:0] out;
  fibonacci F1 (clk, rst, out);
  
  always #1 clk = ~clk;
  
  initial begin
    clk = 0; rst = 1; en = 0;
    #2 rst = 0; en = 0;
    #2 en = 1;
    #30 en = 0;
    #2 en = 1;
    #40 $stop;
  end

  initial begin
    $dumpfile("fibonacci.vcd");
    $dumpvars(0,fibonacci_tb);
  end
  
endmodule
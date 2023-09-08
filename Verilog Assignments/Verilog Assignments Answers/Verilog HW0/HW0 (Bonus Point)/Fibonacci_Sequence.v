// Computer Organization - IUST Spring 2023
// Verilog HW0 : 2
//-----------------------------------------
// Fibonacci Sequence

`timescale 1ns / 1ps
module fibonacci (clk, rst, out); input clk;
  input rst;
  output [11:0] out;
  reg [11:0] previous_val;
  reg [11:0] current_val;

  always @(posedge clk or posedge rst)
  begin
      if (rst == 1'b1)
      begin
        previous_val <= 12'b0;
        current_val <= 12'b1;
      end
      else if (clk == 1'b1)
      begin
        previous_val <= current_val;
        current_val<= current_val + previous_val;
      end
  end
  assign out = previous_val;
endmodule
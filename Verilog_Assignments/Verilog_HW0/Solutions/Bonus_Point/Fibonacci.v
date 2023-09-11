// Computer Organization - IUST Spring 2023
// Verilog HW0 : 2
//-----------------------------------------
// Fibonacci Sequence Generator

`timescale 1ns / 1ps
module Fibonacci 
( 
    input clk, 
    input reset, 
    output [11 : 0] result
); 
    reg [11:0] previous_value;
    reg [11:0] current_value;

    always @(posedge clk or posedge reset)
    begin
        if (reset == 1'b1)
        begin
            previous_value <= 12'b0;
            current_value <= 12'b1;
        end
        else if (clk == 1'b1)
        begin
            previous_value <= current_value;
            current_value<= current_value + previous_value;
        end
    end
    assign result = previous_value;
endmodule
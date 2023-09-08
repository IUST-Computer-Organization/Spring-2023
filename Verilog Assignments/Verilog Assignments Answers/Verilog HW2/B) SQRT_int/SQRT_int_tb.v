// Computer Organization - IUST Spring 2023
// Verilog HW2 : 2
//-----------------------------------------
// Squared Root Module testbench

`include "SQRT_int.v"
module sqrt_int_tb();

    parameter CLK_PERIOD = 10;
    parameter WIDTH = 8;
    reg clk;
    reg start;              // start signal
    wire busy;              // calculation in progress
    wire valid;             // root and rem are valid
    reg [WIDTH-1:0] rad;    // radicand
    wire [WIDTH-1:0] root;  // root
    wire [WIDTH-1:0] rem;   // remainder
    
    sqrt_int SQRT(clk, start, busy, valid, rad, root, rem); 

    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        $monitor("\t%d:\tsqrt(%d) =%d (rem =%d) (V=%b)", $time, rad, root, rem, valid);
    end

    initial begin
        $dumpfile("SQRT_int.vcd");
        $dumpvars(0,sqrt_int_tb);
        clk = 1;
        #100    rad = 8'b00000000;  // 0
                start = 1;
        #10     start = 0;
        #50     rad = 8'b00000001;  // 1
                start = 1;
        #10     start = 0;
        #50     rad = 8'b01111001;  // 121
                start = 1;
        #10     start = 0;
        #50     rad = 8'b01010001;  // 81
                start = 1;
        #10     start = 0;
        #50     rad = 8'b01011010;  // 90
                start = 1;
        #10     start = 0;
        #50     rad = 8'b11111111;  // 255
                start = 1;
        #10     start = 0;
        #50     $finish;
    end
endmodule
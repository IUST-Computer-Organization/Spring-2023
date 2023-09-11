// Computer Organization - IUST Spring 2023
// Verilog HW2 : 3
//-----------------------------------------
// Fixed-Point Square Root Module testbench

`include "Square_Root.v"

module Square_Root_Testbench();

    parameter CLK_PERIOD = 10;
    parameter WIDTH = 32;
    parameter FBITS = 10;
    parameter SF = 2.0**-10.0;  // Q8.8 scaling factor is 2^-10

    reg clk;
    reg start;              // start signal
    wire busy;              // calculation in progress
    wire valid;             // root and rem are valid
    reg  [WIDTH-1:0] rad;   // radicand
    wire [WIDTH-1:0] root;  // root
    wire [WIDTH-1:0] rem;   // remainder

    
    Square_Root uut (clk, start, rad, busy, valid, root, rem);

    always #(CLK_PERIOD / 2) clk = ~clk;


    initial 
    begin
        $dumpfile("Square_Root.vcd");
        $dumpvars(0, Square_Root_Testbench);

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

        #10000    $finish;
    end
endmodule
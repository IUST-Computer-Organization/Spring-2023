`timescale 1ns/1ns
`include "Booth_App.v"

module  Booth_Mult_tb();
    localparam Testcase_Numbers = 10;
    localparam WIDTH = 8;

    reg signed      [WIDTH - 1 : 0] A;
    reg signed      [WIDTH - 1 : 0] B;
    wire signed     [2 * WIDTH - 1 : 0] Result;

    Booth_App #(WIDTH) uut (
        .input_A(A),
        .input_B(B),
        .C(Result)
    );
    
    initial
    begin
        #5      A = 124;
                B = 73;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result); // -> exact answer = 9052
        #5      A = 2;
                B = 2;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result); // -> exact answer = 9052
        #5      A = 49;
                B = 49;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result); 
        #5      A = 52;
                B = 63;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result); 
        #5      A = 5;
                B = 9;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result);
        #5      A = 10;
                B = 12;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result);
        #5      A = 115;
                B = 63;
        #5      $display("%d:\t%d\t*\t%d\t=\t%d\n", $time, A, B, Result);
        #10     $finish;
    end 
endmodule

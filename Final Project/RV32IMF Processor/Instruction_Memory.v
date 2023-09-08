module Instruction_Memory
(
    input ImemReadEnable,
    input [31 : 0] ImemReadAddress,
    output reg [31 : 0] ImemReadData

);

	reg [31:0] Memory [0:31];

	initial
    begin
        Memory[0]   =   32'h00000533;  // add x10 x0 x0
        Memory[1]   =   32'h00100593;  // addi x11 x0 1
        Memory[2]   =   32'h06200613;  // addi x12 x0 98
        Memory[3]   =   32'h00000153;  // fadd.s f2 f0 f0
        Memory[4]   =   32'h00054083;  // lbu x1 0(x10)
        Memory[5]   =   32'h00250513;  // addi x10 x10 2
        Memory[6]   =   32'h0005C103;  // lbu x2 0(x11)
        Memory[7]   =   32'h00258593;  // addi x11 x11 2
        Memory[8]   =   32'h021081B3;  // mul x3 x1 x1
        Memory[9]   =   32'h02210233;  // mul x4 x2 x2
        Memory[10]  =   32'h004182B3;  // add x5 x3 x4
        Memory[11]  =   32'hD01282D3;  // fcvt.s.wu f5 x5
        Memory[12]  =   32'h580283D3;  // fsqrt.s x7 f5
        Memory[13]  =   32'h00710153;  // fadd.s f2 f2 f7
        Memory[14]  =   32'hFCC5CCE3;  // blt x11 x12 -40
    end
	
    always @(*)
    begin
        ImemReadData = Memory[ImemReadAddress];
    end
endmodule
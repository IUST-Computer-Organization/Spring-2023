module Fetch_Unit #(
    parameter ADDRESS_WIDTH = 10,
    parameter DATA_WIDTH = 18
) (
    input Enable,
    input [ADDRESS_WIDTH - 1 : 0] Address,
    output [DATA_WIDTH - 1 : 0]  Data
);
    reg [DATA_WIDTH - 1 : 0] Memory [0 : $pow(2, ADDRESS_WIDTH) - 1];

    initial $readmemb("Memory.txt", Memory);   

    assign Data = Enable ? Memory[Address] : 'bz;
endmodule
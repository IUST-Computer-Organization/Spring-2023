module Data_Memory
(
    input wire DmemWriteEnable,
    input wire DmemReadEnable,

    input wire [31 : 0] DmemAddress,

    input wire [31 : 0] DmemWriteData,
    output reg [31 : 0] DmemReadData
);

	reg [7 : 0 ] Memory [0 : 127];      // 128 Byte Memory for Data
    
    integer i;
    initial
    begin
        Memory[0]	=	8'd2;
        Memory[1]	=	8'd49;
        Memory[2]	=	8'd1;
        Memory[3]	=	8'd12;
        Memory[4]	=	8'd7;
        Memory[5]	=	8'd33;
        Memory[6]	=	8'd6;
        Memory[7]	=	8'd19;
        Memory[8]	=	8'd8;
        Memory[9]	=	8'd16;
        Memory[10]	=	8'd18;
        Memory[11]	=	8'd22;
        Memory[12]	=	8'd14;
        Memory[13]	=	8'd20;
        Memory[14]	=	8'd4;
        Memory[15]	=	8'd15;
        Memory[16]	=	8'd0;
        Memory[17]	=	8'd28;
        Memory[18]	=	8'd4;
        Memory[19]	=	8'd24;
        Memory[20]	=	8'd5;
        Memory[21]	=	8'd21;
        Memory[22]	=	8'd55;
        Memory[23]	=	8'd18;
        Memory[24]	=	8'd2;
        Memory[25]	=	8'd17;
        Memory[26]	=	8'd36;
        Memory[27]	=	8'd19;
        Memory[28]	=	8'd1;
        Memory[29]	=	8'd29;
        Memory[30]	=	8'd28;
        Memory[31]	=	8'd11;
        Memory[32]	=	8'd16;
        Memory[33]	=	8'd12;
        Memory[34]	=	8'd7;
        Memory[35]	=	8'd11;
        Memory[36]	=	8'd1;
        Memory[37]	=	8'd20;
        Memory[38]	=	8'd6;
        Memory[39]	=	8'd16;
        Memory[40]	=	8'd15;
        Memory[41]	=	8'd17;
        Memory[42]	=	8'd25;
        Memory[43]	=	8'd14;
        Memory[44]	=	8'd16;
        Memory[45]	=	8'd5;
        Memory[46]	=	8'd21;
        Memory[47]	=	8'd3;
        Memory[48]	=	8'd31;
        Memory[49]	=	8'd11;
        Memory[50]	=	8'd16;
        Memory[51]	=	8'd8;
        Memory[52]	=	8'd15;
        Memory[53]	=	8'd10;
        Memory[54]	=	8'd13;
        Memory[55]	=	8'd11;
        Memory[56]	=	8'd12;
        Memory[57]	=	8'd12;
        Memory[58]	=	8'd10;
        Memory[59]	=	8'd13;
        Memory[60]	=	8'd12;
        Memory[61]	=	8'd22;
        Memory[62]	=	8'd7;
        Memory[63]	=	8'd24;
        Memory[64]	=	8'd1;
        Memory[65]	=	8'd17;
        Memory[66]	=	8'd15;
        Memory[67]	=	8'd5;
        Memory[68]	=	8'd26;
        Memory[69]	=	8'd15;
        Memory[70]	=	8'd15;
        Memory[71]	=	8'd10;
        Memory[72]	=	8'd14;
        Memory[73]	=	8'd11;
        Memory[74]	=	8'd13;
        Memory[75]	=	8'd12;
        Memory[76]	=	8'd13;
        Memory[77]	=	8'd13;
        Memory[78]	=	8'd12;
        Memory[79]	=	8'd14;
        Memory[80]	=	8'd12;
        Memory[81]	=	8'd14;
        Memory[82]	=	8'd11;
        Memory[83]	=	8'd15;
        Memory[84]	=	8'd10;
        Memory[85]	=	8'd15;
        Memory[86]	=	8'd0;
        Memory[87]	=	8'd32;
        Memory[88]	=	8'd5;
        Memory[89]	=	8'd26;
        Memory[90]	=	8'd13;
        Memory[91]	=	8'd30;
        Memory[92]	=	8'd5;
        Memory[93]	=	8'd8;
        Memory[94]	=	8'd12;
        Memory[95]	=	8'd15;
        Memory[96]	=	8'd14;
        Memory[97]	=	8'd14;
    end
	
    always @(*)
    begin
        if (DmemWriteEnable == 1'b1)
        begin
            Memory[DmemAddress] <= DmemWriteData;
        end

        if (DmemReadEnable == 1'b1)
            DmemReadData <= Memory[DmemAddress];
        else
            DmemReadData <= 8'bz;
    end
    
endmodule
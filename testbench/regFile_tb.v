`timescale 1ns/1ps

module regFile_tb;
	reg clk;
	reg RegWrite;
	reg [4:0] rs1, rs2, rd;
	reg [31:0] WriteData;
	wire [31:0] ReadData1, ReadData2;

registerFile DUT (
        .clk(clk),
        .RegWrite(RegWrite),
        .WriteData(WriteData),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
);

always #5 clk = ~clk;

initial begin
        clk = 0;
        RegWrite = 0;
        rs1 = 0; rs2 = 0; rd = 0; WriteData = 0;
        #10;

        // TEST 1: Write to register 5 and read it
        RegWrite = 1; rd = 5; WriteData = 32'hAAAA_BBBB;
        #10; // wait one clock
        RegWrite = 0; rs1 = 5;
        #10;
        $display("TEST 1: x5 = %h (expected AAAA_BBBB)", ReadData1);

        // TEST 2: Write to register 10 and read it
        RegWrite = 1; rd = 10; WriteData = 32'h1234_5678;
        #10;
        RegWrite = 0; rs1 = 10;
        #10;
        $display("TEST 2: x10 = %h (expected 1234_5678)", ReadData1);

        // TEST 3: Read two registers simultaneously
        rs1 = 5; rs2 = 10;
        #10;
        $display("TEST 3: ReadData1 = %h (x5), ReadData2 = %h (x10)", ReadData1, ReadData2);

        // TEST 4: Attempt to write x0 (should remain 0)
        RegWrite = 1; rd = 0; WriteData = 32'hFFFFFFFF;
        #10;
        RegWrite = 0; rs1 = 0;
        #10;
        $display("TEST 4: x0 = %h (expected 0000_0000)", ReadData1);

        // TEST 5: Overwrite register 5 and check new value
        RegWrite = 1; rd = 5; WriteData = 32'hDEAD_BEEF;
        #10;
        RegWrite = 0; rs1 = 5;
        #10;
        $display("TEST 5: x5 = %h (expected DEAD_BEEF)", ReadData1);

        // TEST 6: Write to multiple registers and read back
        RegWrite = 1; rd = 20; WriteData = 32'hCAFECAFE; #10;
        rd = 25; WriteData = 32'hFACEFACE; #10;
        RegWrite = 0; rs1 = 20; rs2 = 25;
        #10;
        $display("TEST 6: x20 = %h, x25 = %h (expected CAFECAFE, FACEFACE)", ReadData1, ReadData2);

        // TEST 7: Ensure no write when RegWrite = 0
        rd = 15; WriteData = 32'hABCDEF12; RegWrite = 0;
        #10;
        rs1 = 15;
        #10;
        $display("TEST 7: x15 = %h (should NOT be ABCDEF12)", ReadData1);

        #10;
        $stop;
end

endmodule


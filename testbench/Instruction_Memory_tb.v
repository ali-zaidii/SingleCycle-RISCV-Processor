`timescale 1ns/1ps

module Instruction_Memory_tb();
	reg [31:0] A;
	wire [31:0] Ins;

Instruction_Memory dut(
	.Inst_Address(A),
	.Instruction(Ins)
);

initial begin

	$monitor("Time=%0t | Inst_Address=%0d | Instruction=%h", $time, A, Ins);

	//Test Cases
	A = 0;   #10;   // should fetch word from bytes 0-3
        A = 1;   #10;   // bytes 1-4
        A = 2;   #10;   // bytes 2-5
        A = 4;   #10;   // bytes 4-7
        A = 8;   #10;   // bytes 8-11
        A = 12;  #10;   // bytes 12-15

        #10;
        $finish;

end


endmodule 
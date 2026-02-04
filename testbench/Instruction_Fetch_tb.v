`timescale 1ns/1ps

module Instruction_Fetch_tb;
reg clk,reset;
wire[31:0] Instruction;

Instruction_Fetch dut (
	.clk(clk),
	.reset(reset),
	.Instruction(Instruction)
);

initial begin 
	clk = 0;
	forever #5 clk=~clk;
end

initial begin
	reset = 1;
	#10;

	reset = 0;
	#50;

	$finish;
end

endmodule 

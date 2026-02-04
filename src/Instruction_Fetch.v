module Instruction_Fetch (
	input clk, reset,
	output [31:0] Instruction
);

wire [31:0] next_pc;
wire [31:0] current_pc;

Program_Counter PC (
	.clk(clk),
	.reset(reset),
	.PC_In(next_pc),
	.PC_Out(current_pc)
);

Adder Add(
	.a(current_pc),
	.b(32'd4),
	.out(next_pc)
);

Instruction_Memory IM(
	.Inst_Address(current_pc),
	.Instruction(Instruction)
);

endmodule

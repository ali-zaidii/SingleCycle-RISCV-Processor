module Instruction_Memory(
	input wire [31:0] Inst_Address,
	output reg [31:0] Instruction
);

reg [7:0] ram [15:0];

initial begin
	$readmemb("InstructionMemory.mif", ram);
end

always @(*) begin
	Instruction = {ram[Inst_Address+3], ram[Inst_Address+2], ram[Inst_Address+1], ram[Inst_Address]};
end

endmodule 
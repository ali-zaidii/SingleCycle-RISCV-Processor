module RISCV_Processor(
	input clk,reset,
	output [31:0] PC, PCNext, PCPlus4, PCTarget, Instr, Result, SrcA, RD2, SrcB, ImmExt, ALUResult, ReadData,
	output PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite, zero,
	output [2:0] ALUControl,
	output [1:0] ImmSrc
);

Control_Unit CU(
	.opcode(Instr[6:0]), 
	.zero(zero),
	.func7(Instr[30]),
	.func3(Instr[14:12]),
	.PCSrc(PCSrc), 
	.ResultSrc(ResultSrc),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.ALUControl(ALUControl),
	.ImmSrc(ImmSrc)
);

// Fetch

Program_Counter PCounter(
	.clk(clk), 
	.reset(reset),
	.PC_In(PCNext),
	.PC_Out(PC)
);

Adder Add4(
	.a(PC),
	.b(32'd4),
	.out(PCPlus4)
);

multiplexer2x1 muxPCSrc(
	.result(PCNext),
	.sel(PCSrc),
	.a(PCPlus4),
	.b(PCTarget)
);

Instruction_Memory IM(
	.Inst_Address(PC), 
	.Instruction(Instr)
);

//Decode

registerFile RF(
	.clk(clk),
	.RegWrite(RegWrite),
	.WriteData(Result),
	.rs1(Instr[19:15]),
	.rs2(Instr[24:20]),
	.rd(Instr[11:7]),
	.ReadData1(SrcA),
	.ReadData2(RD2)
);

ImmDataGen ImmExtender(
	.instruction(Instr),
	.ImmSrc(ImmSrc),
	.imm_data(ImmExt)
);

// Execute

multiplexer2x1 muxALU(
	.result(SrcB),
	.sel(ALUSrc),
	.a(RD2),
	.b(ImmExt)
);

ALU alu(
	.result(ALUResult),
	.zero(zero),
	.a(SrcA),
	.b(SrcB),
	.sel(ALUControl)
);

Adder Addbranch(
	.a(PC),
	.b(ImmExt),
	.out(PCTarget)
);

// Memory

Data_Memory DM(
	.clk(clk),
	.MemWrite(MemWrite),
	.Mem_Addr(ALUResult),
	.Write_Data(RD2),
	.Read_Data(ReadData)
);

// WriteBack

multiplexer2x1 muxResult(
	.result(Result),
	.sel(ResultSrc),
	.a(ALUResult),
	.b(ReadData)
);

endmodule
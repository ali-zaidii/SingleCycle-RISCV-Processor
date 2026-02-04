`timescale 1ns/1ps
module RISCV_Processor_tb;

reg clk, reset;

wire [31:0] PC, PCNext, PCPlus4, PCTarget, Instr, Result, SrcA, RD2, SrcB, ImmExt, ALUResult, ReadData;
wire PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite, zero;
wire [2:0] ALUControl;
wire [1:0] ImmSrc;


RISCV_Processor RISCV(
	.clk(clk),
	.reset(reset),
	.PC(PC),
	.PCNext(PCNext),
	.PCPlus4(PCPlus4),
	.PCTarget(PCTarget),
	.Instr(Instr),
	.Result(Result),
	.SrcA(SrcA),
	.RD2(RD2),
	.SrcB(SrcB),
	.ImmExt(ImmExt),
	.ALUResult(ALUResult),
	.ReadData(ReadData),
	.PCSrc(PCSrc), 
	.ResultSrc(ResultSrc),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),	
	.RegWrite(RegWrite),
	.zero(zero),
	.ALUControl(ALUControl),
	.ImmSrc(ImmSrc)
);

initial begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end

initial begin
	reset = 1;
	#15;

	reset = 0;
	#50;

	$finish;
end
endmodule

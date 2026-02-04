module Control_Unit(
	input [6:0] opcode,
	input zero, func7,
	input [2:0]func3,
	output PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite,
	output [2:0] ALUControl, 
	output [1:0] ImmSrc
);

wire Branch;
wire [1:0] ALUop;
assign PCSrc = zero & Branch;

Main_Decoder MD(
	.opcode(opcode),
	.Branch(Branch),
	.ResultSrc(ResultSrc),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.ImmSrc(ImmSrc),
	.ALUop(ALUop)
);

ALUControl ALUCon(
	.func7(func7),
	.ALUop(ALUop),
	.func3(func3),
	.ALUControl(ALUControl)
);

endmodule

module Main_Decoder(
	input [6:0] opcode,
	output reg Branch,ResultSrc,MemWrite,ALUSrc,RegWrite,
	output reg [1:0] ImmSrc,ALUop
);
reg [8:0] controls;


always@(*)begin
	{ALUSrc, ResultSrc, ImmSrc, RegWrite, MemWrite, Branch, ALUop} = controls;
end

always @(*) begin
	case(opcode)
		7'b0110011: controls = 9'b00xx10010;
		7'b0000011: controls = 9'b110010000;
		7'b0100011: controls = 9'b1x0101000;
		7'b1100011: controls = 9'b0x1000101;
		7'b0010011: controls = 9'b100010010;
		default:    controls = 9'bxxxxxxxxx;
	endcase

end

endmodule

module ALUControl(
	input func7,
	input [1:0] ALUop,
	input [2:0] func3,
	output reg [2:0] ALUControl
);

always @(*) begin
	case(ALUop)
		2'b00: ALUControl = 3'b000;
		2'b01: ALUControl = 3'b001;
		2'b10: begin
			case(func3)
				3'b000:  ALUControl = func7 ? 3'b001 : 3'b000;
				3'b010:  ALUControl = 3'b101;
				3'b110:  ALUControl = 3'b011;
				3'b111:  ALUControl = 3'b010;
				default: ALUControl = 3'bx;
			endcase
		end
		default: ALUControl = 3'bx;
	endcase
end

endmodule

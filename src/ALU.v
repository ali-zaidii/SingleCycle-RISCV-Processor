module ALU(
	output reg [31:0]result,
	output reg zero,
	input wire [31:0]a,
	input wire [31:0]b,
	input wire [2:0]sel
);

always @(*) begin
	case(sel)

	3'b000: 
		result = a + b;
	3'b001: 
		result = a - b;
	3'b101: 
		result = (a<b)? 32'h00000001 : 32'h00000000;
	3'b011:
		result = a | b;
	3'b010:
		result = a & b;
	default: 
		result = 32'bx;
	endcase
	zero = (result == 0) ? 1'b1 : 1'b0 ;
end
endmodule



module multiplexer2x1(
	output reg [31:0]result,
	input wire sel,
	input wire [31:0]a,
	input wire [31:0]b
);

always@(*) begin
	result = sel ? b : a;
end
endmodule



module Program_Counter(
	input clk, reset,
	input [31:0] PC_In,
	output reg [31:0] PC_Out
);

always @ (posedge clk) begin
	if (reset) PC_Out <= 32'b0;
	else PC_Out <= PC_In;
end
endmodule
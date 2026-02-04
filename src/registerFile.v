module registerFile(
	input wire clk,
	input wire RegWrite,
	input wire [31:0] WriteData,
	input wire [4:0] rs1, rs2, rd,
	output wire [31:0] ReadData1,
	output wire [31:0] ReadData2
);

reg [31:0] registers [31:0];

initial begin
	$readmemh("registerFile.mif", registers);
end
	
assign ReadData1 = (rs1 == 5'd0) ? 32'd0 : registers[rs1];
assign ReadData2 = (rs2 == 5'd0) ? 32'd0 : registers[rs2];

always @(posedge clk) begin
	if (RegWrite == 1 && rd != 0)begin
		registers[rd] <= WriteData;
	end
end

endmodule 

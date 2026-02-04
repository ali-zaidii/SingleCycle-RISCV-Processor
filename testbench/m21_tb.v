`timescale 1ns/1ps

module m21_tb;
	reg [31:0]a;
	reg [31:0]b;
	reg sel;
	wire [31:0]result;

	multiplexer2x1 DUT(
		.a(a),
		.b(b),
		.sel(sel),
		.result(result)
	);

	initial begin

		$monitor("Time=%0t | sel=%b | a=%h, b=%h | Output result=%h", $time, sel, a, b, result);

		a= 32'hAAAAAAAA;
		b= 32'hBBBBBBBB;
		sel= 0;

		#10;

		sel= 1;

		#10;
		$finish;
	end

endmodule

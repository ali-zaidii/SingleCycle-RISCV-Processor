`timescale 1ns/1ps

module ImmDataGen_tb;
	wire [31:0]imm_data;
	reg [31:0]instruction;
	reg [1:0]ImmSrc;


ImmDataGen DUT (
	.imm_data(imm_data),
	.instruction(instruction),
	.ImmSrc(ImmSrc)
);

	initial begin
  
	        $display("Starting Simulation...");
	        instruction = 32'b0;
	        ImmSrc      = 2'b0;
	        #10; 

	        //Test Case 1: I-type (ImmSrc = 00)
	        $display("\n--- Testing I-type (ImmSrc = 00) ---");
	        // Positive value: imm = 0x1A3 = 419
	        instruction = 32'h1A300000;
	        ImmSrc      = 2'b00;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: 000001a3)", instruction, ImmSrc, imm_data);
	
	        // Negative value: imm = 0xEC4 = -316
	        instruction = 32'hEC400000;
	        ImmSrc      = 2'b00;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: fffffec4)", instruction, ImmSrc, imm_data);


	        //Test Case 2: S-type (ImmSrc = 01)
	        $display("\n--- Testing S-type (ImmSrc = 01) ---");
	        // Positive value: instruction[31:25]=0x34, instruction[11:7]=0x15 -> imm=0x695
	        instruction = 32'h69400A80; 
	        ImmSrc      = 2'b01;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: 00000695)", instruction, ImmSrc, imm_data);

	        // Negative value: instruction[31:25]=0x7C, instruction[11:7]=0x1F -> imm=0xFFF = -1
	        instruction = 32'hF9F00FC0; 
	        ImmSrc      = 2'b01;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: ffffff9f)", instruction, ImmSrc, imm_data);


	        //Test Case 3: B-type (ImmSrc = 10)
	        $display("\n--- Testing B-type (ImmSrc = 10) ---");
	        // Positive value: imm[11]=0, imm[10]=1, imm[9:4]=0x1A, imm[3:0]=0xB -> imm=0x6AB
	        instruction = 32'h34B5A080;
	        ImmSrc      = 2'b10;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: 000005a0)", instruction, ImmSrc, imm_data);
	
	        // Negative value: imm[11]=1, imm[10]=0, imm[9:4]=0x3F, imm[3:0]=0xF -> imm=0x8FF = -1793
	        instruction = 32'hFFFE0F00;
	        ImmSrc      = 2'b10;
	        #10;
	        $display("Instruction: %h, ImmSrc: %b -> imm_data: %h (Expected: 7ffffbff)", instruction, ImmSrc, imm_data);
	
	        $display("\nSimulation Finished.");
	        $finish;
	end
endmodule

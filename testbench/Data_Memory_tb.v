`timescale 1ns/1ps

module Data_Memory_tb;

    reg clk;
    reg MemWrite;
    reg [31:0] Mem_Addr;
    reg [31:0] Write_Data;
    wire [31:0] Read_Data;

    Data_Memory dut (
        .clk(clk),
        .MemWrite(MemWrite),
        .Mem_Addr(Mem_Addr),
        .Write_Data(Write_Data),
        .Read_Data(Read_Data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        MemWrite = 0;
        Mem_Addr = 0;
        Write_Data = 0;

        #10 MemWrite = 1; Mem_Addr = 0; Write_Data = 32'hAABBCCDD;
        #10 MemWrite = 0;
        #10 Mem_Addr = 0;
        #10 Mem_Addr = 4; Write_Data = 32'h11223344; MemWrite = 1;
        #10 MemWrite = 0;
        #10 Mem_Addr = 4;
        #20 $finish;
    end

endmodule


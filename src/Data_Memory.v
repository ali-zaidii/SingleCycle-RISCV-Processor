module Data_Memory(
    input wire clk, MemWrite,
    input wire [31:0] Mem_Addr, Write_Data,
    output reg [31:0] Read_Data
);

reg [7:0] mem [0:63];
wire [5:0] base_addr = Mem_Addr[5:0];

initial begin
    $readmemh("DataMemory.mif", mem);
end

// Write (synchronous)
always @(posedge clk) begin
    if (MemWrite) begin
        mem[base_addr + 0] <= Write_Data[7:0];
        mem[base_addr + 1] <= Write_Data[15:8];
        mem[base_addr + 2] <= Write_Data[23:16];
        mem[base_addr + 3] <= Write_Data[31:24];
    end
end

// Read (combinational, big-endian)
always @(*) begin
    Read_Data = {mem[base_addr + 3], mem[base_addr + 2], mem[base_addr + 1], mem[base_addr + 0]};
end

endmodule


module DataMemory (
  input clk,
  input MemWrite,
  input MemRead,
  input [31:0] address,
  input [31:0] WriteData,
  output reg [31:0] ReadData
);
reg [31:0] dataMem[63:0];
always @(*)
begin
if(MemRead == 1'b1)
ReadData <= dataMem[address];
else if(MemWrite == 1'b1)
dataMem[address] = WriteData;
end
endmodule

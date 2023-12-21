`timescale 1ps/100fs
module RISC_V_tb();
reg clk,reset;
wire [31:0] ALUOut,WriteData,PC;
parameter PERIOD = 20;
initial begin
	clk = 0;
	reset = 1;
	#5 reset = 0;
end
always #((PERIOD)/2) clk = ~clk;
RISC_V CPU(clk,reset,ALUOut,WriteData,PC);
endmodule

module Instruction_Mem(address,instruction);
input [31:0] address;
output [31:0] instruction;
reg [31:0] i_arr[0:31];
initial begin
		$readmemh("imem.hex",i_arr);
	 end
    assign instruction = i_arr[address[31:2]]; //  i_arr[address/4]
endmodule
module RegisterFile(clk,Rs1,Rs2,Rd,Write_data,RegWrite,Read_data1,Read_data2);
input clk,RegWrite;
input [4:0] Rs1;
input [4:0] Rs2;
input [4:0] Rd;
input [31:0] Write_data;
output [31:0] Read_data1,Read_data2;
reg [31:0] Register [31:0];
generate
    integer i;
    initial begin
      for (i = 0; i <= 31; i = i + 1) begin
        Register[i] = 0;
      end
    end
endgenerate
always @(posedge clk)
begin
if(RegWrite)
	Register[Rd]= Write_data;
end 
assign Read_data1 = Register[Rs1];
assign Read_data2 = Register[Rs2];
endmodule
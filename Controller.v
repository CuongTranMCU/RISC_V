module Controller(
input [6:0] Opcode,
output ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch,jump,jSel,
output [1:0] Aluop);
reg [9:0] control;
assign {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,jump,jSel,Aluop} = control;
always @(*)
begin	
case(Opcode)
7'b0110011 : control <= 10'b0010000010; // R-type
7'b0000011 : control <= 10'b1111000000; // lw-type
7'b0100011 : control <= 10'b1x00100000; // s-type
7'b1100011 : control <= 10'b0x00010001; // sb-type
7'b0010011 : control <= 10'b1010000011; // I-type
7'b1100111 : control <= 10'b111xx01000; // jalr-type
7'b1101111 : control <= 10'b111xx01100; // jal-type // jSel: phân biệt jal với phần còn lại
default : control    <= 10'bxxxxxxxxxx;
endcase
end
endmodule
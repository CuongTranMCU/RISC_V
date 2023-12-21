module RISC_V(
	input clk,
	input reset,
	output [31:0] ALUOut,
	output [31:0] WriteData,
	output [31:0] PC
);
// stage 1: Instruction Fetch:
wire [31:0] PCin,PCPlus4;
wire [31:0] Ins;
// stage 2: Decode:
wire ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch,jump,jSel;
wire[1:0] ALUOp;
// Register File:
wire [31:0] RD1,RD2;
// Sign_Ex:
wire [31:0] ImmOut,ALUIn1, ALUIn2;
// ALU:
wire [3:0] Control;
wire zero;
// MEMORY:
wire [31:0] ReadData;
wire [31:0] WriteData1;
// Branch
wire andOut;
wire [31:0] shiftOut;
wire [31:0] branchAdd,PCAddress;
//
PC_Counter PC1(clk,reset,PCin,PC); // PC 
Adder A1(PC,32'd4,PCPlus4);  // + 4;
Instruction_Mem InsMem(PC,Ins);
// Decode 
Controller Ctrl(Ins[6:0],ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch,jump,jSel,ALUOp);
// Register File:
RegisterFile RF(clk,Ins[19:15],Ins[24:20],Ins[11:7],WriteData,RegWrite,RD1,RD2);
// Sign Ex:
Sign_Extender SE(Ins[31:0],ImmOut);
// Mux:
MUX M1(RD2,ImmOut,ALUSrc,ALUIn2);
// ALU
ALUControl AC(ALUOp,Ins[30],Ins[14:12],Control); // Funct7: 7bit : nhưng khác biệt ở bit 30 thôi, funct3: 14->12
MUX M2(RD1,PC,jSel,ALUIn1);// jSel: 0=> lấy RD1, 1: lấy PC:  : jal x5,16 : x5 = PC+4; PC= PC + 16 : trong mã asm: thì bằng 8 nên sll 1 = *2 = 16
ALU A2(Control,ALUIn1,ALUIn2,ALUOut,zero); // Thực hiện ALU từ control
// MEMORY:
DataMemory DM(clk,MemWrite,MemRead,ALUOut,RD2,ReadData);
// Chọn Write Data vào Register File
MUX M3(ALUOut,ReadData,MemtoReg,WriteData1); //
MUX M4(WriteData1,PCPlus4,jump,WriteData);
and AN(andOut,Branch,zero);
shift S1(ImmOut,shiftOut);
Adder A3(PC,shiftOut,branchAdd);
MUX M5(PCPlus4,branchAdd,andOut,PCAddress);
MUX M6(PCAddress,ALUOut,jump,PCin);
endmodule

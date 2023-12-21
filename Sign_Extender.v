module Sign_Extender #(parameter Width =32)(
input [Width-1:0] In,
output reg [Width-1:0] Out );
always@(*)
begin
case(In[6:0])
7'b0000011 : Out <= {{{Width-12},{In[31]}},In[31:20]}; //I2: loadword: 12bit=> WIDTH-12 = bit dấu imm: [31:20]
7'b0100011 : Out <= {{{Width-12}{In[31]}},In[31:25],In[11:7]};// storeword: 12 bit: imm: [31:25] [11:7]
7'b1100011 : Out <= {{{Width-12}{In[31]}},In[31],In[7],In[30:25],In[11:8]}; // branch: imm: [31][7][30:25][11:8]
7'b0010011 : Out <= {{{Width-12}{In[31]}},In[31:20]};                       // I1: andi,ori,... :  imm : [31:20]
7'b1100111 : Out <= {{{Width-12}{In[31]}},In[31:20]};								 // jalr: 12 bit: [31:20
7'b1101111 : Out <= {{{Width-19}{In[31]}},In[31],In[19:12],In[20],In[30:21],1'b0}; // jal: [31][19:12][20][30:21]
default Out <= {Width{1'b0}};
endcase
end
endmodule



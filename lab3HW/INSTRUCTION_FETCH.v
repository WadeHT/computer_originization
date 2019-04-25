`timescale 1ns/1ps

module INSTRUCTION_FETCH(
	clk,
	rst,
	beq,
	bgt,
	zero,
	bne,	
	offset,
	jump,
	address,
	sign,
	DX_PC,
	FD_PC,
	
	PC,
	IR,
	bnoWB,
	jnoWB
);

input clk, rst,beq,bgt,jump,sign,zero,bne;
input [27:0]address;
input [31:0]offset,DX_PC,FD_PC;
output reg 	[31:0] PC, IR;
output reg  bnoWB,jnoWB;

//instruction memory
reg [31:0] instruction [127:0];

//output instruction
always @(posedge clk or posedge rst)
begin
	if(rst)
		IR <= 32'd0;
	else
		IR <= instruction[PC[10:2]];
end

// output program counter
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		PC <= 32'd0;
		bnoWB<=0;
		jnoWB<=0;
	end
	else
	begin
	
		if(beq & zero || bgt & sign || bne & !zero)
		begin
			PC<=DX_PC+offset;
			bnoWB<=1;
			jnoWB<=0;
		end
		else if(jump)
		begin
			PC<={FD_PC[31:28],address};
			bnoWB<=0;
			jnoWB<=1;
		end
		else
		begin
			PC<=PC+4;
			bnoWB<=0;
			jnoWB<=0;
		end
	end
	
end

endmodule
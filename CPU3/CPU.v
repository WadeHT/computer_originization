`timescale 1ns/1ps

`include "INSTRUCTION_FETCH.v"
`include "INSTRUCTION_DECODE.v"
`include "EXECUTION.v"
`include "MEMORY.v"

module CPU(
	clk,
	rst,
	en,
	/*****/
	number,
	ANS0,
	ANS1
	/****/
);
input clk, rst,en;
/*****/
input[31:0]number;
output[31:0] ANS0,ANS1;
/****/
/*============================== Wire  ==============================*/
// INSTRUCTION_FETCH wires
wire [31:0] PC, IR;
// INSTRUCTION_DECODE wires
wire [31:0] A, B;
wire [4:0] DX_RD,shamt;
wire [3:0] ALUctr;
// EXECUTION wires
wire [31:0] XM_ALUout;
wire [4:0] XM_RD;
// DATA_MEMORY wires
wire [31:0] MW_ALUout;
wire [4:0]	MW_RD;
// STORE??DST wires
wire [31:0] DX_RT,XM_RT;
// MemReg
wire MemToReg,XM_MemWrite,MemWrite;
//jump branch
wire jump, beq,zero,sign,DX_beq,DX_bgt,bgt,bne,DX_bme;
wire [27:0]address;
wire [31:0]offset,DX_PC,FD_PC,DX_offset;
wire jnoWB,bnoWB;
/*============================== INSTRUCTION_FETCH  ==============================*/

INSTRUCTION_FETCH IF(
	.clk(clk),
	.rst(rst),
	.beq(DX_beq),
	.bgt(DX_bgt),
	.bne(DX_bne),
	.zero(zero),
	.offset(offset),
	.jump(jump),
	.address(address),
	.DX_PC(DX_PC),
	.FD_PC(FD_PC),
	.sign(sign),
	.en(en),

	.PC(PC),
	.IR(IR),
	.jnoWB(jnoWB),
	.bnoWB(bnoWB)
);

/*============================== INSTRUCTION_DECODE ==============================*/

INSTRUCTION_DECODE ID(
	.clk(clk),
	.rst(rst),
	.PC(PC),
	.IR(IR),
	.MW_RD(MW_RD),
	.MW_ALUout(MW_ALUout),
	.bnoWB(bnoWB),
	.jnoWB(jnoWB),
	.en(en),
	/*********/
	.number(number),
	.ans0(ANS0),
	.ans1(ANS1),
	/*********/

	.A(A),
	.B(B),
	.RD(DX_RD),
	.ALUctr(ALUctr),
	.MemToReg(MemToReg),
	.DX_RT(DX_RT),
	.MemWrite(MemWrite),
	.beq(beq),
	.bgt(bgt),
	.bne(bne),
	.FD_PC(FD_PC),
	.offset(offset),
	.jump(jump),
	.address(address),
	.shamt(shamt)
);

/*==============================     EXECUTION  	==============================*/

EXECUTION EXE(
	.clk(clk),
	.rst(rst),
	.A(A),
	.B(B),
	.DX_RD(DX_RD),
	.ALUctr(ALUctr),
	.MemToReg(MemToReg),
	.DX_RT(DX_RT),
	.MemWrite(MemWrite),
	.beq(beq),
	.bgt(bgt),
	.bne(bne),
	.FD_PC(FD_PC),
	.offset(offset),
	.shamt(shamt),
	.bnoWB(bnoWB),
	.jnoWB(jnoWB),
	.en(en),


	.ALUout(XM_ALUout),
	.XM_RD(XM_RD),
	.XM_MemToReg(XM_MemToReg),
	.XM_RT(XM_RT),
	.XM_MemWrite(XM_MemWrite),
	.DX_beq(DX_beq),
	.DX_bgt(DX_bgt),
	.DX_bne(DX_bne),
	.zero(zero),
	.sign(sign),
	.DX_PC(DX_PC),
	.DX_offset(DX_offset)
);

/*==============================     DATA_MEMORY	==============================*/

MEMORY MEM(
	.clk(clk),
	.rst(rst),
	.ALUout(XM_ALUout),
	.XM_RD(XM_RD),
	.XM_MemToReg(XM_MemToReg),
	.XM_RT(XM_RT),
	.XM_MemWrite(XM_MemWrite),
	.bnoWB(bnoWB),
	.en(en),

	.MW_ALUout(MW_ALUout),
	.MW_RD(MW_RD)
);

endmodule

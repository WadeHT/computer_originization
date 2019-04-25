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
	en,
	
	PC,
	IR,
	bnoWB,
	jnoWB
);

input clk, rst,beq,bgt,jump,sign,zero,bne,en;
input [27:0]address;
input [31:0]offset,DX_PC,FD_PC;
output reg 	[31:0] PC, IR;
output reg  bnoWB,jnoWB;

//instruction memory
reg [31:0] instruction [127:0];
/*****************/
always @(posedge rst)begin
                 instruction[ 0] <= {6'd8,5'd2,5'd16,16'd0};
                 instruction[ 1] <= {32'd0};
                 instruction[ 2] <= {32'd0};
                 instruction[ 3] <= {32'd0};
                 instruction[ 4] <= {6'd8,5'd16,5'd17,16'd1};
                 instruction[ 5] <= {32'd0};
                 instruction[ 6] <= {32'd0};
                 instruction[ 7] <= {32'd0};
                 
                 instruction[ 8] <= {6'd8,5'd17,5'd4,16'd0};
                 instruction[ 9] <= {32'd0};
                 instruction[10] <= {32'd0};
                 instruction[11 ]<= {32'd0};
                 instruction[12 ] <= {6'd2,26'd56};
                 instruction[13 ] <= {32'd0};
                 instruction[14 ] <= {32'd0};
                 instruction[15 ] <= {32'd0};
                 instruction[16 ] <= {6'd5,5'd2,5'd0,16'd11};
                 instruction[17 ] <= {32'd0};
                 instruction[18 ] <= {32'd0};
                 instruction[19 ] <= {32'd0};
                 instruction[20] <= {6'd8,5'd17,5'd17,16'd1};
                 instruction[21] <= {32'd0};
                 instruction[ 22]<= {32'd0};
                 instruction[ 23]<= {32'd0};
                 instruction[ 24] <= {6'd2,26'd8};
                 instruction[ 25] <= {32'd0};
                 instruction[ 26] <= {32'd0};
                 instruction[ 27] <= {32'd0};
                 
                 instruction[ 28] <= {6'd8,5'd17,5'd18,16'd0};
                 instruction[ 29] <= {32'd0};
                 instruction[ 30] <= {32'd0};
                 instruction[ 31] <= {32'd0};
                 instruction[ 32] <= {6'd8,5'd16,5'd17,16'hffff};
                 instruction[ 33] <= {32'd0};
                 instruction[ 34] <= {32'd0};
                 instruction[ 35] <= {32'd0};
                 
                 instruction[ 36] <= {6'd8,5'd17,5'd4,16'd0};
                 instruction[ 37] <= {6'd8,5'd0,5'd31,16'd1};
                 instruction[ 38] <= {32'd0};
                 instruction[ 39] <= {32'd0};
                 instruction[ 40] <= {6'd2,26'd56};
                 instruction[ 41] <= {32'd0};
                 instruction[ 42] <= {32'd0};
                 instruction[ 43] <= {32'd0};
                 instruction[ 44] <= {6'd5,5'd2,5'd0,16'd56};
                 instruction[ 45] <= {32'd0};
                 instruction[ 46] <= {32'd0};
                 instruction[ 47] <= {32'd0};
                 instruction[ 48] <= {6'd8,5'd17,5'd17,16'hffff};
                 instruction[ 49] <= {32'd0};
                 instruction[50 ] <= {32'd0};
                 instruction[ 51] <= {32'd0};
                 instruction[ 52] <= {6'd2,26'd36};
                 instruction[ 53] <= {32'd0};
                 instruction[ 54] <= {32'd0};
                 instruction[ 55] <= {32'd0};
                 
                 instruction[ 56] <= {6'd8,5'd0,5'd8,16'd2};
                 instruction[ 57] <= {32'd0};
                 instruction[ 58] <= {32'd0};
                 instruction[ 59] <= {32'd0};
                 
                 instruction[60 ] <= {6'd0,5'd8,5'd8,5'd9,5'd0,6'd24};
                 instruction[ 61] <= {32'd0};
                 instruction[ 62] <= {32'd0};
                 instruction[ 63] <= {32'd0};
                 instruction[ 64] <= {6'd7,5'd9,5'd4,16'd28};
                 instruction[ 65] <= {32'd0};
                 instruction[ 66] <= {32'd0};
                 instruction[ 67] <= {32'd0};
                 instruction[ 68] <= {6'd0,5'd4,5'd8,5'd9,5'd0,6'd26};
                 instruction[ 69] <= {32'd0};
                 instruction[ 70] <= {32'd0};
                 instruction[ 71] <= {32'd0};
                 instruction[ 72] <= {6'd0,5'd9,5'd8,5'd9,5'd0,6'd24};
                 instruction[ 73] <= {32'd0};
                 instruction[ 74] <= {32'd0};
                 instruction[ 75] <= {32'd0};
                 instruction[ 76] <= {6'd5,5'd4,5'd9,16'd8};
                 instruction[ 77] <= {32'd0};
                 instruction[ 78] <= {32'd0};
                 instruction[ 79] <= {32'd0};
                 instruction[ 80] <= {6'd8,5'd0,5'd2,16'd0};
                 instruction[ 81] <= {32'd0};
                 instruction[ 82] <= {32'd0};
                 instruction[ 83] <= {6'd5,5'd31,5'd0,16'hffd8};
                 instruction[ 84] <= {6'd2,26'd16};
                
                 instruction[ 85] <= {6'd8,5'd8,5'd8,16'd1};
                 instruction[ 86] <= {32'd0};
                 instruction[ 87] <= {32'd0};
                 instruction[ 88] <= {32'd0};
                 instruction[ 89] <= {6'd2,26'd60};
                 instruction[ 90] <= {32'd0};
                 instruction[ 91] <= {32'd0};
                 instruction[ 92] <= {32'd0};
                
                 instruction[ 93] <= {6'd8,5'd0,5'd2,16'd1};
                 instruction[ 94] <= {32'd0};
                 instruction[ 95] <= {32'd0};
                 instruction[ 96] <= {32'd0};
                 instruction[ 97] <= {6'd5,5'd31,5'd0,16'hffca};
                 instruction[ 98] <= {6'd2,26'd16};
                 instruction[ 99] <= {32'd0};
                 instruction[100] <= {32'd0};
                 instruction[101] <= {32'd0};
                 instruction[102] <= {6'd8,5'd17,5'd19,16'd0};
                 instruction[103] <= {32'd0};
                 instruction[104] <= {32'd0};
                 instruction[105] <= {32'd0};
                 
                 instruction[106] = {6'd2,26'd103};
                 instruction[107] = {32'd0};
                 instruction[108] = {32'd0};
                 instruction[109] = {32'd0};
                
end
/****************/
//output instruction
always @(posedge clk or posedge rst)
begin
	if(rst)
		IR <= 32'd0;
	else if(en)/**/
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
	else if(en)/**/
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
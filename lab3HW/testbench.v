`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 3000
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
		
		#20;
		cpu.IF.instruction[ 0] = {6'd8,5'd2,5'd16,16'd0};
		cpu.IF.instruction[ 1] = {32'd0};
		cpu.IF.instruction[ 2] = {32'd0};
		cpu.IF.instruction[ 3] = {32'd0};
		cpu.IF.instruction[ 4] = {6'd8,5'd16,5'd17,16'd1};
		cpu.IF.instruction[ 5] = {32'd0};
		cpu.IF.instruction[ 6] = {32'd0};
		cpu.IF.instruction[ 7] = {32'd0};
		//while0
		cpu.IF.instruction[ 8] = {6'd8,5'd17,5'd4,16'd0};
		cpu.IF.instruction[ 9] = {32'd0};
		cpu.IF.instruction[10] = {32'd0};
		cpu.IF.instruction[11 ] = {32'd0};
		cpu.IF.instruction[12 ] = {6'd2,26'd56};
		cpu.IF.instruction[13 ] = {32'd0};
		cpu.IF.instruction[14 ] = {32'd0};
		cpu.IF.instruction[15 ] = {32'd0};
		cpu.IF.instruction[16 ] = {6'd5,5'd2,5'd0,16'd11};
		cpu.IF.instruction[17 ] = {32'd0};
		cpu.IF.instruction[18 ] = {32'd0};
		cpu.IF.instruction[19 ] = {32'd0};
		cpu.IF.instruction[20] = {6'd8,5'd17,5'd17,16'd1};
		cpu.IF.instruction[21] = {32'd0};
		cpu.IF.instruction[ 22] = {32'd0};
		cpu.IF.instruction[ 23]= {32'd0};
		cpu.IF.instruction[ 24] = {6'd2,26'd8};
		cpu.IF.instruction[ 25] = {32'd0};
		cpu.IF.instruction[ 26] = {32'd0};
		cpu.IF.instruction[ 27] = {32'd0};
		//Exit0
		cpu.IF.instruction[ 28] = {6'd8,5'd17,5'd18,16'd0};
		cpu.IF.instruction[ 29] = {32'd0};
		cpu.IF.instruction[ 30] = {32'd0};
		cpu.IF.instruction[ 31] = {32'd0};
		cpu.IF.instruction[ 32] = {6'd8,5'd16,5'd17,16'hffff};
		cpu.IF.instruction[ 33] = {32'd0};
		cpu.IF.instruction[ 34] = {32'd0};
		cpu.IF.instruction[ 35] = {32'd0};
		//while1
		cpu.IF.instruction[ 36] = {6'd8,5'd17,5'd4,16'd0};
		cpu.IF.instruction[ 37] = {6'd8,5'd0,5'd31,16'd1};
		cpu.IF.instruction[ 38] = {32'd0};
		cpu.IF.instruction[ 39] = {32'd0};
		cpu.IF.instruction[ 40] = {6'd2,26'd56};
		cpu.IF.instruction[ 41] = {32'd0};
		cpu.IF.instruction[ 42] = {32'd0};
		cpu.IF.instruction[ 43] = {32'd0};
		cpu.IF.instruction[ 44] = {6'd5,5'd2,5'd0,16'd56};
		cpu.IF.instruction[ 45] = {32'd0};
		cpu.IF.instruction[ 46] = {32'd0};
		cpu.IF.instruction[ 47] = {32'd0};
		cpu.IF.instruction[ 48] = {6'd8,5'd17,5'd17,16'hffff};
		cpu.IF.instruction[ 49] = {32'd0};
		cpu.IF.instruction[50 ] = {32'd0};
		cpu.IF.instruction[ 51] = {32'd0};
		cpu.IF.instruction[ 52] = {6'd2,26'd36};
		cpu.IF.instruction[ 53] = {32'd0};
		cpu.IF.instruction[ 54] = {32'd0};
		cpu.IF.instruction[ 55] = {32'd0};
		//checkPrime
		cpu.IF.instruction[ 56] = {6'd8,5'd0,5'd8,16'd2};
		cpu.IF.instruction[ 57] = {32'd0};
		cpu.IF.instruction[ 58] = {32'd0};
		cpu.IF.instruction[ 59] = {32'd0};
		//while0_cP
		cpu.IF.instruction[60 ] = {6'd0,5'd8,5'd8,5'd9,5'd0,6'd24};
		cpu.IF.instruction[ 61] = {32'd0};
		cpu.IF.instruction[ 62] = {32'd0};
		cpu.IF.instruction[ 63] = {32'd0};
		cpu.IF.instruction[ 64] = {6'd7,5'd9,5'd4,16'd28};
		cpu.IF.instruction[ 65] = {32'd0};
		cpu.IF.instruction[ 66] = {32'd0};
		cpu.IF.instruction[ 67] = {32'd0};
		cpu.IF.instruction[ 68] = {6'd0,5'd4,5'd8,5'd9,5'd0,6'd26};
		cpu.IF.instruction[ 69] = {32'd0};
		cpu.IF.instruction[ 70] = {32'd0};
		cpu.IF.instruction[ 71] = {32'd0};
		cpu.IF.instruction[ 72] = {6'd0,5'd9,5'd8,5'd9,5'd0,6'd24};
		cpu.IF.instruction[ 73] = {32'd0};
		cpu.IF.instruction[ 74] = {32'd0};
		cpu.IF.instruction[ 75] = {32'd0};
		cpu.IF.instruction[ 76] = {6'd5,5'd4,5'd9,16'd8};
		cpu.IF.instruction[ 77] = {32'd0};
		cpu.IF.instruction[ 78] = {32'd0};
		cpu.IF.instruction[ 79] = {32'd0};
		cpu.IF.instruction[ 80] = {6'd8,5'd0,5'd2,16'd0};
		cpu.IF.instruction[ 81] = {32'd0};
		cpu.IF.instruction[ 82] = {32'd0};
		cpu.IF.instruction[ 83] = {6'd5,5'd31,5'd0,16'hffd8};
		cpu.IF.instruction[ 84] = {6'd2,26'd16};
		//Else0_cP0
		cpu.IF.instruction[ 85] = {6'd8,5'd8,5'd8,16'd1};
		cpu.IF.instruction[ 86] = {32'd0};
		cpu.IF.instruction[ 87] = {32'd0};
		cpu.IF.instruction[ 88] = {32'd0};
		cpu.IF.instruction[ 89] = {6'd2,26'd60};
		cpu.IF.instruction[ 90] = {32'd0};
		cpu.IF.instruction[ 91] = {32'd0};
		cpu.IF.instruction[ 92] = {32'd0};
		//Exit0_cP
		cpu.IF.instruction[ 93] = {6'd8,5'd0,5'd2,16'd1};
		cpu.IF.instruction[ 94] = {32'd0};
		cpu.IF.instruction[ 95] = {32'd0};
		cpu.IF.instruction[ 96] = {32'd0};
		cpu.IF.instruction[ 97] = {6'd5,5'd31,5'd0,16'hffca};
		cpu.IF.instruction[ 98] = {6'd2,26'd16};
		cpu.IF.instruction[ 99] = {32'd0};
		cpu.IF.instruction[100] = {32'd0};
		cpu.IF.instruction[101] = {32'd0};
		cpu.IF.instruction[102] = {6'd8,5'd17,5'd19,16'd0};
		cpu.IF.instruction[103] = {32'd0};
		cpu.IF.instruction[104] = {32'd0};
		cpu.IF.instruction[105] = {32'd0};
		//Exit1
		cpu.IF.PC = 0;
		
		//ANS IN R18 R19
		//if there is so much useless turn may make ANS wrong unless after instructurn[105] have be defined
		//1024 around 2600 runs 137 around 1300 runs 1976 around 3000 runs the accurately number have be tried by TA 
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd9;
	cpu.MEM.DM[1] = 32'd3;
	for (i=2; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0;
	cpu.ID.REG[1] = 32'd0;
	cpu.ID.REG[2] = 32'd1976;//INPUT NUMBER
	for (i=3; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;

end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	/*
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
	*/
	$display("  PC:%d   cycles:%d", cpu.PC>>2 , cycles);
	$display("  R00-R07: %10d %10d %10d %10d %10d %10d %10d %10d", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %10d %10d %10d %10d %10d %10d %10d %10d", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %10d %10d %10d %10d %10d %10d %10d %10d", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %10d %10d %10d %10d %10d %10d %10d %10d", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %10d %10d %10d %10d %10d %10d %10d %10d", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %10d %10d %10d %10d %10d %10d %10d %10d\n\n", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule


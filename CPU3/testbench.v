`define CYCLE_TIME 20
`timescale 1ns/1ps
`include "top.v"
module testbench;
reg clk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,sw10,sw11,sw12,sw13,sw14;
wire a,b,c,d,e,f,g,dp,d0,d1,d2,d3,d4,d5,d6,d7;
top cpu(clk,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,sw10,sw11,sw12,sw13,sw14,a,b,c,d,e,f,g,dp,d0,d1,d2,d3,d4,d5,d6,d7);
initial begin
	$dumpfile("CPU.vcd");
	$dumpvars;
	clk<=0;
	sw14<=1;sw13<=0;sw12<=0;sw11<=0;sw10<=0;sw9<=0;sw8<=0;sw7<=0;sw6<=0;sw5<=0;sw4<=0;sw3<=0;sw2<=0;sw1<=0;sw0<=0;
	#20;
	sw14<=0;
	#20;
	sw10<=1;
	#20;
	sw13<=1;

	#600000;
	sw14<=1;sw13<=0;sw12<=0;sw11<=0;sw10<=0;sw9<=0;sw8<=0;sw7<=0;sw6<=0;sw5<=0;sw4<=0;sw3<=0;sw2<=0;sw1<=0;sw0<=0;
	#20
	sw14<=0;
	#20;
	sw0<=1;sw3<=1;sw7<=1;
	#20;
	sw13<=1;
	
	#600000 $finish;
end
reg [6:0]num;
reg [7:0]scan;
always#10 clk=~clk;
always#500 begin 
	num={g,f,e,d,c,b,a};
	scan={d7,d6,d5,d4,d3,d2,d1,d0};/*
	case(num)
	7'b100_0000:$display("0");
	7'b111_1001:$display("1");
	7'b010_0100:$display("2");
	7'b011_0000:$display("3");
	7'b001_1001:$display("4");
	7'b000_0000:$display("5");
	7'b000_0010:$display("6");
	7'b101_1000:$display("7");
	7'b000_0000:$display("8");
	7'b001_0000:$display("9");
	endcase
	case(scan)
	8'b1111_1110:$display("0*");
	8'b1111_1101:$display("1*");
	8'b1111_1011:$display("2*");
	8'b1111_0111:$display("3*");
	8'b1110_1111:$display("4*");
	8'b1101_1111:$display("5*");
	8'b1011_1111:$display("6*");
	8'b0111_1111:$display("7*");
	endcase*/
end
endmodule
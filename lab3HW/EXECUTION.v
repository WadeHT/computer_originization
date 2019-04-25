`timescale 1ns/1ps

module EXECUTION(
	clk,
	rst,
	A,
	B,
	DX_RD,
	shamt,
	ALUctr,
	MemToReg,
	DX_RT,
	MemWrite,
	FD_PC,
	beq,
	offset,
	bgt,
	bne,
	bnoWB,
	jnoWB,
	
	ALUout,
	XM_RD,
	XM_MemToReg,
	XM_RT,
	XM_MemWrite,
	DX_PC,
	zero,
	sign,
	DX_beq,
	DX_offset,
	DX_bgt,
	DX_bne
);

input clk,rst,ALUop,beq,bgt,bne,bnoWB,jnoWB;
input [31:0] A,B,DX_RT,FD_PC,offset;
input [4:0]DX_RD,shamt;
input [3:0] ALUctr;
input MemToReg,MemWrite;
output reg [31:0]ALUout,XM_RT,DX_PC,DX_offset;
output reg [4:0]XM_RD;
output reg XM_MemToReg,XM_MemWrite,zero,sign,DX_beq,DX_bgt,DX_bne;

//set pipeline register
always @(posedge clk or posedge rst)
begin
  if(rst)
    begin
	  XM_RD	<= 5'd0;
	end 
  else 
	begin
	//$display("%4d %4d %4d %4d %4d %4d %4d %4d %4d %4d\n",beq,bgt,bnoWB,jnoWB,A,B,DX_RT,FD_PC,offset,DX_RD);
	  XM_RD <=(jnoWB|bnoWB)?5'd0:DX_RD;	 
	  XM_MemToReg<=MemToReg;
	  XM_RT <=DX_RT;
	  XM_MemWrite<=MemWrite;
	  DX_PC<=FD_PC;
	  DX_beq<=beq;
	  DX_bgt<=bgt;
	  DX_offset<=offset;
	  DX_bne<=bne;	
	end
end

// calculating ALUout
always @(posedge clk or posedge rst)
begin
  if(rst)
    begin
	  ALUout	<= 32'd0;
	  zero		<=0;
	  sign		<=0;
	end 
  else 
	begin
	  case(ALUctr)
	    4'd0: //add //lw //sw
		  begin
	        ALUout <=A+B;
		  end
		4'd1: //sub
		  begin
			ALUout<=A-B;
			zero<=(A-B)?0:1;
			sign<=(A>B)?1:0;
		  end
		4'd2: //slt
		  begin
			ALUout<=(A<B)?1:0;
		  end
		4'd3://mul
		  begin
			ALUout<=A*B;
		  end
		4'd4://div
		  begin
			ALUout<=A/B;
		  end
		4'd5://and
		  begin
			ALUout<=A&B;
		  end
		4'd6://or
		  begin
			ALUout<=A|B;
		  end
		4'd7://xor
		  begin
			ALUout<=A^B;
		  end
		4'd8://nor
		  begin
			ALUout<=~(A|B);
		  end
		4'd9://shift left
		  begin
			Left_shift(shamt,B,ALUout);
			
		  end
		4'd10://shift right
		  begin
			Right_shift(shamt,B,ALUout);
		  end
		4'd11://shift right arithmetic
		  begin
			Right_shift_arithmetic(shamt,B,ALUout);
		  end
	  endcase
	end
end

task Left_shift;
input[4:0]shamt;
input[31:0]B;
output[31:0]ALUout;
reg[31:0]t0,t1,t2,t3;
begin
t0=(shamt[0])? B<<1:B;
t1=(shamt[1])? t0<<2:t0;
t2=(shamt[2])? t1<<3:t1;
t3=(shamt[3])? t2<<8:t2;
ALUout=(shamt[4])? t3<<16:t3;
end
endtask

task Right_shift;
input[4:0]shamt;
input[31:0]B;
output[31:0]ALUout;
reg[31:0]t0,t1,t2,t3;
begin
t0=(shamt[0])? B>>1:B;
t1=(shamt[1])? t0>>2:t0;
t2=(shamt[2])? t1>>3:t1;
t3=(shamt[3])? t2>>8:t2;
ALUout=(shamt[4])? t3>>16:t3;
end
endtask

task Right_shift_arithmetic;
input[4:0]shamt;
input[31:0]B;
output[31:0]ALUout;
reg[31:0]t0,t1,t2,t3;
begin
t0=(shamt[0])? B>>>1:B;
t1=(shamt[1])? t0>>>2:t0;
t2=(shamt[2])? t1>>>3:t1;
t3=(shamt[3])? t2>>>8:t2;
ALUout=(shamt[4])? t3>>>16:t3;
end
endtask

endmodule
	

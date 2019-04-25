`timescale 1ns/1ps

module INSTRUCTION_DECODE(
	clk,
	rst,
	IR,
	PC,
	MW_RD,
	MW_ALUout,
	jnoWB,
	bnoWB,
	XM_RD,
	
	A,
	B,
	RD,
	ALUctr,
	MemToReg,
	DX_RT,
	MemWrite,
	FD_PC,
	jump,
	address,
	offset,
	beq,
	shamt,
	bgt,
	bne
);

input clk,rst,jnoWB,bnoWB;
input [31:0]IR, PC, MW_ALUout;
input [4:0] MW_RD,XM_RD;

output reg [31:0] A, B, DX_RT,FD_PC,offset;
output reg [27:0]address;
output reg [4:0] RD,shamt;
output reg [3:0] ALUctr;
output reg MemToReg,MemWrite,jump,beq,bgt,bne;

//register file
reg [31:0] REG [0:31];

//Write back
always @(posedge clk)//add new Dst REG source here
	if(MW_RD)
	  REG[MW_RD] <= MW_ALUout;
	else
	  REG[MW_RD] <= REG[MW_RD];//keep REG[0] always equal zero

//set A, and other register content(j/beq flag and address)	
always @(posedge clk or posedge rst)
begin
	if(rst) 
	  begin
	    A 	<=32'b0;
	  end 
	else 
	  begin
	    A 	 <=REG[IR[25:21]];
		DX_RT<=REG[IR[20:16]];
		FD_PC<=PC;
		shamt<=IR[10:6];
	  end
end

//set control signal, choose Dst REG, and set B	
always @(posedge clk or posedge rst)
begin
	if(rst) 
	  begin
		A		<=32'b0;
		B 		<=32'b0;
		RD 		<=5'b0;
		ALUctr 	<=4'b0;
		MemToReg<=1'b0;
		shamt	<=4'b0;
		DX_RT	<=32'b0;
		MemWrite<=1'b0;
		jump	<=1'b0;
		beq		<=1'b0;
		offset	<=0;
		bgt		<=1'b0;
		bne		<=0;
	  end 
	else 
	  begin
	  //$display("\n***op= %d***\n",IR[31:26]);
	    case(IR[31:26])
		  6'd0://R-Type
		    begin
			  case(IR[5:0])//funct & setting ALUctr
			    6'd32://add
				  begin
		            B	<=REG[IR[20:16]];
		            RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd0;//self define ALUctr value
					MemToReg<=0;
					MemWrite<=0;
				    jump <=1'b0;
					beq<=1'b0;
					bgt<=0;
					bne<=0;
				  end
				6'd34://sub
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd1;//self define ALUctr value
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd42://slt
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd2;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bne<=0;
					bgt<=0;
				  end
				6'd24://mul
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd3;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd26://div
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd4;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bne<=0;
					bgt<=0;
				  end
				6'd36://and
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd5;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bne<=0;
					bgt<=0;
				  end
				6'd37://or
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd6;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd38://xor
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd7;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd39://nor
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd8;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					bgt<=0;
					bne<=0;
				  end
				6'd0://shift left logic
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd9;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd2://shift right logic
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd10;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
				6'd24://shift right arithmetic
				  begin
					B	<=REG[IR[20:16]];
					RD	<=(jnoWB|bnoWB)?5'd0:IR[15:11];
					ALUctr <=4'd11;
					MemToReg<=0;
					MemWrite<=0;
					jump <=1'b0;
					beq<=0;
					bgt<=0;
					bne<=0;
				  end
			  endcase
			end
	      6'd35://lw
			begin
			  MemToReg<=1;
			  RD	<=(jnoWB|bnoWB)?5'd0:IR[20:16];
			  B		<=IR[15]? {16'b1111_1111_1111_1111,IR[15:0]}:{16'd0,IR[15:0]};
			  ALUctr<=4'd0;
			  MemWrite<=0;
			  jump <=1'b0;
			  beq<=0;
			  bgt<=0;
			  bne<=0;
			end
	      6'd43://sw
			begin
			  RD	<=5'd0;
			  B		<=IR[15]? {16'b1111_1111_1111_1111,IR[15:0]}:{16'd0,IR[15:0]};
			  ALUctr<=4'd0;
			  MemToReg<=0;
			  MemWrite<=1;
			  jump <=1'b0;
			  beq<=0;
			  bgt<=0;
			  bne<=0;
			end
	      6'd4://beq
			begin
			  B		<=REG[IR[20:16]];
			  MemToReg<=0;
			  MemWrite<=0;
			  ALUctr<=4'd1;
			  jump <=1'b0;
			  beq<=1;
			  offset<=(IR[15])?{14'b11_1111_1111_1111,IR[15:0],2'd0}:{14'd0,IR[15:0],2'd0};
			  bgt<=0;
			  bne<=0;
			  RD<=0;
			end
	      6'd2://j
			begin
			  jump <= 1'b1;
			  address<={IR[25:0],2'd0};
			  MemToReg<=0;
			  MemWrite<=0;
			  beq<=0;
			  bgt<=0;
			  RD<=0;
			  bne<=0;
			end
		  6'd8://addi
		    begin
			  B	<=  (IR[15])?{16'b1111_1111_1111_1111,IR[15:0]}:{16'd0,IR[15:0]};
			  RD<=(jnoWB|bnoWB)?5'd0:IR[20:16];
			  ALUctr <=4'd0;
			  MemToReg<=0;
			  MemWrite<=0;
			  jump <=1'b0;
			  beq<=0;
			  bgt<=0;
			  bne<=0;
			end
		  6'd7://bgt
		    begin
			  B		<=REG[IR[20:16]];
			  MemToReg<=0;
			  MemWrite<=0;
			  ALUctr<=4'd1;
			  jump <=1'b0;
			  bgt<=1;
			  beq<=0;
			  bne<=0;
			  RD<=0;
			  offset<=(IR[15])?{14'b11_1111_1111_1111,IR[15:0],2'd0}:{14'd0,IR[15:0],2'd0};
			end
		  6'd5://bne
		    begin
			  B		<=REG[IR[20:16]];
			  MemToReg<=0;
			  MemWrite<=0;
			  ALUctr<=4'd1;
			  jump <=1'b0;
			  bgt<=0;
			  beq<=0;
			  bne<=1;
			  RD<=0;
			  offset<=(IR[15])?{14'b11_1111_1111_1111,IR[15:0],2'd0}:{14'd0,IR[15:0],2'd0};
			end
		endcase
	  end
	  //$display("\n+++++++++++++++%x\n",MemToReg);
end
endmodule

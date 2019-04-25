`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 3000
`timescale 1ns/1ps
`include "CPU.v"

module top(
    input clk, 
    input sw0,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    input sw7,
    input sw8,
	input sw9,
    input sw10,
    input sw11,
    input sw12,
    input sw13,
    input sw14,

    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp,
    output d0,
    output d1,
    output d2,
    output d3,
    output d4,
    output d5,
    output d6,
    output d7 
    );
 wire [31:0] ANS0,ANS1;
 reg [31:0]ans0,ans1;
 reg[7:0] scan;
 reg[2:0] state;
 reg [6:0] seg_number,seg_data;
 reg[31:0]number;
 reg [17:0]counter,cycle;
 reg rst,en; 
 CPU t(.clk(clk), .rst(rst), .en(en), .number(number), .ANS0(ANS0), .ANS1(ANS1));
 /***************/
 always@(posedge clk)$display("%d %d %d",number,ans0,ans1);
 /***************/
 always@(posedge clk)begin
    number<={19'd0,sw12,sw11,sw10,sw9,sw8,sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0};
    rst<=sw14;
    en<=sw13;
    if(sw14)begin
    ans0<=0;
    ans1<=0;
	/*******/counter<=0;state<=0;
    end
    else if(sw13) begin
    ans0<=ANS0;
    ans1<=ANS1;
    end
 end
 assign {d7,d6,d5,d4,d3,d2,d1,d0} = scan;
assign dp = ((state==7) || (state==3)) ? 0 : 1;
 always@(posedge clk) begin
  counter <=(counter<=3000) ? (counter +1) : 0;
   state <= (counter==3000) ? (state + 1) : state;
    case(state)
     0:begin
       seg_number <=ans0/1000%10;
       scan <= 8'b0111_1111;
     end
     1:begin
       seg_number <=ans0/100%10;
       scan <= 8'b1011_1111;
     end
     2:begin
       seg_number <= ans0/10%10;
       scan <= 8'b1101_1111;
     end
     3:begin
       seg_number <= ans0%10;
       scan <= 8'b1110_1111;
     end
     4:begin
       seg_number <=ans1/1000%10;
       scan <= 8'b1111_0111;
     end
     5:begin
       seg_number <= ans1/100%10;
       scan <= 8'b1111_1011;
     end
     6:begin
       seg_number <= ans1/10%10;
       scan <= 8'b1111_1101;
     end
     7:begin
       seg_number <= ans1%10;
       scan <= 8'b1111_1110;
     end
     default: state <= state;
   endcase  
 end  
 
 //7-segment ¿é¥X¼Æ¦r¸Ñ½X
 assign {g,f,e,d,c,b,a} = seg_data;
 always@(posedge clk) begin  
   case(seg_number)
     16'd0:seg_data <= 7'b100_0000;
     16'd1:seg_data <= 7'b111_1001;
     16'd2:seg_data <= 7'b010_0100;
     16'd3:seg_data <= 7'b011_0000;
     16'd4:seg_data <= 7'b001_1001;
     16'd5:seg_data <= 7'b001_0010;
     16'd6:seg_data <= 7'b000_0010;
     16'd7:seg_data <= 7'b101_1000;
     16'd8:seg_data <= 7'b000_0000;
     16'd9:seg_data <= 7'b001_0000;
     default: seg_number <= seg_number;
   endcase
 end 
endmodule
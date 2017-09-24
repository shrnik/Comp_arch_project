`timescale 1ns/10ps
module mul_4x4(out,a,b,clk);
input [3:0]a,b;
output reg [7:0]out;

input clk;
reg [3:0]temp;
reg [7:0]x1;

integer i,j;
initial x1 <= 8'b00000000;
initial out <=8'b00000000;

always @(posedge clk)
begin
	/* for(i=0;i<=3;i=i+1)
		begin
			x1=8'b00000000;
			if(b[i]==1) temp = a;
			else temp = 4'b0000;
			x1[i+3:i]=temp[3:0];
			out = out+x1;
		end */	
		out =8'b00000000;
		x1=8'b00000000;
			if(b[0]==1) temp = a;
			else temp = 4'b0000;
			x1[3:0]=temp[3:0];
			out = out+x1;
		
		x1=8'b00000000;
			if(b[1]==1) temp = a;
			else temp = 4'b0000;
			x1[4:1]=temp[3:0];
			out = out+x1;
			
			x1=8'b00000000;
			if(b[2]==1) temp = a;
			else temp = 4'b0000;
			x1[5:2]=temp[3:0];
			out = out+x1;
			
			x1=8'b00000000;
			if(b[3]==1) temp = a;
			else temp = 4'b0000;
			x1[6:3]=temp[3:0];
			out = out+x1;
	
end
endmodule

module tb_mul_4x4();

wire [7:0]out;
reg [3:0]a,b;

reg clk;

mul_4x4 uut(out,a,b,clk);

initial  
  begin  
  #0 clk = 1'b0 ; 
  forever #25 clk = ~clk ;
  end
  
initial #00 a=4'b1100;
initial #00 b=4'b0011;

initial #60 a=4'b1111;
initial #60 b=4'b1111;

initial $monitor("t=%3d, out=%8b, a=%4b, b=%4b, clk=%b",$time,out,a,b,clk);
initial #2500 $stop;

endmodule 
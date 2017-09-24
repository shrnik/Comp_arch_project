`timescale 1ns/10ps
module BCD_XS3(out,temp,y,clk);
output reg [3:0]out;
input y,clk;
output reg [3:0]temp;
reg[3:0] BCD[0:9];
reg[3:0] XS3[0:9];

initial $readmemb("BCD.txt",BCD);
initial $readmemb("XS3.txt",XS3);

integer i;
initial i=0;
integer j;
always @(posedge clk)
begin
	if(i==4)
	begin
		j=0;
		for(j=0;j<=9;j=j+1) begin
			if (temp==XS3[j])
			begin
				out = BCD[j];
			end
		end
	i=0;
	end
	
	temp[i]=y;
	i=i+1;
end

endmodule

module tb_x_to_b();

wire [3:0]out,temp;
reg y,clk;
BCD_XS3 uut(out,temp,y,clk);

initial  
  begin  
  #0 clk = 1'b0 ; 
  forever #25 clk = ~clk ;
  end
/* initial #00 y = 0; */
initial forever #1 y = $random %2 ;
initial $monitor("t=%3d, out=%4b,temp=%4b, y=%b, clk=%b",$time,out,temp,y,clk);
initial #2000 $stop;

endmodule 
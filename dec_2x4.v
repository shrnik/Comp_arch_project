`timescale 1ns/10ps
module dec(out,in);
input [1:0]in;
output [3:0]out;

assign out = (in==2'b00)?4'b00_01:
			 (in==2'b01)?4'b00_10:
			 (in==2'b10)?4'bx:			  
			 (in==2'b11)?4'b1000:4'b00_00;
endmodule

module tb_dec();
wire [3:0]out;
reg [1:0]in;

dec dec1(out,in);

initial #00 in=2'b00;
initial #20 in=2'b10;
initial #40 in=2'b11;

initial $monitor("t=%3d, out=%4b, in=%2b",$time,out,in);
initial #250 $stop;

endmodule 			 
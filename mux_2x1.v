`timescale 1ns/10ps
module mux_2x1(out,a,b,s);
output [p:0]out;
input [p:0]a,b;
parameter p = 7;
input s;

assign out=s?a:b;

endmodule

module tb_mux_2x1();
wire [p:0]out;
reg [p:0]a,b;
parameter p = 7;
reg s; 

mux_2x1 uut(out,a,b,s);

initial $monitor("t=%3d, out=%8b, a=%9b, b=%9b,s=%1b",$time,out,a,b,s);

initial
  begin
 #00 a = 9'b000000000; b = 9'b000000001; s= 0;
 #100 a = 9'b000000000; b = 9'b000000001; s= 1;
 #100 a = 9'b000000011; b = 9'b000000001; s= 0;
 #100 a = 9'b000000001; b = 9'b000000011; s= 0;
 end
 initial #650 $stop;
 endmodule 
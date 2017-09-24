`timescale 1ns/10ps
module aaa(out,ip,clk);
input clk;
input [7:0]ip;
output reg [7:0]out;
always @(*)
begin
out[5:0] <= ip[6:1];
end
endmodule

module tb();
wire [7:0]out;
reg [7:0]ip;
reg clk;

aaa uut(out,ip,clk);

initial $monitor("t=%3d, out0=%7b, out7=%b, clk=%b",$time,out[6:0],out[7],clk);

initial  
  begin  
  #0 clk = 1'b0 ; 
  forever #25 clk = ~clk ;
  end
  
 initial #0 ip = 8'b11010001; 
  
  initial #200 $stop;

endmodule 
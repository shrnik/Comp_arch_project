`timescale 1ns/10ps
`include "full_adder.v"
module rca_nbit(cout,sum,a,b,cin);
input cin;
input [n-1:0]a,b;
output [n-1:0]sum;
output cout;
wire [n-1:1]c;
parameter n = 8;
full_adder faone(c[1],sum[0],a[0],b[0],cin);
full_adder fan(cout,sum[n-1],a[n-1],b[n-1],c[n-1]);
generate
genvar i;
   for (i=1; i<=n-2; i=i+1) begin: faloop
	full_adder fai(c[i+1],sum[i],a[i],b[i],c[i]);
   end
endgenerate
endmodule

module tb_rca_nbit();  
parameter n = 8; 
wire [n-1:0]tsum;
wire tcout;
reg tcin;
reg [n-1:0]ta,tb;  
rca_nbit uut(tcout,tsum,ta,tb,tcin); 
initial $monitor("t=%3d, cout=%b, sum=%8b, a=%8b, b=%8b, cin=%b",$time,tcout,tsum,ta,tb,tcin);
initial     
	begin      
$dumpfile("rca_nbit.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 ta=8'b00000000 ; tb=8'b00000000 ; tcin=1'b0;    
 #50 ta=8'b11110000 ; tb=8'b11110000 ; tcin=1'b0;      
 #50 ta=8'b11111111 ; tb=8'b11111111 ; tcin=1'b0;      
 #50 $stop ;    
 end
endmodule  	
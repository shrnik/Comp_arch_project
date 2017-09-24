`timescale 1ns/10ps
`include "full_adder.v"
module rca_add_sub(b_comp,cin_comp,cout,sum,a,b,cin,con);
input cin;
input con;
input [n-1:0]a;
input [n-1:0]b;
output [n-1:0]sum;
output cout;
output reg [n-1:0]b_comp;
output reg cin_comp;
wire [n-1:1]c;
parameter n = 8;
always @ (*)
begin
if (con == 1'b0)
	begin
		cin_comp = cin;
		b_comp = b;
    end
	else 
	begin
		cin_comp = ~cin;
		b_comp = ~b;
	end
end	
 /*  cin = ~cin;
  b[n-1] = ~b[n-1]; */
full_adder faone(c[1],sum[0],a[0],b_comp[0],cin_comp);
full_adder fan(cout,sum[n-1],a[n-1],b_comp[n-1],c[n-1]);
generate
genvar i;
   for (i=1; i<=n-2; i=i+1) begin: faloop
	full_adder fai(c[i+1],sum[i],a[i],b_comp[i],c[i]);
   end
endgenerate

endmodule

module tb_rca_add_sub();  
parameter n = 8; 
wire [n-1:0]tsum;
wire tcout;
wire tcin_comp;
wire [n-1:0]tb_comp;
reg tcin,tcon;
reg [n-1:0]ta,tb;  
rca_add_sub uut(tb_comp,tcin_comp,tcout,tsum,ta,tb,tcin,tcon); 
initial $monitor("t=%3d, b_comp=%8b, cin_comp=%b, cout=%b, sum=%8b, a=%8b, b=%8b, cin=%b, con=%b",$time,tb_comp, tcin_comp, tcout,tsum,ta,tb,tcin,tcon);
initial     
	begin      
$dumpfile("rca_add_sub.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 ta=8'b00000000 ; tb=8'b00000000 ; tcin=1'b0; tcon=1'b0;  
 #50 ta=8'b11110000 ; tb=8'b11110000 ; tcin=1'b0; tcon=1'b1;     
 #50 ta=8'b11111111 ; tb=8'b11111111 ; tcin=1'b0; tcon=1'b1;    
 #50 $stop ;    
 end
endmodule  	
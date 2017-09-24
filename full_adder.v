`timescale 1ns/10ps
`include "half_adder.v"
 module full_adder(cout,sum,a,b,cin);
 input a,b,cin;
 output sum,cout;
 wire has1,hac1,hac2;
 half_adder ha1(hac1,has1,a,b);
 half_adder ha2(hac2,sum,has1,cin);
 or o1(cout,hac2,hac1);
 endmodule
 
 module tb_full_adder();   
wire tsum,tcout ; 
reg ta,tb,tcin ;  
full_adder uut(tcout,tsum,ta,tb,tcin); 
initial $monitor("t=%3d, cout=%b, sum=%b, a=%b, b=%b, cin=%b",$time,tcout,tsum,ta,tb,tcin);
initial     
	begin      
$dumpfile("full_adder.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 ta=1'b0 ; tb=1'b0 ; tcin=1'b1;    
 #50 ta=1'b0 ; tb=1'b1 ; tcin=1'b1;      
 #50 ta=1'b0 ; tb=1'b0 ; tcin=1'b0;   
 #50 ta=1'b1 ; tb=1'b1 ; tcin=1'b1;   
 #50 $stop ;    
 end
   
endmodule  
 
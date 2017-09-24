`timescale 1ns/10ps
`include "full_adder.v"
module ripple_four (cout,s3,s2,s1,s0,a3,a2,a1,a0,b3,b2,b1,b0,cain);
output cout,s0,s1,s2,s3;
input a0,a1,a2,a3,b0,b1,b2,b3,cain;
wire fa0,fa1,fa2;
/* assign cain= 0; */
full_adder fua1(fa0,s0,a0,b0,cain);
full_adder fua2(fa1,s1,a1,b1,fa0);
full_adder fua3(fa2,s2,a2,b2,fa1);
full_adder fua4(cout,s3,a3,b3,fa2);
endmodule

module tb_ripple_four();   
wire ts3,ts2,ts1,ts0,tcout ; 
reg ta0,ta1,ta2,ta3,tb0,tb1,tb2,tb3,tcain;  
ripple_four uut(tcout,ts3,ts2,ts1,ts0,ta3,ta2,ta1,ta0,tb3,tb2,tb1,tb0,tcain); 
initial $monitor("t=%3d, cout=%b, s3=%b, s2=%b, s1=%b, s0=%b, a3=%b, a2=%b, a1=%b, a0=%b, b3=%b, b2=%b, b1=%b, b0=%b, cain=%b",$time,tcout,ts3,ts2,ts1,ts0,ta3,ta2,ta1,ta0,tb3,tb2,tb1,tb0,tcain);
initial     
	begin      
$dumpfile("ripple_four.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 ta0=1'b0 ; ta1=1'b0 ; ta2=1'b0; ta3=1'b0; tb0=1'b0; tb1=1'b0; tb2=1'b0; tb3=1'b0; 
 #50 ta0=1'b0 ; ta1=1'b1 ; ta2=1'b0; ta3=1'b1; tb0=1'b0; tb1=1'b1; tb2=1'b0; tb3=1'b1;      
 #50 ta0=1'b0 ; ta1=1'b1 ; ta2=1'b1; ta3=1'b1; tb0=1'b1; tb1=1'b1; tb2=1'b0; tb3=1'b0; 
 #50 ta0=1'b1 ; ta1=1'b1 ; ta2=1'b1; ta3=1'b1; tb0=1'b1; tb1=1'b1; tb2=1'b1; tb3=1'b1;    
 #50 $stop ;    
 end
   
endmodule  
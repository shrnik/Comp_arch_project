`timescale 1ns/10ps
module half_adder(cout,sum,a,b);  
output sum,cout ;  
input a,b ;  
wire w1,w2,w3 ;   
parameter delay = 0 ;   
nand #delay n1(w1,a,b); 
nand #delay n2(cout,w1,w1); 
nand #delay n3(w2,a,w1);  
nand #delay n4(w3,b,w1); 
nand #delay n5(sum,w2,w3); 
endmodule 

module tb_half_adder();   
wire tsum,tcout ; 
reg ta,tb ;  
half_adder uut(tcout,tsum,ta,tb); 
initial $monitor("t=%3d, cout=%b, sum=%b, a=%b, b=%b",$time,tcout,tsum,ta,tb);
initial     
	begin      
$dumpfile("half_adder.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 ta=1'b0 ; tb=1'b0 ;     
 #50 ta=1'b0 ; tb=1'b1 ;       
 #50 ta=1'b1 ; tb=1'b0 ;    
 #50 ta=1'b1 ; tb=1'b1 ;    
 #50 $stop ;    
 end
   
endmodule  

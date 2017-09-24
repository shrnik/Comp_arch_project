`timescale 1ns/10ps
module comp(b_new,b,con);
input con;
input [7:0]b;
output reg [7:0]b_new;

always @ (*)
begin
if (con == 1'b1)
		b_new= ~b;		
	else 
	b_new = b;
end
	
endmodule

module tb_comp();   
wire [7:0]tb_new; 
reg tcon; 
reg [7:0]tb;  
comp uut(tb_new,tb,tcon); 
initial $monitor("t=%3d, b_new=%8b, b=%8b, con=%b",$time,tb_new,tb,tcon);
initial     
	begin      
$dumpfile("comp.vcd");    
$dumpvars;     
end     
initial     
 begin      
 #00 tb=8'b00000000 ; tcon=1'b0 ;     
 #50 tb=8'b00000000 ; tcon=1'b1 ;       
 #50 tb=8'b11111111 ; tcon=1'b0 ;      
 #50 $stop ;    
 end
   
endmodule  
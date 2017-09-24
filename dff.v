`timescale 1ns/10ps
module dff(q,d,clk,rst,en);
input clk,rst,d,en;
output reg q;
always @(posedge clk or negedge rst)
begin 
	if(!rst)
		q = 1'b0;
	else if (en)
		q = d;
end
endmodule	

module tb_dff();
reg td,tclk,trst, ten;
wire tq;
dff uut(tq,td,tclk,trst,ten);
initial $monitor("t=%3d, q=%8b, d=%8b, clk=%b, rst=%b, en=%b",$time,tq,td,tclk,trst,ten);
initial     
	begin      
$dumpfile("dff.vcd");    
$dumpvars;     
end 

initial 
	begin
		#00 tclk = 1'b0;
		forever #50 tclk = ~tclk;
	end
initial
	begin  
		#000 ten = 1'b1 ;  
		#050 ten = 1'b0 ;  
		#100 ten = 1'b1 ;
		#030 ten = 1'b1 ;  
		#500 ten = 1'b0 ; 
		#040 ten = 1'b1 ; 
	end 	
initial
	begin  
		#000 trst = 1'b1 ;  
		#030 trst = 1'b0 ;  
		#030 trst = 1'b1 ;
		#030 trst = 1'b1 ;  
		#800 trst = 1'b0 ; 
		#040 trst = 1'b1 ; 
	end 	
	
initial
  begin  
  #00 td = 1'b0 ;  
  forever #65 td = ~tclk ;  
  end

initial 
#2000 $stop;
endmodule  
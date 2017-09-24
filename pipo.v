`timescale 1ns/10ps
`include "dff.v"
module pipo(q,d,clk,rst,en);
input [n-1:0]d;
input clk,rst,en;
output [n-1:0]q;
parameter n=16;

generate 
 genvar i;
	for (i=0;i<=n-1;i=i+1) begin: pipoloop
	  dff dff1(q[i],d[i],clk,rst,en);
	  end
endgenerate

endmodule

module tb_pipo();
wire [n-1:0]tq;
reg tclk,trst,ten;
reg [n-1:0]td;
parameter n=16;

pipo uut(tq,td,tclk,trst,ten);
initial $monitor("t=%3d, q=%b, d=%b, clk=%b, rst=%b, en=%b",$time,tq,td,tclk,trst,ten);
initial     
	begin      
$dumpfile("pipo.vcd");    
$dumpvars;     
end 

initial 
	begin
		#00 tclk = 1'b0;
		forever #50 tclk = ~tclk;
	end
initial
	begin 
		#010 ten  = 1'b0 ;
		#020 trst = 1'b1 ;  
		#030 trst = 1'b0 ;  
		#030 trst = 1'b1 ;
		#030 trst = 1'b1 ;  
		#800 trst = 1'b0 ; 
		#040 trst = 1'b1 ;
        #020 ten  = 1'b1 ;		
		#000 trst = 1'b1 ;  
		#030 trst = 1'b0 ;  
		#030 trst = 1'b1 ;
		#030 trst = 1'b1 ;  
		#800 trst = 1'b0 ; 
		#040 trst = 1'b1 ; 
	end 	
	
initial
  begin  
  #00 td = 16'b0000000000000000 ; 
  #30 td = 16'b1111111111111111;	
  forever #65 td = ~td ;  
  end

initial 
#4000 $stop;
endmodule  
	  
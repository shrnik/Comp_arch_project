`timescale 1ns/10ps   
module tb_RAM_64B();  
reg [5:0]adr ;
 reg clk,rwb; 
 reg [7:0]din ;
 wire [7:0]dout ; 
reg wr; 
// Clock generator T=100ns
  initial  
  begin  
  #00 clk = 1'b0 ;
  #10 clk = 1'b1 ;  
  forever #50 clk = ~clk ;
  end  
// initializing address and setting read mode
 initial 
 begin  
 #00 rwb = 1 ; 
 #00 wr = 1 ; 
 
 #5 adr = 6'd0 ;   
 #6500 $stop ; 
 end   
// Increamenting the address by 1 
initial forever #100 adr <= adr + 1 ;   
initial  
begin  
$dumpfile("RAM_64B.vcd"); 
$dumpvars ;    
end  
initial #6500 $stop ; 
RAM_64B uut (dout,din,adr,rwb,clk,wr); 
endmodule  

module RAM_64B(dout,din,adr,rwb,clk,wr);  
output reg [7:0]dout ; 
input [7:0]din ;
reg [7:0]din1; 
input wr;
input [5:0]adr ; 
input clk,rwb ;  
reg [7:0]memory1[0:63];  
//The text file data_64B.txt should be in the same folder //This file will have 64 Rows each row a 2digit hexa decimal number 
initial $readmemh("data_64B.txt",memory1);  
/* initial $writememh("data_64B.txt",memory1); */

always @(negedge clk)
begin 
	if(wr)
		begin memory1[adr] <= din1;
			dout <= memory1[adr];
			$writememb("wrt.txt",memory1);
		end	
end 

always @(posedge clk)
begin
	if(rwb) 
	begin 
	dout <= memory1[adr];
	din1 <= ~dout + 8'b00000001;
	end
	
end	
 
/* always @(negedge clk) 
begin      
if(rwb) dout <= memory1[adr];     
else memory1[adr]<= din ; 
end  */
endmodule 
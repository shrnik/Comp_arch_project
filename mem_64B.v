`timescale 1ns/10ps
module mem_64B(dout,din,addr,clk,rd,wr);
input clk,rd,wr;
input [7:0]din;
input [5:0]addr;
output reg [7:0]dout;

reg [7:0]memory[0:63];
initial $readmemh("abc.txt",memory);
/* 
always @(negedge clk)
begin 
	if(wr) memory[addr] <= din;
end */

always @(posedge clk)
begin
	if(rd) dout <= memory[addr];
	else if(wr) memory[addr] <= din;
	/* else dout <= 8'bz; */
end	


endmodule

module tb_mem_64B();  
reg [5:0]addr ;
 reg clk,rd; 
 reg [7:0]din ;
 wire [7:0]dout ;  
reg  wr;
 
  initial  
  begin  
  #0 clk = 1'b1 ; 
  forever #50 clk = ~clk ;
  end  

 initial 
 begin  
 #00 rd = 1 ; 
 #00 addr = 6'd0 ;  
 #9500 $stop ; 
 end   
// Increamenting the address by 1 
initial forever #100 addr <= addr + 1 ;   
initial  
begin  
$dumpfile("mem_64B.vcd"); 
$dumpvars ;  
end  
initial #9500 $stop ; 
mem_64B uut(dout,din,addr,clk,rd,wr); 
endmodule   
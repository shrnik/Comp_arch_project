`timescale 1ns/10ps
module data_mem(readdata,wd,addr,clk,memread,memwrt);
input clk,memread,memwrt;
input [15:0]wd;
input [7:0]addr;
output reg [15:0]readdata;

reg [15:0]memory[0:12];
initial $readmemb("abc.txt",memory);
always @(negedge clk)
	begin
		if(memwrt)
			begin
			memory[addr] <= wd;
			$writememb("abc.txt",memory);
			end
		
	/* else readdata <= 8'bz; */
	end	

always @ (addr)
	begin
		if (memread) readdata <= memory[addr];
    end
endmodule

/* module tb_data_mem();  
reg [7:0]addr ;
reg clk, memread,memwrt; 
 reg [15:0]wd ;
 wire [15:0]readdata ; 
reg wr; 
// Clock generator T=100ns
  initial  
  begin  
  #00 clk = 1'b1 ;
  forever #1 clk = ~clk ;
  end  
// initializing address and setting read mode



 initial 
 begin  
 #00 memread = 1 ; 
 #00 memwrt = 0 ; 
 #00 addr = 6'd0 ;
 #20 wd =1'b1;memwrt=1;memread=0;  
 #100 $stop ; 
 end   
// Increamenting the address by 1 
initial forever #2 addr <= addr + 1 ;   
 

data_mem uut(readdata,wd,addr,clk,memread, memwrt);

initial $monitor("t=%3d, readdata=%16b , wd=%16b , addr=%7b , memread=%1b , memwrt =%1b",$time,readdata,wd,addr,memread, memwrt); 
endmodule   */
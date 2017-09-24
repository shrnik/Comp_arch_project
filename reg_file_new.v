`timescale 1ns/10ps
module reg_file_new(r1out,r2out,r3out,r1,r2,wr,wd,regwrt,clk);
output reg [15:0] r1out , r2out , r3out;
input [3:0]r1,r2,wr;
input [15:0]wd;
input regwrt;
input clk;

reg [15:0]register[0:15];
integer i,r1i,r2i,wri;

initial
	begin
		for(i=0;i<16;i=i+1)
		begin
			register[i]=16'b0000000000000000;
		end
	end
	
/* always @ (*)
	begin		//binary to int conversion
		r1i = r1;
		r2i = r2; 
		wri = wr;
	end */

always @ (*) 
	begin
		r3out <= register[15];
	end

always @(*)
	begin
		r1out <= register[r1];
		r2out <= register[r2];
	end

always @(negedge clk)
	begin
			if(regwrt==1)
				begin
					register[wr]=wd;
					$writememb("reg.txt",register);
				end
	end

endmodule


/* module tb_regfile();
wire [15:0]r1out,r2out,r3out;
reg [3:0]r1,r2,wr;
reg regwrt,clk;
reg [15:0]wd;

reg_file_new uut(r1out,r2out,r3out,r1,r2,wr,wd,regwrt,clk);

initial  
  begin  
  #0 clk = 1'b1 ; 
  forever #50 clk = ~clk ;
  end 
  
initial 
  begin
  #0 regwrt = 1;
  end
  
initial 
  begin
  #50 wr = 4'b1111;
  wd = 16'b0000000000000001; 
  #100 wr = 4'b0010;
  wd = 16'b0000000000000010;  
  #100 wr = 4'b0011;
  wd = 16'b0000000000000011;  
  #100 wr = 4'b0100;
  wd = 16'b0000000000000100; 
end

initial
  begin
 #75 r1 = 4'b0001;
 #100 r1 = 4'b0010;
 #100 r1 = 4'b0011;
 #100 r1 = 4'b0100;
 end
  
initial # 500 $stop;

initial $monitor("t=%3d, r1out=%16b , r2out=%16b , r3out=%16b, r1=%4b, r2=%4b , wr=%4b , wd = %16b",$time,r1out,r2out,r3out,r1,r2,wr,wd);

endmodule  */





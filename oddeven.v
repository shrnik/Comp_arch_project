`timescale 1ns/10ps
module oddeven(z,y,clk,rst);
input y,clk,rst;
output reg z;
reg [1:0]currentstate,nextstate;

parameter idle= 2'b00, st1= 2'b01, st2= 2'b11, st3= 2'b10;

always @(posedge clk or negedge rst)
 begin
	if(!rst) currentstate <= idle;
	else currentstate <= nextstate;
end

always @(*)
begin
	case(currentstate)
	2'b00: begin 
				if(y) nextstate <= st2;
				 else nextstate <= st1;
			end
    2'b01: begin 
				 if(y) nextstate <= st2;
				 else nextstate <= idle;
			end
	2'b11: begin
				if(y) nextstate <= st3;
				else nextstate <= st1;
			end
	2'b10: begin
				if(y) nextstate <= st2;
				else nextstate <= st1;
			end	
	default: nextstate <= idle;
	
	endcase
end

always @(*)
begin
	case(currentstate)
	2'b00: begin if(y) z <= 1'b0 ;
				 else z <= 1'b0;
			end	 
	2'b01: begin if(y) z<= 1'b1 ;
	             else z <= 1'b0 ;
			end	 
	2'b11: begin if(y) z <= 1'b0 ;
				else z <= 1'b0 ;
			end	
	2'b10: begin if(y) z <= 1'b0;
				else z <= 1'b1;
			end	
	default: z <=1'b0;			
	endcase
end	
				
endmodule

module tb_oddeven();
wire z;
reg y,clk,rst;

oddeven uut(z,y,clk,rst);
initial $monitor("t=%3d, z=%b, y=%b, clk=%b, rst=%b",$time,z,y,clk,rst);
 initial  
 begin  
 $dumpfile("oddeven.vcd");  
 $dumpvars;  
 end  
 
initial  
begin  #00 clk <= 1'b0 ;  
forever #50 clk <= ~ clk ;  
end  

initial forever #100 y = $random %2 ;  
 
initial  
begin  #0000 rst = 1'b1; 
#0050 rst = 1'b0;
 #0050 rst = 1'b1;  
 #2000 rst = 1'b0;
 #0050 rst = 1'b1;
 end  
initial 
#4000 $stop ; 
 endmodule
	
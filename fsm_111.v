`timescale 1ns/10ps
module fsm_111(z,y,clk,rst);
input y,clk,rst;
output reg z;
reg [1:0]current_state,next_state;

parameter idle= 2'b00, st1= 2'b01, st2= 2'b11, st3= 2'b10;

always @(posedge clk, negedge rst)
	begin
		if(!rst)
		current_state <= idle;
		else
		current_state <= next_state;
	end	
	
always @(*)
   begin
    case(current_state)
	
	2'b00: begin
	if(y)
	next_state <= st1;
	else
	next_state <= idle;
	end
	
	2'b01: begin
	if(y)
	next_state <= st2;
	else
	next_state <= idle;
	end
	
	2'b11: begin
	if(y)
	next_state <= st3;
	else
	next_state <= idle;
	end
	
	2'b10: begin
	if(y)
	next_state <= st1;
	else
	next_state <= idle;
	end
	
	default: next_state <= idle;
	
endcase
end	
	
always @(*)
begin
	case(current_state)
	2'b00: z <=1'b0;
	2'b01: z <=1'b0;
	2'b11: z <=1'b0;
	2'b10: z <=1'b1;
	default: z <=1'b0;
	endcase
end

endmodule	

module tb_fsm_111();
wire z;
reg y,clk,rst;

fsm_111 uut(z,y,clk,rst);

initial $monitor("t=%3d, z=%b, y=%b, clk=%b, rst=%b",$time,z,y,clk,rst);
 initial  
 begin  
 $dumpfile("fsm_111.vcd");  
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
#2000 $stop ; 
 endmodule	
`timescale 10ns/1ps
module ALU(ALUresult,zero,overflow,carryout,sign,a,b,ALUop,carryin);
input [15:0] a,b;
input [2:0]ALUop;
input carryin;
output reg [15:0] ALUresult;
output reg zero,overflow,carryout,sign;
reg [15:0]temp;

always @(a or b or ALUop)
begin
	case(ALUop)
		3'b000:begin					//ADD
				{carryout, ALUresult} = a + b + carryin;
				
				temp = a[14:0]+b[14:0]+carryin;
				overflow = carryout^temp[15];
				sign=ALUresult[15];
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
			end
		3'b001:	begin 					//SUB
				{carryout,ALUresult}=a+(~b)+1;
				
				temp = a[14:0]+(~b[14:0])+1;
				overflow = carryout^temp[15];
				sign=ALUresult[15];
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
				
				end
				
		3'b010:begin					//AND
				ALUresult = a & b;
				
				sign=ALUresult[15];
				carryout=0;
				overflow=0;
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
					
			end
			
		3'b011:begin					//OR
				ALUresult = a | b;
				
				sign=ALUresult[15];
				carryout=0;
				overflow=0;
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
			end
			
		3'b100:begin					//NAND
				ALUresult = a ~& b;
				
				sign=ALUresult[15];
				carryout=0;
				overflow=0;
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
			end
			
		3'b101:	begin 					//NEG
				{carryout,ALUresult}=(~a)+1;
				temp =(~a[14:0])+1;
				
				overflow = 0;
				sign=ALUresult[15];
				carryout=0;
				
				if(ALUresult== 16'h00)
					zero = 1;
				else
					zero = 0;
		
				end	
				
		default: {carryout,ALUresult} = {17{1'b0}};
	endcase
	
end
endmodule


/* module tb_alu();
reg [15:0] a,b;
reg [2:0]ALUop;
reg carryin;

wire [15:0] ALUresult;
wire zero,overflow,carryout,sign;

ALU uut(ALUresult,zero,overflow,carryout,sign,a,b,ALUop,carryin);

initial $monitor("t=%3d, carryout =%1b, ALUresult = %16b, ALUop = %3b, a=%16b, b=%16b , carryin=%1b , zero=%1b, overflow=%1b, sign=%1b",$time,carryout, ALUresult, ALUop, a, b,carryin , zero, overflow, sign);

initial
 begin
 #00  a = 16'b0100000000000001; b = 16'b0100000000000001; ALUop= 3'b000;carryin=1'b1;
 #100 a = 16'b0000000000000001; b = 16'b0000000000000001; ALUop= 3'b001;carryin=1'b0;
 #100 a = 16'b0000000000000000; b = 16'b0000000000000001; ALUop= 3'b010;carryin=1'b0;
 #100 a = 16'b0000000000000000; b = 16'b0000000000000001; ALUop= 3'b011;carryin=1'b0;
 #100 a = 16'b0000000000000000; b = 16'b0000000000000001; ALUop= 3'b100;carryin=1'b0;
 #100 a = 16'b0000000000000001; b = 16'b0000000000010001; ALUop= 3'b101;carryin=1'b0;
 end
 
initial #750 $stop;
 
 
 endmodule */




















`timescale 1ns/10ps
//2013B3A8678P Shrenik Borad
//2013B1A3848P Dewanshu Sewake

//Stack
module stack(dout,push ,pop ,din);

output reg [15:0] dout ;

input push ;
input pop ;
input [15:0] din ;


reg [15:0] stack [0:7] ;

reg [2:0] i;

initial i = 0;

always @ (*) 
begin
	if (push) begin 
		stack[i] = din;
		i= i + 1;
	end 
	else if (pop) begin
		dout = stack[i];
		i = i - 1;
	end
end  

endmodule

//Shifter
module shifter(out,datain,shftamt,code);
input signed[15:0]datain;
input [3:0]shftamt;
input [1:0]code;
output [15:0]out;

assign out = (code==2'b10)?datain>>shftamt/* {shftamt'b0,datain[15:shftamt]} */: //right shift logical
			 (code==2'b11)?datain<<shftamt/* {datain[15-shftamt:0],shftamt'b0} */://left shift logical
			 (code==2'b01)?(datain >>> shftamt)  :datain;	//SAR
			 
endmodule

//Register File
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

//SIGNEX
module signex(out,datain);
input [7:0]datain;
output [8:0]out;

assign out = {datain[7],datain[7:0]};

endmodule

//ALU
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

// DATA Memory
module data_mem(readdata,wd,addr,clk,memread,memwrt);
input clk,memread,memwrt;
input [15:0]wd;
input [7:0]addr;
output reg [15:0]readdata;

reg [15:0]memory[0:3];
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

//Instruction Memory
module inst_mem(inst,readaddr);
input [8:0]readaddr;
output reg [15:0]inst;

initial $readmemb("inst.txt",memory);

reg [15:0]memory[0:7];

always @(readaddr)
	begin
		inst = memory[readaddr];
	end
endmodule

//Control Signals
module consig(lwsw,wrtdata,jump,branch,memread,memwrt,memtoreg,ALUop,regwrt,regsrc,push,pop,opcode);
input [3:0]opcode;
output reg lwsw,jump,branch,memread,memwrt,memtoreg,regwrt,regsrc,push,pop;
output reg [1:0]wrtdata;
output reg [2:0]ALUop;

always @(opcode)
	begin
		case(opcode)      
		4'b0000: begin      //add 
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b000;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0001: begin     //sub
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b001;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0010: begin   //NAND
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b100;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0011: begin    //NEG
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b101;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0101: begin    // AND
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b010;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0110: begin   // OR
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;
		ALUop = 3'b011;
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b0100: begin   // SAR SHR SHL
		lwsw = 0;
		wrtdata = 2'b01;
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;    //irrelevant
		ALUop = 3'b000;    //irrelevant
		regwrt = 1;
		regsrc = 1;
		push =0;
		pop = 0;
		end
		
		4'b1000: begin  //LW
		lwsw = 1;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 1; 
		memwrt = 0;
		memtoreg = 1;
		ALUop = 3'b000;    //irrelevant
		regwrt = 1;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b1001: begin  //SW
		lwsw = 0;
		wrtdata = 2'b00;
		jump = 0;
		branch = 0;
		memread = 0; 
		memwrt = 1;
		memtoreg = 1;    //irrelevant
		ALUop = 3'b000;    //irrelevant
		regwrt = 0;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b1100: begin //JUMP
		lwsw = 0;        //irrelevant
		wrtdata = 2'b00;     //irrelevant
		jump = 1;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;    //irrelevant
		ALUop = 0;         //irrelevant
		regwrt = 0;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b1101: begin //BEQ
		lwsw = 0;        //irrelevant
		wrtdata = 2'b00;     //irrelevant
		jump = 0;
		branch = 1;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;    //irrelevant
		ALUop = 3'b001;    
		regwrt = 0;
		regsrc = 0;
		push =0;
		pop = 0;
		end
		
		4'b1110: begin //PUSH
		lwsw = 0;        //irrelevant
		wrtdata = 0;     //irrelevant
		jump = 0;
		branch = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;    //irrelevant
		ALUop = 3'b001;    
		regwrt = 0;
		regsrc = 1;
		push =1;
		pop = 0;
		end
		
		4'b1111: begin //POP
		lwsw = 0;        //irrelevant
		wrtdata = 2'b10;     //relevant
		branch = 0;
		jump = 0;
		memread = 0;
		memwrt = 0;
		memtoreg = 0;    //irrelevant
		ALUop = 3'b001;    
		regwrt = 1;
		regsrc = 1;
		push =0;
		pop = 1;
		end
	endcase	
	end
endmodule

module processor(clk,instruction,pc,ALUop,ALUresult,r1out,r2out,regsrc);
input clk;
output [15:0]instruction;
output signed[8:0]pc;
output [2:0]ALUop;
output [15:0]ALUresult;
output [15:0] r1out,r2out;
output regsrc;
//Program Counter
reg [8:0]pc;

initial
begin 
#00 pc <= 0;
end

//PC Addder
wire [8:0]NEWpc;
assign NEWpc = pc+1;

always@(posedge clk)
begin
	pc=JUMPout;
end

//Instruction
wire [15:0]instruction;
inst_mem instmem(instruction,pc);

// Controller
wire lwsw,jump,branch,memread,memwrt,memtoreg,regwrt,regsrc,push,pop;
wire [1:0]wrtdata;
wire [2:0]ALUop;
consig consig1(lwsw,wrtdata,jump,branch,memread,memwrt,memtoreg,ALUop,regwrt,regsrc,push,pop,instruction[15:12]);

//MUX wrtdata
wire [15:0]wd;
wire [15:0]MEMtoREGout,SHIFTout,STACKout; //aage aakar isko dekhna MEMtoREGmux 

assign wd=(wrtdata==2'b00)?MEMtoREGout:
			(wrtdata==2'b01)?SHIFTout:
			(wrtdata==2'b10)?STACKout:0;

			
			
stack stack1(STACKout,push,pop,r1out);

//MUX REGsourceout
wire [3:0]REGsourceout;
assign REGsourceout = regsrc ? instruction[11:8]:instruction[7:4];

//Register File
wire [15:0] r1out,r2out,r3out;
reg_file_new reg_file_new1(r1out,r2out,r3out,REGsourceout,instruction[3:0],instruction[11:8],wd,regwrt,clk);

//ALU
wire [15:0]ALUresult;
wire zero,overflow,carryout,sign;
wire carryin;
assign carryin=0 ;// Carry in assigned zero
ALU alu1(ALUresult,zero,overflow,carryout,sign,r1out,r2out,ALUop,carryin);

//LWSW MUX
wire [7:0]LWSWout;
assign LWSWout = lwsw?instruction[7:0]:instruction[11:4];

//Memory
wire [15:0] MEMout;
data_mem data_mem1(MEMout,r2out,LWSWout,clk,memread,memwrt);

//MEMtoREGmux
assign MEMtoREGout = memtoreg ? MEMout : ALUresult;

//Shifter
shifter shifter1(SHIFTout,r1out,instruction[7:4],instruction[1:0]);

//Branch Selector
wire branchout;
and m1(branchout,branch,zero);

//BRANCHout MUX
wire [8:0]BRANCHmuxout;
assign BRANCHmuxout = branchout ? r3out : NEWpc;

//Sign Extender
wire [8:0]SIGNEXout;
signex signex1(SIGNEXout,instruction[11:4]);

// Jump MUX
wire [8:0]JUMPout;
assign JUMPout = jump? SIGNEXout : BRANCHmuxout;

/* // Controller
wire lwsw,wrtdata,jump,branch,memread,memwrt,memtoreg,regwrt,regsrc;
wire [2:0]ALUop;
consig consig1(lwsw,wrtdata,jump,branch,memread,memwrt,memtoreg,ALUop,regwrt,regsrc,instruction[15:12]); */
endmodule


module tb_processor();
reg clk;
wire [15:0]instruction;
wire [8:0]pc;
wire [2:0]ALUop;
wire [15:0]ALUresult;
wire [15:0] r1out,r2out;
wire regsrc;
initial  
begin  #0 clk = 1'b1 ;  
forever #50 clk = ~clk ; 
end

processor uut(clk,instruction,pc,ALUop,ALUresult,r1out,r2out,regsrc);

initial #1500 $stop ;
initial $monitor("t=%3d, inst=%16b,pc=%9b ,ALUop = %3b,ALUresult=%16b,r1out=%16b,r2out=%16b,regsrc=%1b",$time,instruction,pc,ALUop,ALUresult,r1out,r2out,regsrc);
endmodule
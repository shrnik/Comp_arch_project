`timescale 1ns/10ps
`include "inst_mem.v"
`include "reg_file_new.v"
`include "alu.v"
`include "data_mem.v"
`include "shifter.v"
`include "signex.v"
`include "consig.v"
`include "stack.v"

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

wire [8:0]signr3out;
assign signr3out = {r3out[7],r3out[7:0]};

//BRANCHout MUX
wire [8:0]BRANCHmuxout;
assign BRANCHmuxout = branchout ? signr3out : NEWpc;

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













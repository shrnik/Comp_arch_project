`timescale 1ns/10ps
module inst_mem(inst,readaddr);
input [8:0]readaddr;
output reg [15:0]inst;

initial $readmemb("xor.txt",memory);

reg [15:0]memory[0:9];

always @(readaddr)
	begin
		inst = memory[readaddr];
	end
endmodule

/* module tb_inst_mem();
wire [15:0]inst;
reg [8:0]readaddr;

inst_mem uut(inst,readaddr);

initial $monitor("t=%3d, inst=%16b, readaddr=%9b",$time,inst,readaddr);

initial
  begin
 #75 readaddr = 9'b000000001;
 #100 readaddr = 9'b000000010;
 #100 readaddr = 9'b000000011;
 #100 readaddr = 9'b000000100;
 end
 initial #650 $stop;
 endmodule */ 
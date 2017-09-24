`timescale 1ns/10ps
module combmul(out,a,b);
input [3:0]a,b;
output [7:0]out;
wire [7:0]out0,out1,out2,out3;
wire [3:0]temp0,temp1,temp2,temp3;

assign temp0 = (b[0])? a:4'b0000;
assign temp1 = (b[1])? a:4'b0000;
assign temp2 = (b[2])? a:4'b0000; 
assign temp3 = (b[3])? a:4'b0000; 
   

assign out0 = {4'b0000,temp0};
assign out1 = {3'b000,temp1,1'b0};
assign out2 = {2'b00,temp2,2'b00};
assign out3 = {1'b0,temp3,3'b000};

assign out = out0 + out1 + out2 + out3;

endmodule 

module mul_8(out,a,b);
output [15:0]out;
input [7:0]a,b;
wire [7:0]temp0,temp1,temp2,temp3;
wire [15:0]out0,out1,out2;

combmul m0(temp0,a[3:0],b[3:0]);
combmul m1(temp1,a[7:4],b[7:4]);
combmul m2(temp2,a[7:4],b[3:0]);
combmul m3(temp3,a[3:0],b[7:4]);

assign out0 = {temp1,temp0};
assign out1 = {4'b0000,temp2,4'b0000};
assign out2 = {4'b0000,temp3,4'b0000};
assign out = out0 + out1 + out2;

endmodule

module tb_mul_8();
wire [15:0]out;
reg [7:0]a,b;

mul_8 uut(out,a,b);

initial #00 a=8'b10000000;
initial #00 b=8'b00000011;

initial #60 a=8'b11111111;
initial #60 b=8'b11111111;

initial $monitor("t=%3d, out=%16b, a=%8b, b=%8b",$time,out,a,b);
initial #250 $stop;

endmodule 

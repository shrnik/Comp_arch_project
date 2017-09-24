`timescale 1ns/10ps
`include "pipo.v"
`include "mux_16x1.v"
`include "dec_4x16.v"

module reg_file(rd_data1,wrt_data,wrt_loc,write,clk,rd_loc1,rst);
input [15:0]wrt_data;
input write,clk,rst;
input [3:0]rd_loc1,wrt_loc;
output [15:0]rd_data1;
wire [15:0]q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15;
wire a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
wire en0,en1,en2,en3,en4,en5,en6,en7,en8,en9,en10,en11,en12,en13,en14,en15;
/* 
always @ (*) //read//
	begin
mux_16x1 mux1(rd_data1,q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,rd_loc1);
	end */
	pipo pipo0(q0,wrt_data,clk,rst,en0);
   pipo pipo1(q1,wrt_data,clk,rst,en1);
   pipo pipo2(q2,wrt_data,clk,rst,en2);
   pipo pipo3(q3,wrt_data,clk,rst,en3);
   pipo pipo4(q4,wrt_data,clk,rst,en4);
   pipo pipo5(q5,wrt_data,clk,rst,en5);
   pipo pipo6(q6,wrt_data,clk,rst,en6);
   pipo pipo7(q7,wrt_data,clk,rst,en7);
   pipo pipo8(q8,wrt_data,clk,rst,en8);
   pipo pipo9(q9,wrt_data,clk,rst,en9);
   pipo pipo10(q10,wrt_data,clk,rst,en10);
   pipo pipo11(q11,wrt_data,clk,rst,en11);
   pipo pipo12(q12,wrt_data,clk,rst,en12);
   pipo pipo13(q13,wrt_data,clk,rst,en13);
   pipo pipo14(q14,wrt_data,clk,rst,en14);
   pipo pipo15(q15,wrt_data,clk,rst,en15);
always @ (*) //write//
   begin
   
   dec_4x16 dec1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,wrt_loc);
   and ga0(en0,a0,write);
   and ga1(en1,a1,write);
   and ga2(en2,a2,write);
   and ga3(en3,a3,write);
   and ga4(en4,a4,write);
   and ga5(en5,a5,write);
   and ga6(en6,a6,write);
   and ga7(en7,a7,write);
   and ga8(en8,a8,write);
   and ga9(en9,a9,write);
   and ga10(en10,a10,write);
   and ga11(en11,a11,write);
   and ga12(en12,a12,write);
   and ga13(en13,a13,write);
   and ga14(en14,a14,write);
   and ga15(en15,a15,write);
   end
endmodule
   
   
   
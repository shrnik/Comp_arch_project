`timescale 1ns/10ps
module signex(out,datain);
input [7:0]datain;
output [8:0]out;

assign out = {datain[7],datain[7:0]};

endmodule

/* module tb_signex();
wire [8:0]out;
reg [7:0]datain;
signex uut(out, datain);

initial $monitor("t=%3d, out=%9b, datain=%8b",$time,out,datain);
initial 
begin 
#0 datain = 8'b00000000;
#50 datain = 8'b11111111;
end

initial #100 $stop;

endmodule */


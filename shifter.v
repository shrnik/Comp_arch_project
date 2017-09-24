`timescale 1ns/10ps
module shifter(out,datain,shftamt,code);
input signed[15:0]datain;
input [3:0]shftamt;
input [1:0]code;
output [15:0]out;

assign out = (code==2'b10)?datain>>shftamt/* {shftamt'b0,datain[15:shftamt]} */: //right shift logical
			 (code==2'b11)?datain<<shftamt/* {datain[15-shftamt:0],shftamt'b0} */://left shift logical
			 (code==2'b01)?(datain >>> shftamt)  :datain;	//SAR
			 
endmodule

/* module tb_shifter();
reg [15:0]datain;
reg [3:0]shftamt;
reg [1:0]code;
wire [15:0]out;

shifter uut(out,datain,shftamt,code);
initial $monitor("t=%3d, out=%16b, datain=%16b, shftamt=%4b code = %2b",$time,out,datain,shftamt,code);

initial
begin

#00 datain=16'b1100110011001100;shftamt=4'b1000;code=2'b01;
#10 datain=16'b1100110011001100;shftamt=4'b1000;code=2'b10;
#20 datain=16'b1100110011001100;shftamt=4'b1000;code=2'b11;

end
endmodule */
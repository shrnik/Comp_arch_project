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
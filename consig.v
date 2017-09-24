`timescale 1ns/10ps
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
			
module alu(
	input		logic	[31:0]	A, B,
	input 	logic	[2:0]		F,
	output 	logic	[31:0]	Y,
	output	logic				zero);

	logic [31:0] BB, aluAND, aluOR, aluSUM, aluZSUM;
	
	
	assign BB = F[2] ? ~B : B;
	assign aluAND = A & BB;
	assign aluOR = A ^ BB;
	assign aluSUM = A + BB;
	assign aluZSUM = {1'b0, aluSUM[30:0]};
	
	always_comb
	begin
		case(F[1:0])
			2'b00: Y = aluAND;
			2'b01: Y = aluOR;
			2'b10: Y = aluSUM;
			2'b11: Y = aluZSUM;
			default: ;
		endcase
	end
	
	


endmodule
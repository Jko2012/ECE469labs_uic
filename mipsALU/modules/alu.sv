module alu(
	input	logic	[31:0]	A, B,
	input 	logic	[2:0]	F,
	output 	logic	[31:0]	Y,
	output	logic		zero, OF);

	logic [31:0] BB, aluAND, aluOR, aluSUM, aluZSUM;
	logic overflow;
	
	assign BB = F[2] ? ~B : B;
	assign aluAND = A & BB;
	assign aluOR = A | BB;
	assign aluSUM = A + BB + F[2];
	assign aluZSUM = {31'b0, aluSUM[31]};
	assign overflow = ~(A[31] ^ BB[31]) & (aluSUM[31] ^ A[31]);
	
	always_comb
	begin
		case(F[1:0])
			2'b00: Y = aluAND;
			2'b01: Y = aluOR;
			2'b10: Y = aluSUM;
			2'b11: Y = aluZSUM;
			default: ;
		endcase

		zero = 1'b0;
		if (Y == 32'd0) begin
			zero = 1'b1;
		end

		OF = 1'b0;
		if (F == 3'b010 || F == 3'110) begin
			OF = overflow;
		end
	end

endmodule
module mod_carry (
	input logic Gi, Pi, Cin,
	output logic Cout);

	assign Cout = Gi | (Pi & Cin);

endmodule
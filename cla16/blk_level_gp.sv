module blk_lvl_gp (
	input logic Gkj, Gik, Pkj, Pik, Cin,
	output logic Gij, Pij);

	assign Gij = Gik | (Gkj & Pik);
	assign Pij = Pik & Pkj;
	//assign Cout = Gij | (Pij & Cin);

endmodule
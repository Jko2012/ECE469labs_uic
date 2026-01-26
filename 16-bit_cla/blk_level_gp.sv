module blk_lvl_gp (
	input logic Gik, Gkj, Pik, Pkj, Cin
	output logic Gij, Pij
);

	assign Gij = Gik | (Gkj & Pik);
	assign Pij = Pik & Pkj;
	//assign Cout = Gij | (Pij & Cin);

endmodule
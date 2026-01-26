module bit_lvl_gp (
	input logic Ai, Bi,
	output logic Gi, Pi
);

	assign Gi = Ai & Bi;
	assign Pi = Ai | Bi;

endmodule

module regfile(
	input 	logic 		clk, init, swapnow,
	input 	logic [2:0] x, y,
	output 	logic [3:0] r[7:0]);

	logic [3:0] regs[7:0];
	logic [3:0] tmp;
	
	always_ff@(posedge clk)
	begin
		if (init) begin
			regs[0] <= 4'd0;
			regs[1] <= 4'd1;
			regs[2] <= 4'd2;
			regs[3] <= 4'd3;
			regs[4] <= 4'd4;
			regs[5] <= 4'd5;
			regs[6] <= 4'd6;
			regs[7] <= 4'd7;
		end
		else if (swapnow) begin
			tmp <= regs[x];
			regs[x] <= regs[y];
			regs[y] <= tmp;
		end
	end

	
	always_comb
	begin
		r[7:0] = regs[7:0];	
	end
	

endmodule
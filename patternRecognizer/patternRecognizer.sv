module patternRecognizer(
	input		logic clk, reset,
	input 	logic d,
	output 	logic rec_C, rec_E, rec_4, rec_6, rec_9
);

	enum bit[3:0] {
		INIT,
		S1,
		S10,
		S100,
		S1001,
		S11,
		S110,
		S1100,
		S111,
		S1110
	} state;




	always_ff @(posedge clk) begin
		if (reset) begin
			state <= INIT;
		end else begin
			case (state)
				INIT: begin
					if (d == 1'b1)
						state <= S1;
				end
				S1: begin
					if (d == 1'b1) 
						state <= S11;
					if (d == 1'b0) 
						state <= S10;
				end
				S10: begin
					if (d == 1'b1) 
						state <= S1;
					if (d == 1'b0) 
						state <= S100;
				end
				S100: begin
					if (d == 1'b1) 
						state <= S1001;
					if (d == 1'b0) 
						state <= INIT;
				end
				S1001: begin
					if (d == 1'b1) 
						state <= S11;
					if (d == 1'b0) 
						state <= S10;
				end
				S11: begin
					if (d == 1'b1) 
						state <= S111;
					if (d == 1'b0) 
						state <= S110;
				end
				S110: begin
					if (d == 1'b1) 
						state <= S1;
					if (d == 1'b0) 
						state <= S1100;
				end
				S1100: begin
					if (d == 1'b1) 
						state <= S1001;
					if (d == 1'b0) 
						state <= INIT;
				end
				S111: begin
					if (d == 1'b1) 
						state <= S111;
					if (d == 1'b0) 
						state <= S1110;
				end
				S1110: begin
					if (d == 1'b1) 
						state <= S1;
					if (d == 1'b0) 
						state <= S1100;
				end
				default: begin
					state <= INIT;
				end
			endcase
		end
	end

	
	always_comb begin
		case (state) 
			INIT: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end
			S1: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end
			S10: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end 
			S100: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 1;
				rec_6 = 0;
				rec_9 = 0;
			end 
			S1001: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 1;
			end 
			S11: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end 
			S110: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 1;
				rec_9 = 0;
			end
			S1100: begin
				rec_C = 1;
				rec_E = 0;
				rec_4 = 1;
				rec_6 = 0;
				rec_9 = 0;
			end
			S111:  begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end
			S1110: begin
				rec_C = 0;
				rec_E = 1;
				rec_4 = 0;
				rec_6 = 1;
				rec_9 = 0;
			end
			default: begin
				rec_C = 0;
				rec_E = 0;
				rec_4 = 0;
				rec_6 = 0;
				rec_9 = 0;
			end
		endcase
	end




endmodule
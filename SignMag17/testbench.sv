module testbench();
	logic [16:0] a_IN, b_IN, s_OUT, d_OUT;
	logic [15:0] a_mag, b_mag, s_mag, d_mag;
	logic OF_S, OF_D, A_S, B_S, S_S, D_S;
	
	assign a_IN = {A_S, a_mag[15:0]};
	assign b_IN = {B_S, b_mag[15:0]};
	assign {S_S, s_mag[15:0]} = s_OUT;
	assign {D_S, d_mag[15:0]} = d_OUT;
	
	SignMag17 dut(a_IN, b_IN, s_OUT, d_OUT, OF_S, OF_D);
	//SignMag17 dut({A_S, a}, {B_S, b}, {S_S, s}, {D_S, d}, OF_S, OF_D);
	
	initial begin
		A_S = 0; a_mag = 20000; B_S = 0; b_mag = 5000; #10; //1
		A_S = 0; a_mag = 40000; B_S = 0; b_mag = 40500; #10; //2
		A_S = 0; a_mag = 48000; B_S = 1; b_mag = 30500; #10; //3
		A_S = 0; a_mag = 8520; B_S = 1; b_mag = 12500; #10; //4
		A_S = 1; a_mag = 8520; B_S = 0; b_mag = 12500; #10; //5
		A_S = 1; a_mag = 48500; B_S = 0; b_mag = 32500; #10; //6
		A_S = 1; a_mag = 38500; B_S = 1; b_mag = 42500; #10; //7
		A_S = 1; a_mag = 20000; B_S = 1; b_mag = 12500; #10; //8
	end
	
endmodule
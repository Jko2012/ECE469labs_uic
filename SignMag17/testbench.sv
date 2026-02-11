module testbench();
	//logic [16:0] a_IN, b_IN, s_OUT, d_OUT;
	logic [15:0] a, b, s, d;
	logic OF_S, OF_D, A_S, B_S, S_S, D_S;
	
	//assign a_IN = {A_S, a[15:0]};
	//assign b_IN = {B_S, b[15:0]};
	//assign {S_S, s[15:0]} = s_OUT;
	//assign {D_S, d[15:0]} = d_OUT;
	
	//SignMag17 dut(a_IN, b_IN, s_OUT, d_OUT, OF_S, OF_D);
	SignMag17 dut({A_S, a}, {B_S, b}, {S_S, s}, {D_S, d}, OF_S, OF_D);
	
	initial begin
		A_S = 0; a = 20000; B_S = 0; b = 5000; #10; //1
		A_S = 0; a = 40000; B_S = 0; b = 40500; #10; //2
		A_S = 0; a = 48000; B_S = 0; b = 30500; #10; //3
		A_S = 0; a = 8520; B_S = 1; b = 12500; #10; //4
		A_S = 1; a = 8520; B_S = 0; b = 12500; #10; //5
		A_S = 1; a = 48500; B_S = 0; b = 32500; #10; //6
		A_S = 1; a = 38500; B_S = 1; b = 42500; #10; //7
		A_S = 1; a = 20300; B_S = 1; b = 12500; #10; //8
	end
	
endmodule
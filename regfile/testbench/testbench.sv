module testbench();
	logic clk, init;
	logic swapnow;
	logic [2:0] x, y;
	logic [3:0] r[7:0];
	
	//instantiate device under test
	regfile dut(clk, init, swapnow, x, y, r);


	always begin
		clk = 1; #5; clk = 0; #5;
	end
		
	initial begin
		swapnow = 0;
		init = 1; #27; init = 0; #10;		
		swapnow = 1; x = 0; y = 7; #10;
		swapnow = 0; #10;
		swapnow = 1; x = 1; y = 6; #10;
		swapnow = 0; #10;
		swapnow = 1; x = 2; y = 5; #10;
		swapnow = 0; #10;
		swapnow = 1; x = 3; y = 4; #10;
		swapnow = 0; #20;

		//second test [r0, …, r7] = [1, 2, 3, 4, 5, 6, 7, 0]
		swapnow = 1; x = 0; y = 6; #10;
		swapnow = 0; #10;
		swapnow = 1; x = 1; y = 5; #10;
		swapnow = 0; #10;
		swapnow = 1; x = 2; y = 4; #10;
		swapnow = 0; #20;

		//third test [r0, …, r7] = [3, 1, 5, 6, 0, 7, 4, 2]
		swapnow = 1; x = 0; y = 2; #10;
		swapnow = 0; #10; //[3, 2, 1, 4, 5, 6, 7, 0]
		swapnow = 1; x = 1; y = 4; #10;
		swapnow = 0; #10; //[3, 5, 1, 4, 2, 6, 7, 0]
		swapnow = 1; x = 1; y = 2; #10;
		swapnow = 0; #10; //[3, 1, 5, 4, 2, 6, 7, 0]
		swapnow = 1; x = 3; y =5; #10;
		swapnow = 0; #10; //[3, 1, 5, 6, 2, 4, 7, 0]
		swapnow = 1; x = 4; y = 7; #10;
		swapnow = 0; #10; //[3, 1, 5, 6, 0, 4, 7, 2]
		swapnow = 1; x = 5; y = 6; #10;
		swapnow = 0; #10; //[3, 1, 5, 6, 0, 7, 4, 2]

		#10;
		init = 1; #10;

	end
	
	


endmodule
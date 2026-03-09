module testbench();
	logic clk, reset;
	logic swapnow;
	logic [2:0] x, y;
	logic [3:0] r[7:0];
	
	//instantiate device under test
	regfile dut(clk, reset, swapnow, x, y, r);


	always begin
		clk = 1; #5; clk = 0; #5;
	end
		
	initial begin
		swapnow = 0;
		reset = 1; #27; reset = 0; #5;		
		
		$finish;
	end
	
	


endmodule
module testbench();
	logic [15:0] a, b, s, d;
	logic of_s, of_d, lessthan;
	//instatiate device under test
	signed_arth dut(a, b, s, d, of_s, of_d, lessthan);
	//apply test inputs
	initial begin
		a = 25000;		b = -20000; 		#10;
		a = -1000;  	b = 2000;			    		#10;
		a = 8000;  b = 1000; 		#10;
		a = -25000;		b = -20000;						#10;
		a = 10000;	b = -500;					#10;
		a = -25000;		b = 10000;			#10;
		a = 10000;		b = 30000; 						#10;
		a = -1000;  b = -2000;		#10;
	end
	
endmodule
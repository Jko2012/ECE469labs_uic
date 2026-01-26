module testbench();
	logic [0:15] a, b, s;
	logic cin, cout;
	//instatiate device under test
	cla16 dut(a, b, cin, s, cout);
	//apply test inputs
	initial begin
		a = 0;	b = 0; cin = 0; #10;
		a = 20;  b = 21;			  #10;
		a = 65535;  b = 1; cin = 1; #10;
	end
	
endmodule
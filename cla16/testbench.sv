module testbench();
	logic [15:0] a, b, s;
	logic cin, cout;
	//instatiate device under test
	cla16 dut(a, b, cin, s, cout);
	//apply test inputs
	initial begin
		a = 0;		b = 0; 		cin = 0; 	#10;
		a = 20;  	b = 21;			    		#10;
		a = 65534;  b = 1; 		cin = 1; 	#10;
						b = 2;						#10;
		a = 65535;	b = 65535;					#10;
		a = 387;		b = 1234;	cin = 0;		#10;
		a = 10;		b = 54; 						#10;
		a = 29084;  b = 2090;	cin = 1;		#10;
						b = 10000;					#10;
		a = 16;		b = 17;						#10;
	end
	
endmodule
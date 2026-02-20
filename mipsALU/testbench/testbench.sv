module testbench();
    logic clk, reset;
    logic [31:0] a, b, y, yexpected;
    logic [2:0] f;
    logic zero;
    logic [31:0] vectornum, errors; //bookkeeping vars
    logic [103:0] testvectors[100:0]; //array of testvectors

    //instantiate device under test
    alu dut(a, b, f, y, zero);

    // generate clock
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    //load vectors and pulse reset
    initial begin
        $readmemh("C:/Users/Julian/Documents/ECE469/mipsALU/testbench/alu.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end

    //apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; {f, a, b, yexpected, zero} = {testvectors[vectornum][102:4], testvectors[vectornum][0]};
    end

    //check results on falling edge of clk
    always @(negedge clk) begin
        if (~reset) begin
            if (y !== yexpected) begin
                $display("Error: inputs = a: %h, b: %h, f: %h", a, b, f);
                $display("  outputs = %h (%h expected)", y, yexpected);
                errors = errors + 1;
            end

            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 104'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end

        end
    end

endmodule
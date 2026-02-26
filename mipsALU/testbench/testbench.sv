module testbench();
    logic clk, reset;
    logic [31:0] a, b, y, yexpected;
    logic [2:0] f;
    logic zero, zexpected, overflow, ofexpected;
    logic [31:0] vectornum, y_errors, z_errors, of_errors; //bookkeeping vars
    logic [103:0] testvectors[100:0]; //array of testvectors

    //instantiate device under test
    alu dut(a, b, f, y, zero, overflow);

    // generate clock
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    //load vectors and pulse reset
    initial begin
        $readmemh("C:/Users/Julian/Documents/ECE469/mipsALU/testbench/alu.tv", testvectors);
        vectornum = 0; y_errors = 0; z_errors = 0; of_errors = 0;
        reset = 1; #27; reset = 0;
    end
    //  xfff_aaaaaaaa_bbbbbbbb_yyyyyyyy_xxzero/overflow
    //  xddd_hhhhhhhh_hhhhhhhh_hhhhhhhh_xxdd
    //  1_00000000_00000000_00000000_1


    //apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; {f, a, b, yexpected, zexpected, ofexpected} = {testvectors[vectornum][102:4], testvectors[vectornum][1:0]};
    end

    //check results on falling edge of clk
    always @(negedge clk) begin
        if (~reset) begin
            if (y !== yexpected) begin
                $display("Y Error: inputs = a: %h, b: %h, f: %h", a, b, f);
                $display("  outputs = %h (%h expected)", y, yexpected);
                y_errors = y_errors + 1;
            end
            if (zero !== zexpected) begin
                $display("Zero Error: inputs = a: %h, b: %h, f: %h", a, b, f);
                $display("  outputs = %b (%b expected)", zero, zexpected);
                z_errors = z_errors + 1;
            end
            if (overflow !== ofexpected) begin
                $display("Overflow Error: inputs = a: %h, b: %h, f: %h", a, b, f);
                $display("  outputs = %b (%b expected)", overflow, ofexpected);
                of_errors = of_errors + 1;
            end

            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 104'bx) begin
                $display("%d tests completed with %d y errors, %d z errors, %d overflow erros", vectornum, y_errors, z_errors, of_errors);
                $finish;
            end

        end
    end

endmodule
module testbench();
    logic clk, reset;
    logic d;
    logic rec_C, rec_E, rec_4, rec_6, rec_9;
    logic exp_C, exp_E, exp_4, exp_6, exp_9;
    logic [31:0] vectornum, errors;
    logic [5:0] testvectors [100:0];

    patternRecognizer dut(clk, reset, d, rec_C, rec_E, rec_4, rec_6, rec_9);

    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        //$readmemb("pattern_given.tv", testvectors);
        $readmemb("pattern_custom.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #17; reset = 0;
    end

    always @(negedge clk) begin
        {d, exp_C, exp_E, exp_4, exp_6, exp_9} = testvectors[vectornum];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if ({rec_C, rec_E, rec_4, rec_6, rec_9} != {exp_C, exp_E, exp_4, exp_6, exp_9}) begin
                $display("Error at cycle %d", vectornum);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 6'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $stop;
            end

        end
    end



endmodule
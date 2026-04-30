module testbench();
    logic clk, reset;
    logic [31:0] writedata, adr;
    logic memwrite;

    logic [167:0] testvectors[100:0];
    logic [31:0] clockcycle, errors;

    logic [3:0] zero_exp, reset_exp;
    logic [7:0] pc_exp, state_exp;
    logic [31:0] instr_exp, srca_exp, srcb_exp, aluresult_exp;
    logic [15:0] control_exp;

    top dut(clk, reset, writedata, adr, memwrite);
    
    always begin
        clk <= 1; #5; clk <= 0; #5;
    end

    initial begin
        $readmemh("testvectors.tv", testvectors);
        clockcycle = 0; errors = 0;
        reset = 1; #22; reset = 0;
    end

    always @(posedge clk) begin
        {reset_exp, pc_exp, instr_exp, state_exp, srca_exp, srcb_exp, aluresult_exp, zero_exp, control_exp} = testvectors[clockcycle];
    end

    always @(negedge clk) begin
        if (~reset) begin
            clockcycle = clockcycle + 1;
            if (dut.mem.RAM[21] === 7) begin
                $stop;
            end

            if ((control_exp != dut.mips.c.md.controls) || (srca_exp != dut.mips.dp.srca) || (srcb_exp != dut.mips.dp.srcb) || (aluresult_exp != dut.mips.dp.aluresult)) begin
                errors = errors + 1;
            end



        end
    end



endmodule
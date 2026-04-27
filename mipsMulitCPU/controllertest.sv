module controllertest();
    logic clk, reset;
    //signals for controller
    logic zero, pcen, irwrite, regwrite, alusrca, iord, memtoreg, regdst, memwrite;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;
    logic [5:0] op, funct;
    logic [31:0] vectornum, errors;
    logic [31:0] testvectors [100:0];

    controller dut(clk, reset, op, funct, zero, pcen, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol);

    always begin
        clk <= 1; #5; clk <= 0; #5;
    end

    initial begin
        $readmemh("memfile.dat", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #22; reset = 0;
    end


    always @(negedge clk) begin
        op = testvectors[vectornum][31:26];
        funct = testvectors[vectornum][5:0];
        zero = 1'b0;
    end

    always @(posedge clk) begin
        if (~reset) begin
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 31'bx) begin
                $stop;
            end
        end
    end



endmodule
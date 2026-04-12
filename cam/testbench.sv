module testbench ();
    logic clk, init;
    logic setD, found;
    logic [3:0] D_lookup, newD;
    logic [2:0] minAddr;

    cam8x4 dut(clk, init, D_lookup, setD, newD, minAddr, found);

    always begin
        clk = 1; #5; clk = 0; #5;
    end


    initial begin
        init = 1; #13; init = 0; #13;
        D_lookup = 4'b1101; setD = 0; #10; 
        D_lookup = 4'b1011; setD = 1; newD = 1110; #10;
        D_lookup = 4'b1110; setD = 0; #10; 
        D_lookup = 4'b1011; setD = 0; #10; 
        D_lookup = 4'b1110; setD = 1; newD = 1010; #10;
        D_lookup = 4'b1101; setD = 0; #10; 
    end



endmodule


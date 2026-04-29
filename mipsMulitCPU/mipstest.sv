module testbench();
    logic clk, reset;
    logic [31:0] writedata, adr;
    logic memwrite;


    top dut(clk, reset, writedata, adr, memwrite);
    



endmodule
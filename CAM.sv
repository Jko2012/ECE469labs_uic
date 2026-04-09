module cam8x4 (
    input  logic       clk,
    input  logic       init,
    input  logic [3:0] D_lookup,
    input  logic       setD,
    input  logic [3:0] newD,
    output logic [2:0] minAddr,
    output logic       found
);

    logic [3:0] r [0:7];
    integer i;

    always_ff @(posedge clk or posedge init) begin
        if (init) begin
            r[0] <= 4'h8;
            r[1] <= 4'h9;
            r[2] <= 4'hA;
            r[3] <= 4'hB;
            r[4] <= 4'hC;
            r[5] <= 4'hD;
            r[6] <= 4'hE;
            r[7] <= 4'hF;
        end
        else if (setD) begin
            for (i = 0; i < 8; i = i + 1) begin
                if (r[i] == D_lookup)
                    r[i] <= newD;   // update with newD if contains lookup
            end
        end
    end

    // comb lookup
    always_comb begin
        found   = 1'b0;
        minAddr = 3'b000;   // default

        for (int j = 0; j < 8; j = j + 1) begin
            if (!found && (r[j] == D_lookup)) begin
                found   = 1'b1;
                minAddr = j[2:0]; // loop starts from min to max addresses
            end
        end
    end

endmodule
module signed_arth(
input logic [15:0] A, B,
output logic [15:0] Sum,
output logic [15:0] Diff,
output logic OF_S, OF_D, LessThan
);
    logic Cin;
    logic Cout_S, Cout_D;
    
    // Sum calculation
    cla16 adder (
        .Ai(A),
        .Bi(B),
        .Cin(1'b0),
        .Sum(Sum),
        .Cout(Cout_S)
    );
    
    // Diff calculation
    cla16 subtractor (
        .Ai(A),
        .Bi(~B), // Two's complement subtraction
        .Cin(1'b1),
        .Sum(Diff),
        .Cout(Cout_D)
    );
    
    // Overflow detection for addition
    assign OF_S = (A[15] == B[15]) && (Sum[15] != A[15]);
    
    // Overflow detection for subtraction
    assign OF_D = (A[15] != B[15]) && (Diff[15] != A[15]);
    
    // Less than detection
    assign LessThan = Diff[15]; // If the sign bit of the difference is 1, A < B
endmodule

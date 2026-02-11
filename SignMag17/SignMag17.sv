//subtractor
module adder(
    input logic a,b,cin,
    output logic sum,cout);

    assign {cout,s} = a+b+cin;
endmodule

module subtractor(
    input logic [15:0] a,b,
	input logic add,
    output logic [15:0] diff,
    output logic OF);

    logic addnot;
    logic x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
    logic c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14;
    //invert add
    assign addnot = ~add;
    //xor gates
    assign x0 = b[0] ^ addnot;
    assign x1 = b[1] ^ addnot;
    assign x2 = b[2] ^ addnot;
    assign x3 = b[3] ^ addnot;
    assign x4 = b[4] ^ addnot;
    assign x5 = b[5] ^ addnot;
    assign x6 = b[6] ^ addnot;
    assign x7 = b[7] ^ addnot;
    assign x8 = b[8] ^ addnot;
    assign x9 = b[9] ^ addnot;
    assign x10 = b[10] ^ addnot;
    assign x11 = b[11] ^ addnot;
    assign x12 = b[12] ^ addnot;
    assign x13 = b[13] ^ addnot;
    assign x14 = b[14] ^ addnot;
    assign x15 = b[15] ^ addnot;
    //adder modules
    adder a0(a[0],x0,addnot,c0,diff[0]); //adder uses addnot as cin
    adder a1(a[1],x1,c0,c1,diff[1]);
    adder a2(a[2],x2,c1,c2,diff[2]);
    adder a3(a[3],x3,c2,c3,diff[3]);
    adder a4(a[4],x4,c3,c4,diff[4]);
    adder a5(a[5],x5,c4,c5,diff[5]);
    adder a6(a[6],x6,c5,c6,diff[6]);
    adder a7(a[7],x7,c6,c7,diff[7]);
    adder a8(a[8],x8,c7,c8,diff[8]);
    adder a9(a[9],x9,c8,c9,diff[9]);
    adder a10(a[10],x10,c9,c10,diff[10]);
    adder a11(a[11],x11,c10,c11,diff[11]);
    adder a12(a[12],x12,c11,c12,diff[12]);
    adder a13(a[13],x13,c12,c13,diff[13]);
    adder a14(a[14],x14,c13,c14,diff[14]);
    adder a15(a[15],x15,c14,OF,diff[15]); //adder outputs cout as OF
endmodule

module bit_lvl_gp (
	input logic Ai, Bi,
	output logic Gi, Pi);

	assign Gi = Ai & Bi;
	assign Pi = Ai | Bi;

endmodule

module blk_lvl_gp (
	input logic Gkj, Gik, Pkj, Pik, Cin,
	output logic Gij, Pij);

	assign Gij = Gik | (Gkj & Pik);
	assign Pij = Pik & Pkj;
	//assign Cout = Gij | (Pij & Cin);

endmodule

module Sum(
    input logic A,B,Cin,
    output logic S);
assign S = A ^ B ^ Cin;
endmodule

module PPA_Adder(
	input logic [15:0] A, B,
	output logic [15:0] sum,
	output logic cout);
logic [15:0] g, p;
logic c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
logic g10, g32, g54, g76, g98, g1110, g1312, g1514;
logic p32, p54, p76, p98, p1110, p1312, p1514;
logic g30, g74, g118, g1512, p74, p118, p1512;
logic g70, g158, p158, g150;
logic g110, g50, g90, g130, g20, g40, g60, g80, g100, g120, g140;
assign c0 = 0;

bit_lvl_gp gpbit0(A[0], B[0], g[0], p[0]);
bit_lvl_gp gpbit1(A[1], B[1], g[1], p[1]);
bit_lvl_gp gpbit2(A[2], B[2], g[2], p[2]);
bit_lvl_gp gpbit3(A[3], B[3], g[3], p[3]);
bit_lvl_gp gpbit4(A[4], B[4], g[4], p[4]);
bit_lvl_gp gpbit5(A[5], B[5], g[5], p[5]);
bit_lvl_gp gpbit6(A[6], B[6], g[6], p[6]);
bit_lvl_gp gpbit7(A[7], B[7], g[7], p[7]);
bit_lvl_gp gpbit8(A[8], B[8], g[8], p[8]);
bit_lvl_gp gpbit9(A[9], B[9], g[9], p[9]);
bit_lvl_gp gpbit10(A[10], B[10], g[10], p[10]);
bit_lvl_gp gpbit11(A[11], B[11], g[11], p[11]);
bit_lvl_gp gpbit12(A[12], B[12], g[12], p[12]);
bit_lvl_gp gpbit13(A[13], B[13], g[13], p[13]);
bit_lvl_gp gpbit14(A[14], B[14], g[14], p[14]);
bit_lvl_gp gpbit15(A[15], B[15], g[15], p[15]);
// 1bit bit_lvl_gp

blk_lvl_gp gpblk32(g[3], p[3], g[2], p[2], g32, p32);
blk_lvl_gp gpblk54(g[5], p[5], g[4], p[4], g54, p54);
blk_lvl_gp gpblk76(g[7], p[7], g[6], p[6], g76, p76);
blk_lvl_gp gpblk98(g[9], p[9], g[8], p[8], g98, p98);
blk_lvl_gp gpblk1110(g[11], p[11], g[10], p[10], g1110, p1110);
blk_lvl_gp gpblk1312(g[13], p[13], g[12], p[12], g1312, p1312);
blk_lvl_gp gpblk1514(g[15], p[15], g[14], p[14], g1514, p1514);
// 2bit blk_lvl_gp

blk_lvl_gp gblk10(g[1], p[1], g[0], g10);
// 2bit blk_lvl_gp

blk_lvl_gp gpblk74(g76, p76, g54, p54, g74, p74);
blk_lvl_gp gpblk118(g1110, p1110, g98, p98, g118, p118);
blk_lvl_gp gpblk1512(g1514, p1514, g1312, p1312, g1512, p1512);
// 4bit blk_lvl_gp

blk_lvl_gp gblk30(g32, p32, g10, g30);
// 4bit blk_lvl_gp

blk_lvl_gp gpblk158(g1512, p1512, g118, p118, g158, p158);
// 8bit blk_lvl_gp

blk_lvl_gp gblk07(g74, p74, g30, g70);
// 8bit blk_lvl_gp

blk_lvl_gp gblk150(g158, p158, g70, g150);
// 16bit blk_lvl_gp

blk_lvl_gp gblk110(g118, p118, g10, g110);
blk_lvl_gp gblk50(g54, p54, g30, g50);
blk_lvl_gp gblk90(g98, p98, g70, g90);
blk_lvl_gp gblk130(g1312, p1312, g110, g130);
blk_lvl_gp gblk20(g[2], p[2], g10, g20);
blk_lvl_gp gblk40(g[4], p[4], g30, g40);
blk_lvl_gp gblk60(g[6], p[6], g50, g60);
blk_lvl_gp gblk80(g[8], p[8], g70, g80);
blk_lvl_gp gblk100(g[10], p[10], g90, g100);
blk_lvl_gp gblk120(g[12], p[12], g110, g120);
blk_lvl_gp gblk140(g[14], p[14], g130, g140);
// final blk_lvl_gp

assign c1 = g[0];
assign c2 = g10;
assign c3 = g20;
assign c4 = g30;
assign c5 = g40;
assign c6 = g50;
assign c7 = g60;
assign c8 = g70;
assign c9 = g80;
assign c10 = g90;
assign c11 = g100;
assign c12 = g110;
assign c13 = g120;
assign c14 = g130;
assign c15 = g140;
assign c16 = g150;
assign cout = c16;
// carries

Sum sum0(A[0], B[0], c0, sum[0]);
Sum sum1(A[1], B[1], c1, sum[1]);
Sum sum2(A[2], B[2], c2, sum[2]);
Sum sum3(A[3], B[3], c3, sum[3]);
Sum sum4(A[4], B[4], c4, sum[4]);
Sum sum5(A[5], B[5], c5, sum[5]);
Sum sum6(A[6], B[6], c6, sum[6]);
Sum sum7(A[7], B[7], c7, sum[7]);
Sum sum8(A[8], B[8], c8, sum[8]);
Sum sum9(A[9], B[9], c9, sum[9]);
Sum sum10(A[10], B[10], c10, sum[10]);
Sum sum11(A[11], B[11], c11, sum[11]);
Sum sum12(A[12], B[12], c12, sum[12]);
Sum sum13(A[13], B[13], c13, sum[13]);
Sum sum14(A[14], B[14], c14, sum[14]);
Sum sum15(A[15], B[15], c15, sum[15]);
// summation

endmodule // PPA Adder

module SignMag17(
    input logic [16:0] A, B,
    output logic [16:0] S, D,
    output logic OF_S, OF_D);
logic [15:0] MagA, MagB, MagD, DifBA, DifAB, MSum, SDif, SumAB;
logic OF, msbD, OFBA, SnDif, inv, msbAB, OFAB, add, msbA, msbB, SnA, SnB, Csum, OFSD, SnSum, Cout, OFS, dummy;

assign MagA = A[15:0];
assign SnA = A[16];
assign MagB = B[15:0];
assign SnB = B[16];

assign msbA = MagA[15];
assign msbB = MagB[15];
assign add = SnA ^ SnB;

subtractor SubAB(MagA, MagB, add, DifAB, OFAB);
subtractor SubBA(MagB, MagA, add, DifBA, OFBA);
assign msbAB = DifAB[15];
assign inv = ~OFS;

assign SnDif = SnA & ~inv | ~SnB & inv;
assign MagD = inv ? DifBA : DifAB;
assign msbD = MagD[15];
assign OF = (inv ? OFBA : OFAB) & add;

PPA_Adder PPABKA(MagA, MagB, SumAB, Csum);
subtractor AddIsSub(inv ? MagB : MagA, inv ? MagA : MagB, 1'b0, SDif, OFSD);
subtractor OFSDetect(MagA, MagB, 1'b0, dummy, OFS);
assign MSum = add ? SDif : SumAB;
assign SnSum = SnA & ~inv | SnB & inv;
assign Cout = add ? ~OFSD : Csum;

assign D = {SnDif,MagD};
assign OF_D = OF;
assign S = {SnSum,MSum};
assign OF_S = Cout;
endmodule



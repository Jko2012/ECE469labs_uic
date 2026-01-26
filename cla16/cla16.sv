module cla16 (
    input logic [15:0] Ai, Bi,
    input logic Cin,
    output logic [15:0] Sum,
    output logic Cout);

    //bit level gp
    logic g0, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15;
    logic p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;

    bit_lvl_gp bitgp0(Ai[0], Bi[0], g0, p0);
    bit_lvl_gp bitgp1(Ai[1], Bi[1], g1, p1);
    bit_lvl_gp bitgp2(Ai[2], Bi[2], g2, p2);
    bit_lvl_gp bitgp3(Ai[3], Bi[3], g3, p3);
    bit_lvl_gp bitgp4(Ai[4], Bi[4], g4, p4);
    bit_lvl_gp bitgp5(Ai[5], Bi[5], g5, p5);
    bit_lvl_gp bitgp6(Ai[6], Bi[6], g6, p6);
    bit_lvl_gp bitgp7(Ai[7], Bi[7], g7, p7);
    bit_lvl_gp bitgp8(Ai[8], Bi[8], g8, p8);
    bit_lvl_gp bitgp9(Ai[9], Bi[9], g9, p9);
    bit_lvl_gp bitgp10(Ai[10], Bi[10], g10, p10);
    bit_lvl_gp bitgp11(Ai[11], Bi[11], g11, p11);
    bit_lvl_gp bitgp12(Ai[12], Bi[12], g12, p12);
    bit_lvl_gp bitgp13(Ai[13], Bi[13], g13, p13);
    bit_lvl_gp bitgp14(Ai[14], Bi[14], g14, p14);
    bit_lvl_gp bitgp15(Ai[15], Bi[15], g15, p15);


    //block level gp
    logic g01, g23, g45, g67, g89, g1011, g1213, g1415;
    logic p01, p23, p45, p67, p89, p1011, p1213, p1415;

    blk_lvl_gp blkgp01(g0, g1, p0, p1, Cin, g01, p01);
    blk_lvl_gp blkgp23(g2, g3, p2, p3, 1'b0, g23, p23);
    blk_lvl_gp blkgp45(g4, g5, p4, p5, 1'b0, g45, p45);
    blk_lvl_gp blkgp67(g6, g7, p6, p7, 1'b0, g67, p67);
    blk_lvl_gp blkgp89(g8, g9, p8, p9, 1'b0, g89, p89);
    blk_lvl_gp blkgp1011(g10, g11, p10, p11, 1'b0, g1011, p1011);
    blk_lvl_gp blkgp1213(g12, g13, p12, p13, 1'b0, g1213, p1213);
    blk_lvl_gp blkgp1415(g14, g15, p14, p15, 1'b0, g1415, p1415);

    logic g03, g47, g811, g1215;
    logic p03, p47, p811, p1215;

    blk_lvl_gp blkgp03(g01, g23, p01, p23, Cin, g03, p03);
    blk_lvl_gp blkgp47(g45, g67, p45, p67, 1'b0, g47, p47);
    blk_lvl_gp blkgp811(g89, g1011, p89, p1011, 1'b0, g811, p811);
    blk_lvl_gp blkgp1215(g1213, g1415, p1213, p1415, 1'b0, g1215, p1215);


    logic g07, g815;
    logic p07, p815;

    blk_lvl_gp blkgp07(g03, g47, p03, p47, Cin, g07, p07);
    blk_lvl_gp blkgp815(g811, g1215, p811, p1215, 1'b0, g815, p815);

    logic g015, p015;

    blk_lvl_gp blkgp015(g07, g815, p07, p815, 1'b0, g015, p015);


    //carry
    logic [15:0] c;
	 logic c16;

    assign c[0] = Cin;

    mod_carry carry0(g0, p0, Cin, c[1]);

    mod_carry carry1(g01, p01, Cin, c[2]);
    mod_carry carry2(g2, p2, c[2], c[3]);

    mod_carry carry3(g03, p03, Cin, c[4]);

    mod_carry carry4(g4, p4, c[4], c[5]);
    mod_carry carry5(g45, p45, c[4], c[6]);
    mod_carry carry6(g6, p6, c[6], c[7]);

    mod_carry carry7(g07, p07, Cin, c[8]);

    mod_carry carry8(g8, p8, c[8], c[9]);
    mod_carry carry9(g89, p89, c[9], c[10]);

    mod_carry carry10(g10, p10, c[10], c[11]);

    mod_carry carry11(g811, p811, c[10], c[12]);
    mod_carry carry12(g12, p12, c[12], c[13]);
    mod_carry carry13(g1213, p1213, c[12], c[14]);
    mod_carry carry14(g14, p14, c[14], c[15]);
    mod_carry carry15(g015, p015, Cin, c16);

    assign Cout = c16;

    //sum
    assign Sum = Ai ^ Bi ^ c;


endmodule

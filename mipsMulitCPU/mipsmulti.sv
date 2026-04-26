module mips(input logic clk, reset,
            output logic [31:0] adr, writedata,
            output logic memwrite,
            input logic [31:0] readdata);

    logic zero, pcen, irwrite, regwrite, alusrca, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;
    logic [5:0] op, funct;

    controller c(clk, reset, op, funct, zero, pcen, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol);
    datapath dp(clk, reset, pcen, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol, op, funct, zero, adr, writedata, readdata);
endmodule

module controller(  input logic clk, reset,
                    input logic [5:0] op, funct,
                    input logic zero,
                    output logic pcen, memwrite, irwrite, regwrite,
                    output logic alusrca, iord, memtoreg, regdst,
                    output logic [1:0] alusrcb, pcsrc,
                    output logic [2:0] alucontrol);
                    
    logic [1:0] aluop;
    logic branch, pcwrite;
    // Main Decoder and ALU Decoder subunits.
    maindec md(clk, reset, op, pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop);
    aludec ad(funct, aluop, alucontrol);

    // ADD CODE HERE
    // Add combinational logic (i.e. an assign statement)
    // to produce the PCEn signal (pcen) from the branch,
    // zero, and pcwrite signals
    assign pcen = (pcwrite | (branch & zero));

endmodule

module maindec( input logic clk, reset,
                input logic [5:0] op,
                output logic pcwrite, memwrite, irwrite, regwrite,
                output logic alusrca, branch, iord, memtoreg, regdst,
                output logic [1:0] alusrcb, pcsrc,
                output logic [1:0] aluop);

    parameter FETCH = 4'b0000; // State 0
    parameter DECODE = 4'b0001; // State 1
    parameter MEMADR = 4'b0010; // State 2
    parameter MEMRD = 4'b0011; // State 3
    parameter MEMWB = 4'b0100; // State 4
    parameter MEMWR = 4'b0101; // State 5
    parameter RTYPEEX = 4'b0110; // State 6
    parameter RTYPEWB = 4'b0111; // State 7
    parameter BEQEX = 4'b1000; // State 8
    parameter ADDIEX = 4'b1001; // State 9
    parameter ADDIWB = 4'b1010; // state 10
    parameter JEX = 4'b1011; // State 11
    parameter LW = 6'b100011; // Opcode for lw
    parameter SW = 6'b101011; // Opcode for sw
    parameter RTYPE = 6'b000000; // Opcode for R-type
    parameter BEQ = 6'b000100; // Opcode for beq
    parameter ADDI = 6'b001000; // Opcode for addi
    parameter J = 6'b000010; // Opcode for j

    logic [3:0] state, nextstate;
    logic [14:0] controls;

    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset) state <= FETCH;
        else state <= nextstate;
    end

    // ADD CODE HERE
    // Finish entering the next state logic below. The first
    // two states, FETCH and DECODE, have been completed for you.

    // next state logic
    always_comb begin
        case(state)
            FETCH: nextstate = DECODE;
            DECODE: case(op)
                LW: nextstate = MEMADR;
                SW: nextstate = MEMADR;
                RTYPE: nextstate = RTYPEEX;
                BEQ: nextstate = BEQEX;
                ADDI: nextstate = ADDIEX;
                J: nextstate = JEX;
                default: nextstate = 4'bx; // should never happen
            endcase
            // Add code here
            MEMADR: case(op)
                LW: nextstate = MEMRD;
                SW: nextstate = MEMWR;
                default: nextstate = 4'bx;
            endcase
            MEMRD: nextstate = MEMWB;
            MEMWB: nextstate = FETCH;
            MEMWR: nextstate = FETCH;
            RTYPEEX: nextstate = RTYPEWB;
            RTYPEWB: nextstate = FETCH;
            BEQEX: nextstate = FETCH;
            ADDIEX: nextstate = ADDIWB;
            ADDIWB: nextstate = FETCH;
            JEX: nextstate = FETCH;
            default: nextstate = 4'bx; // should never happen
        endcase
    end

    // output logic
    assign {pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop} = controls;

    // ADD CODE HERE
    // Finish entering the output logic below. The
    // output logic for the first two states, S0 and S1,
    // have been completed for you.
    always_comb begin
        case(state)
            FETCH: controls = 15'h5010;
            DECODE: controls = 15'h0030;
            // your code goes here
            MEMADR: controls = 15'h0420;
            MEMRD: controls = 15'h0100;
            MEMWB: controls = 15'h0880;
            MEMWR: controls = 15'h2100;
            RTYPEEX: controls = 15'h0402;
            RTYPEWB: controls = 15'h0840;
            BEQEX: controls = 15'h0605;
            ADDIEX: controls = 15'h0420;
            ADDIWB: controls = 15'h0800;
            JEX:  controls = 15'h4008;
            default: controls = 15'hxxxx; // should never happen
        endcase
    end

endmodule


module aludec(  input logic [5:0] funct,
                input logic [1:0] aluop,
                output logic [2:0] alucontrol);
    // ADD CODE HERE
    // Complete the design for the ALU Decoder.
    // Your design goes here. Remember that this is a combinational
    // module.

    // Remember that you may also reuse any code from previous labs.
    always_comb begin
        case(aluop)
            2'b00: alucontrol = 3'b010;  // add
            2'b01: alucontrol = 3'b110;  // sub
            default: case(funct)          // RTYPE
                6'b100000: alucontrol = 3'b010; // ADD
                6'b100010: alucontrol = 3'b110; // SUB
                6'b100100: alucontrol = 3'b000; // AND
                6'b100101: alucontrol = 3'b001; // OR
                6'b101010: alucontrol = 3'b111; // SLT
                default:   alucontrol = 3'bxxx; // ???
            endcase
        endcase
    end
endmodule


// Complete the datapath module below.

// The datapath unit is a structural verilog module. That is,
// it is composed of instances of its sub-modules. For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.
module datapath(input logic clk, reset,
                input logic pcen, irwrite, regwrite,
                input logic alusrca, iord, memtoreg, regdst,
                input logic [1:0] alusrcb, pcsrc,
                input logic [2:0] alucontrol,
                output logic [5:0] op, funct,
                output logic zero,
                output logic [31:0] adr, writedata,
                input logic [31:0] readdata);

    // Below are the internal signals of the datapath module.
    logic [4:0] writereg;
    logic [31:0] pcnext, pc;
    logic [31:0] instr, data, srca, srcb;
    logic [31:0] a;
    logic [31:0] aluresult, aluout;
    logic [31:0] signimm; // the sign-extended immediate
    logic [31:0] signimmsh; // the sign-extended immediate shifted left by 2
    logic [31:0] wd3, rd1, rd2;

    // op and funct fields to controller
    assign op = instr[31:26];
    assign funct = instr[5:0];

    // Your datapath hardware goes below. Instantiate each of the submodules
    // that you need. Remember that alu's, mux's and various other
    // versions of parameterizable modules are available in textbook 7.6

    // Here, parameterizable 3:1 and 4:1 muxes are provided below for your use.

    // Remember to give your instantiated modules applicable names
    // such as pcreg (PC register), wdmux (Write Data Mux), etc.
    // so it's easier to understand.

    // ADD CODE HERE

    // datapath

    //pc & address logic
    flopenr #(32)   pcreg(clk, reset, pcen, pcnext, pc);
    mux2 #(32)      pcmux(pc, aluout, iord, adr);

    //regfile logic
    flopenr #(32)   instreg(clk, reset, irwrite, readdata, instr);
    flopr #(32)     datareg(clk, reset, readdata, data);
    mux2 #(5)       regmux(instr[20:16], instr[15:11], regdst, writereg);
    mux2 #(32)      wdmux(aluout, data, memtoreg, wd3);

    //regfile
    regfile         rf(clk, regwrite, instr[25:21], instr[20:16], writereg, wd3, rd1, rd2);
    flopr #(32)     rd1reg(clk, reset, rd1, a);
    flopr #(32)     rd2reg(clk, reset, rd2, writedata);

    //alu logic
    mux2 #(32)      srcamux(pc, a, alusrca, srca);

    signext         immext(instr[15:0], signimm);
    sl2             immsl(signimm, signimmsh);
    mux4 #(32)      srcbmux(writedata, 32'd4, signimm, signimmsh, alusrcb, srcb);

    //alu
    alu             alu(srca, srcb, alucontrol, aluresult, zero);
    flopr #(32)     alureg(clk, reset, aluresult, aluout);

    //pcnext logic
    mux3 #(32)      pcsrcmux(aluresult, aluout, {pc[31:28], instr[25:0], 2'b00}, pcsrc, pcnext);

endmodule


module mux3 #(parameter WIDTH = 8) (
            input logic [WIDTH-1:0] d0, d1, d2,
            input logic [1:0] s,
            output logic [WIDTH-1:0] y);

    assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule

module mux4 #(parameter WIDTH = 8) (
            input logic [WIDTH-1:0] d0, d1, d2, d3,
            input logic [1:0] s,
            output logic [WIDTH-1:0] y);
    always_comb begin
        case(s)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            2'b11: y = d3;
        endcase
    end
endmodule


module mem( input logic clk, we,
            input logic [31:0] a, wd,
            output logic [31:0] rd);

    logic [31:0] RAM[63:0];
    // initialize memory with instructions
    initial begin
        $readmemh("memfile.dat",RAM);
        // "memfile.dat" contains your instructions in hex
        // you must create this file
    end

    assign rd = RAM[a[31:2]]; // word aligned

    always_ff @(posedge clk) begin
        if (we)
            RAM[a[31:2]] <= wd;
    end

endmodule

module top( input logic clk, reset,
            output logic [31:0] writedata, adr,
            output logic memwrite);
    logic [31:0] readdata;

    // microprocessor (control & datapath)
    mips mips(clk, reset, adr, writedata, memwrite, readdata);

    // memory
    mem mem(clk, memwrite, adr, writedata, readdata);

endmodule
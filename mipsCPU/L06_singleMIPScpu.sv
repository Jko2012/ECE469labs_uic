module RF(
  input logic [4:0] A1, A2, A3,
  input logic CLK, WE3,
  input logic [31:0] WD3,
  output logic [31:0] RD1, RD2
);

  logic [31:0] rf[31:0];

  always_ff @(posedge CLK) begin
  if (WE3 && A3 != 0)
    rf[A3] <= WD3;
  end

  assign RD1 = (A1 != 0) ? rf[A1] : 0;
  assign RD2 = (A2 != 0) ? rf[A2] : 0;
                
endmodule //RF

//submodule for ALU, PC
module adder(
  input logic [31:0] a, b,
  input logic cin,
  output logic [31:0]S,
  output logic cout);

  assign {cout, S} = a + b + cin; //idk if assign is. needed for syntax...
endmodule //adder



//adapted from Lab04
module ALU(
  input logic [31:0] SrcA, SrcB,
  input logic [2:0] ALUControl,
  output logic [31:0] ALUResult,
  output logic Zero //When ALUResult = 16'b0, Zero = 1
);
  logic [31:0] S, BB;
  logic cout;
  // logic ofs, ofd, OF
  
  assign BB = ALUControl[2] ? ~SrcB : SrcB;
  adder add1(SrcA, BB, ALUControl[2], S, cout);
  assign ALUResult = ALUControl[1] ? 
                   (ALUControl[0] ? {31'b0, (SrcA[31]^SrcB[31]) ? SrcA[31] : S[31]} : S)
                   : (ALUControl[0] ? SrcA | BB : SrcA & BB);
  assign Zero = (ALUResult == 32'h0);


  //assign ofs = (SrcA[31] ^ ~SrcB[31]) & (SrcA[31] ^ S[31]);
  //assign ofd = (SrcA[31] ^ SrcB[31]) & (SrcA[31] ^ S[31]);
  //assign OF = ALUControl[1] & ~ALUControl[0] & (~ALUControl[2] & ofs | ALUControl[2] & ofd);

endmodule //ALU

module DataMem(
  input logic CLK, WE,
  input logic [31:0] A, WD,
  output logic [31:0] RD
);

  logic [31:0] ram[63:0];

  assign RD = ram[A[31:2]];

  always_ff @(posedge CLK) begin
    if(WE)
      ram[A[31:2]] <= WD;
  end
endmodule //DataMem

module InstrMem(
  input logic [31:0] A,
  output logic [31:0] RD
);
  logic [31:0] ram[63:0];

  initial
    begin
      $readmemh("memefile.dat", ram);
    end

  assign RD = ram[A[31:2]];
endmodule //InstrMem

module CtrlUnit(
  input logic [5:0] Op, Funct,
  output logic MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump,
  output logic [2:0] ALUControl
);
  logic R_type, lw, sw, beq, addi, j;
  
  assign R_type = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & ~Op[1] & ~Op[0]; // 000000
  assign lw     =  Op[5] &  Op[4] & ~Op[3] & ~Op[2] &  Op[1] &  Op[0]; // 100011
  assign sw     =  Op[5] &  Op[4] & ~Op[3] &  Op[2] &  Op[1] &  Op[0]; // 101011
  assign beq    = ~Op[5] & ~Op[4] &  Op[3] & ~Op[2] & ~Op[1] & ~Op[0]; // 000100
  assign addi   =  Op[5]==0 & Op[4]==0 & Op[3]==1 & Op[2]==0 & Op[1]==0 & Op[0]==0; // 001000
  assign j      = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] &  Op[1] & ~Op[0]; // 000010

  assign RegWrite = R_type | lw | addi;
  assign RegDst   = R_type;
  assign ALUSrc   = lw | sw | addi;
  assign Branch   = beq;
  assign MemWrite = sw;
  assign MemtoReg = lw;
  assign Jump     = j;

  // ALU Control Logic
  logic [1:0] ALUOp;
  assign ALUOp[1] = R_type;
  assign ALUOp[0] = beq;

  always_comb begin
    case (ALUOp)
      2'b00: ALUControl = 3'b010; // lw/sw/addi → ADD
      2'b01: ALUControl = 3'b110; // beq → SUB
      2'b10: begin // R-type instructions
        case (Funct)
          6'b100000: ALUControl = 3'b010; // add
          6'b100010: ALUControl = 3'b110; // sub
          6'b100100: ALUControl = 3'b000; // and
          6'b100101: ALUControl = 3'b001; // or
          6'b101010: ALUControl = 3'b111; // slt
          default:   ALUControl = 3'bxxx; // Undefined
        endcase
      end
      default: ALUControl = 3'bxxx; // Undefined
    endcase
  end
endmodule //CtrlUnit

module mips(
  input logic clk, reset,
  input logic [31:0] Instr, ReadData,
  output logic [31:0] PC, ALUResult, WriteData
);
  logic [31:0] PCnot, PCBranch, PCPlus4, PCJump, ImmExt; //PC
  logic [31:0] SrcA, SrcB, Result; //ALU & Dmem
  logic [4:0] WriteReg;
  logic [2:0] ALUControl;
  logic MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, PCSrc, Jump; //control Unit


endmodule //mips

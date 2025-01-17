/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module Mux_2x1_NBits #(
    parameter Bits = 2
)
(
    input [0:0] sel,
    input [(Bits - 1):0] in_0,
    input [(Bits - 1):0] in_1,
    output reg [(Bits - 1):0] out
);
    always @ (*) begin
        case (sel)
            1'h0: out = in_0;
            1'h1: out = in_1;
            default:
                out = 'h0;
        endcase
    end
endmodule


module DIG_Register_BUS #(
    parameter Bits = 1
)
(
    input C,
    input en,
    input [(Bits - 1):0]D,
    output [(Bits - 1):0]Q
);

    reg [(Bits - 1):0] state = 'h0;

    assign Q = state;

    always @ (posedge C) begin
        if (en)
            state <= D;
   end
endmodule
module DIG_Add
#(
    parameter Bits = 1
)
(
    input [(Bits-1):0] a,
    input [(Bits-1):0] b,
    input c_i,
    output [(Bits - 1):0] s,
    output c_o
);
   wire [Bits:0] temp;

   assign temp = a + b + c_i;
   assign s = temp [(Bits-1):0];
   assign c_o = temp[Bits];
endmodule


module pcdecoder(
    input [31:0] vpc,
    output reg[9:0] ppc,
    output reg invpc
);

parameter [31:0] startp=32'h400000 ;
parameter [31:0] endp=32'h401000 ;

always @(*)
begin
    if(vpc>=startp 
    & vpc<endp)begin
            ppc = vpc - startp;
	    invpc = 1'b0;
    end else begin
        invpc = 1'b1;
        ppc = 7'dx;
    end
end
endmodule
module shift(
	input [9:0] in,
	output [9:0] out
);

assign out = in >> 2;

endmodule
module DIG_ROM_1024X32 (
    input [9:0] A,
    input sel,
    output reg [31:0] D
);
    reg [31:0] my_rom [0:4];

    always @ (*) begin
        if (~sel)
            D = 32'hz;
        else if (A > 10'h4)
            D = 32'h0;
        else
            D = my_rom[A];
    end

    initial begin
        my_rom[0] = 32'h3408aabb;
        my_rom[1] = 32'h3409a0b0;
        my_rom[2] = 32'h1094026;
        my_rom[3] = 32'h3908a0b0;
        my_rom[4] = 32'h8100004;
    end
endmodule

module JumpTarget(
	input [25:0] in,
	input [31:0] pc4,
	output [31:0] out 
);

assign out = {pc4[31:28], in, 2'b0};

endmodule
module BranchTarget(
	input [15:0] imm,
	input [31:0] pc4,
	output [31:0] out
);

wire [31:0] signExt;

assign signExt = {{16{imm[15]}}, imm};

assign out = {signExt[29:0], 2'b0} + pc4;

endmodule
module DIG_BitExtender #(
    parameter inputBits = 2,
    parameter outputBits = 4
)
(
    input [(inputBits-1):0] in,
    output [(outputBits - 1):0] out
);
    assign out = {{(outputBits - inputBits){in[inputBits - 1]}}, in};
endmodule



module controlunit(
    input [5:0] opcode,
    input [5:0] func,
    output reg [1:0]RegDst,
    output reg branch,
    output reg memread,
    output reg memwrite,
    output reg [1:0]memtoReg,
    output reg [2:0]ALUop,
    output reg Alusrc,
    output reg regwrite,
    output reg jump,
    output reg bne,
    output reg immS,
    output reg [1:0]dS,
    output reg btX,
    output reg iOp,
    output reg bgez,
    output reg bgtz,
    output reg blez,
    output reg bltz,
    output reg jal,
    output reg jr
);

always @(*)
begin
    case (opcode)
      6'd0://R-Format((add,sub,and,or,slt)//entrega4(sll,srl,sra,sllv,srlv,srav,)
      begin
            if(func==6'd8) begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop, jump, bne, immS} = 
            {2'b01, 1'b0,  2'b00,   1'b0,    1'b0,   1'b0,    1'b0,  3'b000,1'b0, 1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jal = 1'b0;
            jr = 1'b1;
            end else begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop, jump, bne, immS} = 
            {2'b01, 1'b0,  2'b00,   1'b1,    1'b0,   1'b0,    1'b0,  3'b010,1'b0, 1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jal = 1'b0;
            jr = 1'b0;
            end
      end
      6'd2://Jump
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
           
      end
      6'd3://JAL
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = 
            {2'b10, 1'b0,  2'b11,   1'b1,    1'b0,   1'b0,    1'b0,  3'b000,1'b1,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jal = 1'b1;
            jr = 1'b0;
           
      end
       
      6'd4://beq
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} =
             {2'b00,1'b0,2'b00,1'b0,1'b0,1'b0,1'b1,3'b001,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
            
      end
      6'd5://bne
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,3'b001,1'b0,1'b1,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
         
      end
      6'd8://addi
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
        
      end
      6'd9://addiu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
   
      end
      6'd10://slti
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = 
            {2'b00,  1'b1,  2'b00,   1'b1,    1'b0,   1'b0,    1'b0,  3'b110,1'b0,1'b0,1'b1};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
  
      end
       6'd11://sltiu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = 
            {2'b00,  1'b1,  2'b00,   1'b1,    1'b0,   1'b0,    1'b0,  3'b111,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
  
      end
      6'd12://andi
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b011,1'b0,1'b0,1'b1};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;

      end
      6'd13://ori
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b100,1'b0,1'b0,1'b1};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
  
      end
      6'd14://xori
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = 
            {2'b00,  1'b1,  2'b00,   1'b1,    1'b0,   1'b0,    1'b0,  3'b101,1'b0,1'b0,1'b1};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
  
      end
      6'd15://lui
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {2'b00,1'b0,2'b10,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
         
      end
      6'd32://lb
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
  
      end
      6'd33://lh
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
 
      end
      6'd35://loadword
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,  1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,  3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;

      end

      6'd36://lbu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
           
      end
      6'd37://lhu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx1
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
      
      end
     6'd40://sb
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
      end
      6'd41://sh
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {2'b00,   1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
            
      end
      6'd43://storeword
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS}
          = {2'b00,  1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,  3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
            bgez = 1'b0;
            bgtz = 1'b0;
            blez = 1'b0;
            bltz = 1'b0;
            jr = 1'b0;
            jal = 1'b0;
           
      end
      default: 
      begin
        {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {2'bxx,1'bx,2'bxx,1'bx,1'bx,1'bx,1'bx,3'bxxx,1'bx,1'bx,1'bx};
        dS=2'b00;
        btX=1'b0;
        iOp = 1'b1;
        bgez = 1'b0;
        bgtz = 1'b0;
        blez = 1'b0;
        bltz = 1'b0;
        jr = 1'b0;
        jal = 1'b0;
        
      end
            
    endcase
end

endmodule
module zeroExtension(
    input [15:0] n,
    output [31:0] res
);

assign res = {16'b0,n};

endmodule
module lui(
    input [15:0] n,
    output [31:0] res
);


assign res = {n,16'b0};

endmodule

module Mux_4x1_NBits #(
    parameter Bits = 2
)
(
    input [1:0] sel,
    input [(Bits - 1):0] in_0,
    input [(Bits - 1):0] in_1,
    input [(Bits - 1):0] in_2,
    input [(Bits - 1):0] in_3,
    output reg [(Bits - 1):0] out
);
    always @ (*) begin
        case (sel)
            2'h0: out = in_0;
            2'h1: out = in_1;
            2'h2: out = in_2;
            2'h3: out = in_3;
            default:
                out = 'h0;
        endcase
    end
endmodule

module alucontrol(
    input [2:0] aluop,
    input [5:0] func,
    output reg[3:0] op,
    output reg alurt,
    output reg [1:0] alurssa
);


always @(*)
begin
    case (aluop)
      3'b000:
      begin
            op = 4'd0;//suma para lw y sw
            alurt = 1'b0;
            alurssa = 2'd0;
      end
      3'b001:
      begin
            op = 4'd1;//resta para el beq
            alurt = 1'b0;
            alurssa = 2'd0;
      end
      3'b010://R-Format
            case (func)
                6'b000000://SLL
                begin
                        op = 4'd5;//shift left logic 
                        alurt = 1'b1;
                        alurssa = 2'd1;
                end
                6'b000010://SRL
                begin
                        op = 4'd6;//shift right logic 
                        alurt = 1'b1;
                        alurssa = 2'd1;
                end
                6'b000011://SRA
                begin
                        op = 4'd7;//shift right arithmetic
                        alurt = 1'b1;
                        alurssa = 2'd1;
                end
                6'b000100://SLLV
                begin
                        op = 4'd5;//shift left logic
                        alurt = 1'b1;
                        alurssa = 2'd2;//emtra rs como segundo
                end
                6'b000110://SRLV
                begin
                        op = 4'd6;//shift right logic
                        alurt = 1'b1;
                        alurssa = 2'd2;//emtra rs como segundo
                end
                6'b000111://SRAV
                begin
                        op = 4'd7;//shift right arithmetic
                        alurt = 1'b1;
                        alurssa = 2'd2;//emtra rs como segundo
                end
                6'b100000:
                begin
                        op = 4'd0;//suma 
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100001:
                begin
                        op = 4'd0;//addu
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100010:
                begin
                        op = 4'd1;//resta
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100011:
                begin
                        op= 4'd1;//subu
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100100:
                begin
                        op = 4'd2;//AND
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100101:
                begin
                        op = 4'd3;//OR
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b100110://XOR
                begin
                        op = 4'd8;
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b101010:
                begin
                        op = 4'd4;//set less than
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
                6'b101011://SLTU
                begin
                        op = 4'd9;
                        alurt = 1'b0;
                        alurssa = 2'd0;
                end
            default: 
            begin
                        op = 4'dx;
                        alurt = 1'b0;
                        alurssa = 2'd0;
            end
            endcase
        
        3'b011://and
        begin
                op = 4'd2;
                alurt = 1'b0;
                alurssa = 2'd0;
        end
        3'b100://or
        begin
                op = 4'd3;
                alurt = 1'b0;
                alurssa = 2'd0;
        end
        3'b101://xor
        begin
                op = 4'd3;
                alurt = 1'b0;
                alurssa = 2'd0;
        end
        3'b110://lessthansigned
        begin
                op = 4'd4;
                alurt = 1'b0;
                alurssa = 2'd0;
        end
        3'b111://lessthanunsigned
        begin
                op = 4'd9;
                alurt = 1'b0;
                alurssa = 2'd0;
        end
      default:
      begin
            op = 4'dx;
            alurt = 1'b0;
            alurssa = 2'd0; 
      end
    endcase
end

endmodule
module alu(
	input[31:0] a,
	input[31:0] b,
	input[3:0] op,
	output reg[31:0] r,
	output isZ
);

assign isZ = r == 32'd0;

always@(*)
begin
	case(op)
		4'd0: r = a + b;
		4'd1: r = a - b;
		4'd2: r = a & b;
		4'd3: r = a | b;
		4'd4: r = {31'd0, $signed(a) < $signed(b)};
        	4'd5: r = a << b;
        	4'd6: r = a >> b;
        	4'd7: r = $signed(a) >>> b;
		4'd8: r = a ^ b;
		4'd9: r = {31'd0, a<b};
		default: r = 32'dX;
	endcase
end

endmodule
module regfile(
input clk,
input [4:0]Ra,
input [4:0]Rb,
input [4:0]Rw,
input we,
input [31:0]din,
output reg [31:0]Da,
output reg [31:0]Db,
output [31:0] t_0,
output [31:0] t_1,
output [31:0] t_2,
output [31:0] t_3

);

reg [31:0] memory[31:0];
assign t_0 = memory[8];
assign t_1 = memory[9];
assign t_2 = memory[10];
assign t_3 = memory[11];

//seteando registros
//initial $readmemh("/home/alexander/Documents/MIPS32SOC-Part2/tests/hex/RegFile.mif", memory);
initial begin
memory[0] = 32'b0;
end

always @(posedge clk)
begin
    if(we & Rw > 0)
        memory[Rw]<=din;
    

end

always @(*)
begin
  
    
    Da<=memory[Ra];
    Db<=memory[Rb];
end
endmodule
module memoryDecoder(
    input [31:0] vAddr,
    input mW,
    input mR,
    output reg [12:0] pAd,
    output reg[2:0] mE,
    output reg[1:0] mB,
    output reg iAd
);

parameter [31:0] startg=32'h10010000;
parameter [31:0] endg=32'h10011000;
parameter [31:0] starts=32'h7FFFEFFC;
parameter [31:0] ends=32'h7FFFFFFC;
parameter [31:0] startvga=32'hb800;
parameter [31:0] endvga = 32'hcabf;
parameter [31:0] startio = 32'hffff0000;
parameter [31:0] endio = 32'hffff000f;
reg [31:0] temp;

always @(*)

if(mW | mR) 
begin
    if(vAddr>= startg & vAddr<endg)begin
        temp = vAddr - 32'h10010000;
	    pAd = temp;
        iAd = 1'b0;
        mE = 3'b001; //enable datamemory
        mB = 2'b00; //accediendo datamemory
    end else if(vAddr >= starts & vAddr<ends)begin
	temp= vAddr - 32'h7fffdffc;
     	pAd = temp;
        iAd = 1'b0;
        mE = 3'b001;//enable data memory
        mB = 2'b00;//accediendo datamemory
    end else if(vAddr>=startvga & vAddr<=endvga)begin
        temp = vAddr - 32'hb800;
        pAd = temp;
        iAd = 1'b0;
        mE = 3'b010;//enable vga
        mB = 2'b01;//accediendo vga
    end else if(vAddr>=startio & vAddr<=endio)begin
        temp = vAddr - 32'hFFFF0000;
        pAd = temp;
        iAd = 1'b0;
        mE = 3'b100;//enable I/O
        mB = 2'b10;//accediendio I/O
    end else begin
        pAd = 13'd0;
        iAd = 1'b1;
        mE = 3'b000;
        mB = 2'b00;
    end
end

endmodule
module MemoryRDataDecoder(
    input [31:0] inD,
    input [1:0] ofs,
    input bitX,
    input [1:0] ds,
    output reg[31:0] oD
);

always @(*)
    case (ds)
      2'b00://Word
      begin
        oD=inD;
      end
      2'b01://Half-Word
      begin
        case (ofs)
          2'b00:
              begin
                if(bitX) begin//do signExtend
                  oD={ {16{inD[31]}},inD[31:16]};
                end else begin
                  oD={16'b0,inD[31:16]};
                end
              end
              2'b01:
              begin
                if(bitX) begin//do signExtend
                  oD={ {16{inD[31]}},inD[31:16]};
                end else begin
                  oD={16'b0,inD[31:16]};
                end
              end
              2'b10:
              begin
                if(bitX) begin
                oD={ {16{inD[15]}},inD[15:0]};
                end else begin
                oD={16'b0,inD[15:0]};
                end
              end
              2'b11:
              begin
                if(bitX) begin
                oD={ {16{inD[15]}},inD[15:0]};
                end else begin
                oD={16'b0,inD[15:0]};
                end
              end
        endcase
      end 
      2'b10://Byte
      begin
        case (ofs)
          2'b00:
              begin
                if(bitX) begin//do signExtend
                  oD={ {24{inD[31]}} ,inD[31:24]};
                end else begin
                  oD={24'b0,inD[31:24]};
                end
              end
              2'b01:
              begin
                if(bitX) begin//do signExtend
                  oD={ {24{inD[23]}},inD[23:16]};
                end else begin
                  oD={24'b0,inD[23:16]};
                end
              end
              2'b10:
              begin
                if(bitX) begin//do signExtend
                  oD={ {24{inD[15]}},inD[15:8]};
                end else begin
                  oD={24'b0,inD[15:8]};
                end
              end
              2'b11:
              begin
                if(bitX) begin//do signExtend
                  oD={ {24{inD[7]}},inD[7:0]};
                end else begin
                  oD={24'b0,inD[7:0]};
                end
              end
        endcase
      end
      default: 
        oD=31'b0;
    endcase
endmodule
module MemoryWDataEncoder(
    input [31:0] inD,
    input [1:0]ofs,
    input iwe,
    input [1:0] ds,
    output reg[31:0] oD,
    output reg[3:0] owe
);

always @(*)
if(iwe)
begin
  case (ds)
        2'b00: //Word
        begin
            owe=4'b1111;
            oD = inD;
        end
        2'b01: //Half-Word
        begin
            case (ofs)
              2'b00:
              begin
                owe=4'b0011;
                oD=inD<<16;
              end
              2'b01:
              begin
                owe=4'b0011;
                oD=inD<<16;
              end
              2'b10:
              begin
                owe=4'b1100;
                oD={16'b0,inD[15:0]};
              end
              2'b11:
              begin
                owe=4'b1100;
                oD={16'b0,inD[15:0]};
              end
            endcase
        end
        2'b10: //Byte
        begin
            case(ofs)
              2'b00:
              begin
                owe=4'b0001;
                oD=inD<<24;
              end
              2'b01:
              begin
                owe=4'b0010;
                oD={8'b0,inD[7:0],16'b0};
              end
              2'b10:
              begin
                owe=4'b0100;
                oD={16'b0,inD[7:0],8'b0};
              end
              2'b11:
              begin
                owe=4'b1000;
                oD={24'b0,inD[7:0]};
              end
            endcase
        end
    default: 
        begin
        owe=4'bx;
        oD=31'bx;
        end
  endcase
end else begin
    owe=4'b0000;
    oD=31'b0;
end

endmodule
module cpustop(
    input ipc,
    input iAd,
    input iOp,
    output reg stop
);

always @(*)
if(ipc | iAd | iOp) begin
  stop = 1'b1;
end else begin
  stop = 1'b0;
end

endmodule

module DemuxBus2 #(
    parameter Bits = 2
)
(
    output [10:0] out_0,
    output [10:0] out_1,
    output [10:0] out_2,
    output [10:0] out_3,
    input [1:0] sel,
    input [10:0] in
);
    assign out_0 = (sel == 2'h0)? in : 11'h0;
    assign out_1 = (sel == 2'h1)? in : 11'h0;
    assign out_2 = (sel == 2'h2)? in : 11'h0;
    assign out_3 = (sel == 2'h3)? in : 11'h0;
endmodule

module DataMem(
    input clk, //! Clock input
    input en, //! Enable
    input [3:0] we, //! Per byte write enable
    input [10:0] addr, //! Address
    input [31:0] wd, //! Write data
    output [31:0] rd, //! Read data
    output [31:0] w
);
 
    reg [31:0] memory[0:2047];
    assign w = memory[0];
    assign rd = en? memory[addr] : 32'hz;


    always @(posedge clk)
    begin
        if (en) begin
            if (we[3]) memory[addr][7:0] <= wd[7:0];
            if (we[2]) memory[addr][15:8] <= wd[15:8];
            if (we[1]) memory[addr][23:16] <= wd[23:16];
            if (we[0]) memory[addr][31:24] <= wd[31:24];
        end
    end
 
`ifndef DIGITAL
    initial begin
        //$readmemh("/home/alexander/Documents/Organizacion de Computadoras/MIPS32SOC_Part1_Template/test_lb_data.mif", memory, 0, 1023);
	memory[0]=32'b0;
    end
`endif 
endmodule
module DataMemVGA(
    input clk, //! Clock input
    input en, //! Enable
    input [3:0] we, //! Per byte write enable
    input [10:0] addr, //! Address
    input [31:0] wd, //! Write data
    output [31:0] rd //! Read data
);
 
    reg [31:0] memory[0:2047];
 
    assign rd = en? memory[addr] : 32'hz;
 
    always @(posedge clk)
    begin
        if (en) begin
            if (we[3]) memory[addr][7:0] <= wd[7:0];
            if (we[2]) memory[addr][15:8] <= wd[15:8];
            if (we[1]) memory[addr][23:16] <= wd[23:16];
            if (we[0]) memory[addr][31:24] <= wd[31:24];
        end
    end
 
`ifndef DIGITAL
    initial begin
        //$readmemh("data.mif", memory, 0, 1023);
    end
`endif 
endmodule

module test_xor (
  input CLK,
  input reset,
  output invpc,
  output iAddr,
  output [31:0] t_0,
  output [31:0] t_1,
  output [31:0] t_2,
  output [10:0] error,
  output iOp,
  output [31:0] w_0,
  output [31:0] t_3
);
  wire [9:0] s0;
  wire [31:0] Ins;
  wire [31:0] s1;
  wire [31:0] s2;
  wire [31:0] \pc+4 ;
  wire jump;
  wire [31:0] s3;
  wire [31:0] s4;
  wire [31:0] s5;
  wire s6;
  wire [31:0] s7;
  wire [25:0] s8;
  wire [15:0] i_15_0;
  wire [31:0] s9;
  wire [31:0] s10;
  wire [3:0] opcontrol;
  wire [31:0] rvAddr;
  wire isZ;
  wire ALUsrc;
  wire [31:0] s11;
  wire [31:0] s12;
  wire [31:0] s13;
  wire [31:0] s14;
  wire [5:0] func;
  wire [4:0] sa;
  wire [4:0] rd;
  wire [4:0] rt;
  wire [4:0] rs;
  wire [5:0] op;
  wire [1:0] RegDst;
  wire [4:0] s15;
  wire datamEn;
  wire [3:0] s16;
  wire [10:0] dmAddr;
  wire [31:0] s17;
  wire [31:0] DMrd;
  wire regwrite;
  wire [31:0] rwd;
  wire [31:0] regA;
  wire branch;
  wire memread;
  wire memwrite;
  wire [1:0] memtoReg;
  wire [2:0] ALUop;
  wire branche;
  wire immS;
  wire [1:0] dS;
  wire btX;
  wire iOp_temp;
  wire bgez;
  wire bgtz;
  wire blez;
  wire bltz;
  wire jal;
  wire jr;
  wire alurt;
  wire [1:0] alurs;
  wire [9:0] s18;
  wire invpc_temp;
  wire [12:0] phyAddr;
  wire [2:0] s19;
  wire [1:0] mB;
  wire iAddr_temp;
  wire [31:0] s20;
  wire [31:0] s21;
  wire [31:0] s22;
  wire s23;
  wire [31:0] next_pc;
  wire [31:0] s24;
  wire [31:0] s25;
  wire [1:0] offs;
  wire VGAEn;
  wire [10:0] VGAAddr;
  wire [31:0] VGArd;
  wire IOEn;
  wire [10:0] s26;
  wire [10:0] IOAddr;
  wire [31:0] s27;
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i0 (
    .sel( reset ),
    .in_0( 32'b10000000000000000000000 ),
    .in_1( s24 ),
    .out( s1 )
  );
  // PC
  DIG_Register_BUS #(
    .Bits(32)
  )
  DIG_Register_BUS_i1 (
    .D( s1 ),
    .C( CLK ),
    .en( 1'b1 ),
    .Q( s2 )
  );
  // pc+4
  DIG_Add #(
    .Bits(32)
  )
  DIG_Add_i2 (
    .a( s2 ),
    .b( 32'b100 ),
    .c_i( 1'b0 ),
    .s( \pc+4  )
  );
  // pcdecoder
  pcdecoder pcdecoder_i3 (
    .vpc( s2 ),
    .ppc( s18 ),
    .invpc( invpc_temp )
  );
  // shift
  shift shift_i4 (
    .in( s18 ),
    .out( s0 )
  );
  // Ins_mem
  DIG_ROM_1024X32 DIG_ROM_1024X32_i5 (
    .A( s0 ),
    .sel( 1'b1 ),
    .D( Ins )
  );
  assign s8 = Ins[25:0];
  assign i_15_0 = Ins[15:0];
  assign func = Ins[5:0];
  assign sa = Ins[10:6];
  assign rd = Ins[15:11];
  assign rt = Ins[20:16];
  assign rs = Ins[25:21];
  assign op = Ins[31:26];
  // JumpTarget
  JumpTarget JumpTarget_i6 (
    .in( s8 ),
    .pc4( \pc+4  ),
    .out( s4 )
  );
  // BranchTarget
  BranchTarget BranchTarget_i7 (
    .imm( i_15_0 ),
    .pc4( \pc+4  ),
    .out( s7 )
  );
  // SignEx
  DIG_BitExtender #(
    .inputBits(16),
    .outputBits(32)
  )
  DIG_BitExtender_i8 (
    .in( i_15_0 ),
    .out( s14 )
  );
  // controlunit
  controlunit controlunit_i9 (
    .opcode( op ),
    .func( func ),
    .RegDst( RegDst ),
    .branch( branch ),
    .memread( memread ),
    .memwrite( memwrite ),
    .memtoReg( memtoReg ),
    .ALUop( ALUop ),
    .Alusrc( ALUsrc ),
    .regwrite( regwrite ),
    .jump( jump ),
    .bne( branche ),
    .immS( immS ),
    .dS( dS ),
    .btX( btX ),
    .iOp( iOp_temp ),
    .bgez( bgez ),
    .bgtz( bgtz ),
    .blez( blez ),
    .bltz( bltz ),
    .jal( jal ),
    .jr( jr )
  );
  // zeroExtension
  zeroExtension zeroExtension_i10 (
    .n( i_15_0 ),
    .res( s20 )
  );
  // lui
  lui lui_i11 (
    .n( i_15_0 ),
    .res( s21 )
  );
  // SignEx
  DIG_BitExtender #(
    .inputBits(5),
    .outputBits(32)
  )
  DIG_BitExtender_i12 (
    .in( sa ),
    .out( s27 )
  );
  Mux_4x1_NBits #(
    .Bits(5)
  )
  Mux_4x1_NBits_i13 (
    .sel( RegDst ),
    .in_0( rt ),
    .in_1( rd ),
    .in_2( 5'b11111 ),
    .in_3( 5'b0 ),
    .out( s15 )
  );
  // alucontrol
  alucontrol alucontrol_i14 (
    .aluop( ALUop ),
    .func( func ),
    .op( opcontrol ),
    .alurt( alurt ),
    .alurssa( alurs )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i15 (
    .sel( immS ),
    .in_0( s14 ),
    .in_1( s20 ),
    .out( s12 )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i16 (
    .sel( jump ),
    .in_0( s3 ),
    .in_1( s4 ),
    .out( s5 )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i17 (
    .sel( s6 ),
    .in_0( \pc+4  ),
    .in_1( s7 ),
    .out( s3 )
  );
  // alu
  alu alu_i18 (
    .a( s9 ),
    .b( s10 ),
    .op( opcontrol ),
    .r( rvAddr ),
    .isZ( isZ )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i19 (
    .sel( ALUsrc ),
    .in_0( s11 ),
    .in_1( s12 ),
    .out( s13 )
  );
  // regfile
  regfile regfile_i20 (
    .clk( CLK ),
    .Ra( rs ),
    .Rb( rt ),
    .Rw( s15 ),
    .we( regwrite ),
    .din( rwd ),
    .Da( regA ),
    .Db( s11 ),
    .t_0( t_0 ),
    .t_1( t_1 ),
    .t_2( t_2 ),
    .t_3( t_3 )
  );
  assign s6 = ((isZ & branch) | (branche & ~ isZ));
  // memoryDecoder
  memoryDecoder memoryDecoder_i21 (
    .vAddr( rvAddr ),
    .mW( memwrite ),
    .mR( memread ),
    .pAd( phyAddr ),
    .mE( s19 ),
    .mB( mB ),
    .iAd( iAddr_temp )
  );
  Mux_4x1_NBits #(
    .Bits(32)
  )
  Mux_4x1_NBits_i22 (
    .sel( memtoReg ),
    .in_0( rvAddr ),
    .in_1( s22 ),
    .in_2( s21 ),
    .in_3( \pc+4  ),
    .out( rwd )
  );
  // MemoryRDataDecoder
  MemoryRDataDecoder MemoryRDataDecoder_i23 (
    .inD( s25 ),
    .ofs( offs ),
    .bitX( btX ),
    .ds( dS ),
    .oD( s22 )
  );
  // MemoryWDataEncoder
  MemoryWDataEncoder MemoryWDataEncoder_i24 (
    .inD( s11 ),
    .ofs( offs ),
    .iwe( memwrite ),
    .ds( dS ),
    .oD( s17 ),
    .owe( s16 )
  );
  // cpustop
  cpustop cpustop_i25 (
    .ipc( invpc_temp ),
    .iAd( iAddr_temp ),
    .iOp( iOp_temp ),
    .stop( s23 )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i26 (
    .sel( alurt ),
    .in_0( regA ),
    .in_1( s11 ),
    .out( s9 )
  );
  Mux_4x1_NBits #(
    .Bits(32)
  )
  Mux_4x1_NBits_i27 (
    .sel( alurs ),
    .in_0( s13 ),
    .in_1( s27 ),
    .in_2( regA ),
    .in_3( 32'b0 ),
    .out( s10 )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i28 (
    .sel( jr ),
    .in_0( s5 ),
    .in_1( regA ),
    .out( next_pc )
  );
  Mux_2x1_NBits #(
    .Bits(32)
  )
  Mux_2x1_NBits_i29 (
    .sel( s23 ),
    .in_0( next_pc ),
    .in_1( 32'b0 ),
    .out( s24 )
  );
  assign datamEn = s19[0];
  assign VGAEn = s19[1];
  assign IOEn = s19[2];
  assign offs = phyAddr[1:0];
  assign s26 = phyAddr[12:2];
  DemuxBus2 #(
    .Bits(11)
  )
  DemuxBus2_i30 (
    .sel( mB ),
    .in( s26 ),
    .out_0( dmAddr ),
    .out_1( VGAAddr ),
    .out_2( IOAddr ),
    .out_3( error )
  );
  // DataMem
  DataMem DataMem_i31 (
    .clk( CLK ),
    .en( datamEn ),
    .we( s16 ),
    .addr( dmAddr ),
    .wd( s17 ),
    .rd( DMrd ),
    .w( w_0 )
  );
  // DataMemVGA
  DataMemVGA DataMemVGA_i32 (
    .clk( CLK ),
    .en( VGAEn ),
    .we( s16 ),
    .addr( VGAAddr ),
    .wd( s17 ),
    .rd( VGArd )
  );
  Mux_4x1_NBits #(
    .Bits(32)
  )
  Mux_4x1_NBits_i33 (
    .sel( mB ),
    .in_0( DMrd ),
    .in_1( VGArd ),
    .in_2( 32'b0 ),
    .in_3( 32'b0 ),
    .out( s25 )
  );
  assign invpc = invpc_temp;
  assign iAddr = iAddr_temp;
  assign iOp = iOp_temp;
endmodule

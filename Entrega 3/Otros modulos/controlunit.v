module controlunit(
    input [5:0] opcode,
    output reg RegDst,
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
    output reg iOp
);

always @(*)
begin
    case (opcode)
      6'd0://R-Format((add,sub,and,or,slt)
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b1,1'b0,2'b00,1'b1,1'b0,1'b0,1'b0,3'b010,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd2://Jump
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd4://beq
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b1,3'b001,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd5://bne
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,3'b001,1'b0,1'b1,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd8://addi
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd9://addiu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd12://andi
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b011,1'b0,1'b0,1'b1};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd13://ori
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b1,2'b00,1'b1,1'b0,1'b0,1'b0,3'b100,1'b0,1'b0,1'b1};
            dS=2'b00;dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd15://lui
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} = {1'b0,1'b0,2'b10,1'b1,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;
            btX=1'b0;
            iOp = 1'b0;
      end
      6'd32://lb
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd33://lh
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd35://loadword
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,  1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,  3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;//0-Word,1-HWord,2-byte
            btX=1'b1;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end

      6'd36://lbu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd37://lhu
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b01,   1'b1,    1'b1,   1'b0,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd40://sb
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b10;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd41://sh
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS} 
          = {1'b0,   1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,3'b000, 1'b0,1'b0,1'b0};
            dS=2'b01;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      6'd43://storeword
      begin
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne,immS}
          = {1'b0,  1'b1,  2'b00,   1'b0,    1'b0,   1'b1,    1'b0,  3'b000,1'b0,1'b0,1'b0};
            dS=2'b00;//0-Word,1-HWord,2-byte
            btX=1'b0;//1-SignEx,2-ZeroEx
            iOp = 1'b0;
      end
      default: 
      begin
        {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'bx,1'bx,2'bxx,1'bx,1'bx,1'bx,1'bx,3'bxxx,1'bx,1'bx,1'bx};
        dS=2'b00;
        btX=1'b0;
        iOp = 1'b1;
      end
            
    endcase
end

endmodule
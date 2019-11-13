module controlunit(
    input [5:0] opcode,
    output reg RegDst,
    output reg branch,
    output reg memread,
    output reg memwrite,
    output reg memtoReg,
    output reg [1:0]ALUop,
    output reg Alusrc,
    output reg regwrite,
    output reg jump,
    output reg bne
);

always @(*)
begin
    case (opcode)
      6'd0://R-Format((add,sub,and,or,slt)
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b1,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,2'b10,1'b0,1'b0};
      6'd2://Jump
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,2'b00,1'b1,1'b0};
      6'd4://beq
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,2'b01,1'b0,1'b0};
      6'd5://bne
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,2'b01,1'b0,1'b1};
      6'd35://load
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,2'b00,1'b0,1'b0};
      6'd43://store
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,1'b0,2'b00,1'b0,1'b0};

      default: 
            {RegDst,Alusrc,memtoReg,regwrite,memread,memwrite,branch,ALUop,jump,bne} = {1'bx,1'bx,1'bx,1'bx,1'bx,1'bx,1'bx,2'bxx,1'bx,1'bx};
    endcase
end

endmodule

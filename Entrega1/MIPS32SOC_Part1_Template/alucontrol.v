module alucontrol(
    input [1:0] aluop,
    input [5:0] func,
    output reg[2:0] op
);


always @(*)
begin
    case (aluop)
      2'b00:
            op = 3'd0;//suma para lw y sw
      2'b01:
            op = 3'd1;//resta para el beq
      2'b10://R-Format
            case (func)
                6'b100000:
                        op = 3'd0;//suma 
                6'b100010:
                        op = 3'd1;//resta
                6'b100100:
                        op = 3'd2;//AND
                6'b100101:
                        op = 3'd3;//OR
                6'b101010:
                        op = 3'd4;//set less than
            default: 
                        op = 3'dx;
            endcase
      default:
            op = 3'dx; 
    endcase
end

endmodule
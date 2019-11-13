module alucontrol(
    input [2:0] aluop,
    input [5:0] func,
    output reg[2:0] op
);


always @(*)
begin
    case (aluop)
      3'b000:
            op = 3'd0;//suma para lw y sw
      3'b001:
            op = 3'd1;//resta para el beq

      3'b010://R-Format
            case (func)
                6'b100000:
                        op = 3'd0;//suma 
                6'b100001:
                        op = 3'd0;//addu
                6'b100010:
                        op = 3'd1;//resta
                6'b100011:
                        op= 3'd1;//subu
                6'b100100:
                        op = 3'd2;//AND
                6'b100101:
                        op = 3'd3;//OR
                6'b101010:
                        op = 3'd4;//set less than
            default: 
                        op = 3'dx;
            endcase
        
        3'b011://and
                op = 3'd2;

        3'b100://or
                op = 3'd3;
      default:
            op = 3'dx; 
    endcase
end

endmodule
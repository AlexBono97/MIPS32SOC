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
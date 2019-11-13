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
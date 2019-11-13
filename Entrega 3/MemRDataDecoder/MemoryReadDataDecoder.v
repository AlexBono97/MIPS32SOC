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
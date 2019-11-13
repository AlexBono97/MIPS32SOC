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
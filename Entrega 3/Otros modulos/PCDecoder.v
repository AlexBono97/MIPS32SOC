module pcdecoder(
    input [31:0] vpc,
    output reg[9:0] ppc,
    output reg invpc
);

parameter [31:0] startp=32'h400000 ;
parameter [31:0] endp=32'h401000 ;
reg [31:0] temp;

always @(*)
begin
    if(vpc[31:0]>=startp 
    & vpc[31:0]<endp)begin
	    temp = vpc - startp;
            ppc = temp;
	    invpc = 1'b0;
    end else begin
        invpc = 1'b1;
        ppc = 7'dx;
    end
end
endmodule

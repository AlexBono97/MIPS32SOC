module memoryDecoder(
    input [31:0] vAddr,
    output reg [10:0] pAddr,
    output reg iAddr
);

parameter [31:0] startg=32'h10010000;
parameter [31:0] endg=32'h10011000;
parameter [31:0] starts=32'h7FFFEFFC;
parameter [31:0] ends=32'h7FFFFFFC;
parameter [31:0] sum = 32'd1024;
reg [31:0] temp;

always @(*)
begin
    if(vAddr>= startg & vAddr<endg)begin
        temp = vAddr - startg;
	pAddr = temp;
        iAddr = 1'b0;
    end else if(vAddr >= starts & vAddr<ends)begin
	temp= vAddr - starts;
     	pAddr = temp;
        iAddr = 1'b0;
    end else begin
        pAddr = 10'd0;
        iAddr = 1'b1;
    end
end

endmodule

module memoryDecoder(
    input [31:0] vAddr,
    input mW,
    input mR,
    output reg [12:0] pAd,
    output reg[2:0] mE,
    output reg[1:0] mB,
    output reg iAd
);

parameter [31:0] startg=32'h10010000;
parameter [31:0] endg=32'h10011000;
parameter [31:0] starts=32'h7FFFEFFC;
parameter [31:0] ends=32'h7FFFFFFC;
parameter [31:0] startvga=32'hb800;
parameter [31:0] endvga = 32'hcabf;
parameter [31:0] startio = 32'hffff0000;
parameter [31:0] endio = 32'hffff000f;
reg [31:0] temp;

always @(*)

if(mW | mR) 
begin
    if(vAddr>= startg & vAddr<endg)begin
        temp = vAddr - 32'h10010000;
	    pAd = temp;
        iAd = 1'b0;
        mE = 3'b001; //enable datamemory
        mB = 2'b00; //accediendo datamemory
    end else if(vAddr >= starts & vAddr<ends)begin
	temp= vAddr - 32'h7fffdffc;
     	pAd = temp;
        iAd = 1'b0;
        mE = 3'b001;//enable data memory
        mB = 2'b00;//accediendo datamemory
    end else if(vAddr>=startvga & vAddr<=endvga)begin
        temp = vAddr - 32'hb800;
        pAd = temp;
        iAd = 1'b0;
        mE = 3'b010;//enable vga
        mB = 2'b01;//accediendo vga
    end else if(vAddr>=startio & vAddr<=endio)begin
        temp = vAddr - 32'hFFFF0000;
        pAd = temp;
        iAd = 1'b0;
        mE = 3'b100;//enable I/O
        mB = 2'b10;//accediendio I/O
    end else begin
        pAd = 13'd0;
        iAd = 1'b1;
        mE = 3'b000;
        mB = 2'b00;
    end
end

endmodule

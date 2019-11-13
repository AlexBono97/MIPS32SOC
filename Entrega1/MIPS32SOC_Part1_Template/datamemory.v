module datamemory(
    input clk,
    input [7:0]addr,
    input [31:0]wData,
    input mwrite,
    input mread,
    output reg[31:0]rdata
); 

reg [63:0] memory[31:0];

always @(posedge clk)
begin
    if(mwrite)
        memory[addr]<=wData;
end

always @(*)
begin
    if(mread)
    	rdata<=memory[addr];
end

endmodule

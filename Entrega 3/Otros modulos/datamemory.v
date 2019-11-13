module datamemory(
    input clk,
    input [10:0]addr,
    input [31:0]wData,
    input mwrite,
    input mread,
    output reg[31:0]rdata
); 

parameter [31:0] startg=32'd0 ;
parameter [31:0] endg=32'd1023 ;
parameter [31:0] starts=32'd1024 ;
parameter [31:0] ends=32'd2047 ;

reg [1023:0] stack[31:0];
reg [1023:0] global[31:0];

always @(posedge clk)
begin
    if(mwrite)
        if(addr >=startg & addr <=endg)begin
        global[addr]<=wData;
        end
        else if(addr >=startg & addr <=endg)begin
            stack[addr]<=wData;
        end

end

always @(*)
begin
    if(mread)
        if(addr >=startg & addr <=endg)begin
        rdata<=global[addr];
        end
        else if(addr >=startg & addr <=endg)begin
            rdata<=stack[addr];
        end
    	
end

endmodule

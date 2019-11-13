module iomemory(
    input en,
    input [10:0] addr,
    input [7:0] keypad,
    input [31:0] mscounter,
    output reg [31:0] rd    
);

always @(*) begin
    if(en)
    begin
        if(addr==11'd1)
            rd = {keypad,24'b0};
        else if(addr==11'd2)
            rd = {mscounter};
        else
            rd = 32'b0;
    end
end

endmodule
module regfile(
input clk,
input [4:0]Ra,
input [4:0]Rb,
input [4:0]Rw,
input we,
input [31:0]din,
output reg [31:0]Da,
output reg [31:0]Db
);

reg [31:0] memory[31:0];
reg [3:0] k;
//seteando registros
initial begin
            for (k = 0; k <10; k = k + 1) begin
            memory[k] = k+1;
            end
end

always @(posedge clk)
begin
    if(we)
        memory[Rw]<=din;
    

end

always @(*)
begin
  
    
    Da<=memory[Ra];
    Db<=memory[Rb];
end
endmodule







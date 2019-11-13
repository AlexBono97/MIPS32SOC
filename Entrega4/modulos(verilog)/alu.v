module alu(
	input[31:0] a,
	input[31:0] b,
	input[3:0] op,
	output reg[31:0] r,
	output isZ
);

assign isZ = r == 32'd0;

always@(*)
begin
	case(op)
		4'd0: r = a + b;
		4'd1: r = a - b;
		4'd2: r = a & b;
		4'd3: r = a | b;
		4'd4: r = {31'd0, $signed(a) < $signed(b)};
        4'd5: r = a << b;
        4'd6: r = a >> b;
        4'd7: r = $signed(a) >>> b;
		4'd8: r = a ^ b;
		4'd9: r = {31'd0, a<b};
		default: r = 32'dX;
	endcase
end

endmodule
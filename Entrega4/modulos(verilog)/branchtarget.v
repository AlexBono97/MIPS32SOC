module BranchTarget(
	input [15:0] imm,
	input [31:0] pc4,
	output [31:0] out
);

wire [31:0] signExt;

assign signExt = {{16{imm[15]}}, imm};

assign out = {signExt[29:0], 2'b0} + pc4;

endmodule
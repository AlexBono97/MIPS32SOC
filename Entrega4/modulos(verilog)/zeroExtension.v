module zeroExtension(
    input [15:0] n,
    output [31:0] res
);

assign res = {16'b0,n};

endmodule
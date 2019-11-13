module lui(
    input [15:0] n,
    output [31:0] res
);


assign res = {n,16'b0};

endmodule
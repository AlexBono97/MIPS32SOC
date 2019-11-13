module branchresolver(
    input beq,
    input bne,
    input bgez,
    input bgtz,
    input blez,
    input bltz,
    input zero,
    input sign,
    output reg bt
);

always @(*)
begin
    if(beq & zero)
        bt=1'b1;
    else if(bne & !zero)
        bt=1'b1;
    else if(bgez & sign==1'b0)
        bt=1'b1;
    else if(bgtz & sign==1'b0 & zero==1'b0)
        bt=1'b1;
    else if(blez & (sign==1'b1 | zero==1'b0))
        bt=1'b1;
    else if(bltz & sign==1'b1)
        bt=1'b1;
    else
        bt=1'b0;
    
end

endmodule
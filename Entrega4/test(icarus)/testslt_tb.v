//  A testbench for testslt_tb
`timescale 1us/1ns

module testslt_tb;
    reg CLK;
    reg reset;
    wire invpc;
    wire iAddr;
    wire [31:0] t_0;
    wire [31:0] t_1;
    wire [31:0] t_2;
    wire [10:0] error;
    wire iOp;
    wire [31:0] w_0;
    wire [31:0] t_3;

  testslt testslt0 (
    .CLK(CLK),
    .reset(reset),
    .invpc(invpc),
    .iAddr(iAddr),
    .t_0(t_0),
    .t_1(t_1),
    .t_2(t_2),
    .error(error),
    .iOp(iOp),
    .w_0(w_0),
    .t_3(t_3)
  );

    reg [129:0] patterns[0:20];
    integer i;

    initial begin
      patterns[0] = 130'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[1] = 130'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[2] = 130'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[3] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[4] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[5] = 130'b0_1_11111111111111111111111111111100_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[6] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[7] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[8] = 130'b0_1_11111111111111111111111111111100_00000000000000000000000000000001_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[9] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[10] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[11] = 130'b0_1_11111111111111111111111111111100_00000000000000000000000000000000_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[12] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[13] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[14] = 130'b0_1_11111111111111111111111111111100_00000000000000000000000000000000_00000000000000000000000000000001_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[15] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[16] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[17] = 130'b0_1_11111111111111111111111111111100_00000000000000000000000000000000_00000000000000000000000000000000_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[18] = 130'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[19] = 130'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[20] = 130'b0_1_11111111111111111111111111111100_00000000000000000000000000000000_00000000000000000000000000000000_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

      for (i = 0; i < 21; i = i + 1)
      begin
        CLK = patterns[i][129];
        reset = patterns[i][128];
        #10;
        if (patterns[i][127:96] !== 32'hx)
        begin
          if (t_0 !== patterns[i][127:96])
          begin
            $display("%d:t_0: (assertion error). Expected %h, found %h", i, patterns[i][127:96], t_0);
            $finish;
          end
        end
        if (patterns[i][95:64] !== 32'hx)
        begin
          if (t_1 !== patterns[i][95:64])
          begin
            $display("%d:t_1: (assertion error). Expected %h, found %h", i, patterns[i][95:64], t_1);
            $finish;
          end
        end
        if (patterns[i][63:32] !== 32'hx)
        begin
          if (t_2 !== patterns[i][63:32])
          begin
            $display("%d:t_2: (assertion error). Expected %h, found %h", i, patterns[i][63:32], t_2);
            $finish;
          end
        end
        if (patterns[i][31:0] !== 32'hx)
        begin
          if (t_3 !== patterns[i][31:0])
          begin
            $display("%d:t_3: (assertion error). Expected %h, found %h", i, patterns[i][31:0], t_3);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule

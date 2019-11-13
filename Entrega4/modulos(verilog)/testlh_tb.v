//  A testbench for testlh_tb
`timescale 1us/1ns

module testlh_tb;
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

  testlh testlh0 (
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

    reg [161:0] patterns[0:23];
    integer i;

    initial begin
      patterns[0] = 162'b0_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[1] = 162'b1_1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[2] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[3] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[4] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[5] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[6] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[7] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[8] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[9] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[10] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[11] = 162'b0_0_00000000000000000001101010111011_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[12] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[13] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[14] = 162'b0_0_00000000000000000001101010111011_11111111111111111100110011011101_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[15] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[16] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[17] = 162'b0_0_00000000000000000001101010111011_11111111111111111100110011011101_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[18] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[19] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[20] = 162'b0_0_00000000000000000001101010111011_00000000000000001100110011011101_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[21] = 162'b0_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[22] = 162'b1_0_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      patterns[23] = 162'b0_0_00000000000000000001101010111011_00000000000000001100110011011101_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

      for (i = 0; i < 24; i = i + 1)
      begin
        CLK = patterns[i][161];
        reset = patterns[i][160];
        #10;
        if (patterns[i][159:128] !== 32'hx)
        begin
          if (t_0 !== patterns[i][159:128])
          begin
            $display("%d:t_0: (assertion error). Expected %h, found %h", i, patterns[i][159:128], t_0);
            $finish;
          end
        end
        if (patterns[i][127:96] !== 32'hx)
        begin
          if (t_1 !== patterns[i][127:96])
          begin
            $display("%d:t_1: (assertion error). Expected %h, found %h", i, patterns[i][127:96], t_1);
            $finish;
          end
        end
        if (patterns[i][95:64] !== 32'hx)
        begin
          if (t_2 !== patterns[i][95:64])
          begin
            $display("%d:t_2: (assertion error). Expected %h, found %h", i, patterns[i][95:64], t_2);
            $finish;
          end
        end
        if (patterns[i][63:32] !== 32'hx)
        begin
          if (t_3 !== patterns[i][63:32])
          begin
            $display("%d:t_3: (assertion error). Expected %h, found %h", i, patterns[i][63:32], t_3);
            $finish;
          end
        end
        if (patterns[i][31:0] !== 32'hx)
        begin
          if (w_0 !== patterns[i][31:0])
          begin
            $display("%d:w_0: (assertion error). Expected %h, found %h", i, patterns[i][31:0], w_0);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule

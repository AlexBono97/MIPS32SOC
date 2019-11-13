//  A testbench for testPcDecoder_tb
`timescale 1us/1ns

module testPcDecoder_tb;
    reg [31:0] inp;
    wire [9:0] ppc;
    wire ipc;

  testPcDecoder testPcDecoder0 (
    .inp(inp),
    .ppc(ppc),
    .ipc(ipc)
  );

    reg [42:0] patterns[0:6];
    integer i;

    initial begin
      patterns[0] = 43'b00000000010000000000000000000000_0000000000_0;
      patterns[1] = 43'b00000000010000000000000000000001_0000000001_0;
      patterns[2] = 43'b00000000010000000000000000000010_0000000010_0;
      patterns[3] = 43'b00000000010000000000000000000011_0000000011_0;
      patterns[4] = 43'b00000000010000000001000000000000_xxxxxxxxxx_1;
      patterns[5] = 43'b00000000001111111111111111111100_xxxxxxxxxx_1;
      patterns[6] = 43'b00000000010000000000111111111111_1111111111_0;

      for (i = 0; i < 7; i = i + 1)
      begin
        inp = patterns[i][42:11];
        #10;
        if (patterns[i][10:1] !== 10'hx)
        begin
          if (ppc !== patterns[i][10:1])
          begin
            $display("%d:ppc: (assertion error). Expected %h, found %h", i, patterns[i][10:1], ppc);
            $finish;
          end
        end
        if (patterns[i][0] !== 1'hx)
        begin
          if (ipc !== patterns[i][0])
          begin
            $display("%d:ipc: (assertion error). Expected %h, found %h", i, patterns[i][0], ipc);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule

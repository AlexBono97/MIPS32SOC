//  A testbench for testMemDecoder_tb
`timescale 1us/1ns

module testMemDecoder_tb;
    reg [31:0] \input ;
    wire [10:0] pAddr;
    wire iAddr;

  testMemDecoder testMemDecoder0 (
    .\input (\input ),
    .pAddr(pAddr),
    .iAddr(iAddr)
  );

    reg [43:0] patterns[0:21];
    integer i;

    initial begin
      patterns[0] = 44'b00010000000000010000000000000000_00000000000_0;
      patterns[1] = 44'b00010000000000010000000000000001_00000000001_0;
      patterns[2] = 44'b00010000000000010000000000000010_00000000010_0;
      patterns[3] = 44'b00010000000000010000000000000011_00000000011_0;
      patterns[4] = 44'b00010000000000010000000000000100_00000000100_0;
      patterns[5] = 44'b00010000000000010000000000000101_00000000101_0;
      patterns[6] = 44'b00010000000000010000000000000110_00000000110_0;
      patterns[7] = 44'b00010000000000010000000000000111_00000000111_0;
      patterns[8] = 44'b00010000000000010001000000000000_xxxxxxxxxxx_1;
      patterns[9] = 44'b00010000000000001111111111111111_xxxxxxxxxxx_1;
      patterns[10] = 44'b00010000000000010000111111111111_11111111111_0;
      patterns[11] = 44'b01111111111111111110111111111100_00000000000_0;
      patterns[12] = 44'b01111111111111111110111111111101_00000000001_0;
      patterns[13] = 44'b01111111111111111110111111111110_00000000010_0;
      patterns[14] = 44'b01111111111111111110111111111111_00000000011_0;
      patterns[15] = 44'b01111111111111111111000000000000_00000000100_0;
      patterns[16] = 44'b01111111111111111111000000000001_00000000101_0;
      patterns[17] = 44'b01111111111111111111000000000010_00000000110_0;
      patterns[18] = 44'b01111111111111111111000000000011_00000000111_0;
      patterns[19] = 44'b01111111111111111111111111111100_xxxxxxxxxxx_1;
      patterns[20] = 44'b01111111111111111110111111111011_xxxxxxxxxxx_1;
      patterns[21] = 44'b01111111111111111111111111111011_11111111111_0;

      for (i = 0; i < 22; i = i + 1)
      begin
        \input  = patterns[i][43:12];
        #10;
        if (patterns[i][11:1] !== 11'hx)
        begin
          if (pAddr !== patterns[i][11:1])
          begin
            $display("%d:pAddr: (assertion error). Expected %h, found %h", i, patterns[i][11:1], pAddr);
            $finish;
          end
        end
        if (patterns[i][0] !== 1'hx)
        begin
          if (iAddr !== patterns[i][0])
          begin
            $display("%d:iAddr: (assertion error). Expected %h, found %h", i, patterns[i][0], iAddr);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule

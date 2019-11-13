//  A testbench for testMemoryWDataEncoder_tb
`timescale 1us/1ns

module testMemoryWDataEncoder_tb;
    reg [31:0] inD;
    reg [1:0] Offs;
    reg mWrite;
    reg [1:0] dSize;
    wire [31:0] dOut;
    wire [3:0] weOut;

  testMemoryWDataEncoder testMemoryWDataEncoder0 (
    .inD(inD),
    .Offs(Offs),
    .mWrite(mWrite),
    .dSize(dSize),
    .dOut(dOut),
    .weOut(weOut)
  );

    reg [72:0] patterns[0:20];
    integer i;

    initial begin
      patterns[0] = 73'b10101010101110111100110011011101_00_1_00_10101010101110111100110011011101_1111;
      patterns[1] = 73'b10101010101110111100110011011101_01_1_00_10101010101110111100110011011101_1111;
      patterns[2] = 73'b10101010101110111100110011011101_10_1_00_10101010101110111100110011011101_1111;
      patterns[3] = 73'b10101010101110111100110011011101_11_1_00_10101010101110111100110011011101_1111;
      patterns[4] = 73'b10101010101110111100110011011101_00_1_01_11001100110111010000000000000000_0011;
      patterns[5] = 73'b10101010101110111100110011011101_01_1_01_11001100110111010000000000000000_0011;
      patterns[6] = 73'b10101010101110111100110011011101_10_1_01_00000000000000001100110011011101_1100;
      patterns[7] = 73'b10101010101110111100110011011101_11_1_01_00000000000000001100110011011101_1100;
      patterns[8] = 73'b10101010101110111100110011011101_00_1_10_11011101000000000000000000000000_0001;
      patterns[9] = 73'b10101010101110111100110011011101_01_1_10_00000000110111010000000000000000_0010;
      patterns[10] = 73'b10101010101110111100110011011101_10_1_10_00000000000000001101110100000000_0100;
      patterns[11] = 73'b10101010101110111100110011011101_11_1_10_00000000000000000000000011011101_1000;
      patterns[12] = 73'b10101010101110111100110011011101_00_0_00_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[13] = 73'b10101010101110111100110011011101_00_0_01_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[14] = 73'b10101010101110111100110011011101_00_0_10_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[15] = 73'b10101010101110111100110011011101_01_0_00_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[16] = 73'b10101010101110111100110011011101_01_0_01_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[17] = 73'b10101010101110111100110011011101_01_0_10_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[18] = 73'b10101010101110111100110011011101_10_0_00_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[19] = 73'b10101010101110111100110011011101_10_0_01_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;
      patterns[20] = 73'b10101010101110111100110011011101_10_0_10_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_0000;

      for (i = 0; i < 21; i = i + 1)
      begin
        inD = patterns[i][72:41];
        Offs = patterns[i][40:39];
        mWrite = patterns[i][38];
        dSize = patterns[i][37:36];
        #10;
        if (patterns[i][35:4] !== 32'hx)
        begin
          if (dOut !== patterns[i][35:4])
          begin
            $display("%d:dOut: (assertion error). Expected %h, found %h", i, patterns[i][35:4], dOut);
            $finish;
          end
        end
        if (patterns[i][3:0] !== 4'hx)
        begin
          if (weOut !== patterns[i][3:0])
          begin
            $display("%d:weOut: (assertion error). Expected %h, found %h", i, patterns[i][3:0], weOut);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule

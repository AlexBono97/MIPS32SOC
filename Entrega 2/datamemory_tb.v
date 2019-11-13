 module test;
 
 /* Test Bench*/
 reg [7:0] address=7'd12;
 reg [31:0]writeData=32'd2;
 reg memwrite =1'b1;
 reg memread = 1'b1;
 wire [31:0] readdata;
 /*Clock */
 reg clk =0;
 always #5 clk = !clk;

 initial
    begin
      $monitor("Resultado",readdata);
    end
 
 datamemory c(clk,address,writeData,memwrite,memread,readdata);

  /* Test Bench*/
 reg [7:0] address2=7'd10;
 reg [31:0]writeData2=32'd24;
 reg memwrite2 =1'b1;
 reg memread2 = 1'b1;
 wire [31:0] readdata2;
 /*Clock */
 reg clk2 =0;
 always #5 clk2 = !clk2;

 initial
    begin
      $monitor("Resultado",readdata2);
    end
 
datamemory k(clk2,address2,writeData2,memwrite2,memread2,readdata2);

 endmodule
 

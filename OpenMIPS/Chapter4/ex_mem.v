module ex_mem(
  input clk, rst,
  input [`RegAddrBus] ex_wd,
  input [`RegBus] ex_wdata,
  input ex_wreg,

  output reg[`RegAddrBus] mem_wd,
  output reg[`RegBus] mem_wdata,
  output reg mem_wreg
);

always @(posedge clk)begin
  if(rst == `RstEnable)begin
    mem_wd <= `NOPRegAddr;
    mem_wreg <= `WriteDisable;
    mem_wdata <= `ZeroWord;
  end
  else begin
    mem_wd <= ex_wd;
    mem_wreg <= ex_wreg;
    mem_wdata <= ex_wdata;
  end
end

endmodule

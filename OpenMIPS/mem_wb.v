module mem_wb(
  input clk, rst,
  input [`RegAddrBus] mem_wd,
  input [`RegBus] mem_wdata,
  input mem_wreg,

  output reg[`RegAddrBus] wb_wd,
  output reg[`RegBus] wb_wdata,
  output reg wb_wreg
);

always @(posedge clk)begin
  if(rst == `RstEnable)begin
    wb_wd <= `NOPRegAddr;
    wb_wreg <= `WriteDisable;
    wb_wdata <= `ZeroWord;
  end
  else begin
    wb_wd <= mem_wd;
    wb_wreg <= mem_wreg;
    wb_wdata <= mem_wdata;
  end
end

endmodule


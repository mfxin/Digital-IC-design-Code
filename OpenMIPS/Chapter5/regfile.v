module regfile(
  input clk,
  input rst,
  input we,
  input [`RegAddrBus] waddr,
  input [`RegBus] wdata,

  input re1,
  input [`RegAddrBus] raddr1,
  output reg[`RegBus] rdata1,

  input re2,
  input [`RegAddrBus] raddr2,
  output reg[`RegBus] rdata2
);

reg [`RegBus] regs[0:`RegNum-1];

//write op
always @(posedge clk)begin
  if(rst == `RstDisable)begin
    if((we == `WriteEnable) && (waddr != `RegNumLog2'h0))begin
      regs[waddr] <= wdata;
    end
  end
end

//read1 op
always @(*)begin
  if(rst == `RstEnable)
    rdata1 <= `ZeroWord;
  else if(raddr1 == `RegNumLog2'h0)
    rdata1 <= `ZeroWord;
  else if(raddr1==waddr && we==`WriteEnable 
          && re1==`ReadEnable)
    rdata1 <= wdata;
  else if(re1==`ReadEnable)
    rdata1 <= regs[raddr1];
  else
    rdata1 <= `ZeroWord;
end

//read2 op
always @(*)begin
  if(rst == `RstEnable)
    rdata2 <= `ZeroWord;
  else if(raddr2 == `RegNumLog2'h0)
    rdata2 <= `ZeroWord;
  else if(raddr2==waddr && we==`WriteEnable 
          && re2==`ReadEnable)
    rdata2 <= wdata;
  else if(re2==`ReadEnable)
    rdata2 <= regs[raddr2];
  else
    rdata2 <= `ZeroWord;
end

endmodule

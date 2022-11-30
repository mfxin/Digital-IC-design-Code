module pc_reg(
  input     clk,
  input     rst,
  output reg [`InstAddrBus] pc,
  output reg                ce
);

always @(posedge clk)begin
  if(rst == `RstEnable)
    ce <= `ChipDisable;
  else begin
    ce <= `ChipEnable;
  end
end

always @(posedge clk)begin
  if(ce == `ChipDisable)
    pc <= 32'h0000_0000;
  else
    pc <= pc + 4'h4;
end

endmodule

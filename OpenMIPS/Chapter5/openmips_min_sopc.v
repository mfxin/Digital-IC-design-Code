`include "defines.v"
`include "openmips.v"
`include "inst_rom.v"

module openmips_min_sopc(
  input rst,
  input clk
);

wire[`InstAddrBus] addr_i;
wire ce_i;
wire[`InstBus] inst_o;

inst_rom inst_rom0(
  .addr   (addr_i),
  .ce     (ce_i),
  .inst   (inst_o)
);

openmips  openmips0(
  .clk    (clk),
  .rst    (rst),
  .rom_ce_o   (ce_i),
  .rom_addr_o (addr_i),
  .rom_data_i (inst_o)
);


endmodule

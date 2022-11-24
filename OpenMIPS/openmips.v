`include "defines.v"
`include "ex.v"
`include "ex_mem.v"
`include "id.v"
`include "id_ex.v"
`include "if_id.v"
`include "mem.v"
`include "mem_wb.v"
`include "pc_reg.v"
`include "regfile.v"


module openmips(
  input rst, clk,
  input [`RegBus] rom_data_i,
  output [`RegBus] rom_addr_o,
  output rom_ce_o
);

//if/id id
wire[`InstAddrBus] pc;
wire[`InstAddrBus] id_pc_i;
wire[`InstBus] id_inst_i;

//id id_ex
wire[`AluOpBus] id_aluop_o;
wire[`AluOpBus] id_alusel_o;
wire[`RegBus] id_reg1_o;
wire[`RegBus] id_reg2_o;
wire          id_wreg_o;
wire[`RegAddrBus] id_wd_o;

//id_ex ex
wire[`AluOpBus] ex_aluop_i;
wire[`AluOpBus] ex_alusel_i;
wire[`RegBus] ex_reg1_i;
wire[`RegBus] ex_reg2_i;
wire          ex_wreg_i;
wire[`RegAddrBus] ex_wd_i;

//ex ex_mem
wire[`RegBus] ex_wdata_o;
wire[`RegAddrBus] ex_wd_o;
wire          ex_wreg_o;

//ex_mem mem
wire[`RegBus] mem_wdata_i;
wire[`RegAddrBus] mem_wd_i;
wire          mem_wreg_i;

//mem mem_wb
wire[`RegBus] mem_wdata_o;
wire[`RegAddrBus] mem_wd_o;
wire          mem_wreg_o;

//mem_wb wb
wire[`RegBus] wb_wdata_i;
wire[`RegAddrBus] wb_wd_i;
wire          wb_wreg_i;

//id regfile
wire          reg1_read;
wire          reg2_read;
wire[`RegBus] reg1_data;
wire[`RegBus] reg2_data;
wire[`RegAddrBus] reg1_addr;
wire[`RegAddrBus] reg2_addr;


//pc_reg.inst
pc_reg pc_reg0(
  .clk      (clk),
  .rst      (rst),
  .pc       (pc),
  .ce       (rom_ce_o)
);

assign rom_addr_o = pc;

//if_id.inst
if_id if_id0(
  .clk      (clk),
  .rst      (rst),
  .if_pc    (pc),
  .if_inst  (rom_data_i),
  .id_pc    (id_pc_i),
  .id_inst  (id_inst_i)
);

//id.inst
id id0(
  .rst      (rst),
  .pc_i     (id_pc_i),
  .inst_i   (id_inst_i),
  
  .reg1_data_i(reg1_data),
  .reg2_data_i(reg2_data),

  .reg1_read_o(reg1_read),
  .reg2_read_o(reg2_read),
  .reg1_addr_o(reg1_addr),
  .reg2_addr_o(reg2_addr),

  .aluop_o  (id_alusel_o),
  .alusel_o (id_alusel_o),
  .reg1_o   (id_reg1_o),
  .reg2_o   (id_reg2_o),
  .wd_o     (id_wd_o),
  .wreg_o   (id_wreg_o)
);

//regfile.inst
regfile regfile1(
  .clk      (clk),
  .rst      (rst),
  .we       (wb_wreg_i),
  .waddr    (wb_wd_i),
  .wdata    (wb_wdata_i),
  .re1      (reg1_read),
  .raddr1   (reg1_addr),
  .rdata1   (reg1_data),
  .re2      (reg2_read),
  .raddr2   (reg2_addr),
  .rdata2   (reg2_data)
);

//id_ex.inst
id_ex id_ex0(
  .clk      (clk),
  .rst      (rst),
  .id_aluop (id_aluop_o),
  .id_alusel(id_alusel_o),
  .id_reg1  (id_reg1_o),
  .id_reg2  (id_reg2_o),
  .id_wd    (id_wd_o),
  .id_wreg  (id_wreg_o),
  .ex_aluop (ex_aluop_i),
  .ex_alusel(ex_alusel_i),
  .ex_reg1  (ex_reg1_i),
  .ex_reg2  (ex_reg2_i),
  .ex_wd    (ex_wd_i),
  .ex_wreg  (ex_wreg_i)
);

//ex.inst
ex ex0(
  .rst      (rst),
  .aluop_i  (ex_aluop_i),
  .alusel_i (ex_alusel_i),
  .reg1_i   (ex_reg1_i),
  .reg2_i   (ex_reg2_i),
  .wd_i     (ex_wd_i),
  .wreg_i   (ex_wreg_i),
  .wd_o     (ex_wd_o),
  .wreg_o   (ex_wreg_o),
  .wdata_o  (ex_wdata_o)
);

//ex_mem.inst
ex_mem ex_mem0(
  .clk      (clk),
  .rst      (rst),

  .ex_wd    (ex_wd_o),
  .ex_wreg  (ex_wreg_o),
  .ex_wdata (ex_wdata_o),
  
  .mem_wd    (mem_wd_i),
  .mem_wreg  (mem_wreg_i),
  .mem_wdata (mem_wdata_i)
);

//mem.inst
mem mem0(
  .rst      (rst),
  .wd_i     (mem_wd_i),
  .wreg_i   (mem_wreg_i),
  .wdata_i  (mem_wdata_i),

  .wd_o     (mem_wd_o),
  .wreg_o   (mem_wreg_o),
  .wdata_o  (mem_wdata_o)
);

//mem_wb.inst
mem_wb mem_wb0(
  .clk    (clk),
  .rst    (rst),
  .mem_wd (mem_wd_o),
  .mem_wreg(mem_wreg_o),
  .mem_wdata(mem_wdata_o),

  .wb_wd  (wb_wd_i),
  .wb_wreg(wb_wreg_i),
  .wb_wdata(wb_wdata_i)
);


endmodule



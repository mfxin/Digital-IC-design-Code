module id(
  input rst,
  input [`InstAddrBus] pc_i,
  input [`InstBus] inst_i,

  input [`RegBus] reg1_data_i,
  input [`RegBus] reg2_data_i,
  
  output reg reg1_read_o,
  output reg reg2_read_o,
  output reg[`RegAddrBus] reg1_addr_o,
  output reg[`RegAddrBus] reg2_addr_o,

  output reg[`AluOpBus] aluop_o,
  output reg[`AluSelBus] alusel_o,
  output reg[`RegBus] reg1_o,
  output reg[`RegBus] reg2_o,
  output reg[`RegAddrBus] wd_o,
  output reg wreg_o,

  input ex_wreg_i,
  input [`RegBus] ex_wdata_i,
  input [`RegAddrBus] ex_wd_i,

  input mem_wreg_i,
  input [`RegBus] mem_wdata_i,
  input [`RegAddrBus] mem_wd_i
);

wire[5:0] op  = inst_i[31:26];
wire[4:0] op2 = inst_i[10:6];
wire[5:0] op3 = inst_i[5:0];
wire[4:0] op4 = inst_i[20:16];

reg [`RegBus] imm;
reg instvalid;

always @(*)begin
  if(rst == `RstEnable)begin
    aluop_o   <= `EXE_NOP_OP;
    alusel_o  <= `EXE_RES_NOP;
    wd_o      <= `NOPRegAddr;
    wreg_o    <= `WriteDisable;
    instvalid <= `InstValid;
    reg1_read_o <= 1'b0;
    reg2_read_o <= 1'b0;
    reg1_addr_o <= `NOPRegAddr;
    reg2_addr_o <= `NOPRegAddr;
    imm       <= 32'h0; 
  end
  else begin
    aluop_o   <= `EXE_NOP_OP;
    alusel_o  <= `EXE_RES_NOP;
    wd_o      <= inst_i[15:11];
    wreg_o    <= `WriteDisable;
    instvalid <= `InstInvalid;
    reg1_read_o <= 1'b0;
    reg2_read_o <= 1'b0;
    reg1_addr_o <= inst_i[25:21];
    reg2_addr_o <= inst_i[20:16];
    imm       <= 32'h0; 

    case(op)
      `EXE_SPECIAL_INST:begin
        case(op2)
          5'b00000:begin
            case(op3)
              `EXE_OR:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_OR_OP;
                 alusel_o <= `EXE_RES_LOGIC;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_AND:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_AND_OP;
                 alusel_o <= `EXE_RES_LOGIC;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_XOR:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_XOR_OP;
                 alusel_o <= `EXE_RES_LOGIC;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_NOR:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_NOR_OP;
                 alusel_o <= `EXE_RES_LOGIC;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_SLLV:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_SLL_OP;
                 alusel_o <= `EXE_RES_SHIFT;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_SRLV:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_SRL_OP;
                 alusel_o <= `EXE_RES_SHIFT;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_SRAV:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_SRA_OP;
                 alusel_o <= `EXE_RES_SHIFT;
                 reg1_read_o <= 1'b1;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              `EXE_SYNC:begin
                 wreg_o <= `WriteEnable;
                 aluop_o <= `EXE_NOP_OP;
                 alusel_o <= `EXE_RES_NOP;  
                 reg1_read_o <= 1'b0;
                 reg2_read_o <= 1'b1;
                 instvalid <= `InstValid;
              end
              default:begin end
            endcase
          end
          default:begin end
        endcase
      end
      `EXE_ORI:begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_OR_OP;
        alusel_o <= `EXE_RES_LOGIC;
        reg1_read_o <= 1'b1;
        reg2_read_o <= 1'b0;
        imm <= {16'h0, inst_i[15:0]};
        wd_o <= inst_i[20:16];
        instvalid <= `InstValid;
      end
      `EXE_ANDI:begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_AND_OP;
        alusel_o <= `EXE_RES_LOGIC;
        reg1_read_o <= 1'b1;
        reg2_read_o <= 1'b0;
        imm <= {16'h0, inst_i[15:0]};
        wd_o <= inst_i[20:16];
        instvalid <= `InstValid;
      end
      `EXE_XORI:begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_XOR_OP;
        alusel_o <= `EXE_RES_LOGIC;
        reg1_read_o <= 1'b1;
        reg2_read_o <= 1'b0;
        imm <= {16'h0, inst_i[15:0]};
        wd_o <= inst_i[20:16];
        instvalid <= `InstValid;
      end
      `EXE_LUI:begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_OR_OP;
        alusel_o <= `EXE_RES_LOGIC;
        reg1_read_o <= 1'b1;
        reg2_read_o <= 1'b0;
        imm <= {16'h0, inst_i[15:0]};
        wd_o <= inst_i[20:16];
        instvalid <= `InstValid;
      end
      `EXE_PREF:begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_NOP_OP;
        alusel_o <= `EXE_RES_NOP;  
        reg1_read_o <= 1'b1;
        reg2_read_o <= 1'b0;
        imm <= {16'h0, inst_i[15:0]};
        wd_o <= inst_i[20:16];
        instvalid <= `InstValid;
      end
      default:begin end
    endcase  //case op

    if(inst_i[31:21] == 11'b0)begin
      if(op3 == `EXE_SLL) begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_SLL_OP;
        alusel_o <= `EXE_RES_SHIFT;
        reg1_read_o <= 1'b0;
        reg2_read_o <= 1'b1;
        imm[4:0] <= inst_i[10:6];
        wd_o <= inst_i[15:11];
        instvalid <= `InstValid;  
      end
      else if(op3 == `EXE_SRL)begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_SRL_OP;
        alusel_o <= `EXE_RES_SHIFT;
        reg1_read_o <= 1'b0;
        reg2_read_o <= 1'b1;
        imm[4:0] <= inst_i[10:6];
        wd_o <= inst_i[15:11];
        instvalid <= `InstValid;
      end
      else if(op3 == `EXE_SRA)begin
        wreg_o <= `WriteEnable;
        aluop_o <= `EXE_SRA_OP;
        alusel_o <= `EXE_RES_SHIFT;
        reg1_read_o <= 1'b0;
        reg2_read_o <= 1'b1;
        imm[4:0] <= inst_i[10:6];
        wd_o <= inst_i[15:11];
        instvalid <= `InstValid;
      end
    end
  end
end

always @(*)begin
  if(rst == `RstEnable)begin
    reg1_o <= `ZeroWord;
  end
  else if(reg1_read_o==1'b1 && ex_wreg_i==1'b1 && ex_wd_i==reg1_addr_o)
    reg1_o <= ex_wdata_i;
  else if(reg1_read_o==1'b1 && mem_wreg_i==1'b1 && mem_wd_i==reg1_addr_o)
    reg1_o <= mem_wdata_i;
  else if(reg1_read_o == 1'b1)
    reg1_o <= reg1_data_i;
  else if(reg1_read_o == 1'b0)
    reg1_o <= imm;
  else
    reg1_o <= `ZeroWord;
end

always @(*)begin
  if(rst == `RstEnable)begin
    reg2_o <= `ZeroWord;
  end
  else if(reg2_read_o==1'b1 && ex_wreg_i==1'b1 && ex_wd_i==reg2_addr_o)
    reg2_o <= ex_wdata_i;
  else if(reg2_read_o==1'b1 && mem_wreg_i==1'b1 && mem_wd_i==reg2_addr_o)
    reg2_o <= mem_wdata_i;
  else if(reg2_read_o == 1'b1)
    reg2_o <= reg2_data_i;
  else if(reg2_read_o == 1'b0)
    reg2_o <= imm;
  else
    reg2_o <= `ZeroWord;
end

endmodule

module ex(
  input rst,

  input [`AluOpBus] aluop_i,
  input [`AluSelBus] alusel_i,
  input [`RegBus] reg1_i,
  input [`RegBus] reg2_i,
  input [`RegAddrBus] wd_i,
  input wreg_i,

  output reg[`RegAddrBus] wd_o,
  output reg wreg_o,
  output reg[`RegBus] wdata_o
);

reg [`RegBus] logicout;
reg [`RegBus] shiftres;


always @(*)begin
  if(rst == `RstEnable)begin
    logicout <= `ZeroWord;
  end
  else begin
    case(aluop_i)
      `EXE_OR_OP:begin logicout <= reg1_i | reg2_i; end
      `EXE_AND_OP:begin logicout <= reg1_i & reg2_i; end
      `EXE_NOR_OP:begin logicout <= ~(reg1_i | reg2_i); end
      `EXE_XOR_OP:begin logicout <= reg1_i ^ reg2_i; end
      default: logicout <= `ZeroWord;
    endcase
  end
end

always @(*)begin
  if(rst==`RstEnable)begin
    shiftres <= `ZeroWord;
  end
  else
    case(aluop_i)
      `EXE_SLL_OP:begin shiftres <= reg2_i << reg1_i[4:0]; end
      `EXE_SRL_OP:begin shiftres <= reg2_i >> reg1_i[4:0]; end
      `EXE_SRA_OP:begin shiftres <= ({32{reg2_i[31]}} << (6'd32-{1'b0,reg1_i[4:0]})) | reg2_i >> reg1_i[4:0]; end
      default: shiftres <= `ZeroWord;
    endcase
end

always @(*)begin
  wd_o <= wd_i;
  wreg_o <= wreg_i;
  case(alusel_i)  
    `EXE_RES_LOGIC: begin wdata_o <= logicout; end   //sel or_op
    `EXE_RES_SHIFT: begin wdata_o <= shiftres; end
    default: wdata_o <= `ZeroWord;
  endcase
end

endmodule

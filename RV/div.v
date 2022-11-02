module div(
  input clk,rst_n,
  input [63:0] dived_num,
  input [63:0] div_num,
  output [63:0] s_num,
  output [63:0] y_num
);
  reg [127:0]div_reg;
  reg [63:0] s_reg;
  reg [127:0] y_reg;

  reg [63:0] s_out;
  reg [63:0] y_out;
  int count;
  //init...
  always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
      s_reg <= 0;
      y_reg <= dived_num;
      div_reg <= {div_num,64'b0};
    end
    else begin
      y_reg = y_reg - div_reg;
      if(y_num[127])begin //2b
        y_reg = y_reg + div_reg;
        div_reg = div_reg >> 1;
        s_reg[0] = 0;
        s_reg = s_reg << 1;
      end
      else begin
        div_reg = div_reg >> 1;
        s_reg[0] = 1;
        s_reg = s_reg << 1;
      end
    end
  end

  always@(posedge clk or negedge rst_n)begin
    if(!rst_n || count == 65)
      count <= 0;
    else
      count <= count + 1;
  end

  always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
      s_out <= 0;
      y_out <= 0;
    end
    else if(count == 65)begin
      s_out <= s_reg;
      y_out <= y_reg[63:0];
    end
    else begin
      s_out <= s_out;
      y_out <= y_out;
    end
  end
  assign s_num = s_out;
  assign y_num = y_out;
endmodule

module clk_div#(parameter cfactor = 2)(
  input clk_in,
  input rst_n,
  output clk_out
);
  reg clk_loc;
  reg [7:0] cnt;
  assign clk_out = (cfactor==1) ? clk_in : clk_loc;
  always@(posedge clk_in or negedge rst_n)begin
    if(!rst_n)begin
      cnt <= 0;
      clk_loc <= 1;
    end
    else begin
      cnt = cnt + 1;
      if(cnt==cfactor/2 - 1)begin
        cnt <= 0;
        clk_loc <= ~clk_loc;
      end
      else begin
        clk_loc <= clk_loc;
        cnt <= cnt;
      end
    end
  end
endmodule

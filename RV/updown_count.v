module updown_count#(parameter N=8)(
  input clk, rst_n,
  input load,
  input up_down,
  input [N-1:0] preset_D,
  output [N-1:0] cnt_Q
);
  reg [N-1:0] cnt;
  assign cnt_Q = cnt;

  always@(posedge clk)begin
    if(!rst_n)
      cnt <= 0;
    else if(load)
      cnt <= preset_D;
    else if(up_down)
      cnt <= cnt - 1'b1;
    else
      cnt <= cnt + 1'b1;
  end
endmodule

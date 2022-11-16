module FSM_style1(
  input clk, rst_n,
  input in1, in2, in3,
  output reg out1, out2, out3
);
reg [1:0] state; //4 states
localparam  state0 = 2'b00,
            state1 = 2'b01,
            state2 = 2'b11,
            state3 = 2'b10;
always@(posedge clk)begin
  if(!rst_n)
    state <= state0;
  else begin
    case(state)
      state0:begin
        if(in1)begin
          out1 <= 1;
          state <= state1;
        end
        else
          state <= state0;
      end
      state1:begin
        out2 <= 1;
        state <= state2;
      end
      state2:begin
        if(in2)begin
          out3 <= 1;
          state <= state3;
        end
        else
          state <= state0;
      end
      state3:begin
        if(in3)
          state <= state0;
        else
          state <= state3;
      end
      default:begin
        state <= state0;
        out1 <= 0;
        out2 <= 0;
        out3 <= 0;
      end
    endcase
  end
end
endmodule

module FSM_style3(
  input clk, rst_n,
  input in1, in2, in3,
  output reg out1, out2, out3
);
reg [1:0] state; //4 states
reg [1:0] next_state; //4 states
localparam  state0 = 2'b00,
            state1 = 2'b01,
            state2 = 2'b11,
            state3 = 2'b10;
always@(*)begin
  case(state)
    state0:begin
      if(in1)
        next_state <= state1;
      else
        next_state <= state0;
    end
    state1:begin
      next_state <= state2;
    end
    state2:begin
      if(in2)
        next_state <= state3;
      else
        next_state <= state0;
    end
    state3:begin
      if(in3)
        next_state <= state0;
      else
        next_state <= state3;
    end
  endcase
end
always@(posedge clk)begin
  if(!rst_n)
    state <= state0;
  else
    state <= next_state;
end
always@(*)begin
  case(state)
    state0:{out1,out2,out3} = 3'b000;
    state1:{out1,out2,out3} = 3'b100;
    state2:{out1,out2,out3} = 3'b110;
    state3:{out1,out2,out3} = 3'b111;
    default:{out1,out2,out3} = 3'b000;
  endcase
end
endmodule

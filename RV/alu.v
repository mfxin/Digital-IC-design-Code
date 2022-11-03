module alu #(parameter N=8)(
  input [2:0] opcode,
  input [N-1:0] a,
  input [N-1:0] b,
  output [N-1:0] result
);
  reg [N-1:0]result_temp;
  localparam add = 3'b0;
  localparam min = 3'b001;
  localparam and_ = 3'b010;
  localparam or_  = 3'b011;
  assign result = result_temp;
  always@(*)begin
    case(opcode)
      add: result_temp <= a+b;
      min: result_temp <= a-b;
      and_: result_temp <= a&b;
      or_ : result_temp <= a|b;
      default:result_temp <= 'bx;
    endcase
  end
endmodule

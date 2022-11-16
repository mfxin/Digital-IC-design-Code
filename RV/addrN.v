module addrN #(parameter N = 4)(
  input [N-1:0] a,
  input [N-1:0] b,
  input         cin,

  output        cout,
  output[N-1:0] sum
);

assign {cout,sum} = a+b+cin;// <--> assign cout = (a+b+cin)[N];
                            // assign sum = (a+b+cin)[N-1:0];

endmodule

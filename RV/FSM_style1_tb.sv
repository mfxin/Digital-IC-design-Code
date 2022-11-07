interface FSM_io(input bit clk);
  logic rst_n;
  logic in1, in2, in3;
  logic out1, out2, out3;
  modport sti(
    input rst_n,clk,
    output in1,in2,in3
  );
endinterface

module stimulator(FSM_io.sti intf);
  initial begin:drive_reset
    @(negedge intf.rst_n);
    intf.in1 = 0;
    intf.in2 = 0;
    intf.in3 = 0;
  end
  initial begin:drive_proc
    @(negedge intf.rst_n);
    repeat(2) @(posedge intf.clk);
    repeat(100)begin
      @(posedge intf.clk);
      intf.in1 = $urandom_range(0,1);
      intf.in2 = $urandom_range(0,1);
      intf.in3 = $urandom_range(0,1);
    end
  end
endmodule
module FSM_tb;
  bit clk;
  initial forever #2ns clk = ~clk;

  FSM_io f1(clk);

  initial begin
    @(posedge f1.clk);
    f1.rst_n = 0;
    repeat(2) @(posedge f1.clk);
    f1.rst_n = 1;
    repeat(2) @(posedge f1.clk);
    f1.rst_n = 0;
    repeat(2) @(posedge f1.clk);
    f1.rst_n = 1;
  end

  stimulator sti(f1);
  FSM_style1 Fs1(
    .clk    (f1.clk),
    .rst_n  (f1.rst_n),
    .in1    (f1.in1),
    .in2    (f1.in2),
    .in3    (f1.in3),
    .out1    (f1.out1),
    .out2    (f1.out2),
    .out3    (f1.out3)
  );

endmodule

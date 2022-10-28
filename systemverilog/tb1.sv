module tb;
  bit [1:0] mode;
  bit [2:0] cfg;
  
  bit clk;
  always #2 clk = ~clk;

  covergroup cg@(posedge clk);
    Cfg:coverpoint cfg{
      option.auto_bin_max = 2;
      bins cfg_h = {[0:3]};
      bins cfg_l = {[4:7]};
      option.weight = 0; //setup quanzhong = 0, quit the point
    }
    Mode:coverpoint mode{
      bins mode_h = {1};
      bins mode_l = {[2:3]};
      bins zero = {0};
      option.weight = 0;
    }
    cross Mode, Cfg{
      option.weight = 20;
      ignore_bins hi = binsof(Cfg) intersect{7};
      ignore_bins lo = binsof(Mode.mode_h);
    }
  endgroup

  cg cg_inst;
  initial begin
    cg_inst = new();
    repeat(10) begin
      @(negedge clk);
      mode = $random;
      cfg = $random;
      //$display("[%0t]: mode = %0h cfg = %0h",$time, mode, cfg);
    end
  end

  initial begin
    #500
    $display("Coverage = %0.2f %%",cg_inst.get_coverage());
    $finish;
  end
endmodule

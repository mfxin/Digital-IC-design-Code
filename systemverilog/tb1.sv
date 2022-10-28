module tb;
  bit [1:0] mode;
  bit [2:0] cfg;
  
  bit clk;
  always #2 clk = ~clk;

  covergroup cg@(posedge clk);
    //coverpoint cfg{
    //  option.auto_bin_max = 2;
    //  bins cfg_h = {[0:3]};
    //  bins cfg_l = {[4:7]};
    //}
    coverpoint mode;
  endgroup

  cg cg_inst;
  initial begin
    cg_inst = new();
    for(int i=0; i<5; i++)begin
      @(negedge clk);
      mode = $random;
      cfg = $random;
      $display("[%0t]: mode = %0h cfg = %0h",$time, mode, cfg);
    end
  end

  initial begin
    #500
    $display("Coverage = %0.2f %%",cg_inst.get_coverage());
    $finish;
  end
endmodule

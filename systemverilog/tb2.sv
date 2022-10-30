class Transaction;
  rand bit[2:0] hdr_len;
  rand bit[3:0] payload_len;
  rand bit[4:0] len;
  rand bit[31:0] kind;
  rand bit[31:0] port;
  constraint length{
    len == hdr_len+payload_len;
    solve len before hdr_len,payload_len;
  }
endclass
program tb;
  Transaction tr;
  covergroup CovLen;
    coverpoint tr.port;
    option.per_instance = 1;
    option.comment = $psprintf("%m");

    kind:coverpoint tr.kind;
    port:coverpoint tr.port;
    cross kind,port;
    option.cross_num_print_missing=1000;
    option.goal = 90;
  endgroup
endprogram
module tb1;
bit [7:0]mode;
bit clk;
always #1ns clk=~clk;
covergroup Covmode(int mid);
  coverpoint mode{
    bins hi = {[0:mid-1]};
    bins lo = {[mid:7]};
  }
endgroup
Covmode cm;
initial begin
  cm = new(4);
  repeat(100)begin
    mode = $random;
    $display("mode = %0d",mode);
  end
  #500
  $display("%0t: coverage.mode = %0.2f %%",$time, cm.get_inst_coverage());
  $finish;

end


endmodule

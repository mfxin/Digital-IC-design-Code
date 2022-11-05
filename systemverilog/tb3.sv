//不使用unique 生成一个无重复元素的定长数组
class packet;
  rand bit[7:0] arr[8];
  constraint c1{
    foreach(arr[i])
      foreach(arr[j]) if(j!=i) arr[j]!=arr[i];
        }
endclass

module tb3;
  packet p;
  initial begin
    p = new;
    repeat(10)begin
      if(p.randomize) $display("p.arr = %p",p.arr);
      else $error("random is failed");
    end
  end
endmodule

module tb;
  initial begin
    bit [31:0] src[5] = '{0,1,2,3,4};
    bit [31:0] dst[5] = '{5,4,3,2,1};

    if(src == dst)
      $display("src = dst");
    else
      $display("src != dst");
    
    dst = src;
    src[0] = 5;
    $display(dst);
    foreach(src[i])
      $display("src[%d] = %d",i,src[i]);

  end
  initial begin
    int j = 1;
    int q[$] = {2,3};
    int q2[$] = {1,2};
    q.insert(2,q2[1]);

    $display(q);
  end
    initial begin
      bit [63:0] assoc[bit[63:0]];
      bit [63:0] idx = 1;
      repeat(64) begin
        assoc[idx] = idx;
        idx = idx<<1;
        $display("idx=%d",idx);
      end
      
      foreach(assoc[i])
        $display("assoc[%h]=%h", i, assoc[i]);
      
      $display("next state!!");
      if(assoc.first(idx)) begin
        do
          $display("assoc[%h]=%h", idx, assoc[idx]);
          while(assoc.next(idx));
      end
      
      $display("now the idx=%h",idx);
      $display("now the array has %0d elements!",assoc.num);

      assoc.first(idx);
      $display("now the idx=%h",idx);
      assoc.delete(idx);
      $display("now the array has %0d elements!",assoc.num);

    end
endmodule

module tb1;
function void push_back(ref int b[], input int a[], input int val);
  b = new[a.size()+1](a);
  b[a.size()] = val;
endfunction
function void pop_front(ref int b[]);
  foreach(b[i])
    if(i != b.size()-1)
      b[i] = b[i+1];
  b = new[b.size()-1](b);
endfunction
function void insert(input int pos, input int a[], output int b[], input int val);
  b = new[a.size()+1];
  foreach(b[i])
    if(i<pos)
      b[i] = a[i];
    else if(i==pos)
      b[pos] = val;
    else
      b[i] = a[i-1];
endfunction
initial begin
  int array1[] = '{1,2,3,4};
  int array2[] = '{1,2,3,4};
  int array3[] = '{1,2,3,4}; 
  push_back(array2,array2,5);
  foreach(array2[i]) begin
    $display("push_back : array[%0d]=%d", i, array2[i]);
  end
  pop_front(array1);
  foreach(array1[i]) begin
    $display("pop_front : array[%0d]=%d", i, array1[i]);
  end
  insert(2,array3,array3,9);
  foreach(array3[i])
    $display("insert : array[%0d]=%d", i, array3[i]);
end
endmodule

module tb2;
initial begin
 bit a[10];
int sum_;
int b;
 foreach(a[i]) begin
  a[i] = i;
    $display("a[%d] = %h",i, a[i]);
  end
  $display(a);
  sum_ = a.sum();
  $display("a.sum0 = %h",a.sum());
  $display("a.sum1 = %h",sum_);
  $display("a.sum2 = %h",a.sum()+32'd0);

  b = $urandom_range($size(a)-1);
  $display("b = %h",b);
end

endmodule
module tb3;
int a[] = '{9,1,8,3,4,4};
int count[$],totle[$];
int sum; //定义一个标量
initial begin
  count = a.find_index(x) with(x>7);
  totle = a.find with(item>7);
  $display(count,totle);
  $display(a);
  
  sum = a.sum(item) with(item > 7? item:0);
  //sum = a.sum(item) with((item > 7)*item);
  $display("sum=%d",sum);

end

endmodule

module tb4;
  int i;
  struct {bit[7:0] r,g,b;} pixel;  //声明一个结构体变量
  typedef struct {bit[7:0] r,g,b;} pixel_t;  //自定义结构体类型
  pixel_t my_pixel = '{
                        8'b00000001,
                        8'hff,
                        8'haa
                      };
  initial begin
 // my_pixel.r = 0;
 // $display("my_pixel = %h %h %h",my_pixel.r, my_pixel.g, my_pixel.b);                 

 // $display("next state..");
 // i = int'(10.0-0.1);
 // $display("i = %d",i);
    int h;
    bit [7:0] b,g[4],j[4] = '{8'ha, 8'hb, 8'hc, 8'hd};
    bit [7:0] q, r, s, t;
    
    
    {>>{q, r, s, t}} = j;
    h = {>>{t, s, r, q}};
    $display("h = %h",h);
    $display("q = %h",h);
    $display("r = %h",h);
    $display("s = %h",h);
    $display("t = %h",h);


  typedef enum {INIT=1,DECODE,IDLE} fsmstate_e;
  fsmstate_e pstate,nstate;
  
  //pstate = INIT;
  case(pstate)
    IDLE: nstate = INIT;
    INIT: nstate = DECODE;
    default: nstate = IDLE;
  endcase
  
  $display("next state = %d.",pstate);
  pstate = pstate.first();
  do 
    begin
      $display("pstate = %0d/%s",pstate, pstate.name());
      pstate = pstate.next();
    end
  while(pstate != pstate.first());
end
endmodule

module tb5;
  initial begin
    bit a = 1'b1;
    bit [7:0] sum;
    sum = a +a;
    $display(a+a);
  end
endmodule


module tb5;
initial begin
  integer array[10], sum, j;
  foreach(array[i])
    array[i] = i;
  $display(array);

  sum = array[0];
  j = 1;
  do begin
      sum+=array[j];
      j++;
    end
  while(j!=10);
  $display(sum);
end
endmodule


function multiple_lines();
  $display("the first line...");
endfunction

function void print_checksum(const ref bit [31:0]a[],
                             input int low = 0,
                             input int high = -1,output int checksum);
  bit[31:0] checksum = 0;
  if(high==-1)
    high = a.size()-1;
  for(int i=low; i<=high; i++)
    checksum += a[i];
endfunction

module tb6;
  bit [31:0]b[] = '{1,2,3,4};
  int checksum;
  initial begin
    multiple_lines();
    print_checksum(b,,,checksum);
    a1:assert(checksum==0)
        
      else $error("checksum is not right!");
    $display("sum = %d",checksum);
    // print_checksum(b,1,2);
   // print_checksum(b,1);
   // print_checksum(b,,2);
  end
endmodule

class packet_c;
  integer command;
  int id;
  static int data = 0;
  packet_c prv;
  function new(int i= -1);//keyi buyong dingyi
    command = i;
    id = data++;
  endfunction
endclass

module packet_m;
  integer command;
endmodule

typedef struct{
  integer command;
} packet_s;

module tb;
  packet_m m1();
  packet_s s1;
  packet_c c1;  //c1 named handle
  packet_c c3;
  initial begin
    packet_s s2;
    packet_c c2 = new();
    c1 = c2;
    c2.command = 5;
    $display("c3.data = %0d",c3.data);
    $display("c1 = %0d,c2 = %0d",c1.command,c2.command);
  end
endmodule
module tb2;
  packet_c linked_list[$];
  initial begin
    packet_c cur;
    for(int i=0; i<10; i++)begin
      cur = new(i);
      if(linked_list.size()>0)
        cur.prv = linked_list[$];
      linked_list.push_back(cur);
    end
  end

endmodule

class Transcation;
  bit [31:0] addr, crc, data[8];

  function void display;
    $display("Transcation: %h.",addr);
  endfunction

  function void calc_crc;
    crc = addr^data.xor;
  endfunction

  function new(int i=0);
    addr = i;
  endfunction

endclass

module tb7;
  Transcation tr = new(3);
  packet_c t1,t2;
  initial begin
    t1 = new();
    t2 = new();
    $display("t1.id = %0d; t2.id = %0d;\n data=%0d",t1.id,t2.id,packet_c :: data);
    $display("tr.addr = %0d.",tr.addr);
  end
endmodule

class packet;
  bit [31:0] addr;
  function packet copy;
    copy = new();
    copy.addr = this.addr;
  endfunction
endclass

class packet_1;
  bit [31:0] addr_1;
  packet t1;
  function new;
    t1 = new;
  endfunction
  function packet_1 copy;
    copy = new();
    copy.addr_1 = this.addr_1;
    copy.t1 = t1.copy;
  endfunction
endclass

module tb8;
  packet_1 src, dst;
  packet a;

  packet pkt;
  initial begin:copy_
    src = new;
    src.addr_1 = 2;
    src.t1.addr = 3;
    $display("src.t1.addr = %0d; \n src.addr_1 = %0d.",src.t1.addr, src.addr_1);
    //dst = new src;
    dst = src.copy;
    dst.t1.addr = 4;
    $display("dst.t1.addr = %0d; \n dst.addr_1 = %0d.",dst.t1.addr, dst.addr_1);
    dst.addr_1 = 5;
    $display("src.t1.addr = %0d; src.addr_1 = %0d; dst.t1.addr = %0d; dst.addr_1 = %0d. ",src.t1.addr, src.addr_1, dst.t1.addr, dst.addr_1);

    //packet pkt;
    //pkt = new;
    a = new;
    a.addr = 10;
    pkt = a.copy;
    $display("pkt.addr = %0d",pkt.addr);

  end
endmodule

class packet1;
  bit [31:0] addr;
  function packet1 copy;
    copy = new;
    copy.addr = this.addr;
  endfunction
endclass
class packet2;
  bit [31:0] addr;
  packet1 t1;
  function new;
    t1 = new;
  endfunction
  function packet2 copy;
    copy = new;
    copy.addr = this.addr;
    copy.t1 = t1.copy();
  endfunction
endclass

module tb;
packet2 a, b;
initial begin:copy
  a = new;
  a.addr = 3; //初始化变量
  a.t1.addr = 5; //初始化子类中的变量
  b = a.copy;  //创建一个新的对象，并复制以a为句柄的对象的变量值
  $display(b.addr, b.t1.addr);  //3  5
  //下面的code说明 b和a指向不同的对象，两个句柄的
  //子类也指向不同对象，两者互不干扰；
  b.addr = 0;
  b.t1.addr = 9;
  $display(b.addr, b.t1.addr);  //0  9
  $display(a.addr, a.t1.addr);  //3  5
end
endmodule


class random;
  int a;
  function random Inti;
    Inti = new;
    Inti.a = $urandom_range(0,10); //don't recommaned
  endfunction
endclass


class Packet;
  rand bit [31:0] src, dst, data[8];
  randc bit [7:0] kind;
  //src de yueshu
  constraint c{
    src > 10;
    src < 15;
  };
endclass

module tb9;

  function int sum(ref int a[]);
    sum = 0;
    foreach(a[i])
      sum += a[i];
    //for(int i=0; i<a.size(); i++)
    //  num_a += a[i]; 
  endfunction

  int a[] = '{1,2,3,4};
  int sum_a;


  //Packet p;
  initial begin
   // p = new;
   // assert(p.randomize())  //if success return 1; else return 0.
   // else $fatal(0,"Packet::randommize failed");
   // //transmit(p);
   // $display("p.src= %0d",p.src);
    sum_a = sum(a);
    $display(sum_a);
  end
endmodule

class Stim;
  const bit [31:0] CONGEST_ADDR = 42;
  typedef enum{READ, WRITE, CONTROL} stim_e;
  randc stim_e kind;
  rand bit [31:0] len, src, dst;
  bit congestion_test;

  constraint c_stim{
    len < 1000;
    len > 0;
    if(congestion_test){
      dst inside {[CONGEST_ADDR-100:CONGEST_ADDR+100]};
      src==CONGEST_ADDR;  //约束块内不能进行赋值，但是可以赋一个确定的值const
    }
    else
      src inside {0, [2:10], [100:107]};
  };
endclass
class Child;
  rand bit[31:0] age;  //here rand can't lose
  int array[9] = '{1,2,2,3,3,3,3,4,5};
  constraint c{
    age inside array;
  };
  constraint c1{
    age > 10;
    age < 20;
  };
endclass

class Randcinside;
  int arry[];
  rand int index;

  function new(input int a[]);
    arry = a;
  endfunction
  function int pick;
    pick = arry[index];
  endfunction
  constraint c{
    index < arry.size;
  };
endclass

class Unconstrained;
  rand bit a; // 0 1
  rand bit [1:0] b; // 0 1 2 3
endclass

class Bathtub;
  int value;
  int width = 50, depth = 4, seed = 1;
  function void pre_randomize;
    value = $dist_exponential(seed, depth);
    if(value > width)
      value = width;
    if($urandom_range(1))
      value = width - value;
  endfunction
endclass

module tb10;
  Child child;
  int count[6];
  initial begin
    child = new;
    child.c1.constraint_mode(0);
    repeat(50000) begin
      child.randomize();
      count[child.age]++;
    end
    foreach(count[i]) begin
      if(count[i])
        $display("count[%0d] = %0d;",i, count[i]);
    end
  end
endmodule


module tb11;
  bit[3:0] a[] = '{1,1,1,0,1,1,0};
  initial begin
    if(a.sum==4'h3)
      $display("right");
    else
      $display("error");
  end
endmodule

class Randcrange;
  randc bit [15:0] value;
  int max_value; //zuidazhi
  function new(int max_value=10);
    this.max_value = max_value;
  endfunction
  constraint c_value{
    value < max_value;
  };
endclass

class UniqueArray;
  int max_array_size, max_value;
  rand bit[7:0] a[];  //randomize array
  constraint c_size{
    a.size() inside {[1:max_array_size]};
  };
  function new(int max_array_size=2, int max_value=2);
    this.max_array_size = max_array_size;
    if(max_value < max_array_size) begin
      this.max_value = max_array_size;
    end
    else
      this.max_value = max_value;
  endfunction

  function void post_randomize;
    Randcrange r;
    r = new(max_value);
    foreach(a[i]) begin
      assert(r.randomize());
      a[i] = r.value;
    end
  endfunction

  function void display();
    $write("size: %3d:",a.size());
    foreach(a[i]) $write("%4d",a[i]);
    $display;
  endfunction
endclass

class array;
  rand bit[7:0] a[];
  constraint c{
    a.size inside {[1:10]};
  };
endclass 

module tb12;
  UniqueArray ua;
  array p;
  initial begin
    repeat(10) begin
    ua = new(50); //array_size =50;
    p = new;
    p.randomize();
    $display(p.a);
    //ua.post_randomize();
    assert(ua.randomize()); //didn't use post_randomize(), why success?
    ua.display();
  end
  end
endmodule

module tb13;
  int len;
  int count[4];
  initial begin
    $display("start!");
    repeat(1000) begin
      randcase
        1:len = $urandom_range(5);
        5:len = $urandom_range(6,10);
        4:len = $urandom_range(11,20);
      endcase
      if(len>=0 && len<=5)
        count[0]++;
      else if(len>=6 && len<=10)
        count[1]++;
      else if(len>=11 && len<=20)
        count[2]++;
      else
        count[3]++;
    end
    foreach(count[i])
      $display("count = %2d",count[i]);
    $display("finished!");
  end
endmodule
module tb14;
class Packet;
  integer i = 1;
  function new;
    i = 3;
  endfunction
  function integer get();
    get = i;
  endfunction
endclass
class LinkedPacket extends Packet;
  //integer i = 2;
  function new;
  endfunction
  function integer get();
    get = super.i - i;  //1 - 2
  endfunction
endclass
initial begin
  int j;
  Packet p = new;//父类句柄可以指向子类句柄
  LinkedPacket lp = new;
  $display("p.i = %2d",p.i);
  $display("lp.i = %2d",lp.i);
 end

endmodule

module tb14;
  initial begin
    for(int i=0; i<9; i++)
      forever begin
        $display("@%0t : open..",$time);
        //wait(i == 9);
        //@(i==9);
        #2;
        $display("@%0t : start!",$time);
      end
  end


endmodule


module tb15;
  class Transcation;
    bit [31:0] addr, crc, data[8];
    function void display;
      $display("Transcation: %h.",addr);
    endfunction
    function void calc_crc;
      crc = addr^data.xor;
    endfunction
    function new(int i=0);
      addr = i;
    endfunction
  endclass

  class Generator;
    Transcation tr;
    mailbox mbx;
    function new(mailbox mbx);
      this.mbx = mbx;
    endfunction
    task run(int count);
      repeat(count) begin
        tr = new;
        assert(tr.randomize());
        mbx.put(tr);
      end
    endtask
  endclass

  class Driver;
    Transcation tr;
    mailbox mbx;

    function new(mailbox mbx);
      this.mbx = mbx;
    endfunction
    task run(int count);
      repeat(count)begin
        mbx.get(tr);
      end
    endtask
  endclass

  mailbox mbx;
  Generator gen;
  Driver drv;
  int count;

  initial begin
    count = $urandom_range(50);
    mbx = new;   //creat mailbox
    gen = new(mbx);
    drv = new(mbx);
    fork
      gen.run(count);
      drv.run(count);
    join
  end
endmodule

module tb16;
  
  mailbox mbx;
  initial begin
    mbx = new(1);
    fork
      for(int i=1; i<4; i++) begin
        $display("producer:  before put %0d!",i);
        mbx.put(i);
        $display("producer:  after put %0d!",i);
      end
      repeat(4)begin
        int j;
        #5ns mbx.get(j);
        $display("j == %0d",j);
      end
    join
  end
endmodule
module tb16;
  mailbox mbx;  
  event handshake;
  class Gen;
    task run;
      for(int i=1; i<4; i++)begin
        $display("[GEN]: before put %0d",i);
        mbx.put(i);
        @handshake;
        $display("[GEN]: after put %0d",i);
      end
    endtask
  endclass
  class Consumer;
    task run;
      int i;
      repeat(3)begin
        mbx.get(i);
        $display("[CON]: %0d have gotten",i);
        ->handshake;
      end
    endtask
  endclass
  
  Gen gen;
  Consumer con;
  initial begin
    mbx = new();
    gen = new;
    con = new;
    fork
      gen.run;
      con.run;
    join
  end
endmodule


module tb16;
  mailbox mbx, rtn;  
  class Gen;
    task run;
      int k;
      for(int i=1; i<4; i++)begin
        $display("[GEN]: before put %0d",i);
        mbx.put(i);
        rtn.get(k);
        $display("[GEN]: after get %0d",k);
      end
    endtask
  endclass
  class Consumer;
    task run;
      int i;
      repeat(3)begin
        $display("[CON]: before get");
        mbx.get(i);
        $display("[CON]: after get %0d",i);
        rtn.put(-i);
      end
    endtask
  endclass
  
  Gen gen;
  Consumer con;
  initial begin
    mbx = new();
    rtn = new();
    gen = new;
    con = new;
    fork
      gen.run;
      con.run;
    join
  end
endmodule

package pkg_a;
  class ta;
  endclass
  int va=3;
endpackage
package pkg_b;
  class tb;
  endclass
  int vb;
endpackage
module tb2;
  initial begin
    pkg_a::ta pa = new;
    pkg_b::tb pb = new;
    $display(pkg_a::va);
  end
endmodule

class last;
  int la;
  function new(int val);
    la = val;
  endfunction
  function las;
    $display("[last]: here is last class");
  endfunction
endclass
class next extends last;
  int nxt;
  function new;
    super.new(10);
    nxt = 0;
  endfunction
  function nex;
    las();
    $display("[next]: la = ",la);
    $display("[next]: here is next class");
  endfunction
endclass
module tb17;
  next p;
  initial begin
    p = new;
    p.nex;
  end
endmodule

class Transaction;
  rand bit[31:0]src=10;
   function void display(input string prefix="");
    $display("%sTransaction: src=%0d",prefix, src);
  endfunction
endclass
class BadTr extends Transaction;
  bit bad_crc;
   function void display(input string prefix="");
    $display("%sBadTr: bad_crc=%b",prefix, bad_crc);
    super.display(prefix);
  endfunction
endclass
module tb18;
  Transaction tr;
  BadTr bad;
  initial begin
    bad = new;
    bad.display("[bad]");
    tr = bad;
    tr.display("[tr]");
    $display("bad.src = %0d",bad.src);
    $display("tr.src = %0d",tr.src);
  end
endmodule

class Tr;
  rand bit[31:0]src, dst, data[8];
  bit[31:0]crc;
  virtual function void copy_data(input Tr tr);
    tr.src = src;
    tr.dst = dst;
    tr.data = data;
    tr.crc = crc;
endfunction
  virtual function Tr copy();

    copy = new;
    copy_data(copy);
endfunction
endclass

class Packet;
  integer i =1;
  integer m =2;
  function new(int val);  //val = 3
    i = val+1;  // 4 = 0100
  endfunction
  function shift();
    i = i<<1;  //1000 = 8 
  endfunction
endclass
class linkedpacket extends Packet;
  integer i = 3;
  integer k = 5;
  function new(int val); // val = 1
    super.new(val);   //p.i = 2
    if(val >= 2)  //right
      i = val;   //3 = 0011
  endfunction
  function shift;
    super.shift;
    i = i<<2;  //1100  = 12
  endfunction
endclass

module tb;
  initial begin
    Packet p = new(3);
    linkedpacket lp = new(1);
    Packet tmp;
    tmp = lp;
    $display("p.i = %0d",p.i);
    $display("lp.i = %0d",lp.i);
    $display("tmp.i = %0d",tmp.i);
  end
endmodule

class Stack #(type T=int);
  local T stack[100];
  local int top = 0;
  function push(input T i);
    stack[++top] = i;
  endfunction
  function T pop;
    pop = stack[top--];
  endfunction
endclass

program tb18;
  Stack #(int) stk;
  int i =0;
  initial begin
    $display(i++);
    stk = new;
    repeat(10) begin stk.push(i); ++i; end
    for(int j=0; j<10; j++)
      $display(stk.pop);
  end
endprogram


program automatic test(busifc.TB ifc);
  class Transaction;
    rand bit [31:0] data;
    rand bit [2:0] port;
  endclass
  covergroup CovPort;
    coverpoint tr.port;
  endgroup
  initial begin
    Transaction tr;
    CovPort ck;
    ck = new;
    tr = new;
    repeat(32)begin
      assert(tr.randomize);
      ifc.cb.port <= tr.port;
      ifc.cb.data <= tr.data;
      ck.sample();
      @ifc.cb;
    end
  end
endprogram

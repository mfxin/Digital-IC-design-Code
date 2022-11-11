module tb;
//initial begin //0 2 4 1 3
//  // #10 $display("@ %0t: 0..",$time);
//  fork
//    #40 $display("@ %0t: 1..",$time);
//      #20 $display("@ %0t: 2..",$time);
//      #30 $display("@ %0t: 3..",$time);
//    #30 $display("@ %0t: 4..",$time);
//  join_none
//  disable fork;
//  #10 $display("@ %0t: 5..",$time);
//end
  event e1,e2,e3;
  
  task automatic wait_event(event e, string name);
    $display("@%t start waiting event %s",$time, name);
    @e;
    $display("@%t finish waiting event %s",$time, name);
  endtask
  
  initial begin
    fork
      wait_event(e1, "e1");
      wait_event(e2, "e2");
      wait_event(e3, "e3");
    join
  end

  initial begin
    fork
      begin #10ns -> e1; end
      begin #20ns -> e2; end
      begin #30ns -> e3; end
    join
  end

endmodule

module tb1;
 bit e1,e2,e3;
  
  task automatic wait_event(ref bit e, input string name);
    $display("@%t start waiting event %s",$time, name);
    @e;
    $display("@%t finish waiting event %s",$time, name);
  endtask
  
  initial begin
    fork
      wait_event(e1, "e1");
      wait_event(e2, "e2");
      wait_event(e3, "e3");
    join
  end

  initial begin
    fork
      begin #10ns e1 = !e1; end
      begin #20ns e2 = !e2; end
      begin #30ns e3 = !e3; end
    join
  end
endmodule

//module tb2;
//  semaphore mem_acc_key;
//  
//  int unsigned mem[int unsigned];
//
//  task automatic write(int unsigned addr, int unsigned data);
//    mem_acc_key.get();
//    mem[addr] = data;
//    mem_acc_key.put();
//  endtask
//
//  task automatic read(int unsigned addr, output int unsigned data);
//    mem_acc_key.get();
//    if(mem.exists(addr))
//      data = mem[addr];
//    else
//      data = 'x;
//    mem_acc_key.put();
//  endtask
//
//  int unsigned data = 100;
//  initial begin
//    mem_acc_key = new(1);
//    forever begin
//      fork
//        begin
//          #10ns;
//          write('h10, data+100);
//          $display("@%0t: write data %d", $time, data);
//        end
//        begin
//          #10ns;
//          read('h10, data);
//          $display("@%0t: read data %d", $time, data);
//        end
//      join 
//    end
//  end
//endmodule

module mailbox_tb;
  mailbox #(int) mb;
  string q[$];
  int data;
  initial begin
    q = new(8);
    mb = new(8);
    repeat(10)
    case($urandom_range(0, 1))
        0: begin 
          data = $urandom_range(0, 10);
          if(mb.try_put(data))
            $display("mb put data %0d",data);
        end
        1: begin
          if(mb.try_get(data))
            $display("mb get data %0d",data);
        end
      endcase
  end

endmodule


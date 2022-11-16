interface router_io(input bit clock);
  logic reset_n;
  logic [15:0] din, frame_n, valid_n;
  logic [15:0] dout, frameo_n, busy_n, valido_n;
  
  modport DUT(
    input clock, din, frame_n, valid_n,
    output dout, valido_n, frameo_n, busy_n
  );

  modport sti(
    input clock,reset_n,
    output din, frame_n, valid_n
  );
  clocking cbm @(posedge clock);
    input clock, din, frame_n, valid_n,
          dout, valido_n, frameo_n, busy_n;
  endclocking
  modport MONITOR(clocking cbm, input reset_n);
endinterface

module stimulator(router_io.sti inif);
  logic [7:0] q[$] = {8'h33, 8'h77}; //din
  initial begin: drive_reset
    @(negedge inif.reset_n);
    inif.din = '0;
    inif.valid_n = 0;
    inif.frame_n = '1;
  end
  
  bit [3:0] addr = 3;  //0011

  initial begin: drive
    @(negedge inif.reset_n);
    for(int i=0; i<4; i++)begin //drive_addr
      @(posedge inif.clock);
      inif.din[0] <= addr[i];
      inif.valid_n[0] <= $urandom_range(0,1);
      inif.frame_n[0] <= 0;
    end
    for(int i=0; i<5; i++)begin //drive pad
      @(posedge inif.clock);
      inif.din[0] <= 1;
      inif.valid_n[0] <= 1;
      inif.frame_n[0] <= 0;
    end
    foreach(q[id])begin
      for(int i=0; i<8; i++)begin //drive data
        @(posedge inif.clock);
        inif.din[0] <= q[id][i];
        inif.valid_n[0] <= 0;
        inif.frame_n <= 0;
      end
      if(id == q.size()-1)
        inif.valid_n[0] <= 1;
        inif.frame_n[0] <= 1;
    end
  end
endmodule

module monitor();
endmodule

module top;
  bit clock;
  initial forever #1ns clock = ~clock;
  initial begin : rst
    ri.reset_n = 0;
    repeat(2)@(posedge ri.clock);
    ri.reset_n = 1;
    repeat(2)@(posedge ri.clock);
    ri.reset_n = 0;
  end

  router_io ri(clock);
  router dut(
    .reset_n  (ri.reset_n),
    .clock    (ri.clock),
    .frame_n  (ri.frame_n),
    .valid_n  (ri.valid_n),
    .din      (ri.din),
    .dout     (ri.dout),
    .busy_n     (ri.busy_n),
    .valido_n (ri.valido_n),
    .frameo_n (ri.frameo_n)
  );
  stimulator sti(ri); 

endmodule

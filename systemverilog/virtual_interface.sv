interface Rx_if(input logic clk);
  logic[7:0]data;
  logic soc, en, clav, rclk;

  clocking cb@(posedge clk);
    output data, soc, clav;
    input en;
  endclocking

  modport TB(clocking cb);
  modport DUT(
    output en, rclk,
    input clav, data, soc
  );
endinterface : Rx_if
interface Tx_if(input logic clk);
  logic[7:0]data;
  logic soc, en, clav, tclk;

  clocking cb@(posedge clk);
    input en, data, soc;
    output clav;
  endclocking

  modport TB(clocking cb);
  modport DUT(
    output data, soc, en, tclk,
    input clav
  );
endinterface : Tx_if

class Driver;
  int stream_id;
  bit done = 0;
  mailbox exp_mbx;
  virtual Rx_if.TB Rx;

  function new(input mailbox exp_mbx,
              input int stream_id,
              input virtual Rx_if.TB Rx);
    this.exp_mbx = exp_mbx;
    this.stream_id = stream_id;
    this.Rx = Rx;
  endfunction

  task run(input int ncells,
          input event driver_done);
    ATM_Cell ac;
    fork
      begin
        Rx.cb.clav <= 0;
        Rx.cb.soc <= 0;
        @Rx.cb;

        repeat(ncells)begin
          ac = new;
          assert(ac.randomize);
          if(ac.eot_cell) break;
          drive_cell(ac);
        end
        $display("%0t: Driver::run Driver[%0d] is done",$time, stream_id);
        ->driver_done;
      end
    join_none
  endtask

  task drive_cell(input ATM_Cell ac);
    bit[7:0]bytes[];

    #ac.delay;
    ac.byte_pack(bytes);
    $display("@%0t: Driver::drive_cell(%0d)vci=%h",$time, stream_id, ac.vci);

    @Rx.cb;
    Rx.cb.clav <= 1;
    do
      @Rx.cb;
    while(Rx.cb.en != 0)

    Rx.cb.soc <= 1;
    Rx.cb.data <= bytes[0];
    @Rx.cb;
    Rx.cb.soc <= 0;
    Rx.cb.data <= bytes[1];

    for(int i=2; i<`ATM_SIZE; i++)begin
      @Rx.cb;
      Rx.cb.data <= bytes[i];
    end

    @Rx.cb;
    Rx.cb.soc <= 1'bz;
    Rx.cb.clav <= 0;
    Rx.cb.data <= 8'bz;
    $display("@%0t: Driver::drive_cell(%0d)finish",$time, stream_id);

    exp_mbx.put(ac);
  endtask
endclass


program automatic test(
  Rx_if.TB Rx0,Rx1,Rx2,Rx3,
  Tx_if.TB Tx0,Tx1,Tx2,Tx3,
  output logic rst
);
  Driver drv[4];
  Monitor mon[4];
  Scoreboard scb[4];

  virtual Rx_if.TB vRx[4] = '{Rx0,Rx1,Rx2,Rx3};
  virtual Tx_if.TB vTx[4] = '{Tx0,Tx1,Tx2,Tx3};
  initial begin
    foreach(scb[i])begin
      scb[i] = new(i);
      drv[i] = new(scb[i].exp_mbx, i, vRx[i]);
      mon[i] = new(scb[i].rcv_mbx, i, vTx[i]);
    end
    //...
  end
endprogram


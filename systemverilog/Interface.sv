`define ATM_SIZE  4

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

program automatic test(
  Rx_if.TB Rx0,Rx1,Rx2,Rx3,
  Tx_if.TB Tx0,Tx1,Tx2,Tx3,
  input logic clk,
  output logic rst
);
  bit[7:0]bytes[`ATM_SIZE];

  initial begin
    rst <= 1;
    Rx0.cb.data <= 0;
    Rx1.cb.data <= 0;
    Rx2.cb.data <= 0;
    Rx3.cb.data <= 0;
    
    receive_cell0;
    //...
  end

  task receive_cell0;
    @(Tx0.cb);
    Tx0.cb.clav <= 1;
    wait(Tx0.cb.soc == 1);

    for(int i=0; i<`ATM_SIZE; i++) begin
      wait(Tx0.cb.en==0);
      @(Tx0.cb);
      bytes[i] = Tx0.cb.data;
      @(Tx0.cb);
      Tx0.cb.clav <= 0;
    end
  endtask
endprogram

module top;
  logic clk,rst;
  Rx_if Rx[4](clk);
  Tx_if Tx[4](clk);

  test t1(
    Rx[0],Rx[1],Rx[2],Rx[3],
    Tx[0],Tx[1],Tx[2],Tx[3],
    rst
  );
  //atm_router a1(
  //  Rx[0],Rx[1],Rx[2],Rx[3],
  //  Tx[0],Tx[1],Tx[2],Tx[3],
  //  clk,rst
  //);
  initial begin
    clk = 0;
    forever #20 clk = ~clk;
  end
endmodule

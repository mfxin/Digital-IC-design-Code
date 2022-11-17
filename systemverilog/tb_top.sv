`timescale 1ns/100ps
//`include "intf_0.sv"
module tb_top;

import test_pkg::*;

	generator gen;
	monitor mon[];
	stim stm[];
	check ck;
	mailbox i_mbx,o_mbx;
	


	bit clk	;

	router_if top_io(clk);

	int spn  = 2000;//single pac num
	int ch_n = 16;


	router dut(
    	.reset_n	(top_io.rst_n	),	
    	.clock		(top_io.clk		),
    	.frame_n	(top_io.frame_n	),
    	.valid_n	(top_io.valid_n	),
    	.din		(top_io.din		),
    	.dout		(top_io.dout	),
    	.busy_n		(top_io.busy_n	),
    	.valido_n	(top_io.valido_n),
    	.frameo_n	(top_io.frameo_n)
  	);

	initial begin
		clk = 0;
		forever#50 clk = ~clk;
	end

	initial begin
		i_mbx = new();
		o_mbx = new();
		gen = new(top_io);
		stm = new[16];
		mon = new[16];
		foreach(stm[i])stm[i]=new(top_io,gen.mbx[i]);
		foreach(mon[i])mon[i]=new(top_io,gen.g_mbx[i],i_mbx,o_mbx);
		
		//stm = new(top_io,gen.mbx[0]);
		//mon = new(top_io,gen.g_mbx[0],i_mbx,o_mbx);
		ck = new(i_mbx,o_mbx);
		reset();
		
		fork
			stm[ 0].run(spn);mon[ 0].run(spn);
			stm[ 1].run(spn);mon[ 1].run(spn);
			stm[ 2].run(spn);mon[ 2].run(spn);
			stm[ 3].run(spn);mon[ 3].run(spn);
			stm[ 4].run(spn);mon[ 4].run(spn);
			stm[ 5].run(spn);mon[ 5].run(spn);
			stm[ 6].run(spn);mon[ 6].run(spn);
			stm[ 7].run(spn);mon[ 7].run(spn);
			stm[ 8].run(spn);mon[ 8].run(spn);
			stm[ 9].run(spn);mon[ 9].run(spn);
			stm[10].run(spn);mon[10].run(spn);
			stm[11].run(spn);mon[11].run(spn);
			stm[12].run(spn);mon[12].run(spn);
			stm[13].run(spn);mon[13].run(spn);
			stm[14].run(spn);mon[14].run(spn);
			stm[15].run(spn);mon[15].run(spn);
			gen.run(spn,16);
			ck.run();	
		join_none
	end
	task reset();
		top_io.rst_n <= 1'b0;
		top_io.frame_n <= '1;
		top_io.valid_n <= '1;
	#10	top_io.rst_n <= 1'b1;
	endtask: reset
endmodule 

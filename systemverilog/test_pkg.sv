package test_pkg;

class packet;
	 rand bit 	[3:0]	s_ad	;
	 rand bit	[3:0]	d_ad	;
	 rand logic	[7:0]	data[]	;
	
	 constraint c0 {data.size == 3;}
	 
endclass

class generator;
	virtual router_if io;
	packet pkt;
	mailbox mbx[],g_mbx[];
	int si[$],so[$];
	int pac_cnt=0;
	function new(virtual router_if io);
			this.io = io;
			this.mbx = new[16];
			this.g_mbx = new[16];
			foreach(mbx[i]) mbx[i]=new();
			foreach(g_mbx[i]) g_mbx[i]=new();
	endfunction
	
	task run(int pac_num=1,int ch_num=1);
		@(posedge io.rst_n);
		@(posedge io.clk);
		for(int k=0;k<pac_num;k++)begin
			@(posedge io.clk);
			si.delete();
			so.delete();
			scan_ad(ch_num);
			@(posedge io.valido_n[so[$]]);
		end
	endtask: run

	task scan_ad(int ch_num=1);
		int success;
		int qi[$],qo[$];
		for(int i=0;i<ch_num;)begin
			pkt = new();
			success = pkt.randomize();
			if(success)
				begin
					qi=si.find_index with (item == pkt.s_ad);
					qo=so.find_index with (item == pkt.d_ad);
					if(qi.size()==0)
						if(qo.size()==0)begin
							mbx[i].put(pkt);
							g_mbx[i].put(pkt);
							si.push_back(pkt.s_ad);
							so.push_back(pkt.d_ad);
							i++;pac_cnt++;
							$display("gen pkt done %2dth@ch_cnt[%2d](src_addr=[%2d],dst_addr=[%2d],data=[%3p])@%0t",pac_cnt,i,pkt.s_ad,pkt.d_ad,pkt.data,$time);
						end
						else begin
							i=i;
							end
					else begin
							i=i;
							end
				end
			else begin
					$display("randomize failed ! ! !");
					$stop;
				end
		end
	endtask

endclass

class stim;
	virtual router_if sio;
	packet pkt;
	mailbox g_mbx;
	int pac_cnt;

	function new(virtual router_if sio,mailbox g_mbx);
		this.sio = sio;
		this.g_mbx = g_mbx;
	endfunction

	task automatic run(int pac_num=1);
		pac_cnt = 1;
		@(posedge sio.rst_n);
		forever begin: s_pkt
			g_mbx.get(pkt);
			send_pkt();
			pac_cnt ++;
		end: s_pkt
	endtask: run

	task automatic send_pkt();
		send_addr();
		send_pad();
		send_data();
		back_to_idle();
	endtask: send_pkt

	task automatic send_addr();
			@(posedge sio.clk);
			sio.frame_n[pkt.s_ad] = 1'b0;
			for(int i=0;i<4;i++)begin
			sio.din[pkt.s_ad] <= pkt.d_ad[i];
			@(posedge sio.clk);
			end
	endtask: send_addr

	task automatic send_pad();
		sio.frame_n[pkt.s_ad] <= 1'b0;
		sio.din[pkt.s_ad] <= 1'b1;
		sio.valid_n[pkt.s_ad] <= 1'b1;
		repeat(4) @(posedge sio.clk);
	endtask: send_pad

	task automatic send_data();
		int data_depth;
		data_depth = pkt.data.size();
		foreach(pkt.data[i])
			for(int j=0;j<8;j++)begin
				@(posedge sio.clk)begin
				sio.valid_n[pkt.s_ad] <= 1'b0;
				sio.din[pkt.s_ad] <= pkt.data[i][j];
				sio.frame_n[pkt.s_ad] <= ((j==7)&&(i==(data_depth-1)));	
			end	
			end
	endtask: send_data;

	task automatic back_to_idle();
		@(posedge sio.clk);
		sio.frame_n <= 16'hffff;
		sio.valid_n <= 16'hffff;
	endtask: back_to_idle
		
endclass: stim

class monitor;
	virtual router_if mio;
	packet op,ip,ep;
	mailbox g_mbx,i_mbx,o_mbx;
	int o_p_cnt = 1;
	int i_p_cnt = 1;
	int max_num = 100;
	

	function new(virtual router_if mio,mailbox g_mbx,mailbox i_mbx,mailbox o_mbx);
			this.mio = mio;
			this.g_mbx = g_mbx;
			this.i_mbx = i_mbx;
			this.o_mbx = o_mbx;
	endfunction

	task run(int pac_num=1);
		ep = new();
		ip = new();
		op = new();
		fork
			forever begin
				@(negedge mio.frame_n[ep.s_ad])
				get_in_pkt();
				$display(">>>>>Get IN  pakage %2dth done, get data(%3p) @IN  port[%2d] @%0t<<<<<",i_p_cnt,ip.data,ip.s_ad,$time);
				i_mbx.put(ip);
				i_p_cnt++;
			end
			forever begin
				@(negedge mio.frameo_n[ep.d_ad])
				get_out_pkt();
				$display(">>>>>Get OUT pakage %2dth done, get data(%3p) @OUT port[%2d] @%0t<<<<<",o_p_cnt,op.data,op.d_ad,$time);
				o_mbx.put(op);
				o_p_cnt++;
			end
			begin
				for(int i=0;i<pac_num;i++)begin
					g_mbx.get(ep);
				end
				@(posedge mio.valido_n[ep.d_ad]);
				repeat(2)@(posedge mio.clk);
				$stop;
			end
		join
	endtask: run

	task get_out_pkt();	
			op.s_ad = ep.s_ad;
			op.d_ad = ep.d_ad;
			@(negedge mio.valido_n[op.d_ad]);
			get_op_data();
	endtask: get_out_pkt

	task get_in_pkt();	
			ip.s_ad = ep.s_ad;
			ip.d_ad = ep.d_ad;
			@(negedge mio.valid_n[ip.s_ad]);
			get_ip_data();
	endtask: get_in_pkt

	task automatic get_op_data();
			logic [7:0]data_out[];
			int data_num;
			int k;
			data_out = new[max_num];
			fork
				begin: con_get_data
					for(int j=0;j<max_num;)
					begin
						for(int i=0;i<8;)
						begin
							@(posedge mio.clk);
							begin
							data_out[j][i] = mio.dout[op.d_ad];
							data_num = j;
								if(mio.valido_n[op.d_ad])begin
									if(i===0) j--;
									else i--;
								end
								else
									if(i===7) begin j++; i=0;end
									else i++;
							end
						end
					end
					disable get_last_data;
					$display("time out");
					$finish;
				end
				begin: get_last_data
					wait(mio.frameo_n[op.d_ad]);
					@(posedge mio.valido_n[op.d_ad])begin
						op.data = new[data_num+1](data_out);
						disable con_get_data;
					end
				end
			join
	endtask: get_op_data

	task automatic get_ip_data();
			logic [7:0]data_out[];
			int data_num;
			int k;
			data_out = new[max_num];
			fork
				begin: con_get_data
					for(int j=0;j<max_num;)
					begin
						for(int i=0;i<8;)
						begin
							@(posedge mio.clk);
							begin
							data_out[j][i] = mio.din[ip.s_ad];
							data_num = j;
								if(mio.valid_n[ip.s_ad])begin
									if(i===0) j--;
									else i--;
								end
								else
									if(i===7) begin j++; i=0;end
									else i++;
							end
						end
					end
					disable get_last_data;
					$display("time out");
					$finish;
				end
				begin: get_last_data
					wait(mio.frame_n[ip.s_ad]);
					@(posedge mio.valid_n[ip.s_ad])begin
						ip.data = new[data_num+1](data_out);
						disable con_get_data;
					end
				end
			join
	endtask: get_ip_data
endclass

class check;
	mailbox i_mbx,o_mbx;
	packet i_pkt,o_pkt;
	int p_q[$];
	int path[$];
	

	function new(mailbox i_mbx,mailbox o_mbx);
		this.i_mbx = i_mbx;
		this.o_mbx = o_mbx;
	endfunction

	task run();
		int trans_cnt = 0;
		for(int i=0;i<256;i++)path.push_back(i);
		forever begin
			i_mbx.get(i_pkt);
			o_mbx.get(o_pkt);
			trans_cnt ++;
			if(i_pkt.data === o_pkt.data)begin
				$display("Data transfer success from port[%2d] to port[%2d] @%2dth!",i_pkt.s_ad,i_pkt.d_ad,trans_cnt);
				path_hit();
			end
			else begin
				$display("Data transfer failed  from port[%2d] to port[%2d] @%2dth!",i_pkt.s_ad,i_pkt.d_ad,trans_cnt);
				$stop;
			end
		end
	endtask: run

	task path_hit();
		int p;
		p = {24'd0,i_pkt.s_ad,i_pkt.d_ad};
		p_q = path.find_index with(item == p);
		if(path.size() == 0)begin
			$display("=========================");
			$display("ALL PATH FOUND DONE ! ! !");
			$display("=========================");
			$stop;
		end
		else begin
		case(p_q.size())
			0:;
			1:path.delete(p_q[0]);
			default:$display("expect path error for %8b ! ! !",{i_pkt.s_ad,i_pkt.d_ad});
		endcase
		end
		$display("Total find %3d path",(256-path.size()));
	endtask
				

endclass



endpackage: test_pkg

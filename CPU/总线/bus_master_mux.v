`define DISABLE_ 0
`define ENABLE_ 1
`define BUS_OWNER_MASTER_0 0
`define BUS_OWNER_MASTER_1 1
`define BUS_OWNER_MASTER_2 2
`define BUS_OWNER_MASTER_3 3

module bus_master_mux(
	input [29:0] 	m0_addr,
	input 			m0_as_,
	input 			m0_rw,
	input [31:0]	m0_wr_data,
	input 			m0_grnt_,
	
	input [29:0] 	m1_addr,
	input 			m1_as_,
	input 			m1_rw,
	input [31:0]	m1_wr_data,
	input 			m1_grnt_,
	
	input [29:0] 	m2_addr,
	input 			m2_as_,
	input 			m2_rw,
	input [31:0]	m2_wr_data,
	input 			m2_grnt_,
	
	input [29:0] 	m3_addr,
	input 			m3_as_,
	input 			m3_rw,
	input [31:0]	m3_wr_data,
	input 			m3_grnt_,
	
	output [29:0] 	s_addr,
	output 			s_as_,
	output 			s_rw,
	output			s_wr_data
);

always@(*)begin
	if(m0_grnt_ == `ENABLE) begin
		s_addr <= m0_addr;
		s_as_ <= m0_as_;
		s_rw <= s_rw;
		s_wr_data <= m0_wr_data;
	end
	else if(m1_grnt_ == `ENABLE) begin
		s_addr <= m1_addr;
		s_as_ <= m1_as_;
		s_rw <= m1_rw;
		s_wr_data <= m1_wr_data;
	end
	else if(m2_grnt_ == `ENABLE) begin
		s_addr <= m2_addr;
		s_as_ <= m2_as_;
		s_rw <= m2_rw;
		s_wr_data <= m2_wr_data;
	end
	else if(m3_grnt_ == `ENABLE) begin
		s_addr <= m3_addr;
		s_as_ <= m3_as_;
		s_rw <= m3_rw;
		s_wr_data <= m3_wr_data;
	end
end

endmodule


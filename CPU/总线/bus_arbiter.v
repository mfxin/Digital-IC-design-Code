`define DISABLE_ 0
`define ENABLE_ 1
`define BUS_OWNER_MASTER_0 0
`define BUS_OWNER_MASTER_1 1
`define BUS_OWNER_MASTER_2 2
`define BUS_OWNER_MASTER_3 3


module bus_arbiter(
	input 	wire	clk, reset,
	input 	wire	m0_req_,
	input 	wire	m1_req_,
	input 	wire	m2_req_,
	input 	wire	m3_req_,
	output 	reg		m0_grnt_,
	output 	reg 	m1_grnt_,
	output 	reg		m2_grnt_,
	output 	reg 	m3_grnt_
);

reg [1:0] owner;

/*赋予总线使用权*/
always @(*)begin
	case(owner)
		`BUS_OWNER_MASTER_0: begin m0_grnt_ <= `DISABLE_;
		`BUS_OWNER_MASTER_1: begin m1_grnt_ <= `DISABLE_;
		`BUS_OWNER_MASTER_2: begin m2_grnt_ <= `DISABLE_;
		`BUS_OWNER_MASTER_3: begin m3_grnt_ <= `DISABLE_;
	endcase
end

/*总线使用权仲裁*/
always@(posedge clk or negedge reset)begin
	if(!reset)
		owner <= #1 `BUS_OWNER_MASTER_0;
	else begin
		case(owner)
			`BUS_OWNER_MASTER_0: begin
				if(m0_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_0;
				else if(m1_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_1;
				else if(m2_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_2;
				else if(m3_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_3;
			end
			`BUS_OWNER_MASTER_1: begin
				if(m1_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_1;
				else if(m2_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_2;
				else if(m3_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_3;
				else if(m0_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_0;
			end
			`BUS_OWNER_MASTER_2: begin
				if(m2_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_2;
				else if(m3_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_3;
				else if(m0_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_0;
				else if(m1_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_1;
			end
			`BUS_OWNER_MASTER_3: begin
				if(m3_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_3;
				else if(m0_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_0;
				else if(m1_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_1;
				else if(m2_req_ == `ENABLE_) owner <= #1 `BUS_OWNER_MASTER_2;
			end
		endcase
	end
end


endmodule
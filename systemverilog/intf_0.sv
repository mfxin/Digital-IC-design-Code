interface router_if(input clk);

	logic			rst_n		;
	logic	[15:0]	dout		;
	logic	[15:0]	valido_n	;
	logic	[15:0]	busy_n		;
	logic	[15:0]	frameo_n	;
	logic	[15:0]	din			;
	logic	[15:0]	frame_n		;
	logic	[15:0]	valid_n		;

	modport TB(
			input	clk		,
			output	rst_n	,
			input	dout	,
			input	valido_n,
			input	busy_n	,
			input	frameo_n,
			output	din		,
			output	frame_n	,
			output	valid_n	
	);

endinterface

module ISM(
	input logic CLK,
	input logic RESET,
	input logic [1:0] transition,
	input logic calculating,
	output logic [1:0] state
);
	logic [1:0] next_state;

	initial
		state = 2'b00;

	always_ff @ (posedge CLK)
	begin
		if (RESET) 
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	always_comb
	begin
		next_state = state;
		if ((transition == 2'b01) && (state == 2'b00))
			next_state = 2'b01;
		if ((transition == 2'b10) && (state == 2'b01))
			next_state = 2'b10;
		if ((transition == 2'b11) && state == 2'b10)
			next_state = 2'b11;
	end
	
endmodule

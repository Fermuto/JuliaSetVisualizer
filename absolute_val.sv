module absolute_val(
	input logic signed [31:0] in_val,
	output logic signed [31:0] out_val
);
	always_comb
	begin
		if (in_val < 0)
			out_val = -in_val;
		else
			out_val = in_val;
	end
endmodule

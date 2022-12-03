//`define img_width 640
//`define img_height 480
//`define iterations 100
module fractal_calc(

	input logic CLK,
	input logic RESET,
	
	input logic [31:0] coord_in,
	input logic [1:0] state,
	output shortint y_draw,
	output shortint x_draw,
	output logic [7:0] intensity,
	output logic calculating

);

	logic signed [31:0] x_coord, y_coord, z_real, z_imag, z1, z2, real_var, imag_var, shortreal_in;
	logic once;
	
	initial
	begin
		once = 0;
	end
	
	assign shortreal_in = coord_in << 16;
	

	always_ff @(posedge CLK)
	begin
		if (RESET)
			once = 0;
		if (state == 2'b00)
			real_var = (shortreal_in*(32'b0000000000000000_0000000001000000))[47:16];     //This is so we can input 156 to get 0.156, for example
		else if (state == 2'b01)
			imag_var = (shortreal_in*(32'b0000000000000000_0000000001000000))[47:16];
	end

	always_comb
	begin
		if ((state == 2'b11) && (once == 0))
		begin
			calculating = 1;
			for (logic signed [31:0] y = 32'b0000000000000000_0000000000000000; y < 32'b0000000111100000_0000000000000000; y = y + 1)
			begin
				y_draw = shortint'(y[31:16]);
				for (logic signed [31:0] x = 32'b0000000000000000_0000000000000000; x < 32'b0000001010000000_0000000000000000; x = x + 1)
				begin
					x_draw = shortint'(x[31:16]);
					
					x_coord = x-(32'b0000000000000010_1000000000000000);
					y_coord = y-(32'b0000000000000001_1110000000000000);

					z_real = x_coord;
					z_imag = y_coord;	

					for (int n = 0; n < 100; n++)
					begin
						z1 = ((z_real**2)[47:16] - (z_imag**2)[47:16]) + real_var;
						z2 = (2*z_real*z_imag)[47:16] + imag_var;
						z_real = z1;
						z_imag = z2;

						if (($abs(z_real)+$abs(z_imag)) > 5)
						begin
							intensity = 8'(int'((($ln(n + 1) - 1) / ($ln(100 + 1) + 1) * 2) * 100));
							
							if (intensity < 8'd0)
							begin
								intensity = 8'd0;
							end
							else if (intensity > 8'd100)
							begin
								intensity = 8'd100;
							end
							else
							begin
								intensity = 8'(int'((($ln(n + 1) - 1) / ($ln(100 + 1) + 1) * 2) * 100));
							end
							
							break;
						end

						else
						begin
							intensity = 8'd0;
						end
					end
				end
			end
			calculating = 0;
			once = 1;
		end
		
		else
		begin
			calculating = 0;
			y_draw = 32'b0000000000000000_0000000000000000;
			x_draw = 32'b0000000000000000_0000000000000000;
			intensity = 8'b00000000;
			x_coord = 32'b0000000000000000_0000000000000000;
			y_coord = 32'b0000000000000000_0000000000000000;
			z_real = 32'b0000000000000000_0000000000000000;
			z_imag = 32'b0000000000000000_0000000000000000;
			z1 = 32'b0000000000000000_0000000000000000;
			z2 = 32'b0000000000000000_0000000000000000;
		end
	end

endmodule

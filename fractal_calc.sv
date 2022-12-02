`define img_width 640
`define img_height 480
`define iterations 100
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

	int x_coord, y_coord, z_real, z_imag, z1, z2, real_var, imag_var, shortreal_in;
	logic once;
	
	initial
	begin
		once = 0;
	end
	
	assign shortreal_in = coord_in;
	
	always_ff @(posedge CLK)
	begin
		if (RESET)
			once = 0;
		if (state == 2'b00)
			real_var = shortreal_in;
		else if (state == 2'b01)
			imag_var = shortreal_in;
	end

	always_comb
	begin
		if ((state == 2'b11) && (once == 0))
		begin
			calculating = 1;
			for (int y = 0; y < 480; y++)
			begin
				y_draw = y;
				for (int x = 0; x < 640; x++)
				begin
					x_draw = x;
					
					x_coord = (x-(640/2)) / (640/5);
					y_coord = (y-(480/2)) / (640/5);

					z_real = x_coord;
					z_imag = y_coord;	

					for (int n = 0; n < 100; x++)
					begin
						z1 = ((z_real**2) - (z_imag**2)) + real_var;
						z2 = (2*z_real*z_imag) + imag_var;
						z_real = z1;
						z_imag = z2;

						if ($sqrt((z_real**2)+(z_imag**2)) > 5)
						begin
							intensity = 8'(int'((($ln(n + 1) -1) / ($ln(100 + 1) + 1) * 2) * 100));
							
							if (intensity < 0)
							begin
								intensity = 8'd0;
							end
							else if (intensity > 100)
							begin
								intensity = 8'd100;
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
			y_draw = 0;
			x_draw = 0;
			intensity = 0;
			x_coord = 0;
			y_coord = 0;
			z_real = 0;
			z_imag = 0;
			z1 = 0;
			z2 = 0;
		end
	end
	
endmodule

`define img_width 640
`define img_height 480
`define iterations 100
module fractal_calc(
	
	input shortreal real_var,
	input shortreal imag_var,
	input int state,
	output int y_draw,
	output int x_draw,
	output logic [7:0] intensity,
	output logic calculating

);

	shortreal x_coord, y_coord, z_real, z_imag, z1, z2;
	
	initial
	begin
		calculating = 0;
	end

	always_comb
	begin
		if (1)
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
		end
		
		else
		begin
			y_draw = 0;
			x_draw = 0;
			intensity = 0;
			x_coord = 0.0;
			y_coord = 0.0;
			z_real = 0.0;
			z_imag = 0.0;
			z1 = 0.0;
			z2 = 0.0;
		end
	end
	
endmodule

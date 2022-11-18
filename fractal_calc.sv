'define img_width 640
'define img_height 480
'define iterations 100
module fractal_calc(
	
	input shortreal real_var,
	input shortreal imag_var,
	input int state,
	output int y_draw,
	output int x_draw,
	output logic [7:0] intensity,
	output logic done

);
begin

	shortreal x_coord, y_coord, z_real, z_imag, z1, z2;
	
	initial
	begin
		done = 0;
	end

	always_comb
	begin
		if (state == something)
		begin
			done = 0;
			for (int y = 0; y < img_height; y++)
			begin
				y_draw = y;
				for (int x = 0; x < img_width; x++)
				begin
					x_draw = x;
					
					x_coord = (x-(img_width/2)) / (img_width/5);
					y_coord = (y-(img_height/2)) / (img_width/5);

					z_real = x_coord;
					z_imag = y_coord;	

					for (int n = 0; n < iterations; x++)
					begin
						z1 = ((z_real**2) - (z_imag**2)) + real_var;
						z2 = (2*z_real*z_imag) + imag_var;
						z_real = z1;
						z_imag = z2;

						if ($sqrt((z_real**2)+(z_imag**2)) > 5)
						begin
							intensity = 8'(int'((($ln(n + 1) -1) / ($ln(iterations + 1) + 1) * 2) * 100));
							
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
			done = 1;
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

'define img_width 640
'define img_height 480
module fractal_calc(


);
begin

	real real_var, imag_var;
	string color_var;

	real x_coord, y_coord, z_real, z_imag, z1, z2;

	get_color rgbgen(.stability(), .hue(), .r(), .g(), .b());

	always_comb
	begin
		for (int y = 0; y < img_height; y++)
		begin
			for (int x = 0; x < img_width; x++)
			begin
				x_coord = (x-(img_width/2)) / (img_width/5);
				y_coord = (y-(img_height/2)) / (img_width/5);

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
						//pixels[-(x+1), y] = red, green, blue;
						break;
					end

					if (n == 99)
					begin
						//pixels[-(x+1), y] = (0, 0, 0)
					end
				end
			end
		end
	end
	
endmodule

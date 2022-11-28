`define iterations 100
module get_color(

	input real stability, hue,
	output int r, g, b
	
);

	real normalized, h_prime, chroma, x, big_x, m;
	real h, s, v, r_m, g_m, b_m;

	always_comb
	begin
		//PART 1 generating hsv
		
		normalized = ($ln(stability + 1'd1) - 1'd1) / ($ln(iterations + 1'd1) + 1'd1);
		
		if (normalized < 1'd0) 
		begin
			normalized = 1'd0;
		end
		else if (normalized > 1'd1)
		begin
			normalized = 1'd1;
		end
		
		h = hue;
		s = 1'd1;
		v = normalized * 2'd2;
		
		
		//PART 2 hsv_to_rgb
		
		h_prime = (h % 9'd360) / 6'd60; // 9 and 6 might not be enough bits?
		chroma = s * v;
		x = (h_prime % 2'd2) - 1'd1;
		
		if (x < 1'd0)
		begin
			X = chroma * (1 + x);
		end
		else
		begin
			X = chroma * (1 - x);
		end
		
		if (h_prime < 1'd1)
		begin
			r_m = chroma;
			g_m = X;
			b_m = 1'd0;
		end
		else if (h_prime < 2'd2)
		begin
			r_m = X;
			g_m = chroma;
			b_m = 1'd0;
		end
		else if (h_prime < 2'd3)
		begin
			r_m = 1'd0;
			g_m = chroma;
			b_m = X;
		end
		else if (h_prime < 3'd4)
		begin
			r_m = 1'd0;
			g_m = X;
			b_m = chroma;
		end
		else if (h_prime < 3'd5)
		begin
			r_m = X;
			g_m = 1'd0;
			b_m = chroma;
		end
		else
		begin
			r_m = chroma;
			g_m = 1'd0;
			b_m = X;
		end
		
		m = v - chroma;
		
		r = int'((r_m + m) * 255);
		g = int'((g_m + m) * 255);
		b = int'((b_m + m) * 255);

	end
endmodule

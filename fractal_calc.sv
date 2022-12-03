//`define img_width 640
//`define img_height 480
//`define iterations 100
module fractal_calc(

	input logic CLK,
	input logic RESET,
	
	input logic [31:0] coord_in,
	input logic [1:0] state,
	output logic [9:0] y_draw,
	output logic [9:0] x_draw,
	output logic [7:0] intensity,
	output logic calculating

);

	logic signed [31:0] x_coord, y_coord, z_real, z_imag, z1, z2, real_var, imag_var, shortreal_in, ln_0y, ln_1y;
	logic [9:0] hc, vc;
	logic once;
	int ln_0x;
	parameter [9:0] hpixels = 10'b1100011111;
    parameter [9:0] vlines = 10'b1000001100;
	parameter [31:0] ln_1y = 32'b0000000000000100_1001110101111000;
	
	assign shortreal_in = coord_in << 16; // CHANGE???

	initial
	begin
		once = 0;
	end

	always_comb
	begin
		if (state == 2'b11 && once == 0)
			calculating = 1;
		else
			calculating = 0;
	end

	always_ff @(posedge CLK)
	begin
		if (state == 0)
			real_var = coord_in;
		else if (state == 1)
			imag_var = coord_in;
	end

	always_ff @(posedge CLK)
	begin: counter_proc
		if ( RESET ) 
		begin 
			once = 0;
			hc <= 10'b0000000000;
			vc <= 10'b0000000000;
		end
				
		else 
		begin
			if (calculating == 1)
			begin
				if (hc == hpixels)  //If hc has reached the end of pixel count
				begin 
					hc <= 10'b0000000000;
					if ( vc == vlines )   //if vc has reached end of line count
					begin
						once <= 1;
						vc <= 10'b0000000000;
					end
					else 
						vc <= (vc + 1);
				end
				else 
					hc <= (hc + 1);  //no statement about vc, implied vc <= vc;
			end
		end
	end 
   
    assign x_draw = hc;
    assign y_draw = vc;

	naturallog ln_0(.x (ln_0x), .y (ln_0y));

	always_comb
	begin: pixel_calc
		if (calculating == 1)
		begin
			x_coord = x-(32'b0000000000000010_1000000000000000);
			y_coord = y-(32'b0000000000000001_1110000000000000);

			z_real = x_coord;
			z_imag = y_coord;	
			for (int n = 0; n < 100; n++)
			begin
				z1 = ((z_real * z_real)[47:16] - (z_imag * z_imag)[47:16]) + real_var;
				z2 = (2 * z_real * z_imag)[47:16] + imag_var;
				z_real = z1;
				z_imag = z2;

				if (($abs(z_real) + $abs(z_imag)) > 5)
				begin
					ln_0x = n + 1;

					intensity = 8'(int'(((ln_0y - 32'b0000000000000001_0000000000000000) / (ln_1y + 32'b0000000000000001_0000000000000000) * 2) * 100));
							
					if (intensity < 8'd0)
					begin
						intensity = 8'd0;
					end

					else if (intensity > 8'd100)
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

		else
		begin
			ln_0x = 1;
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

/*
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
*/


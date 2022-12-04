module iteration_calc(
    input logic CLK, RESET,
    input logic start,
    input logic signed [31:0] z_real,
    input logic signed [31:0] z_imag,
    input logic signed [31:0] real_var,
    input logic signed [31:0] imag_var,
    output logic [7:0] intensity,
    output logic done
);

    logic signed [63:0] z1, z2, multiplicand;
    logic signed [31:0] z_real_2, z_imag_2, z_real_abs, z_image_abs, ln_0y, increaser;
    int ln_0x, n;

    // enum logic [7:0] {N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, 
    //                   N11, N12, N13, N14, N15, N16, N17, N18, N19, N20
    //                   N21, N22, N23, N24, N25, N26, N27, N28, N29, N30
    //                   N31, N32, N33, N34, N35, N36, N37, N38, N39, N40
    //                   N41, N42, N43, N44, N45, N46, N47, N48, N49, N50
    //                   N51, N52, N53, N54, N55, N56, N57, N58, N59, N60
    //                   N61, N62, N63, N64, N65, N66, N67, N68, N69, N70
    //                   N71, N72, N73, N74, N75, N76, N77, N78, N79, N80
    //                   N81, N82, N83, N84, N85, N86, N87, N88, N89, N90
    //                   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100}, State, Next_State; 
    
    logic [7:0] curr_state, next_state;

    parameter [31:0] ln_1y_fractional = 32'b0000000000000000_0010110110011000;

    naturallog ln_0(.x (ln_0x), .y (ln_0y));

    absolute_val abs_0(.in_val (z_real_2), .out_val (z_real_abs));
	absolute_val abs_1(.in_val (z_imag_2), .out_val (z_imag_abs));
    initial
    begin
        curr_state <= 8'd101;
    end

    always_ff @ (posedge CLK))
    begin
        if (RESET)
            curr_state <= 8'd101;
        else
            curr_state <= next_state;
    end

    

    always_comb
    begin
        if (start == 1 && curr_state == 101)
        begin
            done = 0;
            next_state = 8'd0;
        end
        else if (curr_state == 100)
        begin
            done = 1;
            next_state = 101;
        end
        else if (curr_state == 101)
        begin
            next_state = 101;
        end
        else
        begin
            next_state = curr_state + 1;
            n = curr_state;
        end
            
    end


    always_comb
    begin
        if ((curr_state != 100) && (curr_state != 101))
        begin
            z1 = ((z_real * z_real) - (z_imag * z_imag));
            z2 = (2 * z_real * z_imag);
                    
            z_real_2 = z1[47:16] + real_var;
            z_imag_2 = z2[47:16] + imag_var;

            if ((z_real_abs + z_imag_abs) > 5)
            begin
                ln_0x = n + 1;
                        
                multiplicand = (ln_0y - 32'b0000000000000001_0000000000000000) * (ln_1y_fractional);

                increaser = (multiplicand[47:16] + multiplicand[47:16]);
                        
                intensity = (increaser[15:8]);
                                
                if (increaser < 0)
                begin
                    intensity = 8'b00000000;
                end

                else if (increaser[16] == 1'b1)
                begin
                    intensity = 8'b11111111;
                end
                        
                next_state = 8'd101;
            end

            else
            begin
                intensity = 8'b00000000;
            end
        end
        else
        begin

        end
    end

endmodule



// for (int n = 0; n < 100; n++)
// 			begin
// 				z1 = ((z_real * z_real) - (z_imag * z_imag));
// 				z2 = (2 * z_real * z_imag);
				
// 				z_real_2 = z1[47:16] + real_var;
// 				z_imag_2 = z2[47:16] + imag_var;

// 				if ((z_real_abs + z_imag_abs) > 5)
// 				begin
// 					ln_0x = n + 1;
					
// 					multiplicand = (ln_0y - 32'b0000000000000001_0000000000000000) * (ln_1y_fractional);

// 					increaser = (multiplicand[47:16] + multiplicand[47:16]);
					
// 					intensity = (increaser[15:8]);
							
// 					if (increaser < 0)
// 					begin
// 						intensity = 8'b00000000;
// 					end

// 					else if (increaser[16] == 1'b1)
// 					begin
// 						intensity = 8'b11111111;
// 					end
					
// 					break;
// 				end

// 				else
// 				begin
// 					intensity = 8'b00000000;
// 				end
// 			end
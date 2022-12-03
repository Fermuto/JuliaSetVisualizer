module visualizer_top(

	///////// Clocks /////////
	input    MAX10_CLK1_50,

	///////// KEY /////////
	input    [ 1: 0]   KEY,

	///////// SW /////////
	input    [ 9: 0]   SW,

	///////// LEDR /////////
	output   [ 9: 0]   LEDR,

	///////// HEX /////////
	output   [ 7: 0]   HEX0,
	output   [ 7: 0]   HEX1,
	output   [ 7: 0]   HEX2,
	output   [ 7: 0]   HEX3,
	output   [ 7: 0]   HEX4,
	output   [ 7: 0]   HEX5,

	///////// SDRAM /////////
	output             DRAM_CLK,
	output             DRAM_CKE,
	output   [11: 0]   DRAM_ADDR,
	output   [ 1: 0]   DRAM_BA,
	inout    [15: 0]   DRAM_DQ,
	output             DRAM_LDQM,
	output             DRAM_UDQM,
	output             DRAM_CS_N,
	output             DRAM_WE_N,
	output             DRAM_CAS_N,
	output             DRAM_RAS_N,

	///////// VGA /////////
	output             VGA_HS,
	output             VGA_VS,
	output   [3: 0]    VGA_R,
	output   [3: 0]    VGA_G,
	output   [3: 0]    VGA_B,
	
	///////// ARDUINO /////////
	inout    [15: 0]   ARDUINO_IO,
	inout              ARDUINO_RESET_N 
	
);
	logic Reset_h, vssig, blank, sync, VGA_Clk;
	//=======================================================
	//  REG/WIRE declarations
	//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

	//=======================================================
	//  Structural coding
	//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	//=======================================================
	//  Inter-module declarations
	//=======================================================
	logic [8:0] pixel_value;
	logic [2:0] color_holder;
	logic [1:0] curr_state, transition_indicators;
	logic calculating;
	logic [9:0] y_coord, x_coord;
	logic[31:0] coord_input;

	//=======================================================
	//  MODULES
	//=======================================================
	
	jsv main(
		.clk_clk 								(MAX10_CLK1_50),
		.reset_reset_n 						(Reset_h),
		.hex_digits_export 					({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.key_external_connection_export 	(KEY),
		.keycode_export 						(keycode),
		.leds_export 							(LEDR),
		.spi0_MISO 								(SPI0_MISO),
		.spi0_MOSI 								(SPI0_MOSI),
		.spi0_SCLK 								(SPI0_SCLK),
		.spi0_SS_n 								(SPI0_CS_N),
		.usb_gpx_export 						(USB_GPX),
		.usb_irq_export 						(USB_IRQ),
		.usb_rst_export 						(USB_RST),
		
		.vga_interface_bitmap_input_sdram_draw (calculating),
		.vga_interface_bitmap_input_sdram_x		(x_coord),
		.vga_interface_bitmap_input_sdram_y		(y_coord),
		.vga_interface_bitmap_input_sdram_i		(pixel_value),
		
		.vga_interface_misc_state (curr_state),
		.vga_interface_misc_color (color_holder),
		
		.vga_interface_sdram_export_sdram_clk_clk		(DRAM_CLK),
		.vga_interface_sdram_export_sdram_wire_addr	(DRAM_ADDR),
		.vga_interface_sdram_export_sdram_wire_ba		(DRAM_BA),
		.vga_interface_sdram_export_sdram_wire_cas_n	(DRAM_CAS_N),
		.vga_interface_sdram_export_sdram_wire_cke	(DRAM_CKE),
		.vga_interface_sdram_export_sdram_wire_cs_n	(DRAM_CS_N),
		.vga_interface_sdram_export_sdram_wire_dq		(DRAM_DQ),
		.vga_interface_sdram_export_sdram_wire_dqm	({DRAM_UDQM, DRAM_LDQM}),
		.vga_interface_sdram_export_sdram_wire_ras_n	(DRAM_RAS_N),
		.vga_interface_sdram_export_sdram_wire_we_n	(DRAM_WE_N),
		
		.vga_interface_vga_export_red 	(VGA_R),
		.vga_interface_vga_export_green 	(VGA_G),
		.vga_interface_vga_export_blue 	(VGA_B),
		.vga_interface_vga_export_hs 		(VGA_HS),
		.vga_interface_vga_export_vs 		(VGA_VS),
		
		.state_to_software_export			(curr_state),
		.color_val_export						(color_holder),
		.shortreal_val_export				(coord_input),
		.transition_code_export				(transition_indicators)
		);
	
	fractal_calc calc(
		.CLK				(MAX10_CLK1_50),
		.RESET			(Reset_h),
		.coord_in		(coord_input),
		.state			(curr_state),
		.y_draw			(y_coord),
		.x_draw			(x_coord),
		.intensity		(pixel_value),
		.calculating	(calculating)
		);
	
	ISM state_machine(
		.CLK				(MAX10_CLK1_50),
		.RESET			(Reset_h),
		.transition		(transition_indicators),
		.calculating	(calculating),
		.state			(curr_state)
		);

endmodule

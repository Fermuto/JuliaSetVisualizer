
module jsv (
	clk_clk,
	color_val_export,
	hex_digits_export,
	key_external_connection_export,
	keycode_export,
	leds_export,
	reset_reset_n,
	shortreal_val_export,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	transition_code_export,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	vga_interface_bitmap_input_sdram_draw,
	vga_interface_bitmap_input_sdram_x,
	vga_interface_bitmap_input_sdram_y,
	vga_interface_bitmap_input_sdram_i,
	vga_interface_misc_state,
	vga_interface_misc_color,
	vga_interface_sdram_export_sdram_clk_clk,
	vga_interface_sdram_export_sdram_wire_addr,
	vga_interface_sdram_export_sdram_wire_ba,
	vga_interface_sdram_export_sdram_wire_cke,
	vga_interface_sdram_export_sdram_wire_cas_n,
	vga_interface_sdram_export_sdram_wire_cs_n,
	vga_interface_sdram_export_sdram_wire_dq,
	vga_interface_sdram_export_sdram_wire_dqm,
	vga_interface_sdram_export_sdram_wire_ras_n,
	vga_interface_sdram_export_sdram_wire_we_n,
	vga_interface_vga_export_hs,
	vga_interface_vga_export_vs,
	vga_interface_vga_export_red,
	vga_interface_vga_export_green,
	vga_interface_vga_export_blue,
	state_to_software_export);	

	input		clk_clk;
	output	[2:0]	color_val_export;
	output	[15:0]	hex_digits_export;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_export;
	output	[13:0]	leds_export;
	input		reset_reset_n;
	output	[31:0]	shortreal_val_export;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	output	[1:0]	transition_code_export;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	input		vga_interface_bitmap_input_sdram_draw;
	input	[15:0]	vga_interface_bitmap_input_sdram_x;
	input	[15:0]	vga_interface_bitmap_input_sdram_y;
	input	[7:0]	vga_interface_bitmap_input_sdram_i;
	input	[1:0]	vga_interface_misc_state;
	input	[2:0]	vga_interface_misc_color;
	output		vga_interface_sdram_export_sdram_clk_clk;
	output	[11:0]	vga_interface_sdram_export_sdram_wire_addr;
	output		vga_interface_sdram_export_sdram_wire_ba;
	output		vga_interface_sdram_export_sdram_wire_cke;
	output		vga_interface_sdram_export_sdram_wire_cas_n;
	output		vga_interface_sdram_export_sdram_wire_cs_n;
	inout	[15:0]	vga_interface_sdram_export_sdram_wire_dq;
	output	[1:0]	vga_interface_sdram_export_sdram_wire_dqm;
	output		vga_interface_sdram_export_sdram_wire_ras_n;
	output		vga_interface_sdram_export_sdram_wire_we_n;
	output		vga_interface_vga_export_hs;
	output		vga_interface_vga_export_vs;
	output	[3:0]	vga_interface_vga_export_red;
	output	[3:0]	vga_interface_vga_export_green;
	output	[3:0]	vga_interface_vga_export_blue;
	input	[2:0]	state_to_software_export;
endmodule

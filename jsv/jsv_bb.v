
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
	state_to_software_export,
	transition_code_export,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	vga_interface_misc_state,
	vga_interface_misc_color,
	vga_interface_vga_export_hs,
	vga_interface_vga_export_vs,
	vga_interface_vga_export_red,
	vga_interface_vga_export_green,
	vga_interface_vga_export_blue,
	vga_interface_bitmap_io_sdram_draw,
	vga_interface_bitmap_io_bitmap_intensity,
	vga_interface_bitmap_io_sdram_grab,
	vga_interface_bitmap_io_sdram_addr);	

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
	input	[2:0]	state_to_software_export;
	output	[1:0]	transition_code_export;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	input	[1:0]	vga_interface_misc_state;
	input	[2:0]	vga_interface_misc_color;
	output		vga_interface_vga_export_hs;
	output		vga_interface_vga_export_vs;
	output	[3:0]	vga_interface_vga_export_red;
	output	[3:0]	vga_interface_vga_export_green;
	output	[3:0]	vga_interface_vga_export_blue;
	input		vga_interface_bitmap_io_sdram_draw;
	input	[7:0]	vga_interface_bitmap_io_bitmap_intensity;
	output		vga_interface_bitmap_io_sdram_grab;
	output	[22:0]	vga_interface_bitmap_io_sdram_addr;
endmodule

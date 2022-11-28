
module jsv (
	clk_clk,
	hex_digits_export,
	key_external_connection_export,
	keycode_export,
	leds_export,
	reset_reset_n,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	vga_interface_bitmap_input_sdram_draw,
	vga_interface_bitmap_input_sdram_x,
	vga_interface_bitmap_input_sdram_y,
	vga_interface_bitmap_input_sdram_i,
	vga_interface_sdram_export_sdram_clk_clk,
	vga_interface_sdram_export_sdram_wire_addr,
	vga_interface_sdram_export_sdram_wire_we_n,
	vga_interface_sdram_export_sdram_wire_ras_n,
	vga_interface_sdram_export_sdram_wire_dqm,
	vga_interface_sdram_export_sdram_wire_dq,
	vga_interface_sdram_export_sdram_wire_cs_n,
	vga_interface_sdram_export_sdram_wire_cke,
	vga_interface_sdram_export_sdram_wire_cas_n,
	vga_interface_sdram_export_sdram_wire_ba,
	vga_interface_vga_export_red,
	vga_interface_vga_export_green,
	vga_interface_vga_export_blue,
	vga_interface_vga_export_hs,
	vga_interface_vga_export_vs);	

	input		clk_clk;
	output	[15:0]	hex_digits_export;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_export;
	output	[13:0]	leds_export;
	input		reset_reset_n;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	input		vga_interface_bitmap_input_sdram_draw;
	input		vga_interface_bitmap_input_sdram_x;
	input		vga_interface_bitmap_input_sdram_y;
	input	[7:0]	vga_interface_bitmap_input_sdram_i;
	output		vga_interface_sdram_export_sdram_clk_clk;
	output	[11:0]	vga_interface_sdram_export_sdram_wire_addr;
	output		vga_interface_sdram_export_sdram_wire_we_n;
	output		vga_interface_sdram_export_sdram_wire_ras_n;
	output	[1:0]	vga_interface_sdram_export_sdram_wire_dqm;
	inout	[15:0]	vga_interface_sdram_export_sdram_wire_dq;
	output		vga_interface_sdram_export_sdram_wire_cs_n;
	output		vga_interface_sdram_export_sdram_wire_cke;
	output		vga_interface_sdram_export_sdram_wire_cas_n;
	output		vga_interface_sdram_export_sdram_wire_ba;
	output	[3:0]	vga_interface_vga_export_red;
	output	[3:0]	vga_interface_vga_export_green;
	output	[3:0]	vga_interface_vga_export_blue;
	output		vga_interface_vga_export_hs;
	output		vga_interface_vga_export_vs;
endmodule

	jsv u0 (
		.clk_clk                                     (<connected-to-clk_clk>),                                     //                        clk.clk
		.hex_digits_export                           (<connected-to-hex_digits_export>),                           //                 hex_digits.export
		.key_external_connection_export              (<connected-to-key_external_connection_export>),              //    key_external_connection.export
		.keycode_export                              (<connected-to-keycode_export>),                              //                    keycode.export
		.leds_export                                 (<connected-to-leds_export>),                                 //                       leds.export
		.reset_reset_n                               (<connected-to-reset_reset_n>),                               //                      reset.reset_n
		.spi0_MISO                                   (<connected-to-spi0_MISO>),                                   //                       spi0.MISO
		.spi0_MOSI                                   (<connected-to-spi0_MOSI>),                                   //                           .MOSI
		.spi0_SCLK                                   (<connected-to-spi0_SCLK>),                                   //                           .SCLK
		.spi0_SS_n                                   (<connected-to-spi0_SS_n>),                                   //                           .SS_n
		.usb_gpx_export                              (<connected-to-usb_gpx_export>),                              //                    usb_gpx.export
		.usb_irq_export                              (<connected-to-usb_irq_export>),                              //                    usb_irq.export
		.usb_rst_export                              (<connected-to-usb_rst_export>),                              //                    usb_rst.export
		.vga_interface_bitmap_input_sdram_draw       (<connected-to-vga_interface_bitmap_input_sdram_draw>),       // vga_interface_bitmap_input.sdram_draw
		.vga_interface_bitmap_input_sdram_x          (<connected-to-vga_interface_bitmap_input_sdram_x>),          //                           .sdram_x
		.vga_interface_bitmap_input_sdram_y          (<connected-to-vga_interface_bitmap_input_sdram_y>),          //                           .sdram_y
		.vga_interface_bitmap_input_sdram_i          (<connected-to-vga_interface_bitmap_input_sdram_i>),          //                           .sdram_i
		.vga_interface_sdram_export_sdram_clk_clk    (<connected-to-vga_interface_sdram_export_sdram_clk_clk>),    // vga_interface_sdram_export.sdram_clk_clk
		.vga_interface_sdram_export_sdram_wire_addr  (<connected-to-vga_interface_sdram_export_sdram_wire_addr>),  //                           .sdram_wire_addr
		.vga_interface_sdram_export_sdram_wire_we_n  (<connected-to-vga_interface_sdram_export_sdram_wire_we_n>),  //                           .sdram_wire_we_n
		.vga_interface_sdram_export_sdram_wire_ras_n (<connected-to-vga_interface_sdram_export_sdram_wire_ras_n>), //                           .sdram_wire_ras_n
		.vga_interface_sdram_export_sdram_wire_dqm   (<connected-to-vga_interface_sdram_export_sdram_wire_dqm>),   //                           .sdram_wire_dqm
		.vga_interface_sdram_export_sdram_wire_dq    (<connected-to-vga_interface_sdram_export_sdram_wire_dq>),    //                           .sdram_wire_dq
		.vga_interface_sdram_export_sdram_wire_cs_n  (<connected-to-vga_interface_sdram_export_sdram_wire_cs_n>),  //                           .sdram_wire_cs_n
		.vga_interface_sdram_export_sdram_wire_cke   (<connected-to-vga_interface_sdram_export_sdram_wire_cke>),   //                           .sdram_wire_cke
		.vga_interface_sdram_export_sdram_wire_cas_n (<connected-to-vga_interface_sdram_export_sdram_wire_cas_n>), //                           .sdram_wire_cas_n
		.vga_interface_sdram_export_sdram_wire_ba    (<connected-to-vga_interface_sdram_export_sdram_wire_ba>),    //                           .sdram_wire_ba
		.vga_interface_vga_export_red                (<connected-to-vga_interface_vga_export_red>),                //   vga_interface_vga_export.red
		.vga_interface_vga_export_green              (<connected-to-vga_interface_vga_export_green>),              //                           .green
		.vga_interface_vga_export_blue               (<connected-to-vga_interface_vga_export_blue>),               //                           .blue
		.vga_interface_vga_export_hs                 (<connected-to-vga_interface_vga_export_hs>),                 //                           .hs
		.vga_interface_vga_export_vs                 (<connected-to-vga_interface_vga_export_vs>)                  //                           .vs
	);


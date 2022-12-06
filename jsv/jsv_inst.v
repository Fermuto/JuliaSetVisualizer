	jsv u0 (
		.clk_clk                                  (<connected-to-clk_clk>),                                  //                      clk.clk
		.color_val_export                         (<connected-to-color_val_export>),                         //                color_val.export
		.hex_digits_export                        (<connected-to-hex_digits_export>),                        //               hex_digits.export
		.key_external_connection_export           (<connected-to-key_external_connection_export>),           //  key_external_connection.export
		.keycode_export                           (<connected-to-keycode_export>),                           //                  keycode.export
		.leds_export                              (<connected-to-leds_export>),                              //                     leds.export
		.reset_reset_n                            (<connected-to-reset_reset_n>),                            //                    reset.reset_n
		.shortreal_val_export                     (<connected-to-shortreal_val_export>),                     //            shortreal_val.export
		.spi0_MISO                                (<connected-to-spi0_MISO>),                                //                     spi0.MISO
		.spi0_MOSI                                (<connected-to-spi0_MOSI>),                                //                         .MOSI
		.spi0_SCLK                                (<connected-to-spi0_SCLK>),                                //                         .SCLK
		.spi0_SS_n                                (<connected-to-spi0_SS_n>),                                //                         .SS_n
		.state_to_software_export                 (<connected-to-state_to_software_export>),                 //        state_to_software.export
		.transition_code_export                   (<connected-to-transition_code_export>),                   //          transition_code.export
		.usb_gpx_export                           (<connected-to-usb_gpx_export>),                           //                  usb_gpx.export
		.usb_irq_export                           (<connected-to-usb_irq_export>),                           //                  usb_irq.export
		.usb_rst_export                           (<connected-to-usb_rst_export>),                           //                  usb_rst.export
		.vga_interface_misc_state                 (<connected-to-vga_interface_misc_state>),                 //       vga_interface_misc.state
		.vga_interface_misc_color                 (<connected-to-vga_interface_misc_color>),                 //                         .color
		.vga_interface_vga_export_hs              (<connected-to-vga_interface_vga_export_hs>),              // vga_interface_vga_export.hs
		.vga_interface_vga_export_vs              (<connected-to-vga_interface_vga_export_vs>),              //                         .vs
		.vga_interface_vga_export_red             (<connected-to-vga_interface_vga_export_red>),             //                         .red
		.vga_interface_vga_export_green           (<connected-to-vga_interface_vga_export_green>),           //                         .green
		.vga_interface_vga_export_blue            (<connected-to-vga_interface_vga_export_blue>),            //                         .blue
		.vga_interface_bitmap_io_sdram_draw       (<connected-to-vga_interface_bitmap_io_sdram_draw>),       //  vga_interface_bitmap_io.sdram_draw
		.vga_interface_bitmap_io_bitmap_intensity (<connected-to-vga_interface_bitmap_io_bitmap_intensity>), //                         .bitmap_intensity
		.vga_interface_bitmap_io_sdram_grab       (<connected-to-vga_interface_bitmap_io_sdram_grab>),       //                         .sdram_grab
		.vga_interface_bitmap_io_sdram_addr       (<connected-to-vga_interface_bitmap_io_sdram_addr>)        //                         .sdram_addr
	);


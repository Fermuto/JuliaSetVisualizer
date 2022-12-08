	component jsv is
		port (
			clk_clk                                  : in  std_logic                     := 'X';             -- clk
			color_val_export                         : out std_logic_vector(2 downto 0);                     -- export
			hex_digits_export                        : out std_logic_vector(15 downto 0);                    -- export
			imag_val_export                          : out std_logic_vector(31 downto 0);                    -- export
			key_external_connection_export           : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			keycode_export                           : out std_logic_vector(7 downto 0);                     -- export
			leds_export                              : out std_logic_vector(13 downto 0);                    -- export
			real_val_export                          : out std_logic_vector(31 downto 0);                    -- export
			reset_reset_n                            : in  std_logic                     := 'X';             -- reset_n
			spi0_MISO                                : in  std_logic                     := 'X';             -- MISO
			spi0_MOSI                                : out std_logic;                                        -- MOSI
			spi0_SCLK                                : out std_logic;                                        -- SCLK
			spi0_SS_n                                : out std_logic;                                        -- SS_n
			state_to_software_export                 : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- export
			transition_code_export                   : out std_logic_vector(1 downto 0);                     -- export
			usb_gpx_export                           : in  std_logic                     := 'X';             -- export
			usb_irq_export                           : in  std_logic                     := 'X';             -- export
			usb_rst_export                           : out std_logic;                                        -- export
			vga_interface_bitmap_io_sdram_draw       : in  std_logic                     := 'X';             -- sdram_draw
			vga_interface_bitmap_io_bitmap_intensity : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- bitmap_intensity
			vga_interface_bitmap_io_sdram_grab       : out std_logic;                                        -- sdram_grab
			vga_interface_bitmap_io_sdram_addr       : out std_logic_vector(22 downto 0);                    -- sdram_addr
			vga_interface_bitmap_io_sdram_x          : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- sdram_x
			vga_interface_bitmap_io_sdram_y          : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- sdram_y
			vga_interface_misc_state                 : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- state
			vga_interface_misc_color                 : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- color
			vga_interface_vga_export_hs              : out std_logic;                                        -- hs
			vga_interface_vga_export_vs              : out std_logic;                                        -- vs
			vga_interface_vga_export_red             : out std_logic_vector(3 downto 0);                     -- red
			vga_interface_vga_export_green           : out std_logic_vector(3 downto 0);                     -- green
			vga_interface_vga_export_blue            : out std_logic_vector(3 downto 0)                      -- blue
		);
	end component jsv;

	u0 : component jsv
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                      clk.clk
			color_val_export                         => CONNECTED_TO_color_val_export,                         --                color_val.export
			hex_digits_export                        => CONNECTED_TO_hex_digits_export,                        --               hex_digits.export
			imag_val_export                          => CONNECTED_TO_imag_val_export,                          --                 imag_val.export
			key_external_connection_export           => CONNECTED_TO_key_external_connection_export,           --  key_external_connection.export
			keycode_export                           => CONNECTED_TO_keycode_export,                           --                  keycode.export
			leds_export                              => CONNECTED_TO_leds_export,                              --                     leds.export
			real_val_export                          => CONNECTED_TO_real_val_export,                          --                 real_val.export
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                    reset.reset_n
			spi0_MISO                                => CONNECTED_TO_spi0_MISO,                                --                     spi0.MISO
			spi0_MOSI                                => CONNECTED_TO_spi0_MOSI,                                --                         .MOSI
			spi0_SCLK                                => CONNECTED_TO_spi0_SCLK,                                --                         .SCLK
			spi0_SS_n                                => CONNECTED_TO_spi0_SS_n,                                --                         .SS_n
			state_to_software_export                 => CONNECTED_TO_state_to_software_export,                 --        state_to_software.export
			transition_code_export                   => CONNECTED_TO_transition_code_export,                   --          transition_code.export
			usb_gpx_export                           => CONNECTED_TO_usb_gpx_export,                           --                  usb_gpx.export
			usb_irq_export                           => CONNECTED_TO_usb_irq_export,                           --                  usb_irq.export
			usb_rst_export                           => CONNECTED_TO_usb_rst_export,                           --                  usb_rst.export
			vga_interface_bitmap_io_sdram_draw       => CONNECTED_TO_vga_interface_bitmap_io_sdram_draw,       --  vga_interface_bitmap_io.sdram_draw
			vga_interface_bitmap_io_bitmap_intensity => CONNECTED_TO_vga_interface_bitmap_io_bitmap_intensity, --                         .bitmap_intensity
			vga_interface_bitmap_io_sdram_grab       => CONNECTED_TO_vga_interface_bitmap_io_sdram_grab,       --                         .sdram_grab
			vga_interface_bitmap_io_sdram_addr       => CONNECTED_TO_vga_interface_bitmap_io_sdram_addr,       --                         .sdram_addr
			vga_interface_bitmap_io_sdram_x          => CONNECTED_TO_vga_interface_bitmap_io_sdram_x,          --                         .sdram_x
			vga_interface_bitmap_io_sdram_y          => CONNECTED_TO_vga_interface_bitmap_io_sdram_y,          --                         .sdram_y
			vga_interface_misc_state                 => CONNECTED_TO_vga_interface_misc_state,                 --       vga_interface_misc.state
			vga_interface_misc_color                 => CONNECTED_TO_vga_interface_misc_color,                 --                         .color
			vga_interface_vga_export_hs              => CONNECTED_TO_vga_interface_vga_export_hs,              -- vga_interface_vga_export.hs
			vga_interface_vga_export_vs              => CONNECTED_TO_vga_interface_vga_export_vs,              --                         .vs
			vga_interface_vga_export_red             => CONNECTED_TO_vga_interface_vga_export_red,             --                         .red
			vga_interface_vga_export_green           => CONNECTED_TO_vga_interface_vga_export_green,           --                         .green
			vga_interface_vga_export_blue            => CONNECTED_TO_vga_interface_vga_export_blue             --                         .blue
		);


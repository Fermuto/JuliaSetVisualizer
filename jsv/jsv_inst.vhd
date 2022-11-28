	component jsv is
		port (
			clk_clk                                     : in    std_logic                     := 'X';             -- clk
			hex_digits_export                           : out   std_logic_vector(15 downto 0);                    -- export
			key_external_connection_export              : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			keycode_export                              : out   std_logic_vector(7 downto 0);                     -- export
			leds_export                                 : out   std_logic_vector(13 downto 0);                    -- export
			reset_reset_n                               : in    std_logic                     := 'X';             -- reset_n
			spi0_MISO                                   : in    std_logic                     := 'X';             -- MISO
			spi0_MOSI                                   : out   std_logic;                                        -- MOSI
			spi0_SCLK                                   : out   std_logic;                                        -- SCLK
			spi0_SS_n                                   : out   std_logic;                                        -- SS_n
			usb_gpx_export                              : in    std_logic                     := 'X';             -- export
			usb_irq_export                              : in    std_logic                     := 'X';             -- export
			usb_rst_export                              : out   std_logic;                                        -- export
			vga_interface_bitmap_input_sdram_draw       : in    std_logic                     := 'X';             -- sdram_draw
			vga_interface_bitmap_input_sdram_x          : in    std_logic                     := 'X';             -- sdram_x
			vga_interface_bitmap_input_sdram_y          : in    std_logic                     := 'X';             -- sdram_y
			vga_interface_bitmap_input_sdram_i          : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- sdram_i
			vga_interface_sdram_export_sdram_clk_clk    : out   std_logic;                                        -- sdram_clk_clk
			vga_interface_sdram_export_sdram_wire_addr  : out   std_logic_vector(11 downto 0);                    -- sdram_wire_addr
			vga_interface_sdram_export_sdram_wire_we_n  : out   std_logic;                                        -- sdram_wire_we_n
			vga_interface_sdram_export_sdram_wire_ras_n : out   std_logic;                                        -- sdram_wire_ras_n
			vga_interface_sdram_export_sdram_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- sdram_wire_dqm
			vga_interface_sdram_export_sdram_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- sdram_wire_dq
			vga_interface_sdram_export_sdram_wire_cs_n  : out   std_logic;                                        -- sdram_wire_cs_n
			vga_interface_sdram_export_sdram_wire_cke   : out   std_logic;                                        -- sdram_wire_cke
			vga_interface_sdram_export_sdram_wire_cas_n : out   std_logic;                                        -- sdram_wire_cas_n
			vga_interface_sdram_export_sdram_wire_ba    : out   std_logic;                                        -- sdram_wire_ba
			vga_interface_vga_export_red                : out   std_logic_vector(3 downto 0);                     -- red
			vga_interface_vga_export_green              : out   std_logic_vector(3 downto 0);                     -- green
			vga_interface_vga_export_blue               : out   std_logic_vector(3 downto 0);                     -- blue
			vga_interface_vga_export_hs                 : out   std_logic;                                        -- hs
			vga_interface_vga_export_vs                 : out   std_logic                                         -- vs
		);
	end component jsv;

	u0 : component jsv
		port map (
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                        clk.clk
			hex_digits_export                           => CONNECTED_TO_hex_digits_export,                           --                 hex_digits.export
			key_external_connection_export              => CONNECTED_TO_key_external_connection_export,              --    key_external_connection.export
			keycode_export                              => CONNECTED_TO_keycode_export,                              --                    keycode.export
			leds_export                                 => CONNECTED_TO_leds_export,                                 --                       leds.export
			reset_reset_n                               => CONNECTED_TO_reset_reset_n,                               --                      reset.reset_n
			spi0_MISO                                   => CONNECTED_TO_spi0_MISO,                                   --                       spi0.MISO
			spi0_MOSI                                   => CONNECTED_TO_spi0_MOSI,                                   --                           .MOSI
			spi0_SCLK                                   => CONNECTED_TO_spi0_SCLK,                                   --                           .SCLK
			spi0_SS_n                                   => CONNECTED_TO_spi0_SS_n,                                   --                           .SS_n
			usb_gpx_export                              => CONNECTED_TO_usb_gpx_export,                              --                    usb_gpx.export
			usb_irq_export                              => CONNECTED_TO_usb_irq_export,                              --                    usb_irq.export
			usb_rst_export                              => CONNECTED_TO_usb_rst_export,                              --                    usb_rst.export
			vga_interface_bitmap_input_sdram_draw       => CONNECTED_TO_vga_interface_bitmap_input_sdram_draw,       -- vga_interface_bitmap_input.sdram_draw
			vga_interface_bitmap_input_sdram_x          => CONNECTED_TO_vga_interface_bitmap_input_sdram_x,          --                           .sdram_x
			vga_interface_bitmap_input_sdram_y          => CONNECTED_TO_vga_interface_bitmap_input_sdram_y,          --                           .sdram_y
			vga_interface_bitmap_input_sdram_i          => CONNECTED_TO_vga_interface_bitmap_input_sdram_i,          --                           .sdram_i
			vga_interface_sdram_export_sdram_clk_clk    => CONNECTED_TO_vga_interface_sdram_export_sdram_clk_clk,    -- vga_interface_sdram_export.sdram_clk_clk
			vga_interface_sdram_export_sdram_wire_addr  => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_addr,  --                           .sdram_wire_addr
			vga_interface_sdram_export_sdram_wire_we_n  => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_we_n,  --                           .sdram_wire_we_n
			vga_interface_sdram_export_sdram_wire_ras_n => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_ras_n, --                           .sdram_wire_ras_n
			vga_interface_sdram_export_sdram_wire_dqm   => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_dqm,   --                           .sdram_wire_dqm
			vga_interface_sdram_export_sdram_wire_dq    => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_dq,    --                           .sdram_wire_dq
			vga_interface_sdram_export_sdram_wire_cs_n  => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_cs_n,  --                           .sdram_wire_cs_n
			vga_interface_sdram_export_sdram_wire_cke   => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_cke,   --                           .sdram_wire_cke
			vga_interface_sdram_export_sdram_wire_cas_n => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_cas_n, --                           .sdram_wire_cas_n
			vga_interface_sdram_export_sdram_wire_ba    => CONNECTED_TO_vga_interface_sdram_export_sdram_wire_ba,    --                           .sdram_wire_ba
			vga_interface_vga_export_red                => CONNECTED_TO_vga_interface_vga_export_red,                --   vga_interface_vga_export.red
			vga_interface_vga_export_green              => CONNECTED_TO_vga_interface_vga_export_green,              --                           .green
			vga_interface_vga_export_blue               => CONNECTED_TO_vga_interface_vga_export_blue,               --                           .blue
			vga_interface_vga_export_hs                 => CONNECTED_TO_vga_interface_vga_export_hs,                 --                           .hs
			vga_interface_vga_export_vs                 => CONNECTED_TO_vga_interface_vga_export_vs                  --                           .vs
		);


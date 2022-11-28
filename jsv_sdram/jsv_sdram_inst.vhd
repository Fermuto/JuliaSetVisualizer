	component jsv_sdram is
		port (
			clk_clk                  : in    std_logic                     := 'X';             -- clk
			reset_reset_n            : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr          : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_wire_ba            : out   std_logic;                                        -- ba
			sdram_wire_cas_n         : out   std_logic;                                        -- cas_n
			sdram_wire_cke           : out   std_logic;                                        -- cke
			sdram_wire_cs_n          : out   std_logic;                                        -- cs_n
			sdram_wire_dq            : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm           : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n         : out   std_logic;                                        -- ras_n
			sdram_wire_we_n          : out   std_logic;                                        -- we_n
			sdram_clk_clk            : out   std_logic;                                        -- clk
			bridge_0_ext_address     : in    std_logic_vector(22 downto 0) := (others => 'X'); -- address
			bridge_0_ext_byte_enable : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byte_enable
			bridge_0_ext_read        : in    std_logic                     := 'X';             -- read
			bridge_0_ext_write       : in    std_logic                     := 'X';             -- write
			bridge_0_ext_write_data  : in    std_logic_vector(15 downto 0) := (others => 'X'); -- write_data
			bridge_0_ext_acknowledge : out   std_logic;                                        -- acknowledge
			bridge_0_ext_read_data   : out   std_logic_vector(15 downto 0)                     -- read_data
		);
	end component jsv_sdram;

	u0 : component jsv_sdram
		port map (
			clk_clk                  => CONNECTED_TO_clk_clk,                  --          clk.clk
			reset_reset_n            => CONNECTED_TO_reset_reset_n,            --        reset.reset_n
			sdram_wire_addr          => CONNECTED_TO_sdram_wire_addr,          --   sdram_wire.addr
			sdram_wire_ba            => CONNECTED_TO_sdram_wire_ba,            --             .ba
			sdram_wire_cas_n         => CONNECTED_TO_sdram_wire_cas_n,         --             .cas_n
			sdram_wire_cke           => CONNECTED_TO_sdram_wire_cke,           --             .cke
			sdram_wire_cs_n          => CONNECTED_TO_sdram_wire_cs_n,          --             .cs_n
			sdram_wire_dq            => CONNECTED_TO_sdram_wire_dq,            --             .dq
			sdram_wire_dqm           => CONNECTED_TO_sdram_wire_dqm,           --             .dqm
			sdram_wire_ras_n         => CONNECTED_TO_sdram_wire_ras_n,         --             .ras_n
			sdram_wire_we_n          => CONNECTED_TO_sdram_wire_we_n,          --             .we_n
			sdram_clk_clk            => CONNECTED_TO_sdram_clk_clk,            --    sdram_clk.clk
			bridge_0_ext_address     => CONNECTED_TO_bridge_0_ext_address,     -- bridge_0_ext.address
			bridge_0_ext_byte_enable => CONNECTED_TO_bridge_0_ext_byte_enable, --             .byte_enable
			bridge_0_ext_read        => CONNECTED_TO_bridge_0_ext_read,        --             .read
			bridge_0_ext_write       => CONNECTED_TO_bridge_0_ext_write,       --             .write
			bridge_0_ext_write_data  => CONNECTED_TO_bridge_0_ext_write_data,  --             .write_data
			bridge_0_ext_acknowledge => CONNECTED_TO_bridge_0_ext_acknowledge, --             .acknowledge
			bridge_0_ext_read_data   => CONNECTED_TO_bridge_0_ext_read_data    --             .read_data
		);


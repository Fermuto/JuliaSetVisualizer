
module jsv_sdram (
	clk_clk,
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	sdram_clk_clk,
	bridge_0_ext_address,
	bridge_0_ext_byte_enable,
	bridge_0_ext_read,
	bridge_0_ext_write,
	bridge_0_ext_write_data,
	bridge_0_ext_acknowledge,
	bridge_0_ext_read_data);	

	input		clk_clk;
	input		reset_reset_n;
	output	[11:0]	sdram_wire_addr;
	output		sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output		sdram_clk_clk;
	input	[22:0]	bridge_0_ext_address;
	input	[1:0]	bridge_0_ext_byte_enable;
	input		bridge_0_ext_read;
	input		bridge_0_ext_write;
	input	[15:0]	bridge_0_ext_write_data;
	output		bridge_0_ext_acknowledge;
	output	[15:0]	bridge_0_ext_read_data;
endmodule

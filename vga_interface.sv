/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 601

module vga_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,                    // Avalon-MM Read
	input  logic AVL_WRITE,                    // Avalon-MM Write
	input  logic AVL_CS,                    // Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,            // Avalon-MM Byte Enable
	input  logic [9:0] AVL_ADDR,            // Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,        // Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,        // Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,    // VGA color channels (mapped to output pins in top-level)
	output logic hs, vs,                        // VGA HS/VS
	
	// Input from fractal_calc, SDRAM data
	input logic SDRAM_DRAW,
	input logic [9:0] SDRAM_X,
	input logic [9:0] SDRAM_Y,
	input logic [7:0] SDRAM_I,
	
	input logic [1:0] state,
	input logic [2:0] color,

	// Pass-through for SDRAM pins
	output wire        sdram_clk_clk,            //    sdram_clk.clk 
	output wire [11:0] sdram_wire_addr,          //   sdram_wire.addr
	output wire        sdram_wire_ba,            //             .ba
	output wire        sdram_wire_cas_n,         //             .cas_n
	output wire        sdram_wire_cke,           //             .cke
	output wire        sdram_wire_cs_n,          //             .cs_n
	inout  wire [15:0] sdram_wire_dq,            //             .dq
	output wire [1:0]  sdram_wire_dqm,           //             .dqm
	output wire        sdram_wire_ras_n,         //             .ras_n
	output wire        sdram_wire_we_n           //             .we_n
);

	//logic [31:0] LOCAL_REG       [`NUM_REGS]; // Registers

	//put other local variables here
	logic blank, sync, VGA_Clk, inversion;
	
	logic SDRAM_GRAB;
	logic [32:0] BM_RED_MUL, BM_GRE_MUL, BM_BLU_MUL;
	logic [22:0] SDRAM_ADDR;
	logic [15:0] BM_RED, BM_GRE, BM_BLU, bitmap_intensity_2;
	logic [7:0] bitmap_intensity;

	logic [31:0] row, col, sprites, colors;
	logic [10:0] addr;
	logic [9:0] drawxsig, drawysig, char_addr, f_addr;
	logic [7:0] sprite_data;
	logic [3:0] F_RED, F_GRE, F_BLU, B_RED, B_GRE, B_BLU;
	logic [3:0] spriteysig;
	logic [2:0] spritexsig;
	logic [1:0] f_spec;
	

	//Declare submodules..e.g. VGA controller, ROMS, etc
	vga_controller vga_0(.Clk(CLK),.Reset(RESET),.hs(hs), .vs(vs), .pixel_clk(VGA_Clk), .blank(blank), .sync(sync), .DrawX(drawxsig), .DrawY(drawysig)); 
										 
	font_rom characters(.addr(addr), .data(sprite_data));

	ocm memoree(.address_a (AVL_ADDR), .byteena_a (AVL_BYTE_EN), .data_a (AVL_WRITEDATA), .rden_a (AVL_READ), .wren_a (AVL_WRITE), .q_a (RAM_OUT),
					.address_b (char_addr), .byteena_b (4'b1111), .data_b (32'b00000000000000000000000000000000), .rden_b (1'b1), .wren_b (1'b0), .q_b (sprites),
					.clock (CLK));
					
					
	jsv_sdram sdram(
		.bridge_0_ext_address     	(SDRAM_ADDR),
		.bridge_0_ext_byte_enable 	(4'b0011),
		.bridge_0_ext_read			(SDRAM_GRAB), //ENABLE
		.bridge_0_ext_write			(SDRAM_DRAW), //ENABLE
		.bridge_0_ext_write_data	(SDRAM_I),
		.bridge_0_ext_acknowledge	(),
		.bridge_0_ext_read_data		(bitmap_intensity),
		.clk_clk			(CLK),
		.reset_reset_n	(RESET),
		.sdram_clk_clk		(sdram_clk_clk),
		.sdram_wire_addr	(sdram_wire_addr),
		.sdram_wire_ba		(sdram_wire_ba),
		.sdram_wire_cas_n	(sdram_wire_cas_n),
		.sdram_wire_cke	(sdram_wire_cke),
		.sdram_wire_cs_n	(sdram_wire_cs_n),
		.sdram_wire_dq		(sdram_wire_dq),
		.sdram_wire_dqm	(sdram_wire_dqm),
		.sdram_wire_ras_n	(sdram_wire_ras_n),
		.sdram_wire_we_n	(sdram_wire_we_n)
		);
		
	always_comb
	begin
		
		if (SDRAM_DRAW == 1)
			SDRAM_ADDR = (SDRAM_X * 480) + SDRAM_Y;
		else
			SDRAM_ADDR = (drawxsig * 480) + drawysig;
		
	end

	//	always_comb
	//	begin
	//		if (SDRAM_DRAW)
	//		begin
	//			Bitmap_Write = 1'b1;
	//			Avalon_Write = 1'b0;
	//		end
	//		
	//		else
	//		begin
	//			Bitmap_Write = 1'b0;
	//			Avalon_Write = 1'b1;
	//		end
	//	end
										 
	//always_ff @(posedge CLK) 
	//begin
	//    if(RESET) 
	//	 begin
	//        for(int i = 0; i< `NUM_REGS; i++)begin
	//            LOCAL_REG[i] <= 32'b00000000000000000000000000000000;
	//        end
	//     end
	//     else 
	//	  begin
	//        if(AVL_WRITE == 1'b1 && AVL_CS == 1'b1)
	//        begin
	//			  case(AVL_BYTE_EN)
	//					4'b1111:
	//						 LOCAL_REG[AVL_ADDR] <= AVL_WRITEDATA;
	//					4'b1100:
	//						 LOCAL_REG[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16];
	//					4'b0011:
	//						 LOCAL_REG[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
	//					4'b1000:
	//						 LOCAL_REG[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];    
	//					4'b0100:
	//						 LOCAL_REG[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];                
	//					4'b0010:
	//						 LOCAL_REG[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];                
	//					4'b0001:
	//						 LOCAL_REG[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];    
	//			  endcase
	//        end
	//        else if(AVL_READ == 1'b1 && AVL_CS == 1'b1)
	//		  begin
	//            AVL_READDATA <= LOCAL_REG[AVL_ADDR];
	//		  end
	//    end
	//end

	



	always_comb // Calculation for sprite display
	begin
		row <= drawysig/8'd16;
		col <= drawxsig/8'd8;
		f_addr <= (row*8'd80) + col;
		char_addr <= (f_addr / 4'd4);
		f_spec <= (f_addr % 4);
		
//		sprites = LOCAL_REG[char_addr];
//		colors = LOCAL_REG[600];
		case(f_spec)
			2'b00:
				 begin
				 addr[10:4] <= sprites[6:0];
				 inversion <= sprites[7];
				 end
			2'b01:
				 begin
				 addr[10:4] <= sprites[14:8];
				 inversion <= sprites[15];
				 end
			2'b10:
				 begin
				 addr[10:4] <= sprites[22:16];
				 inversion <= sprites[23];
				 end
			2'b11:
				 begin
				 addr[10:4] <= sprites[30:24];
				 inversion <= sprites[31];
				 end
		endcase
//		F_RED <= colors[12:9];
//		F_GRE <= colors[8:5];
//		F_BLU <= colors[4:1];
//		B_RED <= colors[24:21];
//		B_GRE <= colors[20:17];
//		B_BLU <= colors[16:13];

		spritexsig = 7-drawxsig%8;
		spriteysig = drawysig%16;
		addr[3:0] = spriteysig;
	end
		
	always_comb // Calculation for bitmap display
	begin
		case (color)
			3'b000: //White
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00001111_00000000;
					BM_BLU = 16'b00001111_00000000;
				end
			3'b001: //Pure Red
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00000000_00000000;
					BM_BLU = 16'b00000000_00000000;
				end
			3'b010: //Pure Green
				begin
					BM_RED = 16'b00000000_00000000;
					BM_GRE = 16'b00001111_00000000;
					BM_BLU = 16'b00000000_00000000;
				end
			3'b011: //Pure Blue
				begin
					BM_RED = 16'b00000000_00000000;
					BM_GRE = 16'b00000000_00000000;
					BM_BLU = 16'b00001111_00000000;
				end
			3'b100: //Pure Yellow (RG)
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00001111_00000000;
					BM_BLU = 16'b00000000_00000000;
				end
			3'b101: //Pure Purple (RB)
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00000000_00000000;
					BM_BLU = 16'b00001111_00000000;
				end
			3'b110: //Pure Cyan (GB)
				begin
					BM_RED = 16'b00000000_00000000;
					BM_GRE = 16'b00001111_00000000;
					BM_BLU = 16'b00001111_00000000;
				end
			3'b111: //Amber Phosphor
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00001010_00000000;
					BM_BLU = 16'b00000000_00000000;
				end
			default:
				begin
					BM_RED = 16'b00001111_00000000;
					BM_GRE = 16'b00001111_00000000;
					BM_BLU = 16'b00001111_00000000;
				end
		endcase
	end

	always_ff @ (posedge VGA_Clk)
	begin
		if (((state == 0) || (state == 1) || (state == 2)))
		begin
			if(blank == 1'b0)
			begin
				red <= 4'h00;
				green <= 4'h00;
				blue <= 4'h00;
			end
			else 
			begin
				if ((inversion && sprite_data[spritexsig]) || (!inversion && !sprite_data[spritexsig])) 
				begin 
					red <= 4'hff;
					green <= 4'hff;
					blue <= 4'hff;
				end      
				
				else 
				begin 
					red <= 4'h00;
					green <= 4'h00;
					blue <= 4'h00;
				end
			end
		end
		
		if (state == 3)
		begin
			if (SDRAM_DRAW == 1)
			begin
				SDRAM_GRAB = 0;
				red <= 4'h00;
				green <= 4'h00;
				blue <= 4'h00;
			end
			else if (SDRAM_DRAW == 0)
			begin
				SDRAM_GRAB = 1;
				bitmap_intensity_2 = {8'b00000000, bitmap_intensity};
				BM_RED_MUL = (bitmap_intensity_2 * BM_RED);
				BM_GRE_MUL = (bitmap_intensity_2 * BM_GRE);
				BM_BLU_MUL = (bitmap_intensity_2 * BM_BLU);
				if (bitmap_intensity == 8'b11111111)
				begin
					red <= BM_RED[11:8];
					green <= BM_GRE[11:8];
					blue <= BM_BLU[11:8];
				end
				else
				begin
					red <= BM_RED_MUL[19:16];
					green <= BM_GRE_MUL[19:16];
					blue <= BM_BLU_MUL[19:16];
				end
			end
			
		end
	end 


endmodule 
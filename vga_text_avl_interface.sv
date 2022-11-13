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

module vga_text_avl_interface (
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
    input  logic [11:0] AVL_ADDR,            // Avalon-MM Address
    input  logic [31:0] AVL_WRITEDATA,        // Avalon-MM Write Data
    output logic [31:0] AVL_READDATA,        // Avalon-MM Read Data
    
    // Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
    output logic [3:0]  red, green, blue,    // VGA color channels (mapped to output pins in top-level)
    output logic hs, vs                        // VGA HS/VS
);

logic [31:0] PALETTE [8]; // Registers

//put other local variables here
logic blank, sync, VGA_Clk, inversion;

logic[31:0] row, col, sprites, ramq;
logic[10:0] addr;
logic[11:0] drawxsig, drawysig, char_addr, f_addr;
logic[7:0] sprite_data;
logic[3:0] F_RED, F_GRE, F_BLU, B_RED, B_GRE, B_BLU;
logic[3:0] spriteysig;
logic[2:0] spritexsig;
logic[1:0] f_spec;

logic Avalon_Write, Palette_Write, color_sel;
logic[3:0] Palette_Off;
logic[11:0] colors_F, colors_B;
logic[31:0] int_modF, int_divF, int_modB, int_divB, RAM_OUT, PAL_OUT;
//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller vga_0(.Clk(CLK),.Reset(RESET),.hs(hs), .vs(vs), .pixel_clk(VGA_Clk), .blank(blank), .sync(sync), .DrawX(drawxsig), .DrawY(drawysig)); 
									 
font_rom bitmaps(.addr(addr), .data(sprite_data));

ram memoree(.address_a (AVL_ADDR), .byteena_a (AVL_BYTE_EN), .data_a (AVL_WRITEDATA), .rden_a (AVL_READ), .wren_a (Avalon_Write), .q_a (RAM_OUT),
				.address_b (char_addr), .byteena_b (4'b1111), .data_b (32'b00000000000000000000000000000000), .rden_b (1'b1), .wren_b (1'b0), .q_b (sprites),
				.clock (CLK));

always_comb
begin
	Palette_Off = AVL_ADDR[2:0];
	if (AVL_ADDR[11] == 1'b1)
	begin
		Palette_Write = 1'b1;
		Avalon_Write = 1'b0;
	end
	
	else
	begin
		Palette_Write = 1'b0;
		Avalon_Write = 1'b1;
	end
	
end

always_ff @(posedge CLK) 
begin
    if(RESET) 
	 begin
        for(int i = 0; i < 8; i++)begin
            PALETTE[i] <= 32'b00000000000000000000000000000000;
        end
     end
     else 
	  begin
        if (Palette_Write == 1'b1 && AVL_WRITE)
        begin
			  case(AVL_BYTE_EN)
					4'b1111:
						 PALETTE[Palette_Off] <= AVL_WRITEDATA;
					4'b1100:
						 PALETTE[Palette_Off][31:16] <= AVL_WRITEDATA[31:16];
					4'b0011:
						 PALETTE[Palette_Off][15:0] <= AVL_WRITEDATA[15:0];
					4'b1000:
						 PALETTE[Palette_Off][31:24] <= AVL_WRITEDATA[31:24];    
					4'b0100:
						 PALETTE[Palette_Off][23:16] <= AVL_WRITEDATA[23:16];                
					4'b0010:
						 PALETTE[Palette_Off][15:8] <= AVL_WRITEDATA[15:8];                
					4'b0001:
						 PALETTE[Palette_Off][7:0] <= AVL_WRITEDATA[7:0];    
			  endcase
        end
		  else if (Palette_Write == 1'b1 && AVL_READ)
		  begin
				PAL_OUT <= PALETTE[Palette_Off];
		  end
    end
end

always_comb
if (Palette_Write == 1'b1 && AVL_READ)
begin
AVL_READDATA = PAL_OUT;
end


else

begin
AVL_READDATA = RAM_OUT;
end

always_comb 
begin
        row <= drawysig/8'd16;
        col <= drawxsig/8'd8;
        f_addr <= (row*8'd80) + col;
        char_addr <= (f_addr / 2'd2);
        f_spec <= (f_addr % 2);
end



always_comb
begin
//	sprites = LOCAL_REG[char_addr];
//	colors = 32'b00000000000000000000000000000000;
	color_sel <= 1'b1;
	addr[10:4] <= sprites[30:24];
	inversion <= sprites[31];
	case(f_spec)
		2'b01:
			 begin
			 color_sel <= 1'b1;
			 addr[10:4] <= sprites[30:24];
			 inversion <= sprites[31];
			 end
		2'b00:
			 begin
			 color_sel <= 1'b0;
			 addr[10:4] <= sprites[14:8];
			 inversion <= sprites[15];
			 end
//		2'b10:
//			 begin
//			 addr[10:4] <= sprites[22:16];
//			 inversion <= sprites[23];
//			 end
//		2'b11:
//			 begin
//			 addr[10:4] <= sprites[30:24];
//			 inversion <= sprites[31];
//			 end
	endcase
	
end

always_comb
begin
	int_modF = ((sprites[23:20]) % 2'd2);
	int_divF = ((sprites[23:20]) / 2'd2);
		
	int_modB = (sprites[19:16]) % 2'd2;
	int_divB = (sprites[19:16]) / 2'd2;
	
	colors_F = 12'b000000000000;
	colors_B = 12'b000000000000;
	if (color_sel == 1'b1)
	begin
		int_modF = ((sprites[23:20]) % 2'd2);
		int_divF = ((sprites[23:20]) / 2'd2);
		
		int_modB = (sprites[19:16]) % 2'd2;
		int_divB = (sprites[19:16]) / 2'd2;

	end
	
	else
	begin
		int_modF = (sprites[7:4]) % 2'd2;
		int_divF = (sprites[7:4]) / 2'd2;
		
		int_modB = (sprites[3:0]) % 2'd2;
		int_divB = (sprites[3:0]) / 2'd2;
	end
	
	if (int_modF)
	begin
		colors_B = PALETTE[int_divF][24:13];
	end
	
	if (!int_modF)
	begin
		colors_B = PALETTE[int_divF][12:1];
	end
	
	if (int_modB)
	begin
		colors_F = PALETTE[int_divB][24:13];
	end
	
	else
	begin
		colors_F = PALETTE[int_divB][12:1];
	end
	
	F_RED <= colors_F[11:8];
	F_GRE <= colors_F[7:4];
	F_BLU <= colors_F[3:0];
	B_RED <= colors_B[11:8];
	B_GRE <= colors_B[7:4];
	B_BLU <= colors_B[3:0];
end

always_comb
begin
	spritexsig = 7-drawxsig%8;
	spriteysig = drawysig%16;
	addr[3:0] = spriteysig;
end

always_ff @ (posedge VGA_Clk)
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
			red <= F_RED;
			green <= F_GRE;
			blue <= F_BLU;
		end      
		
		else 
		begin 
			red <= B_RED;
			green <= B_GRE;
			blue <= B_BLU;
		end
	end
end 

endmodule 
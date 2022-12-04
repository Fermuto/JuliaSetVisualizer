# TCL File Generated by Component Editor 19.1
# Sat Dec 03 18:23:59 CST 2022
# DO NOT MODIFY


# 
# vga_interface "vga_interface" v1.0
#  2022.12.03.18:23:59
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module vga_interface
# 
set_module_property DESCRIPTION ""
set_module_property NAME vga_interface
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME vga_interface
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL vga_controller
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file VGA_controller.sv SYSTEM_VERILOG PATH VGA_controller.sv TOP_LEVEL_FILE
add_fileset_file font_rom.sv SYSTEM_VERILOG PATH font_rom.sv
add_fileset_file vga_interface.sv SYSTEM_VERILOG PATH vga_interface.sv


# 
# parameters
# 
add_parameter hpixels STD_LOGIC_VECTOR 799
set_parameter_property hpixels DEFAULT_VALUE 799
set_parameter_property hpixels DISPLAY_NAME hpixels
set_parameter_property hpixels WIDTH 12
set_parameter_property hpixels TYPE STD_LOGIC_VECTOR
set_parameter_property hpixels UNITS None
set_parameter_property hpixels ALLOWED_RANGES 0:4095
set_parameter_property hpixels HDL_PARAMETER true
add_parameter vlines STD_LOGIC_VECTOR 524
set_parameter_property vlines DEFAULT_VALUE 524
set_parameter_property vlines DISPLAY_NAME vlines
set_parameter_property vlines WIDTH 12
set_parameter_property vlines TYPE STD_LOGIC_VECTOR
set_parameter_property vlines UNITS None
set_parameter_property vlines ALLOWED_RANGES 0:4095
set_parameter_property vlines HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock CLK clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset RESET reset Input 1


# 
# connection point vga_export
# 
add_interface vga_export conduit end
set_interface_property vga_export associatedClock clock
set_interface_property vga_export associatedReset ""
set_interface_property vga_export ENABLED true
set_interface_property vga_export EXPORT_OF ""
set_interface_property vga_export PORT_NAME_MAP ""
set_interface_property vga_export CMSIS_SVD_VARIABLES ""
set_interface_property vga_export SVD_ADDRESS_GROUP ""

add_interface_port vga_export hs hs Output 1
add_interface_port vga_export vs vs Output 1
add_interface_port vga_export red red Output 4
add_interface_port vga_export green green Output 4
add_interface_port vga_export blue blue Output 4


# 
# connection point sdram_export
# 
add_interface sdram_export conduit end
set_interface_property sdram_export associatedClock clock
set_interface_property sdram_export associatedReset ""
set_interface_property sdram_export ENABLED true
set_interface_property sdram_export EXPORT_OF ""
set_interface_property sdram_export PORT_NAME_MAP ""
set_interface_property sdram_export CMSIS_SVD_VARIABLES ""
set_interface_property sdram_export SVD_ADDRESS_GROUP ""

add_interface_port sdram_export sdram_clk_clk sdram_clk_clk Output 1
add_interface_port sdram_export sdram_wire_addr sdram_wire_addr Output 12
add_interface_port sdram_export sdram_wire_ba sdram_wire_ba Output 1
add_interface_port sdram_export sdram_wire_cke sdram_wire_cke Output 1
add_interface_port sdram_export sdram_wire_cas_n sdram_wire_cas_n Output 1
add_interface_port sdram_export sdram_wire_cs_n sdram_wire_cs_n Output 1
add_interface_port sdram_export sdram_wire_dq sdram_wire_dq Bidir 16
add_interface_port sdram_export sdram_wire_dqm sdram_wire_dqm Output 2
add_interface_port sdram_export sdram_wire_ras_n sdram_wire_ras_n Output 1
add_interface_port sdram_export sdram_wire_we_n sdram_wire_we_n Output 1


# 
# connection point misc
# 
add_interface misc conduit end
set_interface_property misc associatedClock clock
set_interface_property misc associatedReset reset
set_interface_property misc ENABLED true
set_interface_property misc EXPORT_OF ""
set_interface_property misc PORT_NAME_MAP ""
set_interface_property misc CMSIS_SVD_VARIABLES ""
set_interface_property misc SVD_ADDRESS_GROUP ""

add_interface_port misc state state Input 2
add_interface_port misc color color Input 3


# 
# connection point bitmap_input
# 
add_interface bitmap_input conduit end
set_interface_property bitmap_input associatedClock clock
set_interface_property bitmap_input associatedReset ""
set_interface_property bitmap_input ENABLED true
set_interface_property bitmap_input EXPORT_OF ""
set_interface_property bitmap_input PORT_NAME_MAP ""
set_interface_property bitmap_input CMSIS_SVD_VARIABLES ""
set_interface_property bitmap_input SVD_ADDRESS_GROUP ""

add_interface_port bitmap_input SDRAM_DRAW sdram_draw Input 1
add_interface_port bitmap_input SDRAM_X sdram_x Input 10
add_interface_port bitmap_input SDRAM_Y sdram_y Input 10
add_interface_port bitmap_input SDRAM_I sdram_i Input 8


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 AVL_ADDR address Input 10
add_interface_port avalon_slave_0 AVL_BYTE_EN byteenable Input 4
add_interface_port avalon_slave_0 AVL_CS chipselect Input 1
add_interface_port avalon_slave_0 AVL_READ read Input 1
add_interface_port avalon_slave_0 AVL_READDATA readdata Output 32
add_interface_port avalon_slave_0 AVL_WRITE write Input 1
add_interface_port avalon_slave_0 AVL_WRITEDATA writedata Input 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


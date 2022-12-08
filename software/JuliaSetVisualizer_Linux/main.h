/*
 * main.h
 *
 *  Created on: Dec 7, 2022
 *      Author: Alexander J
 */

#ifndef MAIN_H_
#define MAIN_H_

#include <system.h>
#include <alt_types.h>

#define COLUMNS 80
#define ROWS 30

struct TEXT_VGA_STRUCT {
    alt_u8 VRAM [ROWS*COLUMNS];
    alt_u32 CTRL;
};

static volatile struct TEXT_VGA_STRUCT* vga_ctrl = VGA_INTERFACE_0_BASE;

void textVGAClr();

#endif /* MAIN_H_ */

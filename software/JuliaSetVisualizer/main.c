/*
 * main.c
 *
 *  Created on: Dec 6, 2022
 *      Author: Alexander J, Dante V
 */
#include <stdio.h>
#include "system.h"
#include "altera_avalon_spi.h"
#include "altera_avalon_spi_regs.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "usb_kb/GenericMacros.h"
#include "usb_kb/GenericTypeDefs.h"
#include "usb_kb/HID.h"
#include "usb_kb/MAX3421E.h"
#include "usb_kb/transfer.h"
#include "usb_kb/usb_ch9.h"
#include "usb_kb/USB.h"
#include "main.h"

#define KEY_1 0x1e // Keyboard 1 and !
#define KEY_2 0x1f // Keyboard 2 and @
#define KEY_3 0x20 // Keyboard 3 and #
#define KEY_4 0x21 // Keyboard 4 and $
#define KEY_5 0x22 // Keyboard 5 and %
#define KEY_6 0x23 // Keyboard 6 and ^
#define KEY_7 0x24 // Keyboard 7 and &
#define KEY_8 0x25 // Keyboard 8 and *
#define KEY_9 0x26 // Keyboard 9 and (
#define KEY_0 0x27 // Keyboard 0 and )

extern HID_DEVICE hid_device;

static BYTE addr = 1; 				//hard-wired USB address
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };

BYTE GetDriverandReport() {
	BYTE i;
	BYTE rcode;
	BYTE device = 0xFF;
	BYTE tmpbyte;

	DEV_RECORD* tpl_ptr;
	printf("Reached USB_STATE_RUNNING (0x40)\n");
	for (i = 1; i < USB_NUMDEVICES; i++) {
		tpl_ptr = GetDevtable(i);
		if (tpl_ptr->epinfo != NULL) {
			printf("Device: %d", i);
			printf("%s \n", devclasses[tpl_ptr->devclass]);
			device = tpl_ptr->devclass;
		}
	}
	//Query rate and protocol
	rcode = XferGetIdle(addr, 0, hid_device.interface, 0, &tmpbyte);
	if (rcode) {   //error handling
		printf("GetIdle Error. Error code: ");
		printf("%x \n", rcode);
	} else {
		printf("Update rate: ");
		printf("%x \n", tmpbyte);
	}
	printf("Protocol: ");
	rcode = XferGetProto(addr, 0, hid_device.interface, &tmpbyte);
	if (rcode) {   //error handling
		printf("GetProto Error. Error code ");
		printf("%x \n", rcode);
	} else {
		printf("%d \n", tmpbyte);
	}
	return device;
}

void setLED(int LED) {
	IOWR_ALTERA_AVALON_PIO_DATA(LEDS_PIO_BASE,
			(IORD_ALTERA_AVALON_PIO_DATA(LEDS_PIO_BASE) | (0x001 << LED)));
}

void clearLED(int LED) {
	IOWR_ALTERA_AVALON_PIO_DATA(LEDS_PIO_BASE,
			(IORD_ALTERA_AVALON_PIO_DATA(LEDS_PIO_BASE) & ~(0x001 << LED)));

}

void printSignedHex0(signed char value) {
	BYTE tens = 0;
	BYTE ones = 0;
	WORD pio_val = IORD_ALTERA_AVALON_PIO_DATA(HEX_DIGITS_PIO_BASE);
	if (value < 0) {
		setLED(11);
		value = -value;
	} else {
		clearLED(11);
	}
	//handled hundreds
	if (value / 100)
		setLED(13);
	else
		clearLED(13);

	value = value % 100;
	tens = value / 10;
	ones = value % 10;

	pio_val &= 0x00FF;
	pio_val |= (tens << 12);
	pio_val |= (ones << 8);

	IOWR_ALTERA_AVALON_PIO_DATA(HEX_DIGITS_PIO_BASE, pio_val);
}

void printSignedHex1(signed char value) {
	BYTE tens = 0;
	BYTE ones = 0;
	DWORD pio_val = IORD_ALTERA_AVALON_PIO_DATA(HEX_DIGITS_PIO_BASE);
	if (value < 0) {
		setLED(10);
		value = -value;
	} else {
		clearLED(10);
	}
	//handled hundreds
	if (value / 100)
		setLED(12);
	else
		clearLED(12);

	value = value % 100;
	tens = value / 10;
	ones = value % 10;
	tens = value / 10;
	ones = value % 10;

	pio_val &= 0xFF00;
	pio_val |= (tens << 4);
	pio_val |= (ones << 0);

	IOWR_ALTERA_AVALON_PIO_DATA(HEX_DIGITS_PIO_BASE, pio_val);
}

void setKeycode(WORD keycode)
{
	IOWR_ALTERA_AVALON_PIO_DATA(KEYCODE_BASE, keycode);
}



void textVGAClr()
{
	for (int i = 0; i<(ROWS*COLUMNS); i++)
	{
		vga_ctrl->VRAM[i] = 0x00;
	}
}

int main() {
	BYTE rcode;
	BOOT_MOUSE_REPORT buf;		//USB mouse report
	BOOT_KBD_REPORT kbdbuf;

	BYTE runningdebugflag = 0;//flag to dump out a bunch of information when we first get to USB_STATE_RUNNING
	BYTE errorflag = 0; //flag once we get an error device so we don't keep dumping out state info
	BYTE device;
	WORD keycode;
	WORD prev_keycode;


	printf("initializing MAX3421E...\n");
	MAX3421E_init();
	printf("initializing USB...\n");
	USB_init();

	int real_counter = 0;
	int imag_counter = 0;
	float real_val = 0;
	float imag_val = 0;

	char real_prompt[] = "Enter real coordinate.";
	char imag_prompt[] = "Enter imaginary coordinate.";
	char color_prompt[] = "Enter color selection.";
	
	while (1) {
		printf(".");
		MAX3421E_Task();
		USB_Task();
		
		//usleep (500000);
		if (GetUsbTaskState() == USB_STATE_RUNNING) {
			if (!runningdebugflag) {
				runningdebugflag = 1;
				setLED(9);
				device = GetDriverandReport();
			} else if (device == 1) {
				//run keyboard debug polling
				rcode = kbdPoll(&kbdbuf);
				if (rcode == hrNAK) {
					continue; //NAK means no new data
				} else if (rcode) {
					printf("Rcode: ");
					printf("%x \n", rcode);
					continue;
				}
				printf("keycodes: ");
				for (int i = 0; i < 6; i++) {
					printf("%x ", kbdbuf.keycode[i]);
				}

				if (prev_keycode == NULL){
					prev_keycode = kbdbuf_keycode[0];
				}

				if (STATE_BASE == 0){ // real
				memcpy((void*)&vga_ctrl->VRAM[j*COLUMNS]+(ROWS-j),redtest, sizeof(redtest));
					if ((prev_keycode == 0x00) && (kbdbuf_keycode[0] != 0x00)){
						if (real_counter == 0){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									real_val += (0*0.1);
								case KEY_1:
									real_val += (1*0.1);
								case KEY_2:
									real_val += (2*0.1);
								case KEY_3:
									real_val += (3*0.1);
								case KEY_4:
									real_val += (4*0.1);
								case KEY_5:
									real_val += (5*0.1);
								case KEY_6:
									real_val += (6*0.1);
								case KEY_7:
									real_val += (7*0.1);
								case KEY_8:
									real_val += (8*0.1);
								case KEY_9:
									real_val += (9*0.1);
							}
							real_counter++;
						}
						else if (real_counter == 1){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									real_val += (0*0.01);
								case KEY_1:
									real_val += (1*0.01);
								case KEY_2:
									real_val += (2*0.01);
								case KEY_3:
									real_val += (3*0.01);
								case KEY_4:
									real_val += (4*0.01);
								case KEY_5:
									real_val += (5*0.01);
								case KEY_6:
									real_val += (6*0.01);
								case KEY_7:
									real_val += (7*0.01);
								case KEY_8:
									real_val += (8*0.01);
								case KEY_9:
									real_val += (9*0.01);
							}
							real_counter++;
						}
						else if (real_counter == 2){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									real_val += (0*0.001);
								case KEY_1:
									real_val += (1*0.001);
								case KEY_2:
									real_val += (2*0.001);
								case KEY_3:
									real_val += (3*0.001);
								case KEY_4:
									real_val += (4*0.001);
								case KEY_5:
									real_val += (5*0.001);
								case KEY_6:
									real_val += (6*0.001);
								case KEY_7:
									real_val += (7*0.001);
								case KEY_8:
									real_val += (8*0.001);
								case KEY_9:
									real_val += (9*0.001);
							}
							real_counter++;
						}
						else if (real_counter == 3){
							//
							// float to Q16.16hex
							//
							SHORTREAL_VAL_BASE = hex_value;
							TRANSITION_BASE = 0x1;
							textVGAClr();
						}
					}
				}

				else if (STATE_BASE == 1){ // imag
					if ((prev_keycode == 0x00) && (kbdbuf_keycode[0] != 0x00)){
						if (imag_counter == 0){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									imag_val += (0*0.1);
								case KEY_1:
									imag_val += (1*0.1);
								case KEY_2:
									imag_val += (2*0.1);
								case KEY_3:
									imag_val += (3*0.1);
								case KEY_4:
									imag_val += (4*0.1);
								case KEY_5:
									imag_val += (5*0.1);
								case KEY_6:
									imag_val += (6*0.1);
								case KEY_7:
									imag_val += (7*0.1);
								case KEY_8:
									imag_val += (8*0.1);
								case KEY_9:
									imag_val += (9*0.1);
							}
							imag_counter++;
						}
						else if (imag_counter == 1){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									imag_val += (0*0.01);
								case KEY_1:
									imag_val += (1*0.01);
								case KEY_2:
									imag_val += (2*0.01);
								case KEY_3:
									imag_val += (3*0.01);
								case KEY_4:
									imag_val += (4*0.01);
								case KEY_5:
									imag_val += (5*0.01);
								case KEY_6:
									imag_val += (6*0.01);
								case KEY_7:
									imag_val += (7*0.01);
								case KEY_8:
									imag_val += (8*0.01);
								case KEY_9:
									imag_val += (9*0.01);
							}
							imag_counter++;
						}
						else if (imag_counter == 2){
							switch(kbdbuf_keycode[0]){
								case KEY_0:
									imag_val += (0*0.001);
								case KEY_1:
									imag_val += (1*0.001);
								case KEY_2:
									imag_val += (2*0.001);
								case KEY_3:
									imag_val += (3*0.001);
								case KEY_4:
									imag_val += (4*0.001);
								case KEY_5:
									imag_val += (5*0.001);
								case KEY_6:
									imag_val += (6*0.001);
								case KEY_7:
									imag_val += (7*0.001);
								case KEY_8:
									imag_val += (8*0.001);
								case KEY_9:
									imag_val += (9*0.001);
							}
							imag_counter++;
						}
						else if (imag_counter == 3){
							
							SHORTREAL_VAL_BASE = hex_value;
							TRANSITION_BASE = 0x2;
							textVGAClr();
						}
					}
				}

				else if (STATE_BASE == 2){ // color
					if ((prev_keycode == 0x00) && (kbdbuf_keycode[0] != 0x00)){
						switch(kbdbuf_keycode[0]){
								case KEY_0:
									COLOR_BASE = 0x0;
								case KEY_1:
									COLOR_BASE = 0x1;
								case KEY_2:
									COLOR_BASE = 0x2;
								case KEY_3:
									COLOR_BASE = 0x3;
								case KEY_4:
									COLOR_BASE = 0x4;
								case KEY_5:
									COLOR_BASE = 0x5;
								case KEY_6:
									COLOR_BASE = 0x6;
								case KEY_7:
									COLOR_BASE = 0x7;
						}
						TRANSITION_BASE = 0x3; 
						textVGAClr();
					}
				}
					
				int float_value = ;
				int rem;
				char hex_string[] = {'0', 'x', '0', '0', '0', '0', '0', '0', '0', '0'};
				for (int i = 9; i > 1; i--){
					rem = float_value%16;
					float_value /= 16;
					if (rem == 15){
						hex_string[i] = "f";
					} else if (rem == 14){
						hex_string[i] = "e";
					} else if (rem == 13){
						hex_string[i] = "d";
					} else if (rem == 12){
						hex_string[i] = "c";
					} else if (rem == 11){
						hex_string[i] = "b";
					} else if (rem == 10){
						hex_string[i] = "a";
					} else {
						hex_string[i] = (char) (rem);
					}
				}
				const char * = "0x320";
  				int hex_value = (int)strtol(, NULL, 0);

				setKeycode(kbdbuf.keycode[0]);
				printSignedHex0(kbdbuf.keycode[0]);
				printSignedHex1(kbdbuf.keycode[1]);
				printf("\n");
			}

//			else if (device == 2) {e
//				rcode = mousePoll(&buf);
//				if (rcode == hrNAK) {
//					//NAK means no new data
//					continue;
//				} else if (rcode) {
//					printf("Rcode: ");
//					printf("%x \n", rcode);
//					continue;
//				}
//				printf("X displacement: ");
//				printf("%d ", (signed char) buf.Xdispl);
//				printSignedHex0((signed char) buf.Xdispl);
//				printf("Y displacement: ");
//				printf("%d ", (signed char) buf.Ydispl);
//				printSignedHex1((signed char) buf.Ydispl);
//				printf("Buttons: ");
//				printf("%x\n", buf.button);
//				if (buf.button & 0x04)
//					setLED(2);
//				else
//					clearLED(2);
//				if (buf.button & 0x02)
//					setLED(1);
//				else
//					clearLED(1);
//				if (buf.button & 0x01)
//					setLED(0);
//				else
//					clearLED(0);
//			}
		} else if (GetUsbTaskState() == USB_STATE_ERROR) {
			if (!errorflag) {
				errorflag = 1;
				clearLED(9);
				printf("USB Error State\n");
				//print out string descriptor here
			}
		} else //not in USB running state
		{

			printf("USB task state: ");
			printf("%x\n", GetUsbTaskState());
			if (runningdebugflag) {	//previously running, reset USB hardware just to clear out any funky state, HS/FS etc
				runningdebugflag = 0;
				MAX3421E_init();
				USB_init();
			}
			errorflag = 0;
			clearLED(9);
		}

	}
	return 0;
}


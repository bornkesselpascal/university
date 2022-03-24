#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>
#include "fonts.h"

extern void u_delay(uint32_t usec);
extern void  LCD_Output16BitWord(uint16_t data);


/*----------------------------------------
GRUNDLEGENDE DISPLAY-FUNKTIONEN
 *----------------------------------------*/
void  LCD_WriteData(uint16_t data) {
	GPIOD->ODR &= ~(0x0800);							// PD11 deaktivieren (falls aktiviert)
	GPIOD->ODR |= 0x0010;									// PD 4 aktivieren (falls deaktiviert)- RD
	
	GPIOE->ODR |= 0x0008;									// PE 3 aktivieren (Datum) - DC
	
	GPIOD->ODR &= ~(0x0080);							// PD 7 deaktivieren - CS
	GPIOD->ODR &= ~(0x0020);							// PD 5 deaktivieren - WR
	
	LCD_Output16BitWord(data);						// Zustände anlegen
	
	GPIOD->ODR |= 0x0020;									// PD 5 aktivieren - WR
	GPIOD->ODR |= 0x0080;									// PD 7 aktivieren - CS
}

void  LCD_WriteCommand(uint16_t cmd) {
	GPIOD->ODR &= ~(0x0800);							// PD11 deaktivieren (falls aktiviert)
	GPIOD->ODR |= 0x0010;									// PD 4 aktivieren (falls deaktiviert)- RD
	
	GPIOE->ODR &= ~(0x0008);							// PE 3 deaktivieren (Kommando) - DC
	
	GPIOD->ODR &= ~(0x0080);							// PD 7 deaktivieren - CS
	GPIOD->ODR &= ~(0x0020);							// PD 5 deaktivieren - WR
	
	LCD_Output16BitWord(cmd);							// Zustände anlegen
	
	GPIOD->ODR |= 0x0020;									// PD 5 aktivieren - WR
	GPIOD->ODR |= 0x0080;									// PD 7 aktivieren - CS
}

void  LCD_WriteReg(uint16_t cmd, uint16_t data) {
	LCD_WriteCommand(cmd);
	LCD_WriteData(data);
}	

/*----------------------------------------
ERWEITERTE DISPLAY-FUNKTIONEN
 *----------------------------------------*/
void LCD_SetCrusor(uint32_t x, uint32_t y) {
	LCD_WriteReg(0x004E, x);
	LCD_WriteReg(0x004F, y);
}

void LCD_DrawPixel(uint16_t color) {
	LCD_WriteReg(0x0022, color);
}

void LCD_ClearDisplay(uint16_t color) {
	LCD_SetCrusor(0, 0);
	for(int i = 0; i<(240*320); i++) {
		LCD_DrawPixel(color);
	}
}

void LCD_WriteLetter(uint32_t x, uint32_t y, uint16_t color_letter, uint16_t color_back, uint8_t code) {
  uint32_t pos_x = x;
  uint32_t pos_y = y;
  uint32_t counter = 0; // i

  while(counter < 32) {
		
		for(uint32_t letterloop = 0; letterloop < 12; letterloop++) {
			uint8_t part = (console_font_12x16[32*(int)code+counter] << letterloop);
			if(letterloop >= 8) {
				part = (console_font_12x16[32*(int)code+counter+1] << (letterloop-8));
			}
			
			if((part & (1<<7)) != 0) {
				LCD_SetCrusor(pos_x, pos_y);
				LCD_DrawPixel(color_letter);
			} else {
				LCD_SetCrusor(pos_x, pos_y);
				LCD_DrawPixel(color_back);
			}
			pos_x++;
		}
		
		pos_x = x;
		pos_y++;
		counter+=2;
	}
}

void LCD_WriteString(uint32_t x, uint32_t y, uint16_t color_letter, uint16_t color_back, uint8_t code[]) {
	
	int i = 0;
	uint32_t x_count = x;
	char c = code[0];
	
	while(c != '\0') {
		LCD_WriteLetter(x_count, y, color_letter, color_back, c);
		
		x_count+=12;
		i++;
		c = code[i];
	}
}

void LCD_ToggleBacklight() {
	static bool status = false;
	status = !status;
	
	if(status) {
		GPIOD->ODR |=  0x2000;
	} else {
		GPIOD->ODR &=  ~0x2000;
	}
}

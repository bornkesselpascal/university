#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>


void  LCD_Output16BitWord(uint16_t data) {
    GPIOD->ODR &= ~(3 << 14);
    GPIOD->ODR |= ((data & 3) << 14);

    GPIOD->ODR &= ~(3);
    GPIOD->ODR |= ((data & (3 << 2)) >> 2);
    
    GPIOD->ODR &= ~(7 << 8);
    GPIOD->ODR |= ((data & (7 << 13)) >> 5);

    GPIOE->ODR &= ~(511 << 7);
    GPIOE->ODR |= ((data & (511 << 4)) << 3);
}


void  LEDs_Write(uint16_t data) {
		GPIOD->ODR |= 0x0800;								// PD11 aktivieren (falls deaktiviert)
		GPIOD->ODR |= 0x0020;								// PD 5 aktivieren (falls deaktiviert)
		GPIOD->ODR &= ~(0x0080);						// PD 7 deaktivieren - LED-CS
	
		LCD_Output16BitWord(data);					// Zustände anlegen
		GPIOD->ODR &= ~(0x0020);						// PD 5 deaktivieren - WR
		GPIOD->ODR |= 0x0020;								// PD 5 aktivieren - WR
		GPIOD->ODR |= 0x0080;								// PD 7 aktivieren - LED-CS
}

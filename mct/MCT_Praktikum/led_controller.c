#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>


bool ControllerBtn_Status(void) {
	uint32_t reg = GPIOA->IDR;			// GPIOA-Input in Variable reg speichern
	reg &= 0x00000001;							// Alle Bits, außer das 0. Bit "nullen" 
	
	if(reg != 0) {									// Rückgabe des Status der USER-Taste
		return true;
	} else {
		return false;
	}
}

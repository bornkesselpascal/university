#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>

extern void  u_delay(uint32_t usec);


void Bits2String(uint16_t bits, char* string_ptr)
{
    for(int i = 0; i<16; i++){
        if((bits & 32768) == 0){
            *(string_ptr+i) = '0';
        }
        else {
            *(string_ptr+i) = '1';
        }
        bits = bits << 1;
    }
    
    *(string_ptr+16) = '\0';
    return;
}



uint16_t KEY_GetInput(void) {
	uint16_t state = 0;
	uint16_t input = 0;
	
	for(uint16_t i = 0; i<4; i++) {
		GPIOB->ODR |= 0x000000F0;
		GPIOB->ODR &= ~(1 << (i+4));
		
		u_delay(30);
		
		input = GPIOA->IDR;
		input = ~input;
		input &= 0x00000078;
		input = input >> 3;
		
		state |= (input << (i*4));
	}
	return state;
}

uint16_t KEY_Read(uint16_t key_oldstate, uint16_t *key_pressed, uint16_t *key_released) {
	uint16_t key_newstate = KEY_GetInput();
	uint16_t key_changes = key_oldstate ^ key_newstate;
	*key_pressed = 0;
	*key_released = 0;
	
	for(uint16_t i = 0; i < 16; i++) {
		if((key_changes & (1<<i)) != 0) {
			if((key_newstate & (1<<i)) != 0) {
				*key_pressed = *key_pressed | (1<<i);
			} else {
				*key_released = *key_released | (1<<i);
			}
		}
	}
	
	return key_newstate;
}

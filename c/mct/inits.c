#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>

extern void u_delay(uint32_t usec);
extern void LCD_WriteReg(uint16_t cmd, uint16_t data);


void ControllerLED_InitPorts(void) {
	RCC->AHB1ENR |= 0x00000008;			// Taktversorgung GPIOD
	GPIOD->MODER |= 0x01000000;			// PD12 als Ausgang festlegen
}

void ControllerBtn_InitPorts(void) {
	RCC->AHB1ENR |= 0x00000001;			// Taktversorgung GPIOA
	GPIOA->MODER &= ~(0x00000003);	// PA0 als Eingang festlegen
}



 void LEDs_InitPorts(void) {
	RCC->AHB1ENR |= 0x00000008;			// Taktversorgung GPIOD
	RCC->AHB1ENR |= 0x00000010;			// Taktversorgung GPIOE
	
	GPIOD->MODER |= 0x50554405;			// Ausgänge festlegen
	GPIOE->MODER |= 0x55554000;
}



void LCD_InitPorts(void) {
	RCC->AHB1ENR |= 0x0000001A;			// Taktversorgung GPIOB, GPIOD, GPIOE
	
	GPIOB->MODER |= 0x00050000;			// Ausgänge festlegen
	GPIOD->MODER |= 0x54554545;
	GPIOE->MODER |= 0x55554040;
}

void LCD_Reset(void) {
	GPIOD->ODR |= 0x0010;									// PD 4 aktivieren - RD
	GPIOD->ODR |= 0x0020;									// PD 5 aktivieren - WR
	GPIOD->ODR |= 0x0080;									// PD 7 aktivieren - CS
	
	GPIOD->ODR |= 0x0008;									// PD 3 aktivieren - Reset
	GPIOD->ODR |= 0x0008;									// PD 3 deaktivieren - Reset
	u_delay(16);													// Wartezeit von mindestens 15us
	GPIOD->ODR |= 0x0008;									// PD 3 aktivieren - Reset
}

void LCD_Init(void) {
	LCD_InitPorts();
	LCD_Reset();
	
	LCD_WriteReg(0x0010, 0x0001);					/* Enter sleep mode */
	LCD_WriteReg(0x001E, 0x00B2);					/* Set initial power parameters. */
	LCD_WriteReg(0x0028, 0x0006); 				/* Set initial power parameters. */
	LCD_WriteReg(0x0000, 0x0001); 				/* Start the oscillator.*/
	LCD_WriteReg(0x0001, 0x72EF); 				/* Set pixel format and basic display orientation */
	LCD_WriteReg(0x0002, 0x0600);
	LCD_WriteReg(0x0010, 0x0000); 				/* Exit sleep mode. */
 
	u_delay(30000);												/* 30ms warten */
	
	LCD_WriteReg(0x0011, 0x6870); 				/* Configure pixel color format and MCU interface parameters.*/
	LCD_WriteReg(0x0012, 0x0999); 				/* Set analog parameters */
	LCD_WriteReg(0x0026, 0x3800);
	LCD_WriteReg(0x0007, 0x0033); 				/* Enable the display */
	LCD_WriteReg(0x000C, 0x0005); 				/* Set VCIX2 voltage to 6.1V.*/
	LCD_WriteReg(0x000D, 0x000A); 				/* Configure Vlcd63 and VCOMl */
	LCD_WriteReg(0x000E, 0x2E00);
	LCD_WriteReg(0x0044, (240-1) << 8); 	/* Set the display size and ensure that the GRAM window is set to allow access to the full display buffer.*/
	LCD_WriteReg(0x0045, 0x0000);
	LCD_WriteReg(0x0046, 320-1);
	LCD_WriteReg(0x004E, 0x0000); 				/*Set cursor to 0,0 */
	LCD_WriteReg(0x004F, 0x0000);
	
	GPIOD->ODR |=  0x2000;								// Backlight
}



void KEY_InitPorts(void) {
	RCC->AHB1ENR |= 0x00000003;				// Taktversorgung GPIOA, GPIOB
	
	GPIOA->MODER &= ~0x00003FC0;			// Eingänge festlegen
	GPIOB->MODER &= ~0x0000AA00;			// Ausgänge festlegen
	GPIOB->MODER |= 0x00005500;
	
	GPIOA->PUPDR |= 0x00001540;				// PULL-UP WIDERSTAND (Eingänge)
	GPIOB->OTYPER |= 0x000000F0;			// OPEN-DRAIN (Ausgänge)
	 
	GPIOB->ODR |= 0x000000F0; 				// Ausgänge aus '1' festlegen
}



void TMR7_Init(void) {
	RCC->APB1ENR |= (1<<5);
	TIM7->CR1 |= 1;										// Counter enable
	TIM7->DIER |= 1;									// Update-Event enable
	TIM7->PSC = 83;										// Vorteiler 83 - 84MHz/(83+1) = 1MHz
	TIM7->ARR = 999;									// Interrupt nach 1000 Takten
	
	NVIC_SetPriority(TIM7_IRQn, 10);
	NVIC_EnableIRQ(TIM7_IRQn);
}

void TMR12_Capture(void) {
	RCC->APB1ENR |= (1<<6);						// Taktversorgung TIM12
	RCC->AHB1ENR |= (1<<1);
	
	GPIOB->MODER |= (1<<29);					// Alternativfunktion PB14
	GPIOB->AFR[1]|= 0x09000000;			  // PB14 zu TIM12 CH1
	
	TIM12->SMCR   = 0x0000;						// Reset-Value: Interner Takt soll genutzt werden
	TIM12->DIER  |= 2;								// Zulassung des Interrupt Capture 1 und Überlauf Counter
	TIM12->CCMR1 &= ~(1<<1);					// Zuordnung Ch1 als Input
	TIM12->CCMR1 |= 1;
	TIM12->CCER  &= ~(1<<3);					// Rektion auf steigende Flanke
	TIM12->CCER  &= ~(1<<1);
	TIM12->CCER  |= 1;								// Capture-Enable
	TIM12->PSC  = 0;									// kein Prescaler
	TIM12->ARR  = 0xFFFF;							// Maximum beim ARR-Register
	TIM12->CR1   |= 1;								// Counter enable

	NVIC_SetPriority(TIM8_BRK_TIM12_IRQn, 12);
	NVIC_EnableIRQ(TIM8_BRK_TIM12_IRQn);
}

void TMR12_Count(void) {
	RCC->APB1ENR |= (1<<6);						// Taktversorgung TIM12
	RCC->AHB1ENR |= (1<<1);
	
	GPIOB->MODER |= (1<<29);					// Alternativfunktion PB14
	GPIOB->AFR[1]|= 0x09000000;				// PB14 zu TIM12 CH1
	
	TIM12->CCER  &= ~(1<<3);					// Rektion auf steigende Flanke
	TIM12->CCER  &= ~(1<<1);
	TIM12->SMCR  |= 7;								// Auswahl der externen Triggerquelle TI1FP1
	TIM12->SMCR  |= (5<<4);
	TIM12->DIER  = 0;								  // Nicht-Zulassung des Überlauf Counter
	TIM12->CCER  &= ~(1);							// Capture-Disable
	TIM12->PSC  = 0;									// kein Prescaler
	TIM12->ARR  = 0xFFFF;							// Maximum beim ARR-Register
	TIM12->CR1   &= ~1;								// Counter disable

	NVIC_SetPriority(TIM8_BRK_TIM12_IRQn, 12);
	NVIC_EnableIRQ(TIM8_BRK_TIM12_IRQn);
}



void ADC_Init(void) {
	RCC->AHB1ENR |= (1<<2);						// Taktversorgung GPIOC
	GPIOC->MODER |= 15;								// Analog-Modus PC0, PC1
	GPIOC->MODER |= (15<<8);					// Analog-Modus PC4, PC5
	
	RCC->APB2ENR |= (1<<8);						// Taktversorgung ADC1
	ADC1->CR2 |= 1;										// ADC aktivieren (ADON)
	ADC1->SQR3 |= (1<<3);							// erster Kanal zur Umwandlung (SQ1), ADC123_IN10 PC0
	ADC1->SQR3 |= (1<<1);	
	ADC1->SQR1 |= (0<<20);						// 1 Umwandlung (L)
	ADC1->CR1  |= (1<<5);
	
	NVIC_SetPriority(ADC_IRQn, 13);
	NVIC_EnableIRQ(ADC_IRQn);
}



void LIN_Init(void) {
	// 1 - Portleitungen konfigurieren
	RCC->AHB1ENR |= (1<<1);						// Taktversorgung GPIOB, GPIOC
	RCC->AHB1ENR |= (1<<2);
	
	GPIOB->MODER |= (1<<4);						// Output PB2
	GPIOC->MODER |= (1<<12);					// Output PC6
	GPIOB->ODR &= ~(1<<2);
	GPIOB->ODR |= (1<<2);
	GPIOC->ODR |= (1<<6);
	
	GPIOC->MODER |= (1<<13);					// Alternativfunktion PC6
	GPIOC->MODER &= ~(1<<12);
	GPIOC->MODER |= (1<<15);					// Alternativfunktion PC7
	GPIOC->AFR[0]|= (1<<27);			    // PC6 zu TXD (AF8)
	GPIOC->AFR[0]|= (1<<31);			   	// PC7 zu RXD (AF8)
	
	// 2 - Takt für das USART6-Modul
	RCC->APB2ENR |= (1<<5);
	
	// 3 - Konfiguration des USART6
	USART6->BRR = 0x1116;						// USARTDIV = 273,4

	USART6->CR1 |= (1<<2);						// Receiver Enable (RE)
	USART6->CR1 |= (1<<3);						// Tranceiver Enable (TE)
	
	USART6->CR1 |= (1<<5);						// Interrupt - RXNE
	USART6->CR1 |= (1<<6);						// Interrupt - TC
	USART6->CR2 |= (1<<6);						// Interrupt - LIN Break Detection
	USART6->CR2 |= (1<<5);						// LIN Break Detection Lenght 11 Bit
	USART6->CR2 |= (1<<14);						// LIN Mode Enable
	
	USART6->CR1 |= (1<<13);						// USART-Enable
	
	// 4 - USART Interrupt
	NVIC_SetPriority(USART6_IRQn, 11);
	NVIC_EnableIRQ(USART6_IRQn);
}



void TMR3_Init(void) {
	RCC->AHB1ENR |= (1<<1);
	RCC->AHB1ENR |= (1<<2);
	RCC->APB1ENR |= (1<<1);
	
	GPIOB->MODER |= (1<<1);					// Alternativfunktion PB0
	GPIOB->MODER |= (1<<3);					// Alternativfunktion PB1
	GPIOB->AFR[0]|= (1<<1);			  		// PB0 zu Tim3_Ch3 (AF2)
	GPIOB->AFR[0]|= (1<<5);			  		// PB1 zu Tim3_Ch4 (AF2)
	
	TIM3->CR1	|= 1;									// CEN
	// TIM3->CR1 |= (1<<5);					// Center Aligned Mode
	TIM3->CCMR2 |= (3<<5);					// Ch3 Compare-Modus
	TIM3->CCMR2 |= (3<<13);					// Ch4 Compare-Modus
	TIM3->CCER |= (1<<8);
	TIM3->CCER |= (1<<12);
	
	TIM3->PSC = 29;
	TIM3->ARR = 999;
	TIM3->CCR3 = 499;
	TIM3->CCR4 = 550;
	
	GPIOC->MODER |= (1<<22);
	GPIOC->ODR |= (1<<11);
}

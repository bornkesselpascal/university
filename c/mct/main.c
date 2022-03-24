#include "STM32F4xx.h"
#include "_mcpr_stm32f407.h"
#include <stdbool.h>
#include <stdio.h>
#include "inits.h"


// Funktionen
extern bool ControllerBtn_Status(void);
extern void LEDs_Write(uint16_t data);
extern void LCD_ClearDisplay(uint16_t color);
extern void LCD_WriteString(uint32_t x, uint32_t y, uint16_t color_letter, uint16_t color_back, uint8_t code[]);
extern uint16_t KEY_Read(uint16_t key_oldstate, uint16_t *key_pressed, uint16_t *key_released);
extern void Bits2String(uint16_t bits, char* string_ptr);
extern void LCD_WriteLetter(uint32_t x, uint32_t y, uint16_t color_letter, uint16_t color_back, uint8_t code);

void u_delay(uint32_t usec);
void TMR12_CountService(void);
void LIN_prepareSending(void);
uint8_t LIN_checksum(const uint8_t bytes[], uint8_t n, uint8_t id);


// globale Varibalen
volatile uint32_t ms = 0;
char display_OutputString[40];

volatile bool cac_EnCount = false;
volatile bool cac_EnCapture = false;

volatile uint16_t cac_Cap_newVal = 0;
volatile uint16_t cac_Cap_oldVal = 0;
volatile bool     cac_Cap_Evaluate = false;

volatile uint16_t cac_Cnt_val;
volatile uint16_t cac_Cnt_overflow = 0;
volatile bool     cac_Cnt_newVal = false;

volatile bool			adc_running = false;
volatile bool			adc_ready = false;
volatile uint16_t	adc_value[4] = {0,0,0,0};
volatile int			adc_number = 0;

uint32_t cac_Cap_delta;

enum LIN_States {
	Idle,
	BreakReceived,
	SyncReceived,
	CmdReceived,
	Sending
};

volatile enum LIN_States lin_State = Idle;
volatile uint8_t lin_rec_data = 0;

struct LIN_Sending {
	uint8_t buffer[5];
	int buffer_size;
	int buffer_current;
};

volatile struct LIN_Sending lin_Send;

uint16_t key_state = 0;
uint32_t cac_Cap_freq = 0;
volatile uint32_t intr_Latenz = 0;

/*----------------------------------------
	MAIN function
 *----------------------------------------*/
int main (void) {
	mcpr_SetSystemCoreClock();
	
	// Variablen
	uint16_t leds_State = 1;
	bool leds_Invert = false;
	uint16_t key_pressed = 0;
	uint16_t key_released = 0;
	uint32_t ms_IterStart = 0;
	bool tmr_LED = false;
	bool tmr_Display = false;
	bool tmr_SecActive = false;
	uint32_t tmr_CtLED = 0;
	uint32_t tmr_CtDisplay = 0;
	uint16_t cap_control = 0;
	bool cap_toggle = false;
	
	
	// Initialisierungen
	ControllerLED_InitPorts();
	ControllerBtn_InitPorts();
	LEDs_InitPorts();
	LCD_Init();
	KEY_InitPorts();
	TMR7_Init();
	TMR12_Capture();
	// TMR12_Count();
	LCD_ClearDisplay(0x1000);
	ADC_Init();
	LIN_Init();
	TMR3_Init();
	

	LCD_WriteString(10, 10, 0xF0FF, 0x0000, "Tastaturmatrix");
	LCD_WriteString(10, 60, 0xF0FF, 0x0000, "Frequenzmessung");
	LCD_WriteString(10, 130, 0xF0FF, 0x0000, "Potentiometer");

	while (1) {
		
		ms_IterStart = ms;
		
		if(cap_control % 2 == 0) {
			if(cap_toggle) {
				cap_toggle = !cap_toggle;
				// cac_EnCount = false;
				TMR12_Capture();
				cac_EnCapture = true;
			}
			else {
				cap_toggle = !cap_toggle;
				// cac_EnCapture = false;
				TMR12_Count();
				cac_EnCount = true;
			}
		}
		else {
			cac_EnCount = false;
			cac_EnCapture = false;
		}
		
		cap_control++;
		if(cap_control >= 20) {
			cap_control = 0;
		}
		
		
		// LED-Lauflicht (deaktiviert)
		if(false) {
			leds_State = leds_State << 1;
			if(leds_State == 0) {
				leds_State = 1;
				leds_Invert = !leds_Invert ;
			}
			
			if(leds_Invert) {
				LEDs_Write(~leds_State);
			} else {
				LEDs_Write(leds_State);
			}
		}
		
		
		// Matrix-Tastatur mit Ausgabe auf LEDs und Display
		key_state = KEY_Read(key_state, &key_pressed, &key_released);
		
		LEDs_Write(key_state);
		Bits2String(key_state, display_OutputString);						// Bits2String(key_state, (char) display_OutputString);
		LCD_WriteString(10, 30, 0xFFFF, 0x0000, display_OutputString);
		
		
		if(((key_pressed & 0x00FF) != 0) || ((key_released & 0xFF00) != 0)) {
			// Tastatur-Event
			tmr_CtLED = ms;
			tmr_LED = true;
			GPIOD->ODR |= 0x1000;
		}
		
		// LED nach 10s ausschalten
		if((ms-tmr_CtLED >= 10000) && tmr_LED) {
			tmr_LED = false;
			GPIOD->ODR &= ~(0x1000);
		}
		
		
		// Displaybeleuchtung toggeln aktivieren/deaktivieren
		if(ControllerBtn_Status()) {
			if(!tmr_SecActive) {
				tmr_CtDisplay = ms;
				tmr_Display = true;
				tmr_SecActive = true;
				GPIOD->ODR &= ~(0x2000);
			}
		} else {
			tmr_Display = false;
			GPIOD->ODR |= 0x2000;
		}
		
		// 1s-Timer (Abweichung von bis zu 50ms)
		if(tmr_SecActive) {
			uint32_t tmr_CtCounter = ms;
			if(tmr_CtCounter-tmr_CtDisplay >= 1000) {
				if(tmr_Display) {
					GPIOD->ODR ^= 0x2000;
				} else {
					// GPIOD->ODR |= 0x2000; -> bei Steuerung, Frage der Implementierung
					tmr_SecActive = false;
				}
				tmr_CtDisplay = tmr_CtCounter;
			}
		}
		
		
		// Frequenz messen
		if(cac_EnCapture) {
			if(cac_Cap_Evaluate) {
				cac_Cap_Evaluate = false;
				cac_Cap_delta = cac_Cap_newVal - cac_Cap_oldVal;
				cac_Cap_freq =  84000000/cac_Cap_delta;			
				//cac_Cap_freq = cac_Cap_freq / 1000;
				sprintf(display_OutputString, "- Capture %8d  Hz", cac_Cap_freq);
				LCD_WriteString(10, 80, 0xFFFF, 0x0000, display_OutputString);
			}
		}
		
		if(cac_EnCount) {
			if(cac_Cnt_newVal) {
				cac_Cnt_newVal = false;
				int64_t cac_Cnt_localVal = cac_Cnt_val;
				if(cac_Cnt_overflow != 0) {
				  //cac_Cnt_localVal = cac_Cnt_localVal + (cac_Cnt_overflow * 0xFFFF);
					cac_Cnt_overflow = 0;
				}
				int cac_Cnt_freq = cac_Cnt_localVal / 0.005;
				cac_Cnt_freq = cac_Cnt_freq / 1000;
				sprintf(display_OutputString, "- Counter %8d    kHz", cac_Cnt_freq);
				LCD_WriteString(10, 100, 0xFFFF, 0x0000, display_OutputString);
			}
		}
		
		
		// Potentiometer
		if(!adc_running && !adc_ready) {
			adc_running = true;
			adc_number = 0;
			ADC1->CR2 |= (1<<30);
		}
		if(adc_ready) {
			adc_ready = false;
			
			sprintf(display_OutputString, "33@10 31@11 D1@14 D2@15   ");
			LCD_WriteString(10, 150, 0xFFFF, 0x0000, display_OutputString);
			
			uint32_t percent[4];
			for(int i=0; i<2; i++) {
				percent[i] = (adc_value[i]*100) / 4090;
			}
			for(int i=2; i<4; i++) {
				percent[i] = (adc_value[i]*100) / 3700;
			}
			
			if(percent[0] < 5) {
				TIM3->CCR3 = ((5 * 999) / 100);
			}
			else if(percent[0] > 95) {
				TIM3->CCR3 = ((95 * 999) / 100);
			}
			else {
				TIM3->CCR3 = ((percent[0] * 999) / 100);
			}
			
			if(percent[1] < 5) {
				TIM3->CCR4 = ((5 * 999) / 100);
			}
			else if(percent[1] > 95) {
				TIM3->CCR4 = ((95 * 999) / 100);
			}
			else {
				TIM3->CCR4 = ((percent[1] * 999) / 100);
			}
				
			sprintf(display_OutputString, "%3d %% %3d %% %3d %% %3d %%", percent[0], percent[1], percent[2], percent[3]);
			LCD_WriteString(10, 170, 0xFFFF, 0x0000, display_OutputString);
		}
		
		
		
		// Hauptschleife alle 50ms
		while((ms - ms_IterStart) < 50) {
		}
	}
}



void u_delay(uint32_t usec) {
	uint32_t max = usec * 28;				        // RAM-Target
	// uint32_t max = usec * 42;					  // Flash-Target
	
	uint32_t count = 0;
	
	while(count != max) {
		count++;
	}
}



void TIM7_IRQHandler(void) {
	intr_Latenz = TIM7->CNT;
	TIM7->SR = 0x0000;
	ms++;
	TMR12_CountService();
}

void TIM8_BRK_TIM12_IRQHandler(void) {
	static int mycnt = 0;
	mycnt++;
	uint16_t status = TIM12->SR;
	TIM12->SR = 0x0000;
	
	// Capture-Funktion
	if((status & (1<<1)) != 0) {
		cac_Cap_oldVal = cac_Cap_newVal;
		cac_Cap_newVal = TIM12->CCR1;
		cac_Cap_Evaluate = true;
	}
}

void TMR12_CountService(void) {
	static uint32_t count = 0;
	
	if(cac_EnCount) {
		if(count == 0) {
			TIM12->CNT  = 0;
			TIM12->CR1 |= 1;
			count++;
		}
		else if(count > 4) {
			TIM12->CR1 |= 1;
			cac_Cnt_val = TIM12->CNT;
			cac_Cnt_newVal = true;
			count = 0;
		}
		else {
			count++;
		}
	} else {
		count = 0;
	}

}

void ADC_IRQHandler(void) {
	adc_number++;
	
	switch(adc_number) {
		case 1:
			adc_value[0] = ADC1->DR;
			ADC1->SQR3 &= ~31;
		  ADC1->SQR3 |= 11;									// ADC123_IN11 PC1
			ADC1->CR2 |= (1<<30);
			break;
		case 2:
			adc_value[1] = ADC1->DR;
			ADC1->SQR3 &= ~31;
			ADC1->SQR3 |= 14;									// ADC12_IN14
			ADC1->CR2 |= (1<<30);							
			break;
		case 3:
			adc_value[2] = ADC1->DR;
			ADC1->SQR3 &= ~31;
			ADC1->SQR3 |= 15;									// ADC12_IN15
			ADC1->CR2 |= (1<<30);	
			break;
		case 4:
			adc_value[3] = ADC1->DR;
			ADC1->SQR3 &= ~31;
			ADC1->SQR3 |= 10;									// ADC123_IN10 PC0
			adc_running = false;
			adc_ready = true;
			break;
	}
}


void USART6_IRQHandler(void) {
	uint32_t status = USART6->SR;
	USART6->SR = 0;
	
	switch(lin_State) {
		case Idle:
			if((status & (1<<8)) != 0) {
				// LBD
				lin_State = BreakReceived;
				USART6->SR &= ~(1<<8);
			}
			break;
		case BreakReceived:
			if((status & (1<<5)) != 0) {
				// RXNE
				lin_rec_data = USART6->DR;
				if(lin_rec_data == 0x55) {
					lin_State = SyncReceived;
				} else {
					lin_State = Idle;
				}
			}
			break;
		case SyncReceived:
			if((status & (1<<5)) != 0) {
				// RXNE
				lin_rec_data = USART6->DR;
				if((lin_rec_data & 0x0F) == 3) {
					// Station 3 - Senden vorbereiten & beginnen
					LIN_prepareSending();
					USART6->DR = lin_Send.buffer[lin_Send.buffer_current];
					lin_Send.buffer_current++;
					lin_State = Sending;
				} else {
					// Andere Station
					lin_State = Idle;
				}
			}
			break;
		case Sending:
			if((status & (1<<6)) != 0) {
				if(lin_Send.buffer_current < lin_Send.buffer_size) {
					USART6->DR = lin_Send.buffer[lin_Send.buffer_current];
					lin_Send.buffer_current++;
				} else {
					// alles gesendet
					lin_State = Idle;
				}
			}
			break;
		default:
			lin_State = Idle;
			break;
	}
}


void LIN_prepareSending(void) {
	uint8_t lin_request = ((lin_rec_data>>4) & 3);
	
	if(lin_request == 0x01) {
		// Systemzeit (2 Byte + Checksumme)
		lin_Send.buffer_size = 3;
		lin_Send.buffer_current = 0;
		
		uint16_t ms_local = (ms & 0x0000FFFF);

		//lin_Send.buffer[0] = (uint8_t) ms_local;
		//lin_Send.buffer[1] = (uint8_t)(ms_local>>8);
			
		uint8_t bytes[] = {(uint8_t) ms_local, (uint8_t)(ms_local>>8)};
		lin_Send.buffer[0] = bytes[0];
		lin_Send.buffer[1] = bytes[1];
		lin_Send.buffer[2] = LIN_checksum(lin_Send.buffer, 2, lin_rec_data);
	}
	else if(lin_request == 0x02) {
		// Frequenzwert (4 Byte + Checksumme)
		lin_Send.buffer_size = 5;
		lin_Send.buffer_current = 0;
		
		uint32_t frq_local = cac_Cap_freq;
		uint8_t bytes[] = {(uint8_t) frq_local, (uint8_t) (frq_local>>8), (uint8_t) (frq_local>>16), (uint8_t) (frq_local>>24)};
		
		lin_Send.buffer[0] = bytes[0];
		lin_Send.buffer[1] = bytes[1];
		lin_Send.buffer[2] = bytes[2];
		lin_Send.buffer[3] = bytes[3];
		lin_Send.buffer[4] = LIN_checksum(bytes, 4, lin_rec_data);
	}
	else if(lin_request == 0x03) {
		// Tastenzustand (2 Byte + Checksumme)
		lin_Send.buffer_size = 3;
		lin_Send.buffer_current = 0;
		
		uint16_t ks_local = key_state;
		uint8_t ks_1 = key_state;
		uint8_t ks_2 = (key_state>>8);

		lin_Send.buffer[0] = ks_1;
		lin_Send.buffer[1] = ks_2;
		
		// lin_Send.buffer[0] = key_state;
		// lin_Send.buffer[1] = (key_state>>8);
		lin_Send.buffer[2] = LIN_checksum(lin_Send.buffer, 2, lin_rec_data);
	}
}

uint8_t LIN_checksum(const uint8_t bytes[], uint8_t n, uint8_t id) {
	uint32_t sum = 0;
	
	for(uint8_t counter = 0; counter < n; counter++) {
		sum  += bytes[counter];
		if(sum > 255) {
			sum -= 256;
			sum++;
		}
	}
	
	sum += id;
	if(sum > 255) {
		sum -= 256;
		sum++;
	}
	
	return ~(sum);
}

/**
  ******************************************************************************
  * @file    _mcpr_stm32f407_all.c
  * @author  STM, modified by L. Gaul
  * @version V4.1.1
  * @date    26-May-2020 last revision
  * @brief   based on _mcpr_stm32f407_fsmc.c V2.2.0:
  *          V4.1.0: Emulate_RKTYC included
  *                  based on EXTI of PB15 to detect load/discharge of capacitor
  *                  switches pulls of PC8/PC9, controlled by Timer 2, to emulate charge/discharge 
  *                  and comparator inputs
  *                  very sensitve to disturbancies, okay on stand-alone Discovery-Board, notokay with LCD and FSMC!
  *                       (may be due to weak defintion of levels by high ohmic pulls)
  *          V4.0.1: wait replaced by _waitemu_
  *          V4.0.0:
  *          LEDs-LCD-Emulator, based on Memory Protection Unit to catch access to LEDs and LCD           	
  *             relies on stacking of register with LEDs/LCD-adress during Memory Management Fault
  *					 activation of fsmc (external memory bus interface to LCD and 16LEDs)
	*					    depends on definition of USE_FSMC (acitvated) or NO_FSMC (not activated) else error
  *             if/elif in SystemInit_ExtMemCtl() located to avoid warning
  *             
	*          preceding _mcpr_stm32f407_fsmc.c, V2.2.0:
	*          File system_stm32f4xx.c (V2.1.0 modified by ARM, 19-Juni-2014) 
	*          included by µVision 5.13 package manager
  *          misses SetSysClock() to reconfigure PLL.	
  *          This file provides SetSysClock from original system_stm32f4xx.c 
  *          (see below). 
  *          Renaming of names (function, defines) with prefix mcpr_
  *          Initialisation of FSMC (Bank 1, SRAM, async, for lab LEDs + LCD) 
	*
  *
  * Modifications to default configuration:
  *=============================================================================
  *                                               | Default Value                  
  *-----------------------------------------------------------------------------
  *        Supported STM32F4xx device revision    | Rev A
  *-----------------------------------------------------------------------------
  *        System Clock source                    | PLL (HSE)
  *-----------------------------------------------------------------------------
  *        SYSCLK(Hz)                             | 168000000
  *-----------------------------------------------------------------------------
  *        HCLK(Hz)                               | 168000000
  *-----------------------------------------------------------------------------
  *        AHB Prescaler                          | 1
  *-----------------------------------------------------------------------------
  *        APB1 Prescaler                         | 4
  *-----------------------------------------------------------------------------
  *        APB2 Prescaler                         | 2
  *-----------------------------------------------------------------------------
  *        HSE Frequency(Hz)                      | 8000000
  *-----------------------------------------------------------------------------
  *        mcpr_PLL_M                             | 8
  *-----------------------------------------------------------------------------
  *        mcpr_PLL_N                             | 336
  *-----------------------------------------------------------------------------
  *        mcpr_PLL_P                             | 2
  *-----------------------------------------------------------------------------
  *        mcpr_PLL_Q                             | 7
  *-----------------------------------------------------------------------------
  *=============================================================================
  */
	
#include "_mcpr_stm32f407.h"

#include "stm32f4xx.h"

#include "stdio.h"		

static void mcpr_SetSysClock(void);
static void SystemInit_ExtMemCtl(void);


void mcpr_SetSystemCoreClock(void) {
	// Clock Reconfigration  
	mcpr_SetSysClock();
	// Update global variable SystemCoreClock
	//    Defintion in system_stm32f4xx.c
	SystemCoreClockUpdate();	
	SystemInit_ExtMemCtl();
}

//void mcpr_SetSystemCoreClock(void) {
//     // Clock Reconfigration
//     mcpr_SetSysClock();
//     // Update global variable SystemCoreClock
//     //    Defintion in system_stm32f4xx.c
//     SystemCoreClockUpdate();
//#if defined(USE_FSMC)
//     SystemInit_ExtMemCtl();
//#elif defined(NO_FSMC)
//     // keine Initialisierung notwendig
//#else
//	#error Definition of FSMC macro is missing 
//#endif 
//}

void mcpr_ConfigSystemTick(void) {
	// SysTick System Timer Configuration, requests periodically 
	//           a SysTick_Handler, e.g. void SysTick_Handler(void) {   }
	//    Missing SysTick_Handler results in loop for ever in startup_stm32f407xx.s
	//    Definition of SysTick_Config in core_cm4.h 
	  if (SysTick_Config(SystemCoreClock / 1000)) { /* SysTick 1 msec interrupts  */
    while (1);                                  /* Capture error              */
  }
}
//

void mcpr_SetSysClockTick(void) {
	mcpr_SetSystemCoreClock();
	mcpr_ConfigSystemTick();
}


/******************************************************************************
  * @brief  Configuration Emulation of HW-Access to LEDs (0x60020000) and LCDs (0x60000000, 0x60100000)
  *         Uses Memory Management Protection Fault to LEDs/LCD Adresses
  *         Manipulates Stack, based on Stacking of Fault-Handler, works if R0-R3 is used to adress LEDs/LCD
  *
  *         Place Emulate_LEDsLCD (unsigned int rows, unsigned int cols) at beginning of Polling-Loop
  *         use Debug (printf) viewer (terminal mode required) to display LEDs  and LCD
  * @param  rows = number of displayed pixels in y-dir (0...239) 
  *         cols = number of displayed pixels in x-dir (0...319)
  * @retval None
  *****************************************************************************/

// globals for Emulate_LEDsLCD

// simulation of printf is perfect,
// execution of printf over trace-port to IDE is to slow
#if (HSI_VALUE==168000000)  // simulation setting
  #define PRINTPERIODms  0         
  #define WAITUS 0 
  #define ROWMAXPP 512
#else                       // Board targets
  #define PRINTPERIODms  150         
  #define WAITUS 200 
  #define ROWMAXPP 8
#endif


#ifdef USE_EMULATOR    // use emulator for LCD and LEDs

// ---------------- RKTY*C EMULATOR ---------------------
// ======================================================

unsigned char state_emukty=0;     // state machine: 0=empty, 11=empty charging, 12=half charging, 13=full charging, 4=full
                                  //                         21=empty disch.  , 22=half disch.  , 23=full disch.
signed short  temp_emukty=250;
const signed short  del_emukty_11=20,  del_emukty_12=50,   del_emukty_13=5;
const signed short  del_emukty_21=200, del_emukty_22=500,  del_emukty_23=50;

// PB15 changed
void EXTI15_10_IRQHandler (void) {
  unsigned short load_emukty=0;
  int del=0;
  EXTI->PR |= (1 <<15);   // clear pending flag
  load_emukty = (GPIOB->IDR & 0x8000) >> 15;
  if (load_emukty) {        // PB15 is high, charging C
    switch (state_emukty) { 
      case  0:
      case 21:
      case 11: state_emukty=11; del=del_emukty_11;  break;
      case 12:
      case 22: state_emukty=12; del=del_emukty_12;  break;
      case 13:
      case 23: state_emukty=13; del=del_emukty_13;  break;
      case  4: state_emukty=13; del=del_emukty_13;  break;
      default: state_emukty=0;
    }
  } else {                // PB15 is low, discharging C
    switch (state_emukty) { 
      case  0:
      case 21:
      case 11: state_emukty=21; del=del_emukty_21;  break;
      case 12:
      case 22: state_emukty=22; del=del_emukty_22;  break;
      case 13:
      case 23: state_emukty=23; del=del_emukty_23;  break;
      case  4: state_emukty=23; del=del_emukty_23;  break;
      default: state_emukty=0;
    }
  }
  if (state_emukty) {
    TIM2->CNT  = 0;
    TIM2->ARR  = del;
    TIM2->CR1 |= 0x1;
  } else {
    TIM2->CR1 &= ~0x1; // stop      
    GPIOC->PUPDR = (GPIOC->PUPDR & 0xFFF0FFFF) | (0b1010 << 16);   // pulls down
  }
}

void TIM2_IRQHandler (void) {
  unsigned int pullmask=0, del=0;
  TIM2->CR1 &= ~0x1;  // stop
  TIM2->SR = 0x0000;  // Service-Request has to be cleared by SW!
  switch (state_emukty) { 
    case 11: state_emukty=12; pullmask=0b0110; del=del_emukty_12; break; // PC9 high, PC8 low
    case 12: state_emukty=13; pullmask=0b0101; del=del_emukty_13; break; // PC9 high, PC8 high
    case 13: state_emukty= 4; pullmask=0b0101; break; // PC9 high, PC8 high
    case  4: state_emukty=23; pullmask=0b0101; del=del_emukty_23; break; // must not occur!!! PC9 high, PC8 high
    case 23: state_emukty=22; pullmask=0b0110;    // PC9 high, PC8 low
                                               del = ((temp_emukty - 250)*79/100+1000)*114/100;  // linear approx. of RKTY
                                               break;
    case 22: state_emukty=21; pullmask=0b1010; del=del_emukty_21; break; // PC9 low, PC8 low
    case 21: state_emukty= 0; pullmask=0b1010; break; // PC9 low, PC8 low
    case 0:  // must not occur !!! 
    default: state_emukty=0;
  }
  GPIOC->PUPDR = (GPIOC->PUPDR & 0xFFF0FFFF) | (pullmask << 16);   // pulls  
  if (del) {
    TIM2->ARR  = del; // delay time
    TIM2->CR1 |= 0x1; // run
  }
}

// Initialisation of RKTY*C Emulator
// PB15 loads C, PC8 is upper threshold, PC9 is lower threshold
// fully charged C: PC8=1, PC9=1; half charged C: PC8=0, PC9=1; empty C: PC8=0, PC9=0
void Emulate_RKTYC (signed short invtemp){
  unsigned char static flag_init_emukty=0;
  
  if (flag_init_emukty) {
    
  } else {
    RCC->AHB1ENR |= 0x0006;   // Port B, C clock on
    GPIOB->ODR   &= 0x8000;   // PB15 off
    GPIOC->PUPDR = (GPIOC->PUPDR & 0xFFF0FFFF) | (0b1010 << 16);   // pulls down
    // configure PB15 as source for EXTI15 line
    EXTI->IMR |= (1 <<15);    // unmask interrupt line 15 (includes PB15)
    EXTI->EMR |= (1 <<15);    // unmask event line 15 
    EXTI->RTSR |= (1 <<15);    // rising edge selected
    EXTI->FTSR |= (1 <<15);    // falling edge selected 
    RCC->APB2ENR |= (1 <<14);         // switch on clock for system configutation controller
    SYSCFG->EXTICR[3] = 0x00001000;   // PB15 is source for EXTICR4 = EXI15
    NVIC_EnableIRQ(EXTI15_10_IRQn);   // TIM12_IRQn=43 in stm32f407xx.h
    flag_init_emukty = 1;

    RCC->APB1ENR   |= RCC_APB1ENR_TIM2EN; 								// Enable Clock for Timer 2 (Bit 0) 
    DBGMCU->APB1FZ |= DBGMCU_APB1_FZ_DBG_TIM2_STOP;				// Clock for Timer 2 stops if Core halts in Debug mode (Bit 0)
    TIM2->PSC = 83;                     // Prescaler, divides Timer 2 Clock by (PSC1+1) = 84 -> 1MHz Timer Tick
    TIM2->ARR = 999;                 		// ARR + 1 ticks for CNT to overflow and reset to 0 -> 	1MHz Timer Tick results in 1ms Period
    TIM2->CNT = 0x0000;                 // Counter, Timer 2 only upcouting
    TIM2->CR1 = 0x0004;                 // interrupt request only on overflow,
    TIM2->EGR = 0x0001;                 // Bit0=1:  
    TIM2->DIER = 0x0001;                 // Bit0=1:  Interrupt Request Enabled
    NVIC_EnableIRQ(TIM2_IRQn);          // Funktion in core_cm4.h beschrieben im Programming Manual 4.3.1, TIM2_IRQn=28 in stm32f4xx  
    temp_emukty=invtemp*10;
  }
};



// -------------- LCD-LEDS EMULATOR ---------------------
// ======================================================

#define HWADRESS_LEDS 0x60020000
#define HWADRMSK_LCD  0x60FF0000
#define HWADRESS_LCD_COMMAND 0x60000000
#define HWADRESS_LCD_DATA 0x60100000
unsigned char  qflag=0;  // last hw-access_data unvalid
unsigned char  time2printflag=0;  // 
unsigned int   hwaccess_adress, hwhfa;
unsigned short hwaccess_data, lcd_command=0, lcd_data=0, leds;
unsigned char  lcdmatrix[240][320], ledsarray[16];
unsigned int   xcursor, ycursor, invalid=0, busfaultcounter=0;


// whyever, otherwise printf is not redirected to debug ouput window
int fputc(int c, FILE *f) {
  return(ITM_SendChar(c));
}

__attribute__((always_inline)) void Interpret_LEDsLCD(unsigned int do_lcd) {
    unsigned short tmp;
    if (qflag) {
      if ( (hwaccess_adress & HWADRESS_LEDS) == HWADRESS_LEDS) { // LEDs
          leds = hwaccess_data;
      } else if (hwaccess_adress == HWADRESS_LCD_COMMAND) { // LCD command
          lcd_command = hwaccess_data;
      } else if ( (hwaccess_adress & HWADRMSK_LCD) == HWADRESS_LCD_DATA) {  // LCD data, using last LCD command to interpret
          lcd_data    = hwaccess_data;
          if (lcd_command == 0x4E) {
            xcursor = lcd_data;}
          if (lcd_command == 0x4F) {
            ycursor = lcd_data;}
          if (lcd_command == 0x22) {
            tmp = lcd_data;
            if (do_lcd) lcdmatrix[ycursor][xcursor] = 0x20+(unsigned char)((tmp&0x18)>>3)|((tmp&0x600)>>7)|((tmp&0xC000)>>10);
            xcursor++;
          }
        if (xcursor>=320) {xcursor=0; ycursor++;}
        if (ycursor>=240) ycursor=0;
      } else {  // invalid adress ?
          invalid++;
      }
      qflag = 0;
    }  
}

void _waitemu_(unsigned int us) {
  volatile unsigned int i;
  for (i=0; i<us; i++) {}
}

// emulation of LCD and LEDs by catching writes to hw-adresses causing memory protectdion fault
void Emulate_LEDsLCD (unsigned int rows, unsigned int cols) {
	unsigned char static flag_init=0, LEDcolor[4]={'R', 'Y', 'G', 'B'}; 
  int i, j;  
  unsigned int static lcols, lrows, rowstart=0, rowend=ROWMAXPP;
    
  // print writes from catched hw-accesses
  if (flag_init) { 	
    MPU->CTRL  =  0; // MPU is active only for one polling loop pass after completed print
    if (time2printflag) {
      if (PRINTPERIODms) time2printflag = 0;  // no time slicing for simulation
      // catch last data from fault
      Interpret_LEDsLCD(rows);
      if ((rowstart==0) && (cols)) {  // rows==0: only LEDs if cols>0
        printf("%c[%i;%if", 27, 0, 0);
        // Display LEDs in Debug (printf) viewer (terminal mode required)
        printf("\n"); _waitemu_(WAITUS);printf("\n"); _waitemu_(WAITUS);
        printf("16LEDS Bit 15 ... 0, Nibbles\n");
        for (i=15; i>=0; i--) {
           if (leds & (1<<i)) ledsarray[i]=LEDcolor[i/4]; else ledsarray[i]='.';
           printf("%c", ledsarray[i]); _waitemu_(WAITUS);
           if (i%4 == 0) printf(" "); _waitemu_(WAITUS);
        }  printf("\n\n"); _waitemu_(WAITUS);
        if (rows) {
          lcols = (((cols-1)%320)/10 + 1)*10; lrows = (((rows-1)%240)/10 + 1)*10;
          printf("LCD: 1 character corresponds to 1 pixel, character = color, ' ' = black\n|");
          for (i=0; i<cols/10; i++) {
             printf("---------|"); _waitemu_(WAITUS);
          }  
          printf("\n"); _waitemu_(WAITUS);
        } else {
          lrows = 0;
        }
      }
      // Display LCD in Debug (printf) viewer (terminal mode required)
      if (lrows) {
//        cols = ((cols%320)/10)*10; rows = ((rows%240)/10)*10;
//        printf("LCD: 1 character corresponds to 1 pixel, character = color, ' ' = black\n|");
//        for (i=0; i<cols/10; i++) {
//           printf("---------|");_waitemu_(WAITUS);
//        }  printf("\n");_waitemu_(WAITUS);
        if (lrows <= rowend) rowend=lrows;
        for (j=rowstart; j<rowend; j++) {
           if ((j+1)%10) printf("|"); else printf("-"); _waitemu_(WAITUS);
           for (i=0; i<lcols; i++) {
              printf("%c", lcdmatrix[j][i]); _waitemu_(WAITUS);
           }  
           printf("\n"); _waitemu_(WAITUS);
         }
         if (rowend==lrows) {
            rowstart = 0; rowend = ROWMAXPP;
            MPU->CTRL  =  MPU_CTRL_PRIVDEFENA_Msk | MPU_CTRL_ENABLE_Msk;
         } else {
            rowstart = rowend; rowend = rowend + ROWMAXPP; 
         }
      } else {
            MPU->CTRL  =  MPU_CTRL_PRIVDEFENA_Msk | MPU_CTRL_ENABLE_Msk;
      }
     } 
  // first call: init emulation    
  } else {					
    mcpr_ConfigSystemTick();  // Systick timer is required for print-Period
			
      //	NVIC_EnableIRQ (BusFault_IRQn);
      //	NVIC_SetPriority (BusFault_IRQn, 0x08);
    SCB->SHCSR |= (1<< 17);		// Bus Fault enabled
    SCB->SHCSR |= (1<< 16);		// Memory Management Fault enabled
	
    // Config Memory Protection Unit
    // =============================
    // Region 0: define protected region = region no. 0
    // ------------------------------------------------
    MPU->RNR  = 0;		// region number
    // set base adress of region, set valid, select region
    MPU->RBAR = 0x60000000 | MPU_RBAR_VALID_Msk | 0x0;
    // Size and Type,   enable             2^21 Bytes   SRAM 111     0: all access protected, 7: read only
    //                  Bit 0           |  Bits 5:1 | Bits SCB 18:16 |  AP  26:24   //  | Tex 19:21
    MPU->RASR =     MPU_RASR_ENABLE_Msk | (20 << 1) |  ( 7 << 16)    | (0 << 24);   // | (0x6 <<19);

//    // Region 1: define protected region = region no. 1
//    // ------------------------------------------------
//    MPU->RNR  = 1;		// region number
//    // set base adress of region, set valid, select region 
//    MPU->RBAR = 0x60100000 | MPU_RBAR_VALID_Msk | 0x1;
//    // Size and Type,   enable             2^19 Bytes   SRAM 111     0: all access protected, 7: read only
//    //                  Bit 0           |  Bits 5:1 | Bits SCB 18:16 |  AP  26:24
//    MPU->RASR =     MPU_RASR_ENABLE_Msk | (18 << 1) |  ( 7 << 16)    | (0 << 24); 
    //
    // activate MPU
    // ------------
    // 					Bit 2, Enable Default Region    Bit 0, enable MPU
    MPU->CTRL  =  MPU_CTRL_PRIVDEFENA_Msk | MPU_CTRL_ENABLE_Msk;
  
    // clear emulated display RAM  
      for (i=0; i<320; i++){
        for (j=0; j<239; j++) {
          lcdmatrix[j][i] = ' ';
      }}       
      xcursor = 0; ycursor=0;
      for (i=0; i<16; i++) {ledsarray[i]=0;}
      flag_init = 1;
  }	// end if else
	
  
} // end Emulate_LEDsLCD


// Catches accesses to HW-adresses of LEDs and LCDs
void MemManage_Handler(void) {
//void HardFault_Handler(void) {
  unsigned int volatile stat;
  unsigned int * stackp, i=0;

  // locate stack  
  unsigned int spReg, lrReg, pcReg;
    __asm {
      MOV spReg, __current_sp()
      MOV pcReg, __current_pc()
      MOV lrReg, __return_address()
    }

  // emulate LCD-commands    
  Interpret_LEDsLCD(1);

  // save fault adress  
  stat = SCB->CFSR;
  hwaccess_adress  = SCB->MMFAR;     // Memory Manage Fault Adress Register (name datasheed: MMAR
	*(unsigned char *) &(SCB->CFSR) = 0xff;
  SCB->CFSR &= ~SCB_CFSR_MMARVALID_Msk;
  SCB->CFSR &= ~SCB_CFSR_DACCVIOL_Msk;
//	*(unsigned char *) &(SCB->CFSR) = 0;

  // locate fault adress in stack (typ. +6*4 above lower end, (top stack adress is decreased by push)  
  i   = 0;
  stackp = ((unsigned int*) spReg);
  while ( (*stackp != hwaccess_adress) && (i<12) ) {
      stackp++;
      i++;
  }
  // redirect next write to RAM variable to catch data  
  if (i<12) { 
     *stackp =  (unsigned int)&hwaccess_data;
     qflag = 1;   // valid data in hwaccess_data at next entry
  } else {  // wrong fault 
     qflag = 0;
     invalid++;
  }
  
  // The pc, lr, and sp registers cannot be explicitly read or modified using inline assembly code 
  //  because there is no direct access to any physical registers. 
  // However, you can use the intrinsics __current_pc, __current_sp, and __return_address to read these registers.
  
}

//void HardFault_Handler(void) {
////void BusFault_Handler(void) {
////    busfaultcounter++;
//  hwhfa = 0x08000000;
//	*(unsigned char *) &(SCB->CFSR) = 0xff;
//}



/*----------------------------------------------------------------------------
  SysTick_Handler
 *----------------------------------------------------------------------------*/
void SysTick_Handler(void) {
	int static is=0;
	if (is) {
		is--;
	} else {
		is = PRINTPERIODms;
    time2printflag = 1;
//		LED_Toggle(1);
	}
}

#else

void Emulate_RKTYC (signed short invtemp){};
void Emulate_LEDsLCD (unsigned int rows, unsigned int cols) {}

void SysTick_Handler(void) {
	int static is=0;
	if (is) {
		is--;
	} else {
//		LED_Toggle(1);
	}
}

#endif  // end use of emulator for LCD and LEDS


/* From original system_stm32f4xx.c                                           
  ******************************************************************************
  ******************************************************************************
  ******************************************************************************
  ******************************************************************************
*/

/**
  ******************************************************************************
  * @file    system_stm32f4xx.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    30-September-2011
  * @brief   CMSIS Cortex-M4 Device Peripheral Access Layer System Source File.
  *          This file contains the system clock configuration for STM32F4xx devices,
  *          and is generated by the clock configuration tool
  *          stm32f4xx_Clock_Configuration_V1.0.0.xls
  *             
  * 1.  This file provides two functions and one global variable to be called from 
  *     user application:
  *      - SystemInit(): Setups the system clock (System clock source, PLL Multiplier
  *                      and Divider factors, AHB/APBx prescalers and Flash settings),
  *                      depending on the configuration made in the clock xls tool. 
  *                      This function is called at startup just after reset and 
  *                      before branch to main program. This call is made inside
  *                      the "startup_stm32f4xx.s" file.
  *
  *      - SystemCoreClock variable: Contains the core clock (HCLK), it can be used
  *                                  by the user application to setup the SysTick 
  *                                  timer or configure other parameters.
  *                                     
  *      - SystemCoreClockUpdate(): Updates the variable SystemCoreClock and must
  *                                 be called whenever the core clock is changed
  *                                 during program execution.
  *
  * 2. After each device reset the HSI (16 MHz) is used as system clock source.
  *    Then SystemInit() function is called, in "startup_stm32f4xx.s" file, to
  *    configure the system clock before to branch to main program.
  *
  * 3. If the system clock source selected by user fails to startup, the SystemInit()
  *    function will do nothing and HSI still used as system clock source. User can 
  *    add some code to deal with this issue inside the SetSysClock() function.
  *
  * 4. The default value of HSE crystal is set to 8 MHz, refer to "HSE_VALUE" define
  *    in "stm32f4xx.h" file. When HSE is used as system clock source, directly or
  *    through PLL, and you are using different crystal you have to adapt the HSE
  *    value to your own configuration.
  *
  * 5. This file configures the system clock as follows:
  *=============================================================================
  *=============================================================================
  *        Supported STM32F4xx device revision    | Rev A
  *-----------------------------------------------------------------------------
  *        System Clock source                    | PLL (HSE)
  *-----------------------------------------------------------------------------
  *        SYSCLK(Hz)                             | 168000000
  *-----------------------------------------------------------------------------
  *        HCLK(Hz)                               | 168000000
  *-----------------------------------------------------------------------------
  *        AHB Prescaler                          | 1
  *-----------------------------------------------------------------------------
  *        APB1 Prescaler                         | 4
  *-----------------------------------------------------------------------------
  *        APB2 Prescaler                         | 2
  *-----------------------------------------------------------------------------
  *        HSE Frequency(Hz)                      | 8000000
  *-----------------------------------------------------------------------------
  *        PLL_M                                  | 8
  *-----------------------------------------------------------------------------
  *        PLL_N                                  | 336
  *-----------------------------------------------------------------------------
  *        PLL_P                                  | 2
  *-----------------------------------------------------------------------------
  *        PLL_Q                                  | 7
  *-----------------------------------------------------------------------------
  *        PLLI2S_N                               | NA
  *-----------------------------------------------------------------------------
  *        PLLI2S_R                               | NA
  *-----------------------------------------------------------------------------
  *        I2S input clock                        | NA
  *-----------------------------------------------------------------------------
  *        VDD(V)                                 | 3.3
  *-----------------------------------------------------------------------------
  *        Main regulator output voltage          | Scale1 mode
  *-----------------------------------------------------------------------------
  *        Flash Latency(WS)                      | 5
  *-----------------------------------------------------------------------------
  *        Prefetch Buffer                        | OFF
  *-----------------------------------------------------------------------------
  *        Instruction cache                      | ON
  *-----------------------------------------------------------------------------
  *        Data cache                             | ON
  *-----------------------------------------------------------------------------
  *        Require 48MHz for USB OTG FS,          | Enabled
  *        SDIO and RNG clock                     |
  *-----------------------------------------------------------------------------
  *=============================================================================
  ****************************************************************************** 
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */

/** @addtogroup CMSIS
  * @{
  */

/** @addtogroup stm32f4xx_system
  * @{
  */  
  
/** @addtogroup STM32F4xx_System_Private_Includes
  * @{
  */

// #include "stm32f4xx.h"

/**
  * @}
  */

/** @addtogroup STM32F4xx_System_Private_TypesDefinitions
  * @{
  */

/**
  * @}
  */

/** @addtogroup STM32F4xx_System_Private_Defines
  * @{
  */


/************************* PLL Parameters *************************************/
/* PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N */
#define mcpr_PLL_M      8
#define mcpr_PLL_N      336

/* SYSCLK = PLL_VCO / PLL_P */
#define mcpr_PLL_P      2

/* USB OTG FS, SDIO and RNG Clock =  PLL_VCO / PLLQ */
#define mcpr_PLL_Q      7

/******************************************************************************/

/******************************************************************************/
#if !defined  (mcpr_HSE_STARTUP_TIMEOUT) 
  #define mcpr_HSE_STARTUP_TIMEOUT    ((uint16_t)0x0600)   /*!< Time out for HSE start up */
#endif /* HSE_STARTUP_TIMEOUT */   

/******************************************************************************/
/**
  * @}
  */





/** @addtogroup STM32F4xx_System_Private_Functions
  * @{
  */


/**
   * @brief  Update SystemCoreClock variable according to Clock Register Values.
  *         The SystemCoreClock variable contains the core clock (HCLK), it can
  *         be used by the user application to setup the SysTick timer or configure
  *         other parameters.
  *           
  * @note   Each time the core clock (HCLK) changes, this function must be called
  *         to update SystemCoreClock variable value. Otherwise, any configuration
  *         based on this variable will be incorrect.         
  *     
  * @note   - The system frequency computed by this function is not the real 
  *           frequency in the chip. It is calculated based on the predefined 
  *           constant and the selected clock source:
  *             
  *           - If SYSCLK source is HSI, SystemCoreClock will contain the HSI_VALUE(*)
  *                                              
  *           - If SYSCLK source is HSE, SystemCoreClock will contain the HSE_VALUE(**)
  *                          
  *           - If SYSCLK source is PLL, SystemCoreClock will contain the HSE_VALUE(**) 
  *             or HSI_VALUE(*) multiplied/divided by the PLL factors.
  *         
  *         (*) HSI_VALUE is a constant defined in stm32f4xx.h file (default value
  *             16 MHz) but the real value may vary depending on the variations
  *             in voltage and temperature.   
  *    
  *         (**) HSE_VALUE is a constant defined in stm32f4xx.h file (default value
  *              25 MHz), user has to ensure that HSE_VALUE is same as the real
  *              frequency of the crystal used. Otherwise, this function may
  *              have wrong result.
  *                
  *         - The result of this function could be not correct when using fractional
  *           value for HSE crystal.
  *     
  * @param  None
  * @retval None
  */


/**
  * @brief  Configures the System clock source, PLL Multiplier and Divider factors, 
  *         AHB/APBx prescalers and Flash settings
  * @Note   This function should be called only once the RCC clock configuration  
  *         is reset to the default reset state (done in SystemInit() function).   
  * @param  None
  * @retval None
  */
static void mcpr_SetSysClock(void)
{
/******************************************************************************/
/*            PLL (clocked by HSE) used as System clock source                */
/******************************************************************************/
  __IO uint32_t StartUpCounter = 0, HSEStatus = 0;

  SystemCoreClock = 168000000;				// defined in system_stm32f4xx.c
  
  /* Enable HSE */
  RCC->CR |= ((uint32_t)RCC_CR_HSEON);
 
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
    HSEStatus = RCC->CR & RCC_CR_HSERDY;
    StartUpCounter++;
  } while((HSEStatus == 0) && (StartUpCounter != mcpr_HSE_STARTUP_TIMEOUT));

  if ((RCC->CR & RCC_CR_HSERDY) != RESET)
  {
    HSEStatus = (uint32_t)0x01;
  }
  else
  {
    HSEStatus = (uint32_t)0x00;
  }

  if (HSEStatus == (uint32_t)0x01)
  {
    /* Select regulator voltage output Scale 1 mode, System frequency up to 168 MHz */
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
    PWR->CR |= PWR_CR_VOS;

    /* HCLK = SYSCLK / 1*/
    RCC->CFGR |= RCC_CFGR_HPRE_DIV1;
      
    /* PCLK2 = HCLK / 2*/
    RCC->CFGR |= RCC_CFGR_PPRE2_DIV2;
    
    /* PCLK1 = HCLK / 4*/
    RCC->CFGR |= RCC_CFGR_PPRE1_DIV4;

    /* Configure the main PLL */
    RCC->PLLCFGR = mcpr_PLL_M | (mcpr_PLL_N << 6) | (((mcpr_PLL_P >> 1) -1) << 16) |
                   (RCC_PLLCFGR_PLLSRC_HSE) | (mcpr_PLL_Q << 24);

    /* Enable the main PLL */
    RCC->CR |= RCC_CR_PLLON;

    /* Wait till the main PLL is ready */
    while((RCC->CR & RCC_CR_PLLRDY) == 0)
    {
    }
   
    /* Configure Flash prefetch, Instruction cache, Data cache and wait state */
    FLASH->ACR = FLASH_ACR_ICEN |FLASH_ACR_DCEN |FLASH_ACR_LATENCY_5WS;

    /* Select the main PLL as system clock source */
    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
    RCC->CFGR |= RCC_CFGR_SW_PLL;

    /* Wait till the main PLL is used as system clock source */
    while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS ) != RCC_CFGR_SWS_PLL);
    {
    }
  }
  else
  { /* If HSE fails to start-up, the application will have wrong clock
         configuration. User can add here some code to deal with this error */
  }

}





/**
  * @brief  Setup the external memory controller.
  *         Called in startup_stm32f4xx.s before jump to main.
  *         This function configures the external memories (SRAM/SDRAM)
  *         This SRAM/SDRAM will be used as program data memory (including heap and stack).
  * @param  None
  * @retval None
  */
void SystemInit_ExtMemCtl(void)
{

#if defined(USE_FSMC)

	
  __IO uint32_t tmp = 0x00;

#if defined(STM32F405xx) || defined(STM32F415xx) || defined(STM32F407xx) || defined(STM32F417xx)\
 || defined(STM32F427xx) || defined(STM32F437xx) || defined(STM32F429xx) || defined(STM32F439xx)\
 || defined(STM32F469xx) || defined(STM32F479xx) || defined(STM32F412Zx) || defined(STM32F412Vx)

	
/*-- LCD, LEDs address decoding on lab evaluation board */ 
	// 0 1 significant, o unused
	// byte-address LCD: 31-   27-     23- 20    19- 17	 16   15-
	// byte-address LCD: 0110  00  oo  ooo 0/1   oo  0/1  o   oooo oooo oooo oooo
	//                   FMSC  NE1         C/D     LCD/LEDs
	// notice: address signals in following are named as halfword (2byte) signals
	//         e.g. A19 halfword address signal corresponds to bit 20 of byte-address

/*-- GPIOs Configuration -----------------------------------------------------*/
/* Enable GPIOD, GPIOE, GPIOF and GPIOG interface clock */
	// STM32F407: nur GPIOD, GPIOE
	//    NE1=PD7, A16=PD11 (0=LCD, 1=LEDs), A19=PE3 (0=Command, 1=Data),  NOE=PD4, NWE=PD5, 
	//    D0-1=PD14-15, D2-3=PD0-1, D4-12=PE7-15, D13-15=PD8-10
  RCC->AHB1ENR   |= 0x00000018;
  /* Delay after an RCC peripheral clock enabling */
  tmp = READ_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIODEN);

  /* GPIOD Configuration */
	// PD 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
	//    D1  D0  -   -   A16 D15 D14 D13 NE1  -  NWE NOE  -   -  D3  D2
	//
  /* Connect PDx pins to FMC Alternate function, AF12=FSMC */
  GPIOD->AFR[0]  = 0xC0CC00CC;
  GPIOD->AFR[1]  = 0xCC00CCCC;
	/* Configure PDx pins in Alternate function mode, AF=10, Input=00*/  
	GPIOD->MODER   = 0xA0AA8A0A;
  /* Modified Ga: keep reset-configuration (00= min. speed) to avoid EMI!, Configure PEx pins speed to 100 MHz, 11=max. speed */ 
	//  GPIOD->OSPEEDR = 0xF0FFCF0F;
  /* Configure PDx pins Output type to push-pull, 0=push-pull */  
  GPIOD->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PDx pins, 00=no */ 
  GPIOD->PUPDR   = 0x00000000;
	
  /* GPIOE Configuration */
	// PE 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
	//    D12 D11 D10 D9  D8  D7  D6  D5  D4   -   -   - A19   -   -   -
	//
  /* Connect PEx pins to FMC Alternate function, AF12=FSMC  */
  GPIOE->AFR[0]  = 0xC000C000;
  GPIOE->AFR[1]  = 0xCCCCCCCC;
  /* Configure PEx pins in Alternate function mode, AF=10, Input=00 */ 
  GPIOE->MODER   = 0xAAAA8080;
  /* Modified Ga: keep reset-configuration (00= min. speed) to avoid EMI!, Configure PEx pins speed to 100 MHz, 11=max. speed */ 
	//  GPIOE->OSPEEDR = 0xFFFFC0C0;
  /* Configure PEx pins Output type to push-pull */  
  GPIOE->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PEx pins */ 
  GPIOE->PUPDR   = 0x00000000;
  
/*-- FMC/FSMC Configuration --------------------------------------------------*/
/* Enable the FMC/FSMC interface clock, AHB3ENR.Bit0=1 enables FSMC */
  RCC->AHB3ENR         |= 0x00000001;


#if defined(STM32F405xx) || defined(STM32F415xx) || defined(STM32F407xx)|| defined(STM32F417xx)\
   || defined(STM32F412Zx) || defined(STM32F412Vx)
  /* Delay after an RCC peripheral clock enabling */
  tmp = READ_BIT(RCC->AHB3ENR, RCC_AHB3ENR_FSMCEN);
/* Configure FSMC */
/*   only NE1 is used -> FSMC_BCR1, FSMC_BTR1, ... have to be configured */
// (register naming does not match datasheet, in particalar "Bank1")
// Register structure datasheet  <-> stm32f407xx.h
// FSMC_Bank1->BTCR[0]  <-> FSMC_BCR1 chip-select control register Bank1
// FSMC_Bank1->BTCR[1]  <-> FSMC_BTR1 chip-select timing register Bank1
// FSMC_Bank1->BTCR[2]  <-> FSMC_BCR2
// FSMC_Bank1->BTCR[3]  <-> FSMC_BTR2
// ...                      ........4
// 
// FSMC_BCR1  Bits 
//   31-20 19 18-16 15 14 13 12  11 10  9  8   7  6  5-4   3-2  1  0
//     0  | 0  000 | 0  0  0  1 | 0  0  0  0 | 1  0   01 |  00  0  1    = 0x00001091
//     |    |   |    |  |  |  |   |  |  |  |   |  |    |     |  |  |										 
//     |    |   |    |  |  |  |   |  |  |  |   |  |    |     |  |  +-> MBKEN     0/1 Bank disabled / enabled
//     |    |   |    |  |  |  |   |  |  |  |   |  |    |     |  +----> MUXEN     0/1 non-multiplexed / multiplexed A/D-bus
//     |    |   |    |  |  |  |   |  |  |  |   |  |    |     +-------> MTYP      00=SRAM, 01=NOR-Flash										 
//     |    |   |    |  |  |  |   |  |  |  |   |  |    +-------------> MWID      00=8bit D-bus, 01=16bit D-bus
//     |    |   |    |  |  |  |   |  |  |  |   |  +------------------> FACCEN    0/1 NOR-Flash access disabled/enabled
//     |    |   |    |  |  |  |   |  |  |  |   +---------------------> reserved  (reset state = 1 ?)
//     |    |   |    |  |  |  |   |  |  |  +-------------------------> BURSTEN   0/1 disable/enable burst mode (only in sync-mode)
//     |    |   |    |  |  |  |   |  |  +----------------------------- WAITPOL   0/1 active low/high NWAIT-polarity
//     |    |   |    |  |  |  |   |  +-------------------------------> WRAPMOD   0/1 wrapped
//     |    |   |    |  |  |  |   +----------------------------------- WAITCFG   0/1 wait timing one before/during (sync. mode, only if Wait enabled) 
//     |    |   |    |  |  |  +--------------------------------------> WREN      0/1 Write disable/enable
//     |    |   |    |  |  +-----------------------------------------> WAITEN    0/1 Wait (signal) disable/enable, sync. mode
//     |    |   |    |  +--------------------------------------------> EXTMOD    0/1 disable/enable ext. write timing for async (BWTR-Reg.), 0: only mode 1 for SRAM
//     |    |   |    +-----------------------------------------------> ASCYCWAIT 0/1 Wait (signal) disable/enable, async. mode    
//     |    |   +----------------------------------------------------> reserved  (reset state = 000) 
//	   |    +--------------------------------------------------------> CBURSTRW  0/1 disable/enable write burst (for sync. mode), 0: write always in async. mode
//     +--- reserved, 0

	FSMC_Bank1->BTCR[0]  = 0x00001091;	// SRAM, async. mode, wait-signal disabled, mode 1 = NEW toggles, NOE=Low during whole read cycle!

// FSMC_BTR1  
//   Bits 31-30 29-28 27-24  23-20  19-16   15-8   7-4    3-0
//         00    00  | 0000 | 0000 | 0001 | 1111 | 0000 | 1111   = 0x00001F0F
//          |     |      |      |      |      |      |      |
//          |     |      |      |      |      |      |      +-> ADDSET  X*HCLK cycles address set up (=delay of NWE=LOW)
//          |     |      |      |      |      |      +--------- ADDHLD  (used in D-mode and multiplexed modes, needs EXTMOD=1), 0000=reserved?
//          |     |      |      |      |      +---------------> DATAST  data access time (X+1)*HCLK for write access
//          |     |      |      |      +----------------------> BUSTURN X*HCKL delay added between consecutive access (= min. NEx=HIGH ?)
//          |     |      |      +------------------------------ CLKDIV  (sync. mode, divider for CLK output signal)
//          |     |      +------------------------------------- DATLAT  (sync. NOR-Flash, data latency)
//          |     +-------------------------------------------- ACCMOD  (only if EXTMOD=1 in BCR-register, selects mode A...D)
//          +--- reserved, 0


  FSMC_Bank1->BTCR[1]  = 0x00040808;		// optimum: 0x00020606;  // default used:  0x00040808
	//  req. LCD: tcycle (CS 1-0 edges): min 77ns (> 13 HCLK @ 168MHz)


#endif /* STM32F405xx || STM32F415xx || STM32F407xx || STM32F417xx || STM32F412Zx || STM32F412Vx */

#endif /* STM32F405xx || STM32F415xx || STM32F407xx || STM32F417xx || STM32F427xx || STM32F437xx ||\
          STM32F429xx || STM32F439xx || STM32F469xx || STM32F479xx || STM32F412Zx || STM32F412Vx  */ 
  (void)(tmp); 


#elif defined(NO_FSMC)
     // keine Initialisierung notwendig
#else
	#error Definition of FSMC macro is missing 
#endif 	// USE_/NO_FSMC


}






// now in ..\RTE\Device\STM32F407VGTx\system_stm32f4xx.c per CMSIS / Device-Config.
//void SystemCoreClockUpdate(void)
//{
//  uint32_t tmp = 0, pllvco = 0, pllp = 2, pllsource = 0, pllm = 2;
//  
//  /* Get SYSCLK source -------------------------------------------------------*/
//  tmp = RCC->CFGR & RCC_CFGR_SWS;

//  switch (tmp)
//  {
//    case 0x00:  /* HSI used as system clock source */
//      SystemCoreClock = HSI_VALUE;
//      break;
//    case 0x04:  /* HSE used as system clock source */
//      SystemCoreClock = HSE_VALUE;
//      break;
//    case 0x08:  /* PLL used as system clock source */

//      /* PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N
//         SYSCLK = PLL_VCO / PLL_P
//         */    
//      pllsource = (RCC->PLLCFGR & RCC_PLLCFGR_PLLSRC) >> 22;
//      pllm = RCC->PLLCFGR & RCC_PLLCFGR_PLLM;
//      
//      if (pllsource != 0)
//      {
//        /* HSE used as PLL clock source */
//        pllvco = (HSE_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);
//      }
//      else
//      {
//        /* HSI used as PLL clock source */
//        pllvco = (HSI_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);      
//      }

//      pllp = (((RCC->PLLCFGR & RCC_PLLCFGR_PLLP) >>16) + 1 ) *2;
//      SystemCoreClock = pllvco/pllp;
//      break;
//    default:
//      SystemCoreClock = HSI_VALUE;
//      break;
//  }
//  /* Compute HCLK frequency --------------------------------------------------*/
//  /* Get HCLK prescaler */
//  tmp = AHBPrescTable[((RCC->CFGR & RCC_CFGR_HPRE) >> 4)];
//  /* HCLK frequency */
//  SystemCoreClock >>= tmp;
//}

/**
  * @}
  */

/**
  * @}
  */
  
/**
  * @}
  */    
	
	
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

#ifndef __MAIN_H
#define __MAIN_H

#ifndef _MAIN_GLOBAL
#define MAIN_EXT	extern
#else
#define MAIN_EXT
#endif



/* LED on STM8S EVALBOARD */
#define LED_GPIO_PINS  (GPIO_PIN_3)
#define LED_PORT			 (GPIOC)
#define LED1					 (GPIO_PIN_3)
#define LED2					 (GPIO_PIN_4)
#define LED3					 (GPIO_PIN_5)
#define LED4					 (GPIO_PIN_2)
#define LED5					 (GPIO_PIN_1)

#define KEY_PORT			 (GPIOB)
#define KEY1					 (GPIO_PIN_0)
#define KEY2					 (GPIO_PIN_1)

MAIN_EXT int gusture;


/*
*  System time variable
*/
MAIN_EXT u16 systime_count[4];
MAIN_EXT union  FLAG 		Flag1_;
#define Flag1 					Flag1_._flag_byte;
#define f_500us					Flag1_._flag_bit.bit0
#define f_2ms						Flag1_._flag_bit.bit1
#define f_100ms					Flag1_._flag_bit.bit2
#define f_300ms					Flag1_._flag_bit.bit3
#define f_1s						Flag1_._flag_bit.bit4
#define extisr_flag			Flag1_._flag_bit.bit5
#define device_info_sended	Flag1_._flag_bit.bit6

MAIN_EXT void Task_500us(void);
MAIN_EXT void Task_2ms(void);
MAIN_EXT void Task_100ms(void);
MAIN_EXT void Task_300ms(void);
MAIN_EXT void Task_1s(void);
MAIN_EXT void delay(u16 Count);


MAIN_EXT void LED_Init(u8 LedNum);
MAIN_EXT void LED_On(u8 LedNum);
MAIN_EXT void LED_Off(u8 LedNum);
MAIN_EXT void LED_Toggle(u8 LedNum);
MAIN_EXT void KEY_Init(u8 KeyNum);
MAIN_EXT bool KEY_Read(u8 KeyNum);

MAIN_EXT void Variable_Init(void);
@interrupt void PORTB_EXT_ISR(void);
@interrupt void PORTD_EXT_ISR(void);
MAIN_EXT void handleGesture(void);
MAIN_EXT void GestureTest(void);
MAIN_EXT void LightTest(void);

#endif
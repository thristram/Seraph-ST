/**
  ******************************************************************************
  * @file    timer.c
  * @author  Seraph
  * @version  V1.0
  * @date     2017-03
  * @brief   This file contains the main function for STM8S003F3 timer operation.
**/

#define  _TIMER_GLOBAL

#include "stm8s_map.h"
#include "stm8s_conf.h"
#include "main.h"
#include "uart.h"
#include "stm8s_exti.h"
#include "timer.h"
#include "stm8s_tim2.h"




/*----------------------------------------------------------------------------
	定时10ms
-----------------------------------------------------------------------------*/
void timer2_init(void)
{    
	TIM2_TimeBaseInit(TIM2_PRESCALER_64, 2500);
	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	
	TIM2_Cmd(ENABLE);	
	
}

/*----------------------------------------------------------------------------
	Timer2_ISR 10ms
-----------------------------------------------------------------------------*/
@far @interrupt void timer2_ISR(void) 
{
	static u8	cnt_1s = 0;
	static u8	cnt_100ms = 0;


	/* 清除标志 */
	TIM2->SR1 = 0;

	cnt_100ms++;
	cnt_1s++;

	if(cnt_100ms >= 10){			/* 100ms */
		cnt_100ms = 0;
		f_100ms = 1;
	}

	if(cnt_1s >= 100){			/* 1s */
		cnt_1s = 0;
		f_1s = 1;
	}

}












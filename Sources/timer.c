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
#include "main.h"
#include "timer.h"


/**
  * @brief  initializion for time3
  * @param  None.
  * @retval None
  */
void Init_Time3(void)
{

	TIM3->PSCR = 0x06;//分频值 16M/2^6 = 250K
	TIM3->IER = 0x01;//使能触发中断
	TIM3->CNTRH = 0;
	TIM3->CNTRL = 250;//250*(1/250K) = 0.001s
	TIM3->CNTRH = 0;
	TIM3->CNTRL = 250;//自动重装的值
	
}

@interrupt void Tim3_UPD_OVF_BRK_ISR(void)
{
	TIM3->SR1 = 0x00;//清除中断标志
	f_1ms = 1;
	Sys_Time_Manage();
	
}



/**
  * @brief  System time manage,set all the time flag used
  * @param  None.
  * @retval None
  */
void Sys_Time_Manage(void)
{
	systime_count[0]++;
	if (systime_count[0] >= 100)
	{
		systime_count[0] = 0;
		f_100ms = 1;
	}
	systime_count[1]++;
	if (systime_count[1] >= 300)
	{
		systime_count[1] = 0;
		f_300ms = 1;
	}
	systime_count[2]++;
	if (systime_count[2] >= 1000)
	{
		systime_count[2] = 0;
		f_1s = 1;
	}
}
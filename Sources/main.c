/**
  ******************************************************************************
  * @file STM8_main.c
  * @brief RC Touch Sensing Library for STM8 CPU family.
  * Application example.
  * @author STMicroelectronics - MCD Application Team
  * @version V1.2.0
  * @date 24-MAR-2009
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */
#define _MAIN_GLOBAL
#include "STM8_TSL_RC_API.h"
#include "stm8s_conf.h"
#include "main.h"
#include "uart.h"
#include "stm8s_exti.h"
#include "i2c_master_poll.h"
#include "SparkFun_APDS9960.h"

volatile u8 isr_flag;
volatile u8 gest_cnt;
// Constants
#define LIGHT_INT_HIGH  1000 // High light level for interrupt
#define LIGHT_INT_LOW   10   // Low light level for interrupt



_Bool in_range;
_Bool p_valid;
char *ptr;

//--------    SECTION DEFINITION FOR THIS FILE   --------------
#if defined(__CSMC__) && defined(USE_PRAGMA_SECTION)
#pragma section [CONFIG_RAM]
#pragma section @tiny [CONFIG_RAM0]
#pragma section (CONFIG_CODE)
#pragma section const {CONFIG_CONST}
#endif

void ExtraCode_Init(void);
void ExtraCode_StateMachine(void);


void Variable_Init(void)
{
	st1.st_device_status = 0xFF;
	st1.st_pad1_status = 0x00;
	st1.st_pad2_status = 0x00;
	st1.st_pad3_status = 0x00;
	st1.st_ges1_ctrl_H = 0x11;//初始化为无效手势
	st1.st_ges1_ctrl_L = 0x11;
	st1.st_ges2_ctrl_H = 0x11;
	st1.st_ges2_ctrl_L = 0x11;
	st1.st_ges3_ctrl_H = 0x11;
	st1.st_ges3_ctrl_L = 0x11;
	st1.st_ges4_ctrl_H = 0x11;
	st1.st_ges4_ctrl_L = 0x11;
}


/**
  ******************************************************************************
  * @brief PB2外部中断初始化，下降沿触发
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
	/*
void PortBInt_Init(void)
{
	disableInterrupts();
	EXTI_DeInit();
	GPIO_Init(GPIOB,GPIO_PIN_2,GPIO_MODE_IN_PU_IT);//上拉输入with interrupt
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD,EXTI_SENSITIVITY_FALL_LOW);//下降沿触发
	//enableInterrupts();
}*/
/**
  ******************************************************************************
  * @brief PB2外部中断服务函数
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
	/*
@interrupt void PORTB_EXT_ISR(void)
{
	disableInterrupts();//关中断
	extisr_flag = 1;
	LED_Toggle(LED5);
	enableInterrupts();
}
*/
void EXTI_Config(void)
{
	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_IN_PU_IT );
	EXTI_DeInit();
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);//下降沿触发中断
	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOD),EXTI_SENSITIVITY_FALL_ONLY);
}

@interrupt void PORTD_EXT_ISR(void)
{
	disableInterrupts();//关中断
	isr_flag = 1;
	enableInterrupts();
}
/**
  ******************************************************************************
  * @brief Main function.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void main(void)
{

/* Only if _stext routine is not used */
/*
#asm
		sim		// Disable interrupts		
	// To initialize the page 0
		clrw	x
loop0:
		clr	(x)
		incw	x
		cpw	x,#0x05FF
		jrne	loop0
#endasm
*/
  unsigned char value = 100;
  in_range = (value >= 10) && (value <= 20);
  p_valid = ptr;   /* p_valid is true if ptr not 0 */
	/*CLK->SWCR|=0x02;//时钟切换启动，SWEN=1
	CLK->SWR=0xB4; //选择目标时钟源，0xB4=HSE
	while((CLK->SWCR&0x08)==0);//等待切换时间发生，此时 SWIF=1
	CLK->SWCR&=0xF7;//清除切换标志
	if(CLK->CMSR==0xB4)//判断主时钟源是否为 HSE
	{
		CLK->CKDIVR=0x00; //CPU 时钟频率为主时钟源 16 分频
	}*/
	CLK->SWCR |= 0x02; //开启切换
  CLK->SWR   = 0xb4;       //选择时钟为外部8M
  while((CLK->SWCR & 0x01)==0x01);
  CLK->CKDIVR = 0x80;    //不分频
  CLK->SWCR  &= ~0x02; //关闭切换
	LED_Init(LED1|LED2|LED3|LED4|LED5);
	KEY_Init(KEY1|KEY2);
	Variable_Init();
	//PortBInt_Init();
	EXTI_Config();
	Init_uart2();
	init();//init apds9960
	GestureTest();
	TSL_Init();
	ExtraCode_Init();	
  for (;;) {
		
		if((!receipt_device_info1) && (!device_info_sended) && (rev_bleheartbeat) && (rev_host_mesh))
		{
			device_info_sended = 1;
			rev_bleheartbeat = 0;
			send_header_payload_init(0x86,ns_host_meshid_H,ns_host_meshid_L,12,0xB4);
			UART2_Send_Data_Start();
		}
		
    Task_2ms();
		Task_100ms();
		Task_300ms();
		Task_1s();
		ExtraCode_StateMachine();			 
		TSL_Action();
		/*
		if(KEY_Read(KEY1))
		{
			st1.st_ges_H = 0xEF;
			st1.st_ges_L = 0xF0;
			gest1_confirm = 0;
			gest2_confirm = 0;
			gest3_confirm = 0;
			gest4_confirm = 0;
		}
		else
		{
			st1.st_ges_H = 0x00;
			st1.st_ges_L = 0x00;
			gest1_confirm = 0;
			gest2_confirm = 0;
			gest3_confirm = 0;
			gest4_confirm = 0;
		}
		if(KEY_Read(KEY2))
		{
			gest1_confirm = 1;
			gest2_confirm = 0;
			gest3_confirm = 0;
			gest4_confirm = 0;
		}
		else
		{
			gest1_confirm = 0;
			gest2_confirm = 0;
			gest3_confirm = 0;
			gest4_confirm = 0;
		}
		*/
		if(isr_flag ==1)
  	{
			LED_On(LED5);
			handleGesture();
			if((GPIOD->IDR&0x01)==0)
			{
				init();
				enableGestureSensor(1);
			}
			isr_flag = 0;	
		}
	}
  
}


/**
  ******************************************************************************
  * @brief Initialize all the keys, I/Os for LED
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void ExtraCode_Init(void)
{

  u8 i;

  /* All keys are implemented and enabled */

  for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
  {
    sSCKeyInfo[i].Setting.b.IMPLEMENTED = 1;
    sSCKeyInfo[i].Setting.b.ENABLED = 1;
    sSCKeyInfo[i].DESGroup = 0x01; /* Put 0x00 to disable the DES on these pins */
  }

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
  for (i = 0; i < NUMBER_OF_MULTI_CHANNEL_KEYS; i++)
  {
    sMCKeyInfo[i].Setting.b.IMPLEMENTED = 1;
    sMCKeyInfo[i].Setting.b.ENABLED = 1;
    sMCKeyInfo[i].DESGroup = 0x01; /* Put 0x00 to disable the DES on these pins */
  }
#endif

  /* Init I/O in Output Push-Pull to drive the LED */
	LED_On(LED1);
	LED_On(LED2);
	LED_On(LED3);
  LED_On(LED5);
  enableInterrupts();

}


/**
  ******************************************************************************
  * @brief Example of LED switching using touch sensing keys
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void ExtraCode_StateMachine(void)
{
	if ((TSL_GlobalSetting.b.CHANGED) && (TSLState == TSL_IDLE_STATE))
  {
   
		TSL_GlobalSetting.b.CHANGED = 0;
    
    if (sSCKeyInfo[0].Setting.b.DETECTED) /* KEY 1 touched */
    {
			LED_Toggle(LED1);
			st_pad1_ctrl = 1;
			if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
			{
				st_pad1_confirm = 1;
				st1.st_ctrl_address = 0x01;
			}
			//else
			//{
			//	st_pad1_confirm = 0;
			//	st1.st_ctrl_address = 0x00;
			//}
			
			if (st1.st_pad1_status == 0x00)
			{
				st1.st_pad1_status = 0x63;
			}
			else if (st1.st_pad1_status == 0x63)
			{
				st1.st_pad1_status = 0x00;
			}
    }
   
    if (sSCKeyInfo[1].Setting.b.DETECTED) /* KEY 2 touched */
    {
			LED_Toggle(LED2);
			st_pad2_ctrl = 1;
			if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
			{
				st_pad2_confirm = 1;
				st1.st_ctrl_address = 0x02;
			}
			//else
			//{
			//	st_pad2_confirm = 0;
			//	st1.st_ctrl_address = 0x00;
			//}
			if (st1.st_pad2_status == 0x00)
			{
				st1.st_pad2_status = 0x63;
			}
			else if (st1.st_pad2_status == 0x63)
			{
				st1.st_pad2_status = 0x00;
			}
    }
    
    if (sSCKeyInfo[2].Setting.b.DETECTED) /* KEY 3 touched */
    {
      LED_Toggle(LED3);
			st_pad3_ctrl = 1;
			if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
			{
				st_pad3_confirm = 1;
				st1.st_ctrl_address = 0x04;
			}
			//else
			//{
			//	st_pad3_confirm = 0;
			//	st1.st_ctrl_address = 0x00;
			//}
			if (st1.st_pad3_status == 0x00)
			{
				st1.st_pad3_status = 0x63;
			}
			else if (st1.st_pad3_status == 0x63)
			{
				st1.st_pad3_status = 0x00;
			}
    }
  }
}

void handleGesture(void) {
    if ( isGestureAvailable() ) {
			/*send_buf[0] = 0x00;
			send_buf[1] = 0x00;
			send_buf[2] = 0x00;
			send_buf[3] = 0x00;
			send_buf[4] = 0x00;
			send_buf[5] = 0x08;
			send_buf[6] = 0x00;//ns_own_meshid_H;
			send_buf[7] = 0x00;//ns_own_meshid_L;
			send_buf[8] = 0x00;//ns_own_meshid_H;
			send_buf[9] = 0x00;//ns_own_meshid_L;*/
			gest_cnt++;					
    switch ( readGesture() ) {
      case DIR_UP:
        //printf("UP\n");
				if(gest_cnt == 1)				st1.st_ges_H |= 0xC0;
				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0C;
				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xC0;gest_cnt = 0;gest_detect = 1;}
				//send_buf[0] = 0x01;
        break;
      case DIR_DOWN:
        //printf("DOWN\n");
				//send_buf[1] = 0x01;
				if(gest_cnt == 1)				st1.st_ges_H |= 0xD0;
				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0D;
				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xD0;gest_cnt = 0;gest_detect = 1;}
        break;
      case DIR_LEFT:
        //printf("LEFT\n");
				//send_buf[2] = 0x01;
				if(gest_cnt == 1)		st1.st_ges_H |= 0xE0;
				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0E;
				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xE0;gest_cnt = 0;gest_detect = 1;}
        break;
      case DIR_RIGHT:
        //printf("RIGHT\n");
				if(gest_cnt == 1)		st1.st_ges_H |= 0xF0;
				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0F;
				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xF0;gest_cnt = 0;gest_detect = 1;}
				//send_buf[3] = 0x01;
        break;
      case DIR_NEAR:
        //printf("NEAR\n");
				//send_buf[6] = 0x01;
        break;
      case DIR_FAR:
        //printf("FAR\n");
				//send_buf[7] = 0x01;
        break;
      default:
        //printf("NONE\n");
				//send_buf[8] = 0x01;
				break;
    }
		/*send_buf[8] = st1.st_ges_H;
		send_buf[9] = st1.st_ges_L;
		send_buf[10] = Check_Sum(send_buf,send_buf[5]+2);
		UART2_Send_Data_Start();*/
  }
}

void GestureTest(void)
{
  // Initialize APDS-9960 (configure I2C and initial values)
  /*if ( init() ) {
  //  //printf("APDS-9960 initialization complete\n");
  } else {
    //printf("Something went wrong during APDS-9960 init!\n");
		LED_On(LED5);
  }
  */
  // Start running the APDS-9960 gesture sensor engine
  if ( enableGestureSensor(1) ) {
    //printf("Gesture sensor is now running\n");
  } else {
    //printf("Something went wrong during gesture sensor init!\n");
		
  }
	//while(1)
}

void LightTest(void)
{
	static uint16_t ambient_light = 0;
	static uint16_t red_light = 0;
	static uint16_t green_light = 0;
	static uint16_t blue_light = 0;
	static uint16_t threshold = 0;
  // Initialize APDS-9960 (configure I2C and initial values)
  if ( init() ) {
    //printf("APDS-9960 initialization complete\n");
		//
  } else {
    //printf("Something went wrong during APDS-9960 init!\n");
		LED_Toggle(LED5);
		return;
		
  }
  // Set high and low interrupt thresholds
  if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
    //printf("Error writing low threshold\n");
		return;
  }
  if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
    //printf("Error writing high threshold\n");
		return;
  }
	
  // Start running the APDS-9960 light sensor (no interrupts)
  if ( enableLightSensor(0) ) {
    //printf("Light sensor is now running\n");
  } else {
    //printf("Something went wrong during light sensor init!\n");
		return;
  }
  
  // Read high and low interrupt thresholds
  if ( !getLightIntLowThreshold(&threshold) ) {
    //printf("Error reading low threshold\n");
		return;
  } else {
    //printf("Low Threshold: %d\n",threshold);
  }
  if ( !getLightIntHighThreshold(&threshold) ) {
    //printf("Error reading high threshold\n");
		return;
  } else {
    //printf("High Threshold: %d\n",threshold);
  }
  
	if ( setAmbientLightIntEnable(0) ) {
	}
	else{
		return;
	}
  // Enable interrupts
  //if ( !setAmbientLightIntEnable(1) ) {
    //printf("Error enabling interrupts\n");
		
  //}
  // Wait for initialization and calibration to finish
  delay_ms(200);
	//while(1)
	//{
	//	if(isr_flag ==1)
  	{
			// Read the light levels (ambient, red, green, blue) and print
			if (  !readAmbientLight(&ambient_light) ||
						!readRedLight(&red_light) ||
						!readGreenLight(&green_light) ||
						!readBlueLight(&blue_light) ) {
				//printf("Error reading light values");
				return;
			} else {
				//printf("Interrupt! Ambient: %d\n",ambient_light);
				//printf(" R: %d\n",red_light);
				//printf(" G: %d\n",green_light);
				//printf(" B: %d\n",blue_light);
				/*send_buf[0] = (u8)(ambient_light>>8);
				send_buf[1] = (u8)ambient_light;
				send_buf[2] = (u8)(red_light>>8);
				send_buf[3] = (u8)red_light;
				send_buf[4] = 0x00;
				send_buf[5] = 0x08;
				send_buf[6] = (u8)(green_light>>8);//ns_own_meshid_H;
				send_buf[7] = (u8)green_light;//ns_own_meshid_L;
				send_buf[8] = (u8)(blue_light>>8);//ns_own_meshid_H;
				send_buf[9] = (u8)blue_light;//ns_own_meshid_L;
				st1.st_ambient_light = (u8)ambient_light;
				st1.st_color_sense_H = (u8)(red_light/4);
				st1.st_color_sense_M = (u8)(green_light/4);
				st1.st_color_sense_L = (u8)(blue_light/4);
				send_buf[10] = Check_Sum(send_buf,send_buf[5]+2);
				UART2_Send_Data_Start();*/
			}
			//delay_ms(500);
			// Reset flag and clear APDS-9960 interrupt (IMPORTANT!)
			//isr_flag = 0;
			if ( !clearAmbientLightInt() ) {
				//printf("Error clearing interrupt\n");
				return;
			}
			enableGestureSensor(1);
		}
	//}
}




/**
  * @brief f_1ms task
  * @param None
  * @retval None
  */
void Task_500us(void)
{
	if(f_500us)
	{
		f_500us = 0;
		
	}
}

/**
  * @brief f_1ms task
  * @param None
  * @retval None
  */
void Task_2ms(void)
{
	if(f_2ms)
	{
		f_2ms = 0;
		reve_analyze_reply();
	}
}

/**
  * @brief f_100ms task
  * @param None
  * @retval None
  */
void Task_100ms(void)
{
	if(f_100ms)
	{
		f_100ms = 0;
	}
}

/**
  * @brief f_300ms task
  * @param None
  * @retval None
  */
void Task_300ms(void)
{
	if(f_300ms)
	{
		f_300ms = 0;
	}
}

/**
  * @brief f_1s task
  * @param None
  * @retval None
  */
void Task_1s(void)
{
	static int i = 0;
	static int j = 0;
	if(f_1s)
	{
		f_1s = 0;
		i++;
		j++;
		if(i >= 5)	{i = 0;LightTest();}
		LED_Toggle(LED4);
		//每300ms重新获取手势
		if(j >= 3)	{j = 0;gest_cnt = 0;st1.st_ges_H = 0x00;st1.st_ges_L = 0x00;}
		/*
		send_buf[0] = 0x01;
		send_buf[1] = 0x01;
		send_buf[2] = 0x01;
		send_buf[3] = 0x01;
		send_buf[4] = 0x01;
		send_buf[5] = 0x08;
		send_buf[6] = ns_own_meshid_H;
		send_buf[7] = ns_own_meshid_L;
		send_buf[8] = ns_own_meshid_H;
		send_buf[9] = ns_own_meshid_L;
		send_buf[10] = Check_Sum(send_buf,send_buf[5]+2);
		UART2_Send_Data_Start();
		*/
	}
	
}


void LED_Init(u8 LedNum)
{
	if(LedNum & LED1)//LED1
	{
		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED1, GPIO_MODE_OUT_PP_LOW_FAST);
	}
	if(LedNum & LED2)//LED2
	{
		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED2, GPIO_MODE_OUT_PP_LOW_FAST);
	}
	if(LedNum & LED3)//LED3
	{
		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED3, GPIO_MODE_OUT_PP_LOW_FAST);
	}
	if(LedNum & LED4)//LED4
	{
		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED4, GPIO_MODE_OUT_PP_LOW_FAST);
	}
	if(LedNum & LED5)//LED5
	{
		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED5, GPIO_MODE_OUT_PP_LOW_FAST);
	}
}

void LED_On(u8 LedNum)
{
	if(LedNum & LED1)//LED1
	{
		GPIO_WriteHigh(LED_PORT, LED1);
	}
	if(LedNum & LED2)//LED2
	{
		GPIO_WriteHigh(LED_PORT, LED2);
	}
	if(LedNum & LED3)//LED3
	{
		GPIO_WriteHigh(LED_PORT, LED3);
	}
	if(LedNum & LED4)//LED4
	{
		GPIO_WriteLow(LED_PORT, LED4);
	}
	if(LedNum & LED5)//LED5
	{
		GPIO_WriteLow(LED_PORT, LED5);
	}
}


void LED_Off(u8 LedNum)
{
	if(LedNum & LED1)//LED1
	{
		GPIO_WriteLow(LED_PORT, LED1);
	}
	if(LedNum & LED2)//LED2
	{
		GPIO_WriteLow(LED_PORT, LED2);
	}
	if(LedNum & LED3)//LED3
	{
		GPIO_WriteLow(LED_PORT, LED3);
	}
	if(LedNum & LED4)//LED4
	{
		GPIO_WriteLow(LED_PORT, LED4);
	}
	if(LedNum & LED5)//LED5
	{
		GPIO_WriteLow(LED_PORT, LED5);
	}
}

void LED_Toggle(u8 LedNum)
{
	if(LedNum & LED1)//LED1
	{
		GPIO_WriteReverse(LED_PORT, LED1);
	}
	if(LedNum & LED2)//LED2
	{
		GPIO_WriteReverse(LED_PORT, LED2);
	}
	if(LedNum & LED3)//LED3
	{
		GPIO_WriteReverse(LED_PORT, LED3);
	}
	if(LedNum & LED4)//LED4
	{
		GPIO_WriteReverse(LED_PORT, LED4);
	}
	if(LedNum & LED5)//LED5
	{
		GPIO_WriteReverse(LED_PORT, LED5);
	}
}

void KEY_Init(u8 KeyNum)
{
	if(KeyNum & KEY1)//LED1
	{
		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY1, GPIO_MODE_IN_PU_NO_IT);
	}
	if(KeyNum & KEY2)//LED2
	{
		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY2, GPIO_MODE_IN_PU_NO_IT);
	}
}

bool KEY_Read(u8 KeyNum)
{
	if(KeyNum & KEY1)//LED1
	{
		if((GPIO_ReadInputData(KEY_PORT) & 0x01) == 0x00)
			return TRUE;
		else
			return FALSE;
	}
	if(KeyNum & KEY2)//LED2
	{
		if((GPIO_ReadInputData(KEY_PORT) & 0x02) == 0x00)
			return TRUE;
		else
			return FALSE;
	}
}

/****************************************************************/
//延时函数delay()，有形参Count用于控制延时函数执行次数，无返回值
/****************************************************************/
void delay(u16 Count)
{
  u8 i,j;
  while (Count--)//Count形参控制延时次数
  {
    for(i=0;i<100;i++)
    for(j=0;j<50;j++);
  }
}

/****************** (c) 2009  STMicroelectronics ******************************/

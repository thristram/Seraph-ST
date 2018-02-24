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

#include "stm8s_flash.h"
#include "stm8s_conf.h"
#include "string.h"
#include "uart.h"
#include "stm8s_exti.h"
#include "i2c_master_poll.h"
#include "SparkFun_APDS9960.h"
#include "mpr121.h"
#include "timer.h"
#include "main.h"


volatile u8 GESTURE_ISR_FLAG = 0;

APDS9960_Light_t APDS9960_Light = {0};	

u8 BIT[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};


/*----------------------------------------------------------------------------
enum
{
    DIR_NONE,
    DIR_LEFT,
    DIR_RIGHT,
    DIR_UP,    
    DIR_DOWN,
    DIR_NEAR,
    DIR_FAR,
    DIR_ALL
};
-----------------------------------------------------------------------------*/
u8 DIR_DATA[8] = {0x00, 0x0E,0x0F,0x0C, 0x0D, 1, 2, 3};



// Constants
#define LIGHT_INT_HIGH  1000 // High light level for interrupt
#define LIGHT_INT_LOW   10   // Low light level for interrupt




//--------    SECTION DEFINITION FOR THIS FILE   --------------
#if defined(__CSMC__) && defined(USE_PRAGMA_SECTION)
#pragma section [CONFIG_RAM]
#pragma section @tiny [CONFIG_RAM0]
#pragma section (CONFIG_CODE)
#pragma section const {CONFIG_CONST}
#endif






/*----------------------------------------------------------------------------
   EEPROM中写入一个字节
   dLocal_Addr:EEPROM中的地址，从0x4000
   dLocal_Data:要写入EEPOM中的数据
-----------------------------------------------------------------------------*/
void MEEPROM_WriteByte(u16 dLocal_Addr, u8 dLocal_Data)
{
   FLASH_Unlock(FLASH_MEMTYPE_DATA);
   while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
   
   FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr, dLocal_Data);
   FLASH_Lock(FLASH_MEMTYPE_DATA);

}

 /*----------------------------------------------------------------------------
	从EEPROM中读取一个字节
	直接使用FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
-----------------------------------------------------------------------------*/
 u8 MEEPROM_ReadByte(u16 dLocal_Addr)
 {
	 u8 dLocal_1;
	 dLocal_1 = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
	 return dLocal_1;
 }

/*----------------------------------------------------------------------------
	 读取设备信息 
-----------------------------------------------------------------------------*/
void MEEPROM_device_info_read(void)
{
	u8 temp = 0, i;

	st1.model = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MODEL_ADDRESS);
	st1.firmware_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_FW_VERSION_ADDRESS);   
	if(st1.firmware_version == 1){	   /* 第一版本，device ID 4个字节  */	   
		   st1.deviceID[0] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 3);
		   st1.deviceID[1] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 2);
		   st1.deviceID[2] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 1);
		   st1.deviceID[3] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 0);
	}
	st1.HW_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_HW_VERSION_ADDRESS);

	temp = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 0);
	st1.bash = temp + 256 * FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 1);

	st1.manaYear = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_YEAR_ADDRESS);
	st1.manaMonth = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_MONTH_ADDRESS);
	st1.manaDay = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_DAY_ADDRESS);


	st1.keypad[0].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS);
	st1.keypad[1].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS);
	st1.keypad[2].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH3_STATUS_ADDRESS);

	ns_host_meshid_H = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MESHID_H_ADDRESS);
	ns_host_meshid_L = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MESHID_L_ADDRESS);

	st1.keypad[0].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_TARGET_STATUS_ADDRESS);
	st1.keypad[1].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_TARGET_STATUS_ADDRESS);
	st1.keypad[2].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH3_TARGET_STATUS_ADDRESS);
	st1.keypad[0].actural_val_bak = st1.keypad[0].actural_val;
	st1.keypad[1].actural_val_bak = st1.keypad[1].actural_val;
	st1.keypad[2].actural_val_bak = st1.keypad[2].actural_val;


	
	for(i = 0; i < KEYPAY_NUMS; i++){

		st1.keypad[i].meshid_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDH_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
		if(st1.keypad[i].meshid_h){		
			st1.keypad[i].flag.bit.setted = 1;
			
			st1.keypad[i].meshid_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDL_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
			st1.keypad[i].action = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_ACTION_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
			st1.keypad[i].boardid = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_BOARDID_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
			st1.keypad[i].value = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_VALUE_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
			st1.keypad[i].time = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_TIME_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);

		}		
	}

	for(i = 0; i < GESTURE_NUMS; i++){
		
		st1.gesture[i].meshid_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
		if(st1.gesture[i].meshid_h){		
			st1.gesture[i].flag.bit.setted = 1;
			
			st1.gesture[i].meshid_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].ges_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].ges_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].action = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_ACTION_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].boardid = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_BOARDID_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].value = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_VALUE_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
			st1.gesture[i].time = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TIME_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);			

		}			
	}

	/* 滑动按键 */
	mpr121_handle.slipLevel = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_NOKEY_SLIPPAD_VALUE);
	mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;
	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
		mpr121_handle.keylongTouchSlipLevel[i] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_SLIPPAD_VALUE + i);
	}



}

/*----------------------------------------------------------------------------
	 设置默认的信息
-----------------------------------------------------------------------------*/
void MEEPROM_default_info_set(void)
{	
	u8 i;

	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);

	for(i = EEPROM_USER_START_ADDRESS; i <= EEPROM_USER_END_ADDRESS; i++){
		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + i, 0);
	}

	FLASH_Lock(FLASH_MEMTYPE_DATA);

}


/*----------------------------------------------------------------------------
	初始化EEPROM
-----------------------------------------------------------------------------*/
void MEEPROM_Init(void)
{
	u8 temp = 0;

	FLASH_DeInit();
	temp = MEEPROM_ReadByte(EEPROM_INIT_ADDRESS);

	//初次上电设置默认数据
	if(temp != EEPROM_INIT_FLAG) {	   
		   MEEPROM_WriteByte(EEPROM_INIT_ADDRESS, EEPROM_INIT_FLAG);
		   MEEPROM_default_info_set();
	}

	MEEPROM_device_info_read();

}



/*----------------------------------------------------------------------------

-----------------------------------------------------------------------------*/
u8 sicp_get_message_id(void)
{
	static u8 id = 0;

	id++;

	if(id == 0) {
		id = 1;
	}

	return id;
}



/*-----------------------------------------------------------------------------
    //触摸扫描
------------------------------------------------------------------------------*/
void keypad_action(void)
{
	u8 i;

	//组合按键检测，处理完后清空按键触发标志


	//单按键检测，处理完后清空按键触发标志
	for(i = 0; i < KEYPAY_NUMS; i++) {

		if(st1.keypad[i].flag.bit.detected) {		//按键触发标志

			st1.keypad[i].flag.bit.detected = 0;

			if(st1.keypad[i].flag.bit.setted) {	//已设置按键指令
				
				send_action_ctrl(i, KEYPAD_CTRL);
//				delay_ms(10); 
//				send_action_sync(i, KEYPAD_CTRL);

			} else {

				send_action_without_setted(i, KEYPAD_CTRL);

			}
			
			MEEPROM_WriteByte(EEPROM_CH1_STATUS_ADDRESS + i, st1.keypad[i].status);		//保存状态

			
		}

	}
	

}


/*-----------------------------------------------------------------------------
    APDS9960 外部中断设置
------------------------------------------------------------------------------*/
void gesture_exti_config(void)
{

	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_IN_PU_IT );

//	EXTI_DeInit();
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);		//下降沿触发中断
	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOE), EXTI_SENSITIVITY_FALL_ONLY);
	
}

/*----------------------------------------------------------------------------
	设置LED
-----------------------------------------------------------------------------*/
void gesture_led_init(void)
{
	// Set GPIO for LED uses 
  	GPIO_Init(GESTURE_LED_PORT, (GPIO_Pin_TypeDef)GESTURE_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 

}

/*----------------------------------------------------------------------------
	手势LED显示 
	100ms执行一次
-----------------------------------------------------------------------------*/
void gesture_led_show(void)
{
	static u8 ledShowCnt = 0;
	static u8 ledStatusOld = 0;

	ledShowCnt++;

	if(st1.ges_led_ctrl != ledStatusOld){
		ledStatusOld = st1.ges_led_ctrl;
		ledShowCnt = 0;
	}

	if(st1.ges_led_ctrl == 1){

		if(ledShowCnt < 1){		/* 亮 200ms */

			GESTURE_LED_ON;
		}else{
			GESTURE_LED_OFF;
			st1.ges_led_ctrl = 0;
		}

	}else if(st1.ges_led_ctrl == 0xff){

		if(ledShowCnt < 30){		/* */
			GESTURE_LED_ON;
		}else{
			GESTURE_LED_OFF;
			st1.ges_led_ctrl = 0;
		}

	}else{
	
		GESTURE_LED_OFF;
	}




}

/*-----------------------------------------------------------------------------
	每n次动作要在多长时间内完成
------------------------------------------------------------------------------*/
void gesture_timeout_check(void)
{

	if(st1.ges_cnt){		//正在检测手势
		st1.ges_timer++;
		if(st1.ges_timer >= 30){		//3s
			st1.ges_timer = 0;
			st1.ges_cnt = 0;
			st1.ges_h = 0;
			st1.ges_l = 0;
		}
	}
			
}



/*-----------------------------------------------------------------------------
    手势动作
------------------------------------------------------------------------------*/
void gesture_action(void)
{
	u8 num;

	num = get_gesture_num(st1.ges_h, st1.ges_l, GET_SETTED_NUM);		//判断是否已保存过相同手势

	if(num != GET_GESTURE_ERROR){		//有相同手势

		send_action_ctrl(num, GESTURE_CTRL);
//		delay_ms(10); 
//		send_action_sync(num, GESTURE_CTRL);

	}else{						//没有相同手势

		send_action_without_setted(num, GESTURE_CTRL);
	
	}





}

/*-----------------------------------------------------------------------------
    手势分析 检测三个手势
------------------------------------------------------------------------------*/
void gesture_analyze(u8 motion)
{
	u8 reset = 0;

	st1.ges_cnt++;

	if((st1.ges_led_ctrl != 0xff) && motion){		/* 上次的保持时间已经结束 */

		st1.ges_led_ctrl = 1;

		if(st1.ges_cnt == 1) {
			
			st1.ges_timer = 0;
//			st1.ges_h |= DIR_DATA[motion] << 4;
			st1.ges_h |= motion << 4;
			
		} else if(st1.ges_cnt == 2) {
		
//			st1.ges_h |= DIR_DATA[motion];
			st1.ges_h |= motion;
		
		} else if(st1.ges_cnt == 3) {
		
//			st1.ges_l |= DIR_DATA[motion] << 4;
			st1.ges_l |= motion << 4;
					
			st1.ges_led_ctrl = 0xff;
			gesture_action();
			reset = 1;

		}else{
			reset = 1;
		}

	}else{
		reset = 1;
	}

	if(reset == 1){
		st1.ges_timer = 0;
		st1.ges_cnt = 0;
		st1.ges_l = 0;
		st1.ges_h = 0;
	}

}



/*-----------------------------------------------------------------------------
    手势检测
------------------------------------------------------------------------------*/
void gesture_detect(void)
{
	static GESTURE_DETECT_STATUS status = GESTURE_IDLE;
	u8 ret, motion = 0;

	switch(status){
		
		case GESTURE_IDLE:
			if(GESTURE_ISR_FLAG){		//有中断
				status = GESTURE_CHECK;			
				GESTURE_ISR_FLAG = 0;
			}
			break;

		case GESTURE_CHECK:
			 /* Make sure that power and gesture is on and data is valid */
			if(isGestureAvailable() && (getMode() & 0x41)){
				resetGestureParameters();
//				GestureTimeOut = 150;
				GestureTimeOut = 30;
				
				status = GESTURE_WAIT;
				
			}else{
				status = GESTURE_IDLE;
				GESTURE_ISR_FLAG = 0;
			}

			break;
	
		case GESTURE_WAIT:			 /* Wait some time to collect next batch of FIFO data */
			if(GestureTimeOut == 0){
				status = GESTURE_GET;
			}
			break;

		case GESTURE_GET:

			ret = gesture_read_data(&motion);
			if(ret == 1){				//结束
				
				status = GESTURE_IDLE;
				GESTURE_ISR_FLAG = 0;
				
				gesture_analyze(motion);
				
//				if((GPIOD->IDR & 0x01) == 0) {
//					init();
//					enableGestureSensor(1);
//				}

			}else if(ret == 0xff){		//未结束
//				GestureTimeOut = 100;
				GestureTimeOut = 30;			/* 30 */			
				status = GESTURE_WAIT;	

			}else{					//失败
				status = GESTURE_IDLE;
				GESTURE_ISR_FLAG = 0;
			}		
			break;
	
		default:
			status = GESTURE_IDLE;
			GESTURE_ISR_FLAG = 0;
			break;

	}

}


/*-----------------------------------------------------------------------------
    用来检测环境光亮度
------------------------------------------------------------------------------*/
void gesture_lightCheck(void)
{
	static uint16_t ambient_light = 0;
	static uint16_t red_light = 0;
	static uint16_t green_light = 0;
	static uint16_t blue_light = 0;
	static uint16_t threshold = 0;

	// Initialize APDS-9960 (configure I2C and initial values)
	//fyl
	if ( !init() ) {
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
	}

	if ( !setAmbientLightIntEnable(0) ) {
		return;
	}

	// Read the light levels (ambient, red, green, blue) and print
	if (  !readAmbientLight(&ambient_light) ||
	        !readRedLight(&red_light) ||
	        !readGreenLight(&green_light) ||
	        !readBlueLight(&blue_light) ) {
		//printf("Error reading light values");
		return;
	}

	// Reset flag and clear APDS-9960 interrupt (IMPORTANT!)
	if ( !clearAmbientLightInt() ) {
		//printf("Error clearing interrupt\n");
		return;
	}
	enableGestureSensor(1);

}


/*-----------------------------------------------------------------------------
    检测环境光亮度 初始化 
------------------------------------------------------------------------------*/
void APDS9960_Light_init(void)
{
	static uint16_t threshold = 0;

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
	}

	if ( !setAmbientLightIntEnable(0) ) {
		return;
	}

	// Read the light levels (ambient, red, green, blue) and print
	if (  !readAmbientLight(&APDS9960_Light.ambient) ||
			!readRedLight(&APDS9960_Light.red) ||
			!readGreenLight(&APDS9960_Light.green) ||
			!readBlueLight(&APDS9960_Light.blue) ) {
		return;
	}

	// Reset flag and clear APDS-9960 interrupt (IMPORTANT!)
	if ( !clearAmbientLightInt() ) {
		//printf("Error clearing interrupt\n");
		return;
	}


	
}

/*-----------------------------------------------------------------------------
    获取环境光亮度 颜色
------------------------------------------------------------------------------*/
void APDS9960_Light_read(void)
{

	// Read the light levels (ambient, red, green, blue) and print
	if (  !readAmbientLight(&APDS9960_Light.ambient) ||
			!readRedLight(&APDS9960_Light.red) ||
			!readGreenLight(&APDS9960_Light.green) ||
			!readBlueLight(&APDS9960_Light.blue) ) {
		return;
	}

	// Reset flag and clear APDS-9960 interrupt (IMPORTANT!)
	if ( !clearAmbientLightInt() ) {
		return;
	}


	BLE_uart.txBuf[0] = (u8)(APDS9960_Light.ambient >> 8);
	BLE_uart.txBuf[1] = (u8)APDS9960_Light.ambient;
	BLE_uart.txBuf[2] = (u8)(APDS9960_Light.red >> 8);
	BLE_uart.txBuf[3] = (u8)APDS9960_Light.red;
	BLE_uart.txBuf[4] = (u8)(APDS9960_Light.green >> 8);
	BLE_uart.txBuf[5] = (u8)APDS9960_Light.green;
	BLE_uart.txBuf[6] = (u8)(APDS9960_Light.blue >> 8);
	BLE_uart.txBuf[7] = (u8)APDS9960_Light.blue;

	BLE_uart.txCnt = 1;
	BLE_uart.txLen = 8;

	BLE_UART->DR = BLE_uart.txBuf[0];

	while(BLE_uart.txCnt);		//等待发送结束 

}

void KEYPAD_LED_REVERSE(u8 i)
{
	if(i == 0) KEYPAD1_LED_REVERSE; 
	if(i == 1) KEYPAD2_LED_REVERSE; 
	if(i == 2) KEYPAD3_LED_REVERSE;

}
void KEYPAD_LED_ON(u8 i)
{
	if(i == 0) KEYPAD1_LED_ON; 
	if(i == 1) KEYPAD2_LED_ON; 
	if(i == 2) KEYPAD3_LED_ON;

}
void KEYPAD_LED_OFF(u8 i)
{
	if(i == 0) KEYPAD1_LED_OFF; 
	if(i == 1) KEYPAD2_LED_OFF; 
	if(i == 2) KEYPAD3_LED_OFF;

}
/*----------------------------------------------------------------------------

-----------------------------------------------------------------------------*/
void keypad_led_show(void)
{
	u8 i;
	
	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){

		if(mpr121_handle.keyLEDStatus[i] == 0){
			KEYPAD_LED_OFF(i);
			
		}else if(mpr121_handle.keyLEDStatus[i] == 1){
			KEYPAD_LED_ON(i);
			
		}else if(mpr121_handle.keyLEDStatus[i] == 2){
			if(mpr121_handle.keyLEDCnt[i] >= MPR121_KEYPAD_RELEASE_LED_DELAY){
				KEYPAD_LED_OFF(i);
				mpr121_handle.keyLEDStatus[i] = 0;				
			}

		}else if(mpr121_handle.keyLEDStatus[i] == 3){			/* 长按等待，时间由longTouch控制  */
			if(((mpr121_handle.keyLEDCnt[i] /3) % 2) == 0){		/* 每0.5s一个单位，先灭再亮 */
				KEYPAD_LED_OFF(i);
			}else{		/* 亮 */				
				KEYPAD_LED_ON(i);
			}

		}else{			
			mpr121_handle.keyLEDStatus[i] = 0;				
		}
		
	}


}

/*----------------------------------------------------------------------------
	
-----------------------------------------------------------------------------*/
void keypad_led_init(void)
{
	// Set GPIO for LED uses 
  	GPIO_Init(KEYPAD1_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD1_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
  	GPIO_Init(KEYPAD2_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD2_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
  	GPIO_Init(KEYPAD3_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD3_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 

}


void SLIPPAD_LED_ON(u8 i)
{
	if(i == 1) SLIPPAD_LED1_ON; 
	if(i == 2) SLIPPAD_LED2_ON; 
	if(i == 3) SLIPPAD_LED3_ON; 
	if(i == 4) SLIPPAD_LED4_ON; 
	if(i == 5) SLIPPAD_LED5_ON; 
	if(i == 6) SLIPPAD_LED6_ON; 
	if(i == 7) SLIPPAD_LED7_ON; 
	if(i == 8) SLIPPAD_LED8_ON; 

}
void SLIPPAD_LED_OFF(u8 i)
{
	if(i == 1) SLIPPAD_LED1_OFF; 
	if(i == 2) SLIPPAD_LED2_OFF; 
	if(i == 3) SLIPPAD_LED3_OFF; 
	if(i == 4) SLIPPAD_LED4_OFF; 
	if(i == 5) SLIPPAD_LED5_OFF; 
	if(i == 6) SLIPPAD_LED6_OFF; 
	if(i == 7) SLIPPAD_LED7_OFF; 
	if(i == 8) SLIPPAD_LED8_OFF; 

}
/*-----------------------------------------------------------------------------
    onNum = 0...8
------------------------------------------------------------------------------*/
void slippad_led_show(void)
{
	u8 i, onoff;
	
	onoff = 1;		/* 开启  */
		
	if(mpr121_handle.longTouchSlipConfirm){		/* 屏蔽按键时闪烁 */
		if(mpr121_handle.longTouchHoldCnt < MPR121_LONG_TOUCH_CONFIRM_CNT){
			if(((mpr121_handle.longTouchHoldCnt /3) % 2) == 0){		/* 每0.5s一个单位，先灭再亮 */
				onoff = 0;
			}

		}else{
			mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;				/* 滑动LED 恢复原滑动值 */		
			mpr121_handle.keyLEDStatus[mpr121_handle.longTouchSlipConfirm -1] = 0;	/* 按键LED */		
			mpr121_handle.longTouchSlipConfirm = 0;		/* 结束屏蔽 */
		}
	}

	if(onoff){
		
		if(mpr121_handle.slipValue == 1){			/* 关闭 */
			SLIPPAD_LED0_ON;
		}else{								/* 有调光 */
			SLIPPAD_LED0_OFF;
		}
		
		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){
		
			if(i < mpr121_handle.slipValue){
				SLIPPAD_LED_ON(i);
			}else{
				SLIPPAD_LED_OFF(i);
			}
		}

	}else{
		SLIPPAD_LED0_OFF;		
		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){		
			SLIPPAD_LED_OFF(i);
		}
	}

}

/*-----------------------------------------------------------------------------
    滑块LED初始化
------------------------------------------------------------------------------*/
void slippad_led_init(void)
{

	GPIO_Init(SLIPPAD_LED8_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED8_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED7_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED7_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED6_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED6_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED5_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED5_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED4_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED4_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED3_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED3_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED2_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED2_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED1_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED1_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
	GPIO_Init(SLIPPAD_LED0_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED0_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 

}




/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
void Task_2ms(void)
{
	if(f_2ms) {
		f_2ms = 0;
		
	}
}


/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
void Task_100ms(void)
{
	if(f_100ms) {
		f_100ms = 0;
		
		gesture_timeout_check();
		gesture_led_show();

		MPR121_keyPad_hold_time_count();
		
		MPR121_keyPad_slipPad_post();
		
	}
}


/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
void Task_1s(void)
{
	static u8 cnt_5s = 0;

	if(f_1s) {

		f_1s = 0;
		
		SYSTEM_LED_REVERSE;

		if(rev_ssbroadcast == 0){		/* 还没发送deviceinfo */
			if(send_device_info_active()){
				rev_ssbroadcast = 1;
			}						
		}



//		APDS9960_Light_read();



		cnt_5s++;
		if(cnt_5s >= 5) {
			cnt_5s = 0;
//			APDS9960_Light_read();
		}

	}

}



/*----------------------------------------------------------------------------
	设置系统时钟
-----------------------------------------------------------------------------*/
void system_clock_set(void)
{

	//CLK->CKDIVR = 0;				  // sys clock /1
	CLK->SWCR |= 0x02; //开启切换

	CLK->SWR   = 0xb4;		 //选择时钟为外部16M
	while((CLK->SWCR & 0x01) == 0x01);
	CLK->CKDIVR = 0x80;    //不分频

	CLK->SWCR  &= ~0x02; //关闭切换

}


/*----------------------------------------------------------------------------
	设置LED
-----------------------------------------------------------------------------*/
void system_led_init(void)
{
	// Set GPIO for LED uses 
  	GPIO_Init(SYSTEM_LED_PORT, (GPIO_Pin_TypeDef)SYSTEM_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 

}


/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
void system_variable_init(void)
{

	memset(&st1, 0, sizeof(st1));

	st1.HWTtest = 0;

	rev_ssbroadcast = 0;
	
	ns_own_meshid_H = 0;
	ns_own_meshid_L = 0;

}


/*----------------------------------------------------------------------------
	设置中断优先级
-----------------------------------------------------------------------------*/
void system_interrupt_priority_set(void)
{

	//	//中断优先级设置
//	disableInterrupts();
//
//	ITC_DeInit();
//
//	ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF, ITC_PRIORITYLEVEL_3);
//	ITC_SetSoftwarePriority(ITC_IRQ_TIM3_OVF, ITC_PRIORITYLEVEL_3);
//
//	ITC_SetSoftwarePriority(ITC_IRQ_UART2_TX, ITC_PRIORITYLEVEL_2);
//	ITC_SetSoftwarePriority(ITC_IRQ_UART2_RX, ITC_PRIORITYLEVEL_2);

	/* Enable general interrupts */

	enableInterrupts();

}


/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
@interrupt void PORTE_EXT_ISR(void)
{

//	disableInterrupts();//关中断
	GESTURE_ISR_FLAG = 1;
//	enableInterrupts();
}
/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
@interrupt void PORTA_EXT_ISR(void)
{

//	disableInterrupts();//关中断
	MPR121_ISR_FLAG = 1;
//	enableInterrupts();
}

/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
void LED_detect(void)
{
	SYSTEM_LED_ON;
	GESTURE_LED_ON;
	mpr121_handle.slipValue = 9;
	slippad_led_show();
	SLIPPAD_LED0_ON;

	KEYPAD1_LED_ON;	
	KEYPAD2_LED_ON;
	KEYPAD3_LED_ON;

	delay_ms(1000); /* 点亮所有的灯 */

	SYSTEM_LED_OFF;
	GESTURE_LED_OFF;
	mpr121_handle.slipValue = 1;
	slippad_led_show();
	SLIPPAD_LED0_OFF;

	KEYPAD1_LED_OFF; 
	KEYPAD2_LED_OFF;
	KEYPAD3_LED_OFF;

}


/*-------------------------------------------------------------------------
  * @brief Main function.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
-------------------------------------------------------------------------*/
void main(void)
{
	u8 ret = 0;

	system_clock_set();
	system_led_init();
	timer2_init();
	EXTI_DeInit();

	system_variable_init();

	/*----------- APDS9960 -------- start ------------------------------*/
	gesture_exti_config();

	ret = init();
	if(ret){
//		APDS9960_Light_init();
	}

//	while(!ret) {

//		delay_ms(200); 
//		ret = init();

//	}

	enableGestureSensor(1); 		// Start running the APDS-9960 gesture sensor engine

	gesture_led_init();
	
	/*----------- APDS9960 -------- end --------------------------------*/


	/*----------- MPR121 -------- start --------------------------------*/

	MPR121_init();
	
	MPR121_exti_config();

	slippad_led_init();
	keypad_led_init();

	/*----------- MPR121 -------- end ----------------------------------*/

	BLE_uart_init();

	system_interrupt_priority_set();
	
	LED_detect();

	MEEPROM_Init();
	
	for (;;) {

		Task_100ms();
		Task_1s();

		recv_analyze_reply();

		/* 手势 */
		gesture_detect();

		/* 按键 */
		MPR121_detect();
		keypad_led_show();
		slippad_led_show();

	}

}














/****************** (c) 2009  STMicroelectronics ******************************/

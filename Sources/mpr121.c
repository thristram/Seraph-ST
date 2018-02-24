/**
  ******************************************************************************
  * @file    timer.c
  * @author  Seraph
  * @version  V1.0
  * @date     2017-03
  * @brief   This file contains the main function for STM8S003F3 timer operation.
**/

#include <stdlib.h>
#include "mpr121.h"
#include "i2c_master_poll.h"
#include "uart.h"
#include "main.h"

volatile u8 MPR121_ISR_FLAG = 0;
mpr121_handle_t mpr121_handle = {0};



/*-----------------------------------------------------------------------------

 * @brief Writes a single byte to the I2C device and specified register
 *
 * @param[in] reg the register in the I2C device to write to
 * @param[in] val the 1-byte value to write to the I2C device
 * @return 1 if successful write operation. 0 otherwise.
 
------------------------------------------------------------------------------*/
uint8_t MPR121_WriteDataByte(uint8_t reg, uint8_t val)
{
	uint8_t ret;
	uint8_t buffer[2];

	buffer[0] = reg;
	buffer[1] = val;
	ret = I2C_WriteBytes(MPR121_I2C_ADDR, buffer, 2, 10);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}


/*-----------------------------------------------------------------------------
 * @brief Reads a single byte from the I2C device and specified register
 *
 * @param[in] reg the register to read from
 * @param[out] the value returned from the register
 * @return 1 if successful read operation. 0 otherwise.
------------------------------------------------------------------------------*/
uint8_t MPR121_ReadDataByte(uint8_t reg, uint8_t *val)
{
	uint8_t ret;
	ret = I2C_WriteReadBytes(MPR121_I2C_ADDR, &reg, 1, val, 1, 10);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return 1;
}




/*-----------------------------------------------------------------------------

* @brief Reads a block (array) of bytes from the I2C device and register
*
* @param[in] reg the register to read from
* @param[out] val pointer to the beginning of the data
* @param[in] len number of bytes to read
* @return Number of bytes read. -1 on read error.

------------------------------------------------------------------------------*/
int MPR121_ReadDataBlock(uint8_t reg, uint8_t *val, unsigned int len)
{
	uint8_t ret;
	ret = I2C_WriteReadBytes(MPR121_I2C_ADDR, &reg, 1, val, len, 100);
	if(ret != IIC_SUCCESS) {
		return 0;
	}
	return len;
}


/*-----------------------------------------------------------------------------
    MPR121��ʼ��
------------------------------------------------------------------------------*/
void MPR121_init(void)
{  
	// Section A
	//This group controls filtering when data is > baseline.
	MPR121_WriteDataByte(MHD_R, 0x01);
	MPR121_WriteDataByte(NHD_R, 0x01);
	MPR121_WriteDataByte(NCL_R, 0x00);
	MPR121_WriteDataByte(FDL_R, 0x00);

	//  // Section B
	// This group controls filtering when data is < baseline.
	MPR121_WriteDataByte(MHD_F, 0x01);
	MPR121_WriteDataByte(NHD_F, 0x01);
	MPR121_WriteDataByte(NCL_F, 0xFF);
	MPR121_WriteDataByte(FDL_F, 0x02);

	//  // Section C
	//  // This group sets touch and release thresholds for each electrode
	MPR121_WriteDataByte(ELE0_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE0_R, REL_THRESH);
	MPR121_WriteDataByte(ELE1_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE1_R, REL_THRESH);
	MPR121_WriteDataByte(ELE2_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE2_R, REL_THRESH);
	MPR121_WriteDataByte(ELE3_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE3_R, REL_THRESH);
	MPR121_WriteDataByte(ELE4_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE4_R, REL_THRESH);
	MPR121_WriteDataByte(ELE5_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE5_R, REL_THRESH);
	MPR121_WriteDataByte(ELE6_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE6_R, REL_THRESH);
	MPR121_WriteDataByte(ELE7_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE7_R, REL_THRESH);
	MPR121_WriteDataByte(ELE8_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE8_R, REL_THRESH);
	MPR121_WriteDataByte(ELE9_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE9_R, REL_THRESH);
	MPR121_WriteDataByte(ELE10_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE10_R, REL_THRESH);
	MPR121_WriteDataByte(ELE11_T, TOU_THRESH);
	MPR121_WriteDataByte(ELE11_R, REL_THRESH);

	//  // Section D
	//  // Set the Filter Configuration
	//  // Set ESI2
	MPR121_WriteDataByte(FIL_CFG, 0x04);

	//  // Section E
	//  // Electrode Configuration
	//  // Enable 6 Electrodes and set to run mode
	//  // Set ELE_CFG to 0x00 to return to standby mode
	MPR121_WriteDataByte(ELE_CFG, 0x0C);		// Enables all 12 Electrodes
	//MPR121_WriteDataByte(ELE_CFG, 0x06);		// Enable first 6 electrodes

	// Section F
	// Enable Auto Config and auto Reconfig
	MPR121_WriteDataByte(ATO_CFG0, 0x0B);
	MPR121_WriteDataByte(ATO_CFGU, 0xC9);		// USL = (Vdd-0.7)/vdd*256 = 0xC9 @3.3V   
	MPR121_WriteDataByte(ATO_CFGL, 0x82);		// LSL = 0.65*USL = 0x82 @3.3V
	MPR121_WriteDataByte(ATO_CFGT, 0xB5);		// Target = 0.9*USL = 0xB5 @3.3V

}



/*-----------------------------------------------------------------------------
    MPR121 �ⲿ�ж�����
------------------------------------------------------------------------------*/
void MPR121_exti_config(void)
{
	disableInterrupts();

	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_PU_IT );

//	EXTI_DeInit();
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);		//�½��ش����ж�
	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOA), EXTI_SENSITIVITY_FALL_ONLY);

	enableInterrupts();
}



void MPR121_uart_send_until_finish(uint8_t s0, uint8_t s1)
{
	BLE_uart.txBuf[1] = s0;
	
	BLE_uart.txCnt = 1;
	BLE_uart.txLen = 2;

	BLE_UART->DR = s1;

	while(BLE_uart.txCnt);		//�ȴ����ͽ��� 
	
}


/*-----------------------------------------------------------------------------
    ��������ά��ʱ�������������������������ά��ʱ�����
    �ж��Ƿ��ǵ�һ����������ʱ�����
    led��ʾ����
    100msִ��һ��
------------------------------------------------------------------------------*/
void MPR121_keyPad_hold_time_count(void)
{
	static u8 longTouchIntervalCnt = 0;
	u8 longTouchKeyNum = 0;	
	u8 i, j;

	if(mpr121_handle.longTouchKey){				/* �����ȴ��������� */
		mpr121_handle.longTouchHoldCnt++;
		if(mpr121_handle.longTouchHoldCnt >= MPR121_LONG_TOUCH_HOLD_CNT){		/* �ȴ���ʱ */
			mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* ����LED */
			mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* ����LED */
			mpr121_handle.longTouchHoldCnt = 0;
			mpr121_handle.longTouchKey = 0;
		}
	}

	if(mpr121_handle.longTouchSlipConfirm){			/* �����������μ��� */
		mpr121_handle.longTouchHoldCnt++;
	}


	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){

		if((mpr121_handle.keyTouch.byte & BIT[i])){			/* ����ά��ʱ����� */
			mpr121_handle.keyHoldCnt[i]++;
		}

		if(mpr121_handle.keyWaitCnt[i]){			/* ������ʱ����� */
//			mpr121_handle.keyWaitCnt[i]++;
			longTouchKeyNum++;
			j = i;
		}

		if((mpr121_handle.keyLEDStatus[i] == 2) || (mpr121_handle.keyLEDStatus[i] == 3)){			/* led����  */
			mpr121_handle.keyLEDCnt[i]++;
		}
		
	}

	if(longTouchKeyNum){				/* �г����� */

		if(longTouchKeyNum == 1){		/* ֻ��һ��������  */
			longTouchIntervalCnt++;
			if(longTouchIntervalCnt >= MPR121_MULTI_LONG_TOUCH_INTERVAL){  	/* һ������ά��300ms */
				longTouchIntervalCnt = 0;				
				mpr121_handle.keyWaitCnt[j] = 0;	
				
				if(mpr121_handle.longTouchKey){			/* ԭ�Ȼ��г�����������ʱ���ȹر�ԭ�ȵĳ���led��ʾ */
					mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* ����LED */
				}

				if(mpr121_handle.keylongTouchSlipLevel[j] == MPR121_LONG_TOUCH_INVALID){		/* ������������������Ч */
					mpr121_handle.longTouchSlipConfirm = j + 1;
					mpr121_handle.longTouchKey = 0;
				}else{
					mpr121_handle.longTouchKey = j + 1;				
				}
				mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[j] + 1;		/* ����LED */
				mpr121_handle.keyLEDStatus[j] = 3;									/* ����LED */
				mpr121_handle.keyLEDCnt[j] = 0;
				mpr121_handle.longTouchHoldCnt = 0;
				
			}
			
		}else{

			for(i = 0; i < MPR121_KEYPAD_NUMS; i++){			/* ���� */
				mpr121_handle.keyWaitCnt[i] = 0;	
			}
			if(mpr121_handle.longTouchKey){ 			/* ԭ�Ȼ��г�����������ʱ���ȹر�ԭ�ȵĳ���led��ʾ */
				mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* ����LED */			
				mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* ����LED */
			}
			mpr121_handle.longTouchKey = 0;
			mpr121_handle.longTouchHoldCnt = 0;
			longTouchIntervalCnt = 0;
		}

	}


}

/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
void MPR121_keyPad_slipPad_post_data(u8 cmd, u8 key, u8 value)
{

	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xEE;
	BLE_uart.txBuf[2] = sicp_get_message_id();
	BLE_uart.txBuf[3] = ns_host_meshid_H;
	BLE_uart.txBuf[4] = ns_host_meshid_L;
	BLE_uart.txBuf[5] = 7;
	BLE_uart.txBuf[6] = cmd;
	BLE_uart.txBuf[7] = key;
	BLE_uart.txBuf[8] = value;

	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}


/*-----------------------------------------------------------------------------
    ���滬��ֵ 
------------------------------------------------------------------------------*/
void MPR121_slipPad_or_longTouch_value_save(u8 which)
{
	if(which == 0){
		MEEPROM_WriteByte(EEPROM_NOKEY_SLIPPAD_VALUE, mpr121_handle.slipLevel);
	}else{
		which--;
		MEEPROM_WriteByte(EEPROM_KEY1_SLIPPAD_VALUE + which, mpr121_handle.keylongTouchSlipLevel[which]);
	}
}

/*-----------------------------------------------------------------------------
    �ϱ����������򻬶�����
------------------------------------------------------------------------------*/
void MPR121_keyPad_slipPad_post(void)
{
	u8	level = 0;
	u8	which = 0;
		
	/* �������� */
	if(mpr121_handle.keyComfirm){

		MPR121_keyPad_slipPad_post_data(0x35, mpr121_handle.keyComfirm, mpr121_handle.keyValue);

		mpr121_handle.keyComfirm = 0;
		mpr121_handle.keyValue = 0;
	
	}

	/* �������� */
	if(mpr121_handle.slipConfirm){
		
		if(mpr121_handle.slipConfirm == 0xff){			
			mpr121_handle.slipConfirm = 0;					
			level = mpr121_handle.slipLevel;
			which = 0;
		}else{	
			which = mpr121_handle.slipConfirm;
			mpr121_handle.slipConfirm--;
			level = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.slipConfirm];
			mpr121_handle.slipConfirm = BIT[mpr121_handle.slipConfirm];
		}
		MPR121_keyPad_slipPad_post_data(0x36, mpr121_handle.slipConfirm, level);
		mpr121_handle.slipConfirm = 0;
		
		MPR121_slipPad_or_longTouch_value_save(which);		/* �ȷ�����ɺ��ٽ��б��� */			
	}

}


/*-----------------------------------------------------------------------------
    ���������ȼ� 
------------------------------------------------------------------------------*/
void MPR121_slipPad_level_analyze(u8 slipPad)
{
	u8 i, num;

	num = 0;

	/* ����м�������ͬʱ���� */
	for(i = 0; i < MPR121_SLIPPAD_NUMS; i++){
		if((slipPad & BIT[i])){
			num++;
		}
	}

	if(num >= 3){			/* ��3������������ */
		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){			
			if((slipPad & BIT[i -1])){		
				mpr121_handle.slipValue = ((i -1) * 2) + 1;
				break;
			}
		}		
	}
	else if(num > 0){		/* 1��2������*/

		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){
			if((slipPad & BIT[i -1])){	
				if(i > 1){			/* ��������µ�һ������ */
					if((slipPad & BIT[i -2])){	/* ���������ڵİ���ͬʱ���£�ȥ�м��ֵ */
						mpr121_handle.slipValue = (i -1) * 2;
					}else{
						mpr121_handle.slipValue = ((i -1) * 2) + 1;
					}
				}else{
					mpr121_handle.slipValue = 1;
				}
				break;
			}
		}
	}
	else{

	}

}

/*-----------------------------------------------------------------------------
    �����������ͻ�����������
------------------------------------------------------------------------------*/
void MPR121_analyze(void)
{
	u8 i;

	/* ������������ */
	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){

		if((mpr121_handle.keyTouch.byte & BIT[i] ) && ((mpr121_handle.keyRelease & BIT[i]) == 0)){	/* ������ʼ��ѹ */ /* ע������ */
			if(mpr121_handle.longTouchSlipConfirm == 0){			/* ��������û������ */
				mpr121_handle.keyLEDStatus[i] = 1;
			}else{
				mpr121_handle.keyTouch.byte &= ~BIT[i];			/* ȡ�� */
			}		
		}
		else if(((mpr121_handle.keyTouch.byte & BIT[i]) == 0) && (mpr121_handle.keyRelease & BIT[i])){	/* �����ͷ� */ /* ע������ */

			if(mpr121_handle.longTouchSlipConfirm == 0){			/* ��������û������ */

				mpr121_handle.keyComfirm |= BIT[i];
				
				if(mpr121_handle.keyHoldCnt[i] < MPR121_KEYPAD_HOLD_CNT){	/* �̰� */	
					mpr121_handle.keyValue |= BIT[i];
					
					if(mpr121_handle.longTouchKey == i + 1){ 			/* �ð������������������ܣ���ȡ���ù��� */				
						mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* ����LED */
						mpr121_handle.longTouchKey = 0; 	
					}				
				}else{			/* ���� */
					mpr121_handle.keyWaitCnt[i] = 1;		/* ����������ʼ */
				}
				
				mpr121_handle.keyLEDStatus[i] = 2;			/* ����LED */
				mpr121_handle.keyLEDCnt[i] = 0;

			}else{				
				if((mpr121_handle.longTouchSlipConfirm -1) != i){					
					mpr121_handle.keyLEDStatus[i] = 0;			/* */
				}
			}

			mpr121_handle.keyHoldCnt[i] = 0;
			
		}else{			

		}
		
	}
	
	mpr121_handle.keyRelease = mpr121_handle.keyTouch.byte;

	/* ������������ */
	if((mpr121_handle.slipTouch.byte == 0) && (mpr121_handle.slipRelease != 0)){		/* �����ͷ� */
		MPR121_slipPad_level_analyze(mpr121_handle.slipRelease);

		if((mpr121_handle.slipValue < 1) || (mpr121_handle.slipValue > 9)){
			mpr121_handle.slipValue = 1;
		}		

		if(mpr121_handle.longTouchKey){			/* �г������� */
			mpr121_handle.slipConfirm = mpr121_handle.longTouchKey;
			mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchKey -1] = mpr121_handle.slipValue -1;
//			mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;				/* ����LED �ָ�ԭ����ֵ */
//			mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;		/* ����LED */

			mpr121_handle.keyLEDCnt[mpr121_handle.longTouchKey -1] = 0;			/* ���¿�ʼ�����������뻬��LED����һ�� */
			mpr121_handle.longTouchSlipConfirm = mpr121_handle.longTouchKey;
			mpr121_handle.longTouchHoldCnt = 0;
			mpr121_handle.longTouchKey = 0;
		}else{			
			mpr121_handle.slipConfirm = 0xff;
			mpr121_handle.slipLevel = mpr121_handle.slipValue -1;
		}
	}else{
		if(mpr121_handle.slipTouch.byte){			/* ���ڻ��� */
			MPR121_slipPad_level_analyze(mpr121_handle.slipTouch.byte);
		}
	}	
	mpr121_handle.slipRelease = mpr121_handle.slipTouch.byte;

	MPR121_keyPad_slipPad_post();

}


/*-----------------------------------------------------------------------------
    �������
------------------------------------------------------------------------------*/
void MPR121_detect(void)
{	
	if(MPR121_ISR_FLAG){			/* �а����ж� */
		
		MPR121_ISR_FLAG = 0;
		
		mpr121_handle.ts0.byte = 0;
		mpr121_handle.ts1.byte = 0;

		if(MPR121_ReadDataByte(ELE_TOUCH_STATUS1, &mpr121_handle.ts1.byte)){
				
			if(mpr121_handle.ts1.bit.ovcf){			/* over current was detected on REXT pin */

			}else{

				if(MPR121_ReadDataByte(ELE_TOUCH_STATUS0, &mpr121_handle.ts0.byte)){

//					MPR121_uart_send_until_finish(mpr121_handle.ts0.byte, mpr121_handle.ts1.byte);	/* test */

//					if(mpr121_handle.longTouchSlipConfirm == 0){			/* ��������û������ */

						mpr121_handle.keyTouch.bit.keyPad0 = mpr121_handle.ts1.bit.ele11;
						mpr121_handle.keyTouch.bit.keyPad1 = mpr121_handle.ts1.bit.ele10;
						mpr121_handle.keyTouch.bit.keyPad2 = mpr121_handle.ts1.bit.ele9;

						mpr121_handle.slipTouch.byte = mpr121_handle.ts0.byte & 0x1f;
						
//						MPR121_uart_send_until_finish(mpr121_handle.slipRelease, mpr121_handle.slipTouch.byte);	/* test */

						MPR121_analyze();
//					}

				}

			}
			
		}

	}

}

















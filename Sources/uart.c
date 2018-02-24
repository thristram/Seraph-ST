/**
  ******************************************************************************
  * @file    uart.c
  * @author  Seraph
  * @version  V1.0
  * @date     2017-03
  * @brief   This file contains the main function for STM8S003F3 timer operation.
**/


#define  _UART_GLOBAL

#include "stm8s_conf.h"
#include "main.h"
#include "uart.h"
#include "stdlib.h"
#include "stm8s_uart1.h"
#include <string.h>
#include "stm8s_flash.h"
#include "mpr121.h"

uart_frame_t BLE_uart = {0};


/*-----------------------------------------------------------------------------
  * @brief  check sum(cumulative sum)
  * @param  u8 *sendbuf,u8 length.
  * @retval u8 result
------------------------------------------------------------------------------*/
u8 Check_Sum(u8 *buf, u8 length)
{
	u8 i, result = *buf++;
	
	for(i = 1; i < length; i++){
		result ^= *buf++;
	}
	return result;
}

/*-----------------------------------------------------------------------------
    ble���ڳ�ʼ��
------------------------------------------------------------------------------*/
void BLE_uart_init(void)
{
	UART1_DeInit();
	/* ������115200��8λ����λ��1λֹͣλ����У��λ������ͬ��ģʽ��������պͷ��� */
	UART1_Init((u32)57600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	UART1_ITConfig(UART1_IT_TC, ENABLE);			/* ��������ж� */
	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);		/*���շǿ��ж� */
	UART1_Cmd(ENABLE);		/* ����uart1�ӿ� */
}



/*-----------------------------------------------------------------------------
    �������ͣ�uart2_send_cnt=0�������жϷ��ͽ���
------------------------------------------------------------------------------*/
void BLE_uart_send_until_finish(void)
{
	BLE_uart.txCnt = 1;
	BLE_uart.txLen = BLE_uart.txBuf[5] + 3;

	BLE_UART->DR = BLE_uart.txBuf[0];

	while(BLE_uart.txCnt);		//�ȴ����ͽ��� 
	
}


/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
@interrupt void BLE_UART_TX_ISR(void)
{
	/* In order to detect unexpected events during development,
	 it is recommended to set a breakpoint on the following instruction.
	*/
	
	BLE_UART->SR &= ~0x40;	//���������ɱ�־λ
	
	if (BLE_uart.txCnt < BLE_uart.txLen){
		
		BLE_UART->DR = BLE_uart.txBuf[BLE_uart.txCnt];
		BLE_uart.txCnt++;
		
	}else{			//�������
		
		BLE_uart.txLen = 0;
		BLE_uart.txCnt = 0;
	}
}

/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
@interrupt void BLE_UART_RX_ISR(void)
{
	u8 temp, i;
	u8 check_sum;

	temp = (u8)BLE_UART->DR;
	BLE_uart.rxBuf[BLE_uart.rxCnt] = temp;
	BLE_uart.rxCnt++;
	
	switch(BLE_uart.rxCnt)
	{
		case 1:
			if ((temp != 0xEE) && (temp != 0xDD))	BLE_uart.rxCnt = 0;
			break;
		case 2:
			if ((temp != 0xEE) && (temp != 0xDD) && (temp != 0xAA)) BLE_uart.rxCnt = 0;
			break;
		case 3:
			break;
		case 4:
			break;
		case 5:
			break;
		default:
			if (BLE_uart.rxCnt >= UART_BUF_LEN){			/* ��ֹ���մ������� */		
				BLE_uart.rxCnt = 0;
			}
			if ((BLE_uart.rxBuf[0] == 0xEE)&&((BLE_uart.rxBuf[1] == 0xEE) ||(BLE_uart.rxBuf[1] == 0xAA))){
				if (BLE_uart.rxCnt > BLE_uart.rxBuf[5] + 2){//�����������
									
					check_sum = Check_Sum((BLE_uart.rxBuf + 2), BLE_uart.rxBuf[5]);

					if (check_sum == BLE_uart.rxBuf[BLE_uart.rxBuf[5] + 2]){//У����ȷ
					
						if (rev_success == 0){		//ǰһ�������Ѵ������
						
							rev_success = 1;
							for (i = 0; i < BLE_uart.rxCnt; i++){
								sicp_buf[i] = BLE_uart.rxBuf[i];
							}
						}

					}
					BLE_uart.rxCnt = 0;
				}
				
			}
			else if((BLE_uart.rxBuf[0] == 0xDD) && (BLE_uart.rxBuf[1] == 0xDD)){
			
				if (BLE_uart.rxCnt > BLE_uart.rxBuf[3] + 2){	//�����������
				
					if (rev_success == 0){		//ǰһ�������Ѵ������
					
						rev_success = 1;
						for (i = 0; i < BLE_uart.rxCnt; i++){
						
							sicp_buf[i] = BLE_uart.rxBuf[i];
						}					
					
					}					
					BLE_uart.rxCnt = 0;
				}
			}
			else{
				BLE_uart.rxCnt = 0;
			}
			break;
		
	}
	
	if (BLE_UART->SR & 0x20) 
	{
		temp = BLE_UART->DR;
	}

}


/*-----------------------------------------------------------------------------
    0x35,�ϱ�û��Ԥ����ָ��İ���
------------------------------------------------------------------------------*/
void send_action_without_setted(u8 num, CTRL_TYPE type)
{
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xEE;
	BLE_uart.txBuf[2] = sicp_get_message_id();
	BLE_uart.txBuf[3] = ns_host_meshid_H;
	BLE_uart.txBuf[4] = ns_host_meshid_L;
	BLE_uart.txBuf[5] = 7;

	if(type == KEYPAD_CTRL){
		
		BLE_uart.txBuf[6] = 0x35;		//�������ǰ���
		BLE_uart.txBuf[7] = BIT[num];
		BLE_uart.txBuf[8] = st1.keypad[num].status;

	}

	if(type == GESTURE_CTRL){

		BLE_uart.txBuf[6] = 0x29;		//������������
		BLE_uart.txBuf[7] = st1.ges_h;
		BLE_uart.txBuf[8] = st1.ges_l;

	}
	
	BLE_uart.txBuf[9] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}



/*-----------------------------------------------------------------------------
	0x08, �첽֪ͨ���������Ƶȿ���ָ��	
------------------------------------------------------------------------------*/
void send_action_sync(u8 num, CTRL_TYPE type)
{
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xEE;
	BLE_uart.txBuf[2] = sicp_get_message_id();
	BLE_uart.txBuf[3] = ns_host_meshid_H;
	BLE_uart.txBuf[4] = ns_host_meshid_L;
	BLE_uart.txBuf[5] = 14;	
	BLE_uart.txBuf[6] = 0x08;	

	if(type == KEYPAD_CTRL){
		
		BLE_uart.txBuf[7] = 0x01;		//�������ǰ���
		BLE_uart.txBuf[8] = 0x00;
		BLE_uart.txBuf[9] = BIT[num];	
		BLE_uart.txBuf[10] = st1.keypad[num].meshid_h;
		BLE_uart.txBuf[11] = st1.keypad[num].meshid_l;
		BLE_uart.txBuf[12] = st1.keypad[num].action;
		BLE_uart.txBuf[13] = st1.keypad[num].boardid;
		BLE_uart.txBuf[14] = st1.keypad[num].status;
		BLE_uart.txBuf[15] = st1.keypad[num].time;
	}

	if(type == GESTURE_CTRL){

		BLE_uart.txBuf[7] = 0x02; 		//������������
		BLE_uart.txBuf[8] = st1.gesture[num].ges_h;
		BLE_uart.txBuf[9] = st1.gesture[num].ges_l;
		BLE_uart.txBuf[10] = st1.gesture[num].meshid_h;
		BLE_uart.txBuf[11] = st1.gesture[num].meshid_l;
		BLE_uart.txBuf[12] = st1.gesture[num].action;
		BLE_uart.txBuf[13] = st1.gesture[num].boardid;
		BLE_uart.txBuf[14] = st1.gesture[num].value;
		BLE_uart.txBuf[15] = st1.gesture[num].time;
	}

	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}


/*-----------------------------------------------------------------------------
    ���Ͱ�����ָ�� 
------------------------------------------------------------------------------*/
void send_action_ctrl(u8 num, CTRL_TYPE type)
{
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xEE;
	BLE_uart.txBuf[2] = sicp_get_message_id();

	if(type == KEYPAD_CTRL){
		BLE_uart.txBuf[3] = st1.keypad[num].meshid_h;
		BLE_uart.txBuf[4] = st1.keypad[num].meshid_l;
		BLE_uart.txBuf[5] = 8;
		BLE_uart.txBuf[6] = st1.keypad[num].action;
		BLE_uart.txBuf[7] = st1.keypad[num].boardid;
		BLE_uart.txBuf[8] = st1.keypad[num].status;
		BLE_uart.txBuf[9] = st1.keypad[num].time;

	}

	if(type == GESTURE_CTRL){

		BLE_uart.txBuf[3] = st1.gesture[num].meshid_h;
		BLE_uart.txBuf[4] = st1.gesture[num].meshid_l;
		BLE_uart.txBuf[5] = 8;
		BLE_uart.txBuf[6] = st1.gesture[num].action;
		BLE_uart.txBuf[7] = st1.gesture[num].boardid;
		BLE_uart.txBuf[8] = st1.gesture[num].value;	
		BLE_uart.txBuf[9] = st1.gesture[num].time;

	}

	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}




/*-----------------------------------------------------------------------------

------------------------------------------------------------------------------*/
void send_receipt(u8 msg_id, u8 meshid_h, u8 meshid_l, u8 type)
{
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xAA;
	BLE_uart.txBuf[2] = msg_id;
	BLE_uart.txBuf[3] = meshid_h;
	BLE_uart.txBuf[4] = meshid_l;
	BLE_uart.txBuf[5] = 10;	
	BLE_uart.txBuf[6] = 0xAA;	
	BLE_uart.txBuf[7] = type; 		
	
	if(type == 0x02 || type == 0x01 || type == 0x03){
		
		BLE_uart.txBuf[5] = 6;	

	}

	if(type == 0x05){		//����ɹ�ִ�в�����ģ��״̬
				
		BLE_uart.txBuf[8] = st1.keypad[0].status;
		BLE_uart.txBuf[9] = st1.keypad[1].status;
		BLE_uart.txBuf[10] = st1.keypad[2].status;
		BLE_uart.txBuf[11] = st1.st_led_status;

	}

	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}




/**
  * @brief  send_header_init
	* @param  none
  * @retval none
  */
void send_cmd_data(u8 msg_id, u8 meshid_h, u8 meshid_l, u8 type)
{	
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xAA;
	BLE_uart.txBuf[2] = msg_id;
	BLE_uart.txBuf[3] = meshid_h;
	BLE_uart.txBuf[4] = meshid_l;
	BLE_uart.txBuf[5] = 9;
	BLE_uart.txBuf[6] = type;

	if(type == 0x20){
		BLE_uart.txBuf[7] = st1.st_ambient_light;
		BLE_uart.txBuf[8] = st1.st_color_sense_L;
		BLE_uart.txBuf[9] = st1.st_color_sense_M;
		BLE_uart.txBuf[10] = st1.st_color_sense_H;

	}
	
	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
	
	BLE_uart_send_until_finish();

}



/*----------------------------------------------------------------------------
	һ�����ݷ������е���Ϣ
-----------------------------------------------------------------------------*/
void send_device_info_all(u8 type , u8 msg_id)
{
	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = type;
	BLE_uart.txBuf[2] = (type == 0xEE) ? sicp_get_message_id() : msg_id;
	BLE_uart.txBuf[3] = ns_host_meshid_H;
	BLE_uart.txBuf[4] = ns_host_meshid_L;
	BLE_uart.txBuf[5] = 12;	
	BLE_uart.txBuf[6] = 0xB4;

	BLE_uart.txBuf[7] = st1.deviceID[0];
	BLE_uart.txBuf[8] = st1.deviceID[1];
	BLE_uart.txBuf[9] = st1.deviceID[2];
	BLE_uart.txBuf[10] = st1.deviceID[3];
	BLE_uart.txBuf[11] = st1.model;				//�豸�ͺ�
	BLE_uart.txBuf[12] = st1.firmware_version;	
	BLE_uart.txBuf[13] = st1.HWTtest;

	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);

	BLE_uart_send_until_finish();

}

/*----------------------------------------------------------------------------
	�ϵ�60���û���ͣ�����������device info
	1sִ��һ��
	�з��ͷ���1���޷��ͷ���0
	����©��:��һ���ϵ�ʱmeshidΪ0����û�н��յ����صĹ㲥�����޷��Զ�����
-----------------------------------------------------------------------------*/
u8 send_device_info_active(void)
{
	static u16 counts = 0;
	u8 ret = 0;
	u8 waits = 60 + (ns_host_meshid_L & 0x0f);

	if(ns_host_meshid_H){			/* meshid ���� */

		counts++;
		
		if(counts >= waits){
			send_device_info_all(0xEE, 0);
			counts = 0;
			ret = 1;
		}
	}
	return ret;
	
}


/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
u8 get_gesture_num(u8 ges_h, u8 ges_l, GET_GESTURE_WAY way)
{
	u8 i, ret = GET_GESTURE_ERROR;

	//��ȡ�ѱ����λ�ã��ɹ������ѱ����λ�ã�ʧ�ܷ���GET_GESTURE_ERROR
	if(way == GET_SETTED_NUM){
		
		for(i = 0; i < GESTURE_NUMS; i++){

			if(st1.gesture[i].flag.bit.setted){		//������
				if((st1.gesture[i].ges_h == ges_h) && (st1.gesture[i].ges_l == ges_l)){		//������ͬ
					break;
				}				
			}	
		}
		ret = (i == GESTURE_NUMS) ? GET_GESTURE_ERROR : i;
	}

	
	//��ȡ���Ա����λ�ã��ɹ����ظ�λ�ã�ʧ�ܷ���GET_GESTURE_ERROR
	if(way == GET_SAVING_NUM){
		
		for(i = 0; i < GESTURE_NUMS; i++){

			if(st1.gesture[i].flag.bit.setted == 0){			//δ����
				break;
			}	
		}
		ret = (i == GESTURE_NUMS) ? GET_GESTURE_ERROR : i;
	}

	return ret;

}


/*----------------------------------------------------------------------------
	�������ص�meshid
-----------------------------------------------------------------------------*/
void host_meshid_save(u8 meshid_h, u8 meshid_l)
{
	/* mesh id ��ͬ */
	if((ns_host_meshid_H != meshid_h) || (ns_host_meshid_L != meshid_l)){
		
		ns_host_meshid_H = meshid_h;
		ns_host_meshid_L = meshid_l;
			
		MEEPROM_WriteByte(EEPROM_MESHID_H_ADDRESS, ns_host_meshid_H);
		MEEPROM_WriteByte(EEPROM_MESHID_L_ADDRESS, ns_host_meshid_L);

	}

}


/*----------------------------------------------------------------------------
	��� st1.keypad[].actural_val �Ƿ����ı�
	�ı��򱣴�
-----------------------------------------------------------------------------*/
void keypad_target_status_save(void)
{
	u8 i;

	for(i = 0; i < KEYPAY_NUMS; i++){

		if(st1.keypad[i].actural_val_bak != st1.keypad[i].actural_val){
			
			MEEPROM_WriteByte(EEPROM_CH1_TARGET_STATUS_ADDRESS + i, st1.keypad[i].actural_val);
			st1.keypad[i].actural_val_bak = st1.keypad[i].actural_val;
		}	
	}	
	
}


/*----------------------------------------------------------------------------
	��鰴�������ƵĶ����Ƿ����ı�
	�ı��򱣴�
-----------------------------------------------------------------------------*/
void keypad_or_gesture_save(u8 num, CTRL_TYPE type)
{

	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);

	if(type == KEYPAD_CTRL){

		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDH_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].meshid_h);
		
		if(st1.keypad[num].flag.bit.setted == 1){		//���ð�����������棬����ȡ��������ֻ����meshid_h����
			
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDL_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].meshid_l);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_ACTION_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].action);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_BOARDID_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].boardid);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_VALUE_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].value);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_TIME_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].time);
			
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS + num , st1.keypad[num].status);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_TARGET_STATUS_ADDRESS + num , st1.keypad[num].actural_val);

		}
	}

	if(type == GESTURE_CTRL){

		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].meshid_h);
		
		if(st1.gesture[num].flag.bit.setted == 1){		//����������������棬����ȡ��������ֻ����meshid_h����
			
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].meshid_l);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_ACTION_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].action);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_BOARDID_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].boardid);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_VALUE_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].value);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TIME_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].time);
			
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].ges_h);
			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].ges_l);
		
		}

	}

	FLASH_Lock(FLASH_MEMTYPE_DATA);
	
}



/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
void keypad_slipLevel_save(u8 level1, u8 level2)
{
	mpr121_handle.slipLevel = (level1 >> 4) & 0x0f;
	mpr121_handle.keylongTouchSlipLevel[0] = (level1 & 0x0f);
	mpr121_handle.keylongTouchSlipLevel[1] = (level2 >> 4) & 0x0f;
	mpr121_handle.keylongTouchSlipLevel[2] = (level2 & 0x0f);
	
	if(mpr121_handle.longTouchSlipConfirm){ 	/* �����������ܼ��ɹ�ʱ */
		mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchSlipConfirm -1] + 1;
	}else if(mpr121_handle.longTouchKey){
		mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchKey -1] + 1;
	}else{
		mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;
	}
	
	MPR121_slipPad_or_longTouch_value_save(0);
	MPR121_slipPad_or_longTouch_value_save(1);
	MPR121_slipPad_or_longTouch_value_save(2);
	MPR121_slipPad_or_longTouch_value_save(3);

}




/*----------------------------------------------------------------------------
	һ�����ݷ������е���Ϣ
-----------------------------------------------------------------------------*/
void recv_heart_beat(void)
{
//	st1.keypad[0].status = sicp_buf[8] ? 100 : 0;
//	st1.keypad[1].status = sicp_buf[9] ? 100 : 0;
//	st1.keypad[2].status = sicp_buf[10] ? 100 : 0;

//	st1.keypad[0].actural_val = sicp_buf[8];
//	st1.keypad[1].actural_val = sicp_buf[9];
//	st1.keypad[2].actural_val = sicp_buf[10];

//	BLE_uart.txBuf[0] = 0xEE;
//	BLE_uart.txBuf[1] = 0xAA;
//	BLE_uart.txBuf[2] = rev_message_id;
//	BLE_uart.txBuf[3] = rev_meshid_H;
//	BLE_uart.txBuf[4] = rev_meshid_L;
//	BLE_uart.txBuf[5] = 8;	
//	BLE_uart.txBuf[6] = 0x12;
//	
//	BLE_uart.txBuf[7] = st1.keypad[0].status;
//	BLE_uart.txBuf[8] = st1.keypad[1].status;
//	BLE_uart.txBuf[9] = st1.keypad[2].status;

	BLE_uart.txBuf[0] = 0xEE;
	BLE_uart.txBuf[1] = 0xAA;
	BLE_uart.txBuf[2] = rev_message_id;
	BLE_uart.txBuf[3] = rev_meshid_H;
	BLE_uart.txBuf[4] = rev_meshid_L;
	BLE_uart.txBuf[5] = 5;	
	BLE_uart.txBuf[6] = 0x12;
	
	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
	BLE_uart_send_until_finish();

}


/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
void recv_ble_ctrl(void)
{

	switch(sicp_buf[4])
	{
		case 0x01:	//����״̬֡
			ns_signal = sicp_buf[5];
			ns_status = sicp_buf[6];
			ns_phonenum = sicp_buf[7];
			ns_own_meshid_H = sicp_buf[8];
			ns_own_meshid_L = sicp_buf[9];
			break;
			
		case 0x02:	//����оƬ����մ��ڻ��棬����mesh����
			break;
			
		case 0x03:	//����оƬ�����磬�˳�mesh����

			break;
		default:
			break;
			
	}

}


/*-----------------------------------------------------------------------------
    
------------------------------------------------------------------------------*/
void recv_ble_data(void)
{
	u8 i, num, ret = 0x01, cmd = 0;

	switch(sicp_buf[6]){
		
		case 0x10:		/* ���� */ //heartbeat��ȡ��ǰ�豸״̬��Ϣ(�����ȣ����ص�)
			if(sicp_buf[7] == 0x01){			
				recv_heart_beat();
			}
			break;	
			
		case 0xAA:		/* ��ִ */
			if(sicp_buf[7] == 0x07){		//SS/SC�ظ�ST��������λreceipt_send_failed
			
			}
			break;
		case 0x37:		/* SSˢ��ST����ֵ  */
			send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 	

			keypad_slipLevel_save(sicp_buf[7], sicp_buf[8]);

			break;

		case 0xB0:		/* �豸�㲥 */	
			if(rev_message_id == 0){
										
				if((st1.deviceID[0] == sicp_buf[7]) && (st1.deviceID[1] == sicp_buf[8]) && 
					(st1.deviceID[2] == sicp_buf[9]) && (st1.deviceID[3] == sicp_buf[10])){
			
					host_meshid_save(rev_meshid_H, rev_meshid_L);
					rev_ssbroadcast = 1;
					send_device_info_all(0xAA, rev_message_id);
			
				}					
			}
			break;	
			
//		case 0x04:	//SS��ST����������Ϣ
//			cmd = sicp_buf[7];
//			if (cmd == 0x01){		//����ST��������
//			
//				num = sicp_buf[8] -1;				
//				if(num <= (KEYPAY_NUMS -1)){
//					
//					st1.keypad[num].meshid_h		= sicp_buf[10];
//					st1.keypad[num].meshid_l 		= sicp_buf[11];
//					st1.keypad[num].boardid 		= sicp_buf[12];
//					st1.keypad[num].action 		= sicp_buf[13];
//					st1.keypad[num].value 		= sicp_buf[14];
//					
//					st1.keypad[num].time			= 30;
//					st1.keypad[num].status		= 0;
//					st1.keypad[num].actural_val 	= 0;
//					st1.keypad[num].actural_val_bak= 0;
//					
//					st1.keypad[num].flag.bit.setted = 1;
//					
//				}else{
//					ret = 0x03;
//				}

//			}
//			else if (cmd == 0xf1){			//ȡ��ST��������

//				num = sicp_buf[8] - 1;				
//				if(num <= (KEYPAY_NUMS -1)){
//					
//					st1.keypad[num].meshid_h 		= 0;
//					st1.keypad[num].meshid_l 		= 0;
//					st1.keypad[num].boardid		= 0;
//					st1.keypad[num].action		= 0;
//					st1.keypad[num].value		= 0;
//					
//					st1.keypad[num].time 			= 0;
//					st1.keypad[num].status		= 0;
//					st1.keypad[num].actural_val	= 0;
//					st1.keypad[num].actural_val_bak= 0;
//					
//					st1.keypad[num].flag.bit.setted = 0;
//					
//				}else{
//					ret = 0x03;
//				}

//			}

//			else if (cmd == 0x02){			//����ST���ƶ���

//				num = get_gesture_num(sicp_buf[8], sicp_buf[9], GET_SETTED_NUM);			//�ж��Ƿ��ѱ������ͬ����
//				
//				if(num != GET_GESTURE_ERROR){		//����ͬ����

//				}else{						//û����ͬ����
//					num = get_gesture_num(sicp_buf[8], sicp_buf[9], GET_SAVING_NUM);		//�ж��Ƿ��п�λ�ñ���

//					if(num != GET_GESTURE_ERROR){	//��λ�ý��б���

//					}else{					//û��λ�ñ�����������
//						ret = 0x03;
//					}
//				}

//				if(num != GET_GESTURE_ERROR){		//��������
//				
//					st1.gesture[num].ges_h 	= sicp_buf[8];
//					st1.gesture[num].ges_l	= sicp_buf[9];
//					st1.gesture[num].meshid_h 	= sicp_buf[10];
//					st1.gesture[num].meshid_l	= sicp_buf[11];
//					st1.gesture[num].boardid	= sicp_buf[12];
//					st1.gesture[num].action	= sicp_buf[13];
//					st1.gesture[num].value	= sicp_buf[14];
//					
//					st1.gesture[num].time 	= 30;
//					
//					st1.gesture[num].flag.bit.setted = 1;	//���������ƶ���
//				}
//										
//			}
//			else if (cmd == 0xf2){			//ȡ��ST���ƶ���
//			
//				num = get_gesture_num(sicp_buf[8], sicp_buf[9], GET_SETTED_NUM);			//�ж��Ƿ��ѱ������ͬ����
//				
//				if(num != GET_GESTURE_ERROR){		//����ͬ����

//					st1.gesture[num].ges_h 	= 0;
//					st1.gesture[num].ges_l	= 0;
//					st1.gesture[num].meshid_h 	= 0;
//					st1.gesture[num].meshid_l	= 0;
//					st1.gesture[num].boardid	= 0;
//					st1.gesture[num].action	= 0;
//					st1.gesture[num].value	= 0;
//					
//					st1.gesture[num].time 	= 0;

//					st1.gesture[num].flag.bit.setted = 0;
//				}else{						//û����ͬ����
//					ret = 0x03;
//				}
//			}
//			else{
//				ret = 0x03;
//			}
//			
//			send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, ret);	

//			if(ret == 0x01){
//				keypad_or_gesture_save(num, (cmd & 0x01) ? KEYPAD_CTRL : GESTURE_CTRL);
//			}
//			break;
						
//		case 0x03:			//CMD-Data
//			if (sicp_buf[7] == 0x01) {	//��ȡST��������Ϣ
//			
//				if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32)){
//					send_cmd_data(rev_message_id, rev_meshid_H,rev_meshid_L, 0x20);
//				}
//			}
//			
//			if (sicp_buf[7] == 0x02) {	//ˢ��ST����������			
//				send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 				
//			}
//			break;
			
//		case 0x56:		//���� ST �������ؿ���״̬			
//			for(i = 0; i < KEYPAY_NUMS; i++){
//				if(sicp_buf[7] & BIT[i]){
//					st1.keypad[i].status = sicp_buf[8];					
//				}
//			}
//			send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x05);					
//			break;
			
//		case 0x09://LED����
//		
//			switch(sicp_buf[7]){
//				
//				case 0x1F://ѭ��ģʽ
//					st1.st_led_mode = 0x1F;
//					st1.st_led_density = sicp_buf[8];
//					st1.st_led_speed = sicp_buf[9];
//					st1.st_led_color1_H = sicp_buf[10];
//					st1.st_led_color1_M = sicp_buf[11];
//					st1.st_led_color1_L = sicp_buf[12];
//					st1.st_led_color2_H = sicp_buf[13];
//					st1.st_led_color2_M = sicp_buf[14];
//					st1.st_led_color2_L = sicp_buf[15];

//					send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 						
//					break;
//					
//				case 0x2F://������ģʽ
//					st1.st_led_mode = 0x2F;
//					st1.st_led_in		= sicp_buf[8];
//					st1.st_led_duration 	= sicp_buf[9];
//					st1.st_led_out		= sicp_buf[10];
//					st1.st_led_blank 	= sicp_buf[11];
//					st1.st_led_color1_H = sicp_buf[12];
//					st1.st_led_color1_M = sicp_buf[13];
//					st1.st_led_color1_L = sicp_buf[14];
//					st1.st_led_color2_H = sicp_buf[15];
//					st1.st_led_color2_M = sicp_buf[16];
//					st1.st_led_color2_L = sicp_buf[17];
//					
//					send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 	
//					break;
//					
//				case 0x3F://��ɫ�仯ģʽ����һ������ɫ�����ɫ�ٱ䵽��һ������ɫ
//					st1.st_led_mode = 0x3F;
//					st1.st_led_in		= sicp_buf[8];
//					st1.st_led_duration = sicp_buf[9];
//					st1.st_led_color1_H = sicp_buf[10];
//					st1.st_led_color1_M = sicp_buf[11];
//					st1.st_led_color1_L = sicp_buf[12];
//					st1.st_led_color2_H = sicp_buf[13];
//					st1.st_led_color2_M = sicp_buf[14];
//					st1.st_led_color2_L = sicp_buf[15];
//					
//					send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 	
//					break;
//					
//				case 0x4F://ָʾ��ģʽ����LED����ʾȨ�����豸
//					st1.st_led_mode = 0x4F;
//					
//					send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x02); 	
//					break;
//				case 0x5F:	//�ر�ģʽ���ر�����LED��ʾ
//					st1.st_led_mode = 0x5F;
//					send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x02); 	
//					break;
//					
//			}
//			break;
			
//		case 0x05:		//���ڼ���Ԥװ�ı�����Ϣ�����˷��������������� LED����	
//			st1.st_load_alert = sicp_buf[7];			
//			send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 	
//			break;
			
			
//		case 0xC0:					//BLE ����ģ������ָ��
//			break;


		default:
			break;
			
	}

		

	
}




/*-----------------------------------------------------------------------------
    recv_header_anaylze
------------------------------------------------------------------------------*/
BLE_DATA_FRAME recv_header_anaylze(u8 *msg_id, u8 *mesh_id_H, u8 *mesh_id_L, u8 *msg_len)
{
	BLE_DATA_FRAME ret = BLE_INVALID;

	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
	{
		ret = BLE_DATA_EE;
		*msg_id = sicp_buf[2];
		*mesh_id_H = sicp_buf[3];
		*mesh_id_L = sicp_buf[4];
		*msg_len = sicp_buf[5];
	}
	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))	//Network	Status	Reporting
	{
		ret = BLE_CTRL_DD;
		*msg_len = sicp_buf[3];
	}
	
	return ret; 

}


/*-----------------------------------------------------------------------------
    receive data analyze and reply
------------------------------------------------------------------------------*/
void recv_analyze_reply(void)
{
	u8 i;
	BLE_DATA_FRAME ret = BLE_INVALID;

	if (rev_success){
			
		ret = recv_header_anaylze(&rev_message_id, &rev_meshid_H, &rev_meshid_L, &BLE_uart.rxLen);
		
		if(ret == BLE_DATA_EE){
			
//			if(ns_own_meshid_H){				//���յ��Լ���meshid
//				if((rev_meshid_H == ns_own_meshid_H) && (rev_meshid_L == ns_own_meshid_H) ){		//�Լ����͵�����
//					return;
//				}
//			}	
			
			recv_ble_data();

		}else if(ret == BLE_CTRL_DD){
		
			recv_ble_ctrl();

		}

		rev_success = 0;
		
	}

}








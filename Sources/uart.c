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
#include "stm8s_uart2.h"
#include <string.h>

extern void Variable_Init(void);

/**
  * @brief  ��������� 1~255
  * @param  None.
  * @retval None
  */
u8 random(u8 xxx)  
{  
  u8 value,iii;  
  for(iii=0;iii<xxx;iii++)  
  {  
    value = rand() % (MAX + 1- MIN) + MIN; //��ȡһ�������1~255
	}  
  return value;  
} 


/**
  * @brief  initializion for uart1
  * @param  None.
  * @retval None
  */
void Init_uart2(void)
{
	UART2_DeInit();
	//������115200��8λ����λ��1λֹͣλ����У��λ������ͬ��ģʽ��������պͷ���
	UART2_Init((u32)57600,UART2_WORDLENGTH_8D,UART2_STOPBITS_1,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,	UART2_MODE_TXRX_ENABLE);
	UART2_ITConfig(UART2_IT_TC,ENABLE);//��������ж�
	UART2_ITConfig(UART2_IT_RXNE_OR,ENABLE);//���շǿ��ж�
	UART2_Cmd(ENABLE);//����uart1�ӿ�
}


/**
  * @brief  uart1 send data init
  * @param  none.
  * @retval None
  */
void UART2_Send_Data_Init(void)
{
	send_buf[0] = 0xAA;
	send_buf[1] = 0xAA;
	send_buf[2] = 0x11;
	send_buf[3] = 0x22;
	send_buf[4] = 13;	//֡ͷ��У���벻������
	send_buf[5] = 0x01;
	send_buf[6] = 0x02;
	send_buf[7] = 0x03;
	send_buf[8] = 0x04;
	send_buf[9] = 0x05;
	send_buf[10] = 0x06;
	send_buf[11] = 0x07;
	send_buf[12] = 0x08;
	send_buf[13] = 0x09;
	send_buf[14] = 0x0A;
	send_buf[15] = Check_Sum(send_buf,15);
	
}

/**
  * @brief  uart1 send data start
  * @param  none.
  * @retval None
  */
void UART2_Send_Data_Start(void)
{
	UART2->DR = send_buf[0];
	send_count = 1;
}


void clear_sicp_buf(void)
{
	u8 i;
	for (i=0;i<30;i++)
	{
		sicp_buf[i] = 0;
	}
}


void clear_send_buf(void)
{
	u8 i;
	for (i=0;i<30;i++)
	{
		send_buf[i] = 0;
	}
}


/**
  * @brief  uart2 tx isr
  * @param  none.
  * @retval None
  */
@interrupt void UART2_TX_ISR(void)
{
	/* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	UART2->SR &= ~0x40;//���������ɱ�־λ
	if (send_count < send_buf[5]+3)
	{
		UART2->DR = send_buf[send_count];
		send_count++;
	}
	else//�������
	{
		send_count = 0;
		rev_count = 0;
	}
}

/**
  * @brief  uart2 rx isr
  * @param  none.
  * @retval None
  */

@interrupt void UART2_RX_ISR(void)
{
	rev_deal();
}


/**
  * @brief  check sum(cumulative sum)
  * @param  u8 *sendbuf,u8 length.
  * @retval u8 result
  */
u8 Check_Sum(u8 *buf,u8 length)
{
	u8 i;
	u8 result = *buf++;
	for(i = 1;i < length;i++)
	{
		result ^= *buf++;
	}
	return result;
}

/**
  * @brief  receive data deal
  * @param  none
  * @retval none
  */
void rev_deal(void)
{
	u8 temp,temp2,i;
	u8 check_sum;
	temp = (u8)UART2->DR;
	rev_buf[rev_count] = temp;
	rev_count++;
	switch(rev_count)
	{
		case 1:
			if ((temp != 0xEE) && (temp != 0xDD))	rev_count = 0;
			break;
		case 2:
			if ((temp != 0xEE) && (temp != 0xDD) && (temp != 0xAA)) rev_count = 0;
			break;
		case 3:
			//if (!temp)				rev_count = 0;
			break;
		case 4:
			//if (!temp)				rev_count = 0;
			break;
		case 5:
			//if (!temp)				rev_count = 0;
			break;
		default:
			if (rev_count > 30)//��ֹ���մ�������
			{
				rev_count = 0;
			}
			if ((rev_buf[0] == 0xEE)&&((rev_buf[1] == 0xEE) ||(rev_buf[1] == 0xAA)))
			{
				if (rev_count > rev_buf[5] + 2)//�����������
				{
					rev_count = 0;
					check_sum = Check_Sum((rev_buf+2),rev_buf[5]);
					
					if (check_sum == rev_buf[rev_buf[5] + 2])//У����ȷ	
					{
						rev_success = 1;
						for (i = 0;i < 30;i++)
						{
							sicp_buf[i] = rev_buf[i];
						}
					}
					else
					{
						rev_count = 0;
					}
				}
			}
			else if((rev_buf[0] == 0xDD)&&(rev_buf[1] == 0xDD))
			{
				if (rev_count > rev_buf[3] + 2)//�����������
				{
					rev_count = 0;
					rev_success = 1;
					for (i = 0;i < 30;i++)
					{
						sicp_buf[i] = rev_buf[i];
					}
				}
			}
			else
			{
				rev_count = 0;
			}
			break;
	}
	if (UART2->SR & 0x20) //|| (UART2->SR & UART2_SR_OR))
	{
		temp2 = UART2->DR;
	}	
		/*
		if( UART2_GetITStatus(UART2_IT_RXNE) == SET)
		{
			temp2 = UART2_ReceiveData8();
		}
	
	if(UART2->SR & UART2_SR_OR)
	{
		UART2_ClearITPendingBit(UART2_IT_OR);
	}	
	*/
}

/**
  * @brief  ��ǰ��������Ƿ�ΪԤ����ָ������
						����gest1_confirm,gest2_confirm,gest3_confirm,gest4_confirm��ʾλ
	* @param  none
  * @retval none
  */
void gest_confirm(void)
{
	if ((st1.st_ges_H == st1.st_ges1_ctrl_H) && (st1.st_ges_L == st1.st_ges1_ctrl_L))
	{
		gest1_confirm = 1;
	}
	else
	{
		gest1_confirm = 0;
	}
	if ((st1.st_ges_H == st1.st_ges2_ctrl_H) && (st1.st_ges_L == st1.st_ges2_ctrl_L))
	{
		gest2_confirm = 1;
	}
	else
	{
		gest2_confirm = 0;
	}
	if ((st1.st_ges_H == st1.st_ges3_ctrl_H) && (st1.st_ges_L == st1.st_ges3_ctrl_L))
	{
		gest3_confirm = 1;
	}
	else
	{
		gest3_confirm = 0;
	}
	if((st1.st_ges_H == st1.st_ges4_ctrl_H) && (st1.st_ges_L == st1.st_ges4_ctrl_L))
	{
		gest4_confirm = 1;
	}
	else
	{
		gest4_confirm = 0;
	}
}

/**
  * @brief  ��ǰ���������Ƿ�ΪԤ���ð���
						����pad1_confirm,pad2_confirm,pad3_confirm��ʾλ
	* @param  none
  * @retval none
  */
void pad_confirm(void)
{
	if(st_pad1_ctrl)
	{
		if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
		{
			st_pad1_confirm = 1;
			st1.st_ctrl_address = 0x01;
		}
		else
		{
			st_pad1_confirm = 0;
			st1.st_ctrl_address = 0x00;
		}
	}

	if(st_pad2_ctrl)
	{
		if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
		{
			st_pad2_confirm = 1;
			st1.st_ctrl_address = 0x02;
		}
		else
		{
			st_pad2_confirm = 0;
			st1.st_ctrl_address = 0x00;
		}
	}
	if(st_pad3_ctrl)
	{
		if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
		{
			st_pad3_confirm = 1;
			st1.st_ctrl_address = 0x04;
		}
		else
		{
			st_pad3_confirm = 0;
			st1.st_ctrl_address = 0x00;
		}
	}
}
/*   A D D   N O D E   T O   U A R T   T X   S   L   L A S T   */
/*-------------------------------------------------------------------------
    �˺���������can1TxSLHead UartTxSLLast ֱ�Ӱ�
    ������Ϊͨ�õĺ���
    �������ɳ��룬��˻�������ͬʱ��ס����ͺ���    
-------------------------------------------------------------------------*/
int addNodeToUart2TxSLLast(char *psave, int length)
{
	int ret = -1;
	slnode_t * newNode;
	char *pdata;

	newNode = (slnode_t *)malloc(sizeof(slnode_t)); if(!newNode){ return -1;}
	/* 0A 0A */
	pdata = (char *)malloc(length); if(!pdata){free(newNode); return -1;}
	mutex2 = 1;
	if(newNode && pdata){
		newNode->next = NULL;
		newNode->len = (u16)length;	
		newNode->hasWrite = 0;
		memcpy(pdata, psave, length);
		//����?a��?��?��?psave��D��????����?��??��?a��?D��������??����?
		free(psave);
		//*(pdata+length) = 0x0a;
		//*(pdata+length+1)= 0x0a;
		newNode->data = pdata;
		mutex2 = 0;
		if(!uart2TxSLLast){	/* �������?2��?��??a??? */
			uart2TxSLHead = newNode;
			uart2TxSLLast = newNode;
			mutex2 = 0;
		}else{
			uart2TxSLLast->next = newNode;	/* add node */
			uart2TxSLLast = newNode;	/* new list end */
			mutex2 = 0;			
		}
		ret = 0;
	}	
	return ret;
}
/*   D E L E T E   N O D E   F R O M   C A N 1   T X   S   L   H E A D   */
/*-------------------------------------------------------------------------
        ������ͷɾ���ڵ�
-------------------------------------------------------------------------*/
int deleteNodeFromUart2TxSLHead(void)
{
	int ret = -1;
	slnode_t *newhead;

	if(uart2TxSLHead){	/* ����ͷ��Ϊ�� */	
		if(!uart2TxSLHead->next){	/* ����ͷ��nextΪ�գ���ֻ��һ���ڵ㣬����ͷ������β��ָ��ýڵ� */
			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
			free(uart2TxSLHead);
			uart2TxSLHead = NULL;
			uart2TxSLLast = NULL;
		}else{	/* ����ͷ��next��Ϊ�գ������������������ϵĽڵ� */
			newhead = uart2TxSLHead->next;
			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
			free(uart2TxSLHead);
			uart2TxSLHead = newhead;			
		}	
		ret = 0;
	}
	return ret;	
}

/**
  * @brief  send_header_init 
	* @param  none
  * @retval none
  */
void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len ,u8 cmd)
{
	send_buf[0] = 0xEE;
	send_buf[1] = 0xEE;
	send_buf[2] = id;
	send_buf[3] = mesh_id_H;
	send_buf[4] = mesh_id_L;
	send_buf[5] = len;
	
	switch(cmd)
	{
		case 0x20://�ظ�������ͻ�����ɫ
			send_buf[1] = 0xAA;
			send_buf[6] = cmd;
			send_buf[7] = st1.st_ambient_light;
			send_buf[8] = st1.st_color_sense_L;
			send_buf[9] = st1.st_color_sense_M;
			send_buf[10] = st1.st_color_sense_H;
			break;
		case 0x06://�ظ����������ظ�����LED,��3�����ؿ��ص�״̬
			send_buf[1] = 0xAA;
			send_buf[6] = cmd;
			send_buf[7] = 0x00;//ST Module ID��0x00
			send_buf[8] = 0x00;
			if ((st1.st_device_status & 0x08)==0x08)	send_buf[8] = st1.st_pad1_status;
			send_buf[9] = 0x00;
			if ((st1.st_device_status & 0x04)==0x04)	send_buf[9] = st1.st_pad2_status;
			send_buf[10] = 0x00;
			if ((st1.st_device_status & 0x02)==0x02)	send_buf[10]= st1.st_pad3_status;
			send_buf[11] = 0x00;
			if ((st1.st_device_status & 0x01)==0x01)	send_buf[11]= st1.st_led_status;
			break;
		case 0x29://ST�ϱ�������Ϣ
			send_buf[6] = cmd;
			send_buf[7] = st1.st_ges_H;
			send_buf[8] = st1.st_ges_L;
			send_buf[9] = 0x00;//ST Module ID ����
			break;
		case 0x35:
			send_buf[6] = cmd;
			if((st_pad1_ctrl) || (st_pad2_ctrl) || (st_pad3_ctrl)){
				if (st_pad1_ctrl)
				{
					send_buf[7] = 0x01;
					send_buf[8] = st1.st_pad1_status;
					break;
				}
				if (st_pad2_ctrl)
				{
					send_buf[7] = 0x02;
					send_buf[8] = st1.st_pad2_status;
					break;
				}
				if (st_pad3_ctrl)
				{
					send_buf[7] = 0x04;
					send_buf[8] = st1.st_pad3_status;
					break;
				}
			}
			else
				break;
		case 0xAA://���ͻ�ִ
			send_buf[1] = 0xAA;
		  if (action_ctrlpad_flag)
			{
				action_ctrlpad_flag = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x05;//����ɹ�ִ�в�����ģ��״̬
				send_buf[8] = st1.st_pad1_status;
				send_buf[9] = st1.st_pad2_status;
				send_buf[10] = st1.st_pad3_status;
				send_buf[11] = st1.st_led_status;
				
			}
			else if(led_ctrl_flag)
			{
				led_ctrl_flag = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x01;//����ָ��ִ�гɹ�
				if((st1.st_led_mode == 0x4F) ||	(st1.st_led_mode == 0x5F))
					send_buf[7] = 0x02;//����ɹ���������
			}
			else if(load_alert_flag)
			{
				load_alert_flag = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x01;//����ָ��ִ�гɹ�
			}
			else if (cmd_refresh_flag)
			{
				cmd_refresh_flag = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x01;//����ָ��ִ�гɹ�
			}
			else if(receipt_conf_pad1)
			{
				receipt_conf_pad1 = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x01;//����ָ��ִ�гɹ�
			}
			else if(receipt_conf_pad2)
			{
				receipt_conf_pad2 = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x03;//����ָ��ִ��ʧ��
			}
			else if(receipt_conf_gest1)
			{
				receipt_conf_gest1 = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x01;//����ָ��ִ�гɹ�
			}
			else if(receipt_conf_gest2)
			{
				receipt_conf_gest2 = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x03;//����ָ��ִ��ʧ��
			}
			else if(receipt_device_info2)
			{
				receipt_device_info2 = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x03;//����ָ��ִ��ʧ��
			}
			else if(receipt_host_mesh)
			{
				receipt_host_mesh = 0;
				send_buf[6] = cmd;
				send_buf[7] = 0x02;//����ָ����ճɹ�
			}
			break;
		case 0xB4://ST�ظ��豸��Ϣ
			send_buf[6] = cmd;
			send_buf[7] = 0xAA;//UUID
			send_buf[8] = 0x55;
			send_buf[9] = 0xAB;
			send_buf[10] = 0x70;
			send_buf[11] = 0x63;//�豸�ͺ�
			send_buf[12] = 0x00;//�̼��汾
			send_buf[13] = st1.st_device_status;
			break;
		case 0x0A://�㱨 Seraph����豸���� 
			send_buf[6] = cmd;
			send_buf[7] = 0xB4;
			send_buf[8] = st1.st_device_status;
			break;
		case 0x51://ST�������ж���Ҫ��SC ����ָ��	Ԥ��ֵָ������
		case 0x55:
			send_buf[6] = cmd;
			if(gest1_confirm)
			{
				send_buf[7] = st1.st_ges1_ctrl_boardid;
				send_buf[8] = st1.st_ges1_ctrl_action_value;
				send_buf[9] = 0x1E;
			}
			else if(gest2_confirm)
			{
				send_buf[7] = st1.st_ges2_ctrl_boardid;
				send_buf[8] = st1.st_ges2_ctrl_action_value;
				send_buf[9] = 0x1E;
			}
			else if(gest3_confirm)
			{
				send_buf[7] = st1.st_ges3_ctrl_boardid;
				send_buf[8] = st1.st_ges3_ctrl_action_value;
				send_buf[9] = 0x1E;
			}
			else if(gest4_confirm)
			{
				send_buf[7] = st1.st_ges4_ctrl_boardid;
				send_buf[8] = st1.st_ges4_ctrl_action_value;
				send_buf[9] = 0x1E;
			}
			if(st_pad1_confirm)
			{
				send_buf[7] = st1.st_pad1_ctrl_boardid;
				if(cmd == 0x51)	send_buf[8] = st1.st_pad1_ctrl_action_value;//˵���ǵ���
				else						send_buf[8] = st1.st_pad1_status;
				send_buf[9] = 0x1E;
				break;
			}
			else if(st_pad2_confirm)
			{
				send_buf[7] = st1.st_pad2_ctrl_boardid;
				if(cmd == 0x51)	send_buf[8] = st1.st_pad2_ctrl_action_value;//˵���ǵ���
				else						send_buf[8] = st1.st_pad2_status;
				send_buf[9] = 0x1E;
				break;
			}
			else if(st_pad3_confirm)
			{
				send_buf[7] = st1.st_pad3_ctrl_boardid;
				if(cmd == 0x51)	send_buf[8] = st1.st_pad3_ctrl_action_value;//˵���ǵ���
				else						send_buf[8] = st1.st_pad3_status;
				send_buf[9] = 0x1E;
				break;
			}
			
			break;
		case 0x08://ST�������첽�� SS ���ʹ�������ֵ���жϽ��
			send_buf[6] = cmd;
			if(gest1_confirm)
			{
				send_buf[7] = 0x02;//������������
				send_buf[8] = st1.st_ges1_ctrl_H;
				send_buf[9] = st1.st_ges1_ctrl_L;
				send_buf[10] = st1.st_ges1_ctrl_meshid_H;
				send_buf[11] = st1.st_ges1_ctrl_meshid_L;
				send_buf[12] = st1.st_ges1_ctrl_action;
				send_buf[13] = st1.st_ges1_ctrl_boardid;
				send_buf[14] = st1.st_ges1_ctrl_action_value;
				send_buf[15] = st1.st_ges1_ctrl_action_time;
			}
			else if(gest2_confirm)
			{
				send_buf[7] = 0x02;
				send_buf[8] = st1.st_ges2_ctrl_H;
				send_buf[9] = st1.st_ges2_ctrl_L;
				send_buf[10] = st1.st_ges2_ctrl_meshid_H;
				send_buf[11] = st1.st_ges2_ctrl_meshid_L;
				send_buf[12] = st1.st_ges2_ctrl_action;
				send_buf[13] = st1.st_ges2_ctrl_boardid;
				send_buf[14] = st1.st_ges2_ctrl_action_value;
				send_buf[15] = st1.st_ges2_ctrl_action_time;
			}
			else if(gest3_confirm)
			{
				send_buf[7] = 0x02;
				send_buf[8] = st1.st_ges3_ctrl_H;
				send_buf[9] = st1.st_ges3_ctrl_L;
				send_buf[10] = st1.st_ges3_ctrl_meshid_H;
				send_buf[11] = st1.st_ges3_ctrl_meshid_L;
				send_buf[12] = st1.st_ges3_ctrl_action;
				send_buf[13] = st1.st_ges3_ctrl_boardid;
				send_buf[14] = st1.st_ges3_ctrl_action_value;
				send_buf[15] = st1.st_ges3_ctrl_action_time;
			}
			else if(gest4_confirm)
			{
				send_buf[7] = 0x02;
				send_buf[8] = st1.st_ges4_ctrl_H;
				send_buf[9] = st1.st_ges4_ctrl_L;
				send_buf[10] = st1.st_ges4_ctrl_meshid_H;
				send_buf[11] = st1.st_ges4_ctrl_meshid_L;
				send_buf[12] = st1.st_ges4_ctrl_action;
				send_buf[13] = st1.st_ges4_ctrl_boardid;
				send_buf[14] = st1.st_ges4_ctrl_action_value;
				send_buf[15] = 0x00;
			}
			else if(st_pad1_confirm)
			{
				send_buf[7] = 0x01;//�������ǰ���
				send_buf[8] = 0x00;
				send_buf[9] = st1.st_ctrl_address;
				send_buf[10] = st1.st_pad1_ctrl_meshid_H;
				send_buf[11] = st1.st_pad1_ctrl_meshid_L;
				send_buf[12] = st1.st_pad1_ctrl_action;
				send_buf[13] = st1.st_pad1_ctrl_boardid;
				send_buf[14] = st1.st_pad1_status;
				send_buf[15] = 0x00;
			}
			else if(st_pad2_confirm)
			{
				send_buf[7] = 0x01;//�������ǰ���
				send_buf[8] = 0x00;
				send_buf[9] = st1.st_ctrl_address;
				send_buf[10] = st1.st_pad2_ctrl_meshid_H;
				send_buf[11] = st1.st_pad2_ctrl_meshid_L;
				send_buf[12] = st1.st_pad2_ctrl_action;
				send_buf[13] = st1.st_pad2_ctrl_boardid;
				send_buf[14] = st1.st_pad2_status;
				send_buf[15] = 0x00;
			}
			else if(st_pad3_confirm)
			{
				send_buf[7] = 0x01;//�������ǰ���
				send_buf[8] = 0x00;
				send_buf[9] = st1.st_ctrl_address;
				send_buf[10] = st1.st_pad3_ctrl_meshid_H;
				send_buf[11] = st1.st_pad3_ctrl_meshid_L;
				send_buf[12] = st1.st_pad3_ctrl_action;
				send_buf[13] = st1.st_pad3_ctrl_boardid;
				send_buf[14] = st1.st_pad3_status;
				send_buf[15] = 0x00;
			}
			break;
	}
	send_buf[len+2] = Check_Sum((send_buf+2),len);
	//addNodeToUart2TxSLLast(send_buf,len+3);
}

/**
  * @brief  send_payload_init 
	* @param  none
  * @retval none
  */
/*
void send_payload_init(u8 len,u8 cmd)
{
	
}
*/
/**
  * @brief  rev_header_anaylze
	* @param  none
  * @retval none
  */
void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length)
{
	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
	{
		ble_data_frame = 1;
		*message_id = sicp_buf[2];
		*mesh_id_H = sicp_buf[3];
		*mesh_id_L = sicp_buf[4];
		*message_length = sicp_buf[5];
		//return TRUE;
	}
	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))//Network	Status	Reporting	
	{
		ble_ctrl_frame = 1;
		*message_length = sicp_buf[3];
		//return TRUE;
	}
	//else
	//{
	//	return FALSE;
	//}
}

/**
  * @brief  rev_payload_anaylze
	* @param  none
  * @retval none
  */
bool rev_payload_anaylze(void)
{
	u8 action_ctrl_num = 0;
	if (ble_data_frame)
	{
		ble_data_frame = 0;
		switch(sicp_buf[6])
		{
			case 0x04://SS��ST����������Ϣ
				receipt_device_info1 = 1;
				//if (sicp_buf[2] == device_info_message_id)
				{
					if (sicp_buf[7] == 0x01)//����ST��������
					{
						kickout_flag = 0;
						net_reset_flag = 0;
						if (sicp_buf[8] == 1)//����ͨ��1
						{
							st1.st_pad1_ctrl_meshid_H = sicp_buf[10];
							st1.st_pad1_ctrl_meshid_L = sicp_buf[11];
							st1.st_pad1_ctrl_boardid 	= sicp_buf[12];
							st1.st_pad1_ctrl_action   = sicp_buf[13];
							st1.st_pad1_ctrl_action_value = sicp_buf[14];
							receipt_conf_pad1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if (sicp_buf[8] == 2)//����ͨ��2
						{
							st1.st_pad2_ctrl_meshid_H = sicp_buf[10];
							st1.st_pad2_ctrl_meshid_L = sicp_buf[11];
							st1.st_pad2_ctrl_boardid 	= sicp_buf[12];
							st1.st_pad2_ctrl_action   = sicp_buf[13];
							st1.st_pad2_ctrl_action_value = sicp_buf[14];
							receipt_conf_pad1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if (sicp_buf[8] == 3)//����ͨ��3
						{
							st1.st_pad3_ctrl_meshid_H = sicp_buf[10];
							st1.st_pad3_ctrl_meshid_L = sicp_buf[11];
							st1.st_pad3_ctrl_boardid 	= sicp_buf[12];
							st1.st_pad3_ctrl_action   = sicp_buf[13];
							st1.st_pad3_ctrl_action_value = sicp_buf[14];
							receipt_conf_pad1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else
						{
							receipt_conf_pad2 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						
					}
					else if (sicp_buf[7] == 0x02)//����ST��������
					{
						kickout_flag = 0;
						net_reset_flag = 0;
						
						if((st1.st_ges1_ctrl_H == 0x11) && (st1.st_ges1_ctrl_L == 0x11) && (sicp_buf[8] != st1.st_ges1_ctrl_H) && (sicp_buf[9] != st1.st_ges1_ctrl_L))//��һ��Ԥ��������
						{
							st1.st_ges1_ctrl_H						= sicp_buf[8];
							st1.st_ges1_ctrl_L						= sicp_buf[9];
							st1.st_ges1_ctrl_meshid_H 		= sicp_buf[10];
							st1.st_ges1_ctrl_meshid_L 		= sicp_buf[11];
							st1.st_ges1_ctrl_boardid 			= sicp_buf[12];
							st1.st_ges1_ctrl_action				= sicp_buf[13];
							st1.st_ges1_ctrl_action_value = sicp_buf[14];
							//gest_configed = 1;
							receipt_conf_gest1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if((st1.st_ges2_ctrl_H == 0x11) && (st1.st_ges2_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges2_ctrl_H) && (sicp_buf[9] != st1.st_ges2_ctrl_L))//�ڶ���Ԥ��������
						{
							st1.st_ges2_ctrl_H						= sicp_buf[8];
							st1.st_ges2_ctrl_L						= sicp_buf[9];
							st1.st_ges2_ctrl_meshid_H 		= sicp_buf[10];
							st1.st_ges2_ctrl_meshid_L 		= sicp_buf[11];
							st1.st_ges2_ctrl_boardid 			= sicp_buf[12];
							st1.st_ges2_ctrl_action				= sicp_buf[13];
							st1.st_ges2_ctrl_action_value = sicp_buf[14];
							//gest_configed = 1;
							receipt_conf_gest1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if((st1.st_ges3_ctrl_H == 0x11) && (st1.st_ges3_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges3_ctrl_H) && (sicp_buf[9] != st1.st_ges3_ctrl_L))//������Ԥ��������
						{
							st1.st_ges3_ctrl_H						= sicp_buf[8];
							st1.st_ges3_ctrl_L						= sicp_buf[9];
							st1.st_ges3_ctrl_meshid_H 		= sicp_buf[10];
							st1.st_ges3_ctrl_meshid_L 		= sicp_buf[11];
							st1.st_ges3_ctrl_boardid 			= sicp_buf[12];
							st1.st_ges3_ctrl_action				= sicp_buf[13];
							st1.st_ges3_ctrl_action_value = sicp_buf[14];
							//gest_configed = 1;
							receipt_conf_gest1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if((st1.st_ges4_ctrl_H == 0x11) && (st1.st_ges4_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges4_ctrl_H) && (sicp_buf[9] != st1.st_ges4_ctrl_L))//������Ԥ��������
						{
							st1.st_ges4_ctrl_H						= sicp_buf[8];
							st1.st_ges4_ctrl_L						= sicp_buf[9];
							st1.st_ges4_ctrl_meshid_H 		= sicp_buf[10];
							st1.st_ges4_ctrl_meshid_L 		= sicp_buf[11];
							st1.st_ges4_ctrl_boardid 			= sicp_buf[12];
							st1.st_ges4_ctrl_action				= sicp_buf[13];
							st1.st_ges4_ctrl_action_value = sicp_buf[14];
							//gest_configed = 1;
							receipt_conf_gest1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else if(((sicp_buf[8] == st1.st_ges1_ctrl_H) && (sicp_buf[9] == st1.st_ges1_ctrl_L))
										|| ((sicp_buf[8] == st1.st_ges2_ctrl_H) && (sicp_buf[9] == st1.st_ges2_ctrl_L))
										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L))
										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L)))
						{
							receipt_conf_gest1 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
						else
						{
							receipt_conf_gest2 = 1;
							send_message_length = 6;
							send_cmd = 0xAA;
							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
							UART2_Send_Data_Start();
							break;
						}
					}
				}
				break;
			case 0xAA://SS�ظ�ST��Device Info��Kick Out�߳�
				if (sicp_buf[7] == 0x04)
				{
					kickout_flag = 1;
				}
				break;
				if(sicp_buf[7] == 0x07)//SS/SC�ظ�ST��������λreceipt_send_failed
				{
					receipt_send_failed = 1;
					
				}
				break;
			case 0xC0://BLE ����ģ������ָ��
				if (sicp_buf[7] == 0x02)
				{
					net_reset_flag = 1;
				}
				break;
			case 0x03://CMD-Data 
				if (sicp_buf[7] == 0x01)//��ȡST��������Ϣ
				{
					if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32))
					{
						send_message_length = 9;
						send_cmd = 0x20;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						UART2_Send_Data_Start();
					}
				}
				if (sicp_buf[7] == 0x02)//ˢ��ST����������
				{
					cmd_refresh_flag = 1;
					send_message_length = 6;
					send_cmd = 0xAA;
					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
				}
				if (sicp_buf[7] == 0x03)//��ȡST��ǰ�豸��״̬(�����ȡ�����)
				{
					cmd_status_flag = 1;
					//rev_module_id = sicp_buf[8];
					send_message_length = 10;
					send_cmd = 0x06;
					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
				}
				break;
			case 0x56://�򿪻�ر�ST����
				action_ctrlpad_flag = 1;
				
				action_ctrl_address = st1.st_ctrl_address = sicp_buf[7];			
				if(((sicp_buf[7] & 0x01) == 0x01) && (st1.st_pad1_status != sicp_buf[8]))
					{st_pad1_ctrl = 1;st_pad1_confirm = 1;st1.st_pad1_status = sicp_buf[8];action_ctrl_num++;}
				if(((sicp_buf[7] & 0x02) == 0x02) && (st1.st_pad2_status != sicp_buf[8]))
					{st_pad2_ctrl = 1;st_pad2_confirm = 1;st1.st_pad2_status = sicp_buf[8];action_ctrl_num++;}
				if(((sicp_buf[7] & 0x04) == 0x04) && (st1.st_pad3_status != sicp_buf[8]))
					{st_pad3_ctrl = 1;st_pad3_confirm = 1;st1.st_pad3_status = sicp_buf[8];action_ctrl_num++;}
				if((sicp_buf[7] & 0x08) == 0x08)
					st_led_ctrl = 1;
				st1.st_ctrl_value  = sicp_buf[8];
				//send_message_length += (action_ctrl_num+1);//���ӷ���1���ֽڱ�ʾaction_ctrl_num
				send_message_length = 10;
				send_cmd = 0xAA;
				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				break;
			case 0x09://LED����
				led_ctrl_flag = 1;
				switch(sicp_buf[7])
				{
					case 0x1F://ѭ��ģʽ
						st1.st_led_mode = 0x1F;
						st1.st_led_density = sicp_buf[8];
						st1.st_led_speed = sicp_buf[9];
						st1.st_led_color1_H = sicp_buf[10];
						st1.st_led_color1_M = sicp_buf[11];
						st1.st_led_color1_L = sicp_buf[12];
						st1.st_led_color2_H = sicp_buf[13];
						st1.st_led_color2_M = sicp_buf[14];
						st1.st_led_color2_L = sicp_buf[15];
						send_message_length = 6;
						send_cmd = 0xAA;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						//send_payload_init(send_message_length,send_cmd);
						UART2_Send_Data_Start();
						break;
					case 0x2F://������ģʽ
						st1.st_led_mode = 0x2F;
						st1.st_led_in		= sicp_buf[8];
						st1.st_led_duration = sicp_buf[9];
						st1.st_led_out	= sicp_buf[10];
						st1.st_led_blank = sicp_buf[11];
						st1.st_led_color1_H = sicp_buf[12];
						st1.st_led_color1_M = sicp_buf[13];
						st1.st_led_color1_L = sicp_buf[14];
						st1.st_led_color2_H = sicp_buf[15];
						st1.st_led_color2_M = sicp_buf[16];
						st1.st_led_color2_L = sicp_buf[17];
						send_message_length = 6;
						send_cmd = 0xAA;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						//send_payload_init(send_message_length,send_cmd);
						UART2_Send_Data_Start();
						break;
					case 0x3F://��ɫ�仯ģʽ����һ������ɫ�����ɫ�ٱ䵽��һ������ɫ
						st1.st_led_mode = 0x3F;
						st1.st_led_in		= sicp_buf[8];
						st1.st_led_duration = sicp_buf[9];
						st1.st_led_color1_H = sicp_buf[10];
						st1.st_led_color1_M = sicp_buf[11];
						st1.st_led_color1_L = sicp_buf[12];
						st1.st_led_color2_H = sicp_buf[13];
						st1.st_led_color2_M = sicp_buf[14];
						st1.st_led_color2_L = sicp_buf[15];
						send_message_length = 6;
						send_cmd = 0xAA;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						//send_payload_init(send_message_length,send_cmd);
						UART2_Send_Data_Start();
						break;
					case 0x4F://ָʾ��ģʽ����LED����ʾȨ�����豸
						st1.st_led_mode = 0x4F;
						send_message_length = 6;
						send_cmd = 0xAA;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						//send_payload_init(send_message_length,send_cmd);
						UART2_Send_Data_Start();
						break;
					case 0x5F://�ر�ģʽ���ر�����LED��ʾ 
						st1.st_led_mode = 0x5F;
						send_message_length = 6;
						send_cmd = 0xAA;
						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						//send_payload_init(send_message_length,send_cmd);
						UART2_Send_Data_Start();
						break;
				}
				break;
			case 0x05://���ڼ���Ԥװ�ı�����Ϣ�����˷��������������� LED����
				load_alert_flag = 1;
				st1.st_load_alert = sicp_buf[7];
				send_message_length = 6;
				send_cmd = 0xAA;
				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				break;
			case 0xB0://Gateway	Mesh	ID	Broadcasting
				if(sicp_buf[2] == 0x9E){
					rev_host_mesh = 1;receipt_host_mesh = 1;
					ns_host_meshid_H = sicp_buf[3];
					ns_host_meshid_L = sicp_buf[4];
					send_message_length = 6;
					send_cmd = 0xAA;
					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
				}
				break;
			default:
				break;
		}
		
		return TRUE;
	}
	else if (ble_ctrl_frame)
	{
		ble_ctrl_frame = 0;
		switch(sicp_buf[4])
		{
			case 0x01://����״̬֡
				rev_bleheartbeat = 1;
				ns_signal = sicp_buf[5];
				ns_status = sicp_buf[6];
				ns_phonenum = sicp_buf[7];
				ns_own_meshid_H = sicp_buf[8];
				ns_own_meshid_L = sicp_buf[9];
				//ns_host_meshid_H = sicp_buf[10];
				//ns_host_meshid_L = sicp_buf[11];
				break;
			case 0x02://����оƬ����մ��ڻ��棬����mesh����
				Variable_Init();
				clear_sicp_buf();
				break;
			case 0x03://����оƬ�����磬�˳�mesh����
				Variable_Init();
				clear_sicp_buf();
				ns_signal = 0x00;
				ns_status = 0x00;
				ns_phonenum = 0x00;
				ns_own_meshid_H = 0x00;
				ns_own_meshid_L = 0x00;
				ns_host_meshid_H = 0x80;
				ns_host_meshid_L = 0xFF;
				break;
		}
		/*
		generate_messageid = 0x86;//for debug
		//generate_messageid = random(TIM4->CNTR);
		device_info_message_id = generate_messageid;
		//�Ѿ����䵽Mesh ID,��host mesh id��Ϊ0�DDevice Infoָ����Լ���������Ϣ
		if ((((u16)(ns_own_meshid_H<<8) + (u16)ns_own_meshid_L) > 0)
			&& (((u16)(ns_host_meshid_H<<8) + (u16)ns_host_meshid_L) > 0))
		{
			if (!receipt_device_info1)
			{
				
				//clear_sicp_buf();
				send_message_length = 12;
				send_cmd = 0xB4;
				send_header_payload_init(device_info_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				delay(10);
			}
		}
		else
		{
			receipt_device_info2 = 1;
			send_message_length = 6;
			send_cmd = 0xAA;
			send_header_payload_init(device_info_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
			UART2_Send_Data_Start();
			delay(10);
		}*/
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

/**
  * @brief  receive data analyze and reply������Task1ms()
	* @param  none
  * @retval none
  */
void reve_analyze_reply(void)
{
	if (rev_success)
	{
		rev_success = 0;
		rev_header_anaylze(&rev_message_id,&rev_meshid_H,&rev_meshid_L,&rev_message_length);
		rev_payload_anaylze();
	}
	
	/****************************************************
	����ST�������͵���������յ�AA 07��ִ��Ҫ���·���һ��
	*****************************************************/
	
	/***********׼����һ���ط�***********/
	if (receipt_send_failed)
	{
		receipt_send_failed = 0;
		st_pad1_ctrl = st_pad_temp._flag_bit.bit0;
		st_pad2_ctrl = st_pad_temp._flag_bit.bit1;
		st_pad3_ctrl = st_pad_temp._flag_bit.bit2;
		st_pad1_confirm = st_pad_temp._flag_bit.bit3;
		st_pad2_confirm = st_pad_temp._flag_bit.bit4;
		st_pad3_confirm = st_pad_temp._flag_bit.bit5;
	}
	/***********׼����һ���ط�***********/
	if (receipt_send_failed)
	{
		receipt_send_failed = 0;
		st1.st_ges_H = st1_st_ges_H_temp;
		st1.st_ges_L = st1_st_ges_L_temp;
	}
	
	if (st_pad1_ctrl | st_pad2_ctrl | st_pad3_ctrl)
	{
	//����⵽��������״̬�ı�ʱ������Ԥ��ֵ���������Ϳ���SCָ��,���ҷ����첽֪ͨ��SS
		if(st_pad1_confirm | st_pad2_confirm | st_pad3_confirm)
		{
			delay(200);
			st_pad_temp._flag_bit.bit0 = st_pad1_ctrl;
			st_pad_temp._flag_bit.bit1 = st_pad2_ctrl;
			st_pad_temp._flag_bit.bit2 = st_pad3_ctrl;
			st_pad_temp._flag_bit.bit3 = st_pad1_confirm;
			st_pad_temp._flag_bit.bit4 = st_pad2_confirm;
			st_pad_temp._flag_bit.bit5 = st_pad3_confirm;
			
				//generate_messageid = random(TIM4->CNTR);
				pad_set_message_id = 0x9F;//�̶�Ϊ0x9F
				
				
				if (st_pad1_confirm)//Ԥ���ð���1������
				{
					send_message_length = 8;
					send_cmd = st1.st_pad1_ctrl_action;
					st_pad1_ctrl = 0;
					send_header_payload_init(pad_set_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
					delay(200);
					//�����첽֪ͨ��SS
					clear_send_buf();
					send_message_length = 14;
					send_cmd = 0x08;
					if (st_pad1_confirm)//Ԥ���ð���1������
					{
						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						st_pad1_confirm = 0;
						UART2_Send_Data_Start();
						delay(200);
					}
				}
				if (st_pad2_confirm)
				{
					send_message_length = 8;
					send_cmd = st1.st_pad2_ctrl_action;
					st_pad2_ctrl = 0;
					send_header_payload_init(pad_set_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
					delay(200);
					//�����첽֪ͨ��SS
					clear_send_buf();
					send_message_length = 14;
					send_cmd = 0x08;
					if (st_pad2_confirm)
					{
						
						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						st_pad2_confirm = 0;
						UART2_Send_Data_Start();
						delay(200);
					}
					
				}
				if (st_pad3_confirm)
				{
					send_message_length = 8;
					send_cmd = st1.st_pad3_ctrl_action;
					st_pad3_ctrl = 0;
					send_header_payload_init(pad_set_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
					UART2_Send_Data_Start();
					delay(200);
					//�����첽֪ͨ��SS
					clear_send_buf();
					send_message_length = 14;
					send_cmd = 0x08;
					if(st_pad3_confirm)
					{
						
						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
						st_pad3_confirm = 0;
						UART2_Send_Data_Start();
						delay(200);
					}
				}

				
		}
		else//����⵽��������״̬�ı�ʱ��������Ԥ��ֵ��������ͨ����ָ���ϱ�����
		{
			generate_messageid = random(TIM4->CNTR);
			pad_noset_message_id = generate_messageid;
			send_message_length = 7;
			send_cmd = 0x35;
			if (st_pad1_ctrl)
			{
				
				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				st_pad1_ctrl = 0;
				UART2_Send_Data_Start();
				delay(200);
			}
			if (st_pad2_ctrl)
			{
				
				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				st_pad2_ctrl = 0;
				UART2_Send_Data_Start();
			delay(200);
			}
			if (st_pad3_ctrl)
			{
				
				send_header_payload_init(gesture_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
				st_pad3_ctrl = 0;
				UART2_Send_Data_Start();
				delay(200);
			}
			
		}
	}
	
	
	
	//��ST��⵽�����Ʋ�����Ԥ���õ�ָ������ƣ������������ǿ��ƣ�����ͨ���������ϱ�����
	if(gest_detect){
		gest_detect = 0;
		gest_confirm();
		if ((st1.st_ges_H != 0x00) && (st1.st_ges_L != 0x00))
		{
			st1_st_ges_H_temp = st1.st_ges_H;
			st1_st_ges_L_temp = st1.st_ges_L;
			
			
			if((!gest1_confirm) && (!gest2_confirm) && (!gest3_confirm) && (!gest4_confirm))
			{	
				receipt_gesture1 = 0;//������յ���ָ���ִ
				generate_messageid = random(TIM4->CNTR);
				gesture_noset_message_id = generate_messageid;
				
				send_message_length = 8;
				send_cmd = 0x29;
				send_header_payload_init(gesture_noset_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				delay(200);
				st1.st_ges_H = 0x00;
				st1.st_ges_L = 0x00;
			}
			else//��⵽��������Ԥ��ֵָ������ƣ�Asynchronous Action Notification
			{
				receipt_gesture2 = 0;//������յ���ָ���ִ
				generate_messageid = random(TIM4->CNTR);
				gesture_set_message_id = generate_messageid;
				send_message_length = 8;
				
				if (gest1_confirm)
				{
					send_cmd = st1.st_ges1_ctrl_action_value;
					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
				}
				else if (gest2_confirm)
				{
					send_cmd = st1.st_ges2_ctrl_action_value;
					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
				}
				else if (gest3_confirm)
				{
					send_cmd = st1.st_ges3_ctrl_action_value;
					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
				}
				else if (gest4_confirm)
				{
					send_cmd = st1.st_ges4_ctrl_action_value;
					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
				}
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				delay(200);
				
				
				clear_send_buf();
				send_message_length = 14;
				send_cmd = 0x08;
				if (gest1_confirm)
				{
					send_header_payload_init(gesture_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					gest1_confirm = 0;
				}
				else if (gest2_confirm)
				{
					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					gest2_confirm = 0;
				}
				else if (gest3_confirm)
				{
					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					gest3_confirm = 0;
				}
				else if (gest4_confirm)
				{
					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
					gest4_confirm = 0;
				}
				//send_payload_init(send_message_length,send_cmd);
				UART2_Send_Data_Start();
				delay(200);
				st1.st_ges_H = 0x00;
				st1.st_ges_L = 0x00;
			}
		}
	}
	
	
	//STM8S���߻��������������Ϸ���Malfunction Command
	if ((st1.st_device_status & 0xFF) < 0xFF)//ST�й���,��0��1
	{
		send_fault_count++;
		if (send_fault_count >= 500)
		{
			send_fault_count = 0;
			generate_messageid = random(TIM4->CNTR);
			send_message_length = 7;
			send_cmd = 0x0A;
			send_header_payload_init(generate_messageid,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
			//send_payload_init(send_message_length,send_cmd);
			UART2_Send_Data_Start();
		}
	}
}
#ifndef __UART_H
#define __UART_H

#ifndef _UART_GLOBAL
#define UART_EXT	extern
#else
#define UART_EXT
#endif



#define 	BLE_UART		(UART1)





/* �����б� */
typedef struct slnode_t{

	struct slnode_t *next;

	u16 len;		/* data�����ݳ��� */
	u16 hasWrite;	/* data�Ѿ����͵����ݳ��� */
	char *data;

} slnode_t;

UART_EXT u8 mutex2;
/* uart���͵������SingleList�ı�ͷ */
UART_EXT slnode_t *uart2TxSLHead;

/* uart���͵������SingleList�ı�β */
UART_EXT slnode_t *uart2TxSLLast;


typedef enum
{

	BLE_DATA_EE = 1,
	BLE_CTRL_DD,
	BLE_INVALID

}BLE_DATA_FRAME;


typedef enum
{
	KEYPAD_CTRL = 1,	
	GESTURE_CTRL
	
}CTRL_TYPE;





typedef union{
	
	u8 byte;
	struct{
	        u8 detected:1;		//��������
	        u8 setted:1;		//�����ѱ������˶���
	        u8 bit2:1;
	        u8 bit3:1;
	        u8 bit4:1;
	        u8 bit5:1;
	        u8 bit6:1;
	        u8 bit7:1;

  	}bit;
	
} keypad_flag;



#define KEYPAY_NUMS	3	

typedef struct
{
	keypad_flag 	flag;			//��־ 
	u8 	cnt;					//100ms����
	
	u8 	status;			//����״̬��0�� 100��

	u8 	actural_val;		//Ŀ���豸ʵ��ֵ
	u8 	actural_val_bak;	//Ŀ���豸ʵ��ֵ���ݣ������жϸ�ֵ�Ƿ����ı�

	u8 	meshid_h;		//3������
	u8 	meshid_l;		//����1����mesh id
	u8 	boardid;		//����1����board id
	u8 	action; 			//����action 
	u8 	value;		//����
	u8 	time;		//ʱ��
	
}keypad_t;	




typedef union{
	
	u8 byte;
	struct{
	        u8 detected:1;		//��������
	        u8 setted:1;		//�����ѱ������˶���
	        u8 bit2:1;
	        u8 bit3:1;
	        u8 bit4:1;
	        u8 bit5:1;
	        u8 bit6:1;
	        u8 bit7:1;

  	}bit;
	
} gesture_flag;



#define GESTURE_NUMS			4	

#define GET_GESTURE_ERROR	0xff	

typedef struct
{
	gesture_flag 	flag;			//��־ 

	u8 	cnt;					//100ms����
	
	u8 	ges_h;			//���ƶ���
	u8 	ges_l;
	u8 	meshid_h;		//3������
	u8 	meshid_l;		//����1����mesh id
	u8 	boardid;		//����1����board id
	u8 	action; 			//����action 
	u8 	value;		//����
	u8 	time;		//ʱ��
	
}gesture_t;	



typedef enum
{
	GET_SETTED_NUM = 1,		//��ȡ�ѱ����λ��
	GET_SAVING_NUM		//��ȡ��һ����λ�ã��������������õĶ���
	
}GET_GESTURE_WAY;	



typedef struct
{

	u8 				deviceID[4];
	
	u8				scanDevFlag;	//ɨ���豸�ı�־

	u8				model;		//�豸�ͺ�
	
	u8				firmware_version;
	u8				HW_version;

	u8				manaYear;
	u8				manaMonth;
	u8				manaDay;

	u16				bash;		//�������κ�
	u16				meshID;
	u16				GATTmeshID;

	char				coord[10];//�豸�ڷ����λ��
				
	u8				HWTtest;//������Ϣ�����sidp��6��

	u8 st_load_alert;	//����IDΪst_load_alert�ı���Ԥ����Ϣ

	u8 ges_led_ctrl;		/* ����LED��ʾ 1,��⵽һ������  0xff�����Ƽ����ɣ���������  */
	volatile u8 ges_cnt;		//��ǰ��⵽�ڼ�������
	volatile u8 ges_timer;	//�ӵ�һ�����ƿ�ʼ��ʱ��ÿ�̶�ʱ������һ�����ƣ�ÿ100ms��һ��
	volatile u8 ges_h;		//��ǰ��⵽���Ƹ�8λ
	volatile u8 ges_l;		//��ǰ��⵽���Ƶ�8λ

	keypad_t keypad[KEYPAY_NUMS];

	gesture_t gesture[GESTURE_NUMS];


	u8 st_led_status;		//���ذ�״̬��LED״̬,���Ȱٷ���

	u8 st_ambient_light;		//������
	u8 st_color_sense_H;		//������ɫ
	u8 st_color_sense_M;
	u8 st_color_sense_L;
	
	u8 st_led_mode;	//LEDģʽ
	u8 st_led_density;	//LED������ɫʱ��ms
	u8 st_led_speed;	//LED����ɫͣ��ʱ��
	u8 st_led_color1_H;//LED����ɫ1
	u8 st_led_color1_M;
	u8 st_led_color1_L;
	u8 st_led_color2_H;//LED����ɫ2
	u8 st_led_color2_M;
	u8 st_led_color2_L;
	u8 st_led_in;		//�ڽ��������ɫ��ʱ�䣬��λ10ms	
	u8 st_led_duration;//����ɫͣ����ʱ�䣬��λ10ms
	u8 st_led_out;		//����ɫ�����ɫ��ʱ�䣬��λ10ms	
	u8 st_led_blank;		//�ں�ɫͣ����ʱ�䣬��λ10ms	

	
	
}ST_Module;



UART_EXT union  FLAG 		UART1Flag1_;
#define UART1Flag 				UART1Flag1_._flag_byte;
#define rev_success			UART1Flag1_._flag_bit.bit0



UART_EXT union  FLAG 		UART1Flag4_;
#define UART4Flag 				UART1Flag4_._flag_byte;
#define report_fault_flag 		UART1Flag4_._flag_bit.bit4	//�㱨Seraph����豸���� 
#define st_led_ctrl				UART1Flag4_._flag_bit.bit0	//SS����Actionָ���LED
#define rev_ssbroadcast			UART1Flag4_._flag_bit.bit1




/**
**�յ�AA 07ʱ�ط���
*/
UART_EXT u8 st1_st_ges_H_temp;	//����ST���ƴ���ʱ������ֵ��������յ�AA 07�ظ�����Ӹû�����ȡֵ�ط�
UART_EXT u8 st1_st_ges_L_temp;
UART_EXT union  FLAG st_pad_temp; //����ST���ƴ���ʱ�İ���ֵ��������յ�AA 07�ظ�����Ӹû�����ȡֵ�ط�



UART_EXT ST_Module st1;


/*
**����״̬����
*/
UART_EXT u8 	ns_signal;//network status signal�ź�ǿ��
UART_EXT u8 	ns_status;//����״̬��0xFF,0x01~0x05
UART_EXT u8 	ns_phonenum;//�����ֻ�����
UART_EXT u8		ns_own_meshid_H;//����Mesh ID
UART_EXT u8		ns_own_meshid_L;
UART_EXT u8		ns_host_meshid_H;//����Mesh ID
UART_EXT u8		ns_host_meshid_L;

UART_EXT u8 rev_message_id;	//������յ���message id
UART_EXT u8 rev_meshid_H;
UART_EXT u8 rev_meshid_L;

UART_EXT u16 send_fault_count;//ST��⵽���Ϸ��ʹ�,ÿ�뷢1��
UART_EXT u16 send_failed_count;//�յ�SS/SC����ʧ��ָ��,ÿ�� �ط�1��


#define UART_BUF_LEN		32

UART_EXT u8 sicp_buf[UART_BUF_LEN];


typedef struct
{
	u8 txLen;			/* �����ֽ����� */
	u8 txCnt;			/* �����ֽڼ�����ͬʱ������0ʱ��־���������ڷ��� */
	
	u8 rxCnt;			/* �����ж��õ��Ľ��ռ��� */
	u8 rxLen;			/* �����ֽ����� */

	u8 rxBuf[UART_BUF_LEN];			/* ���ջ��� */
	u8 txBuf[UART_BUF_LEN];			/* ���ͻ��� */

	
}uart_frame_t;	

extern uart_frame_t BLE_uart;



u8 Check_Sum(u8 *buf, u8 length);

void BLE_uart_init(void);
void BLE_uart_send_until_finish(void);


@interrupt void BLE_UART_TX_ISR(void);
@interrupt void BLE_UART_RX_ISR(void);
 void recv_analyze_reply(void);


void send_cmd_data(u8 msg_id, u8 meshid_h, u8 meshid_l, u8 type);


void recv_heart_beat(void);

u8 get_gesture_num(u8 ges_h, u8 ges_l, GET_GESTURE_WAY way);

void send_action_without_setted(u8 num, CTRL_TYPE type);
void send_action_ctrl(u8 num, CTRL_TYPE type);
void send_action_sync(u8 num, CTRL_TYPE type);

void send_device_info_all(u8 type , u8 msg_id);
u8 send_device_info_active(void);





#endif

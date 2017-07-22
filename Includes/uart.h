#ifndef __UART_H
#define __UART_H

#ifndef _UART_GLOBAL
#define UART_EXT	extern
#else
#define UART_EXT
#endif

#define MAX              255             //��������ֵ  
#define MIN              1              //�������Сֵ 


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


typedef struct
{
	u8 st_ges_H;//��ǰ��⵽���Ƹ�8λ
	u8 st_ges_L;//��ǰ��⵽���Ƶ�8λ
	u8 st_device_status;	//bit7 STM8S,bit6 CSR1010,bit5 APDS9960,bit4 strip LED,bit3 Back LED,bit2 Touch3,bit1 Touch2,bit0 Touch0ָʾ���ϣ���Ϊ0����Ϊ1
	u8 st_ctrl_address;	//���ذ��ַ��bit3����LED,bit2���ؿ���3,bit1���ؿ���2,bit0���ؿ���1
	u8 st_ctrl_value;		//SS����0x56�޸Ĵ��ذ�״ֵ̬
	u8 st_led_status;		//���ذ�״̬��LED״̬,���Ȱٷ���
	u8 st_pad1_status;		//���ؿ���1״̬��0��99��100����
	u8 st_pad2_status;
	u8 st_pad3_status;
	u8 st_ambient_light;	//������
	u8 st_color_sense_H;		//������ɫ
	u8 st_color_sense_M;
	u8 st_color_sense_L;
	u8 st_pad1_ctrl_meshid_H;//3������
	u8 st_pad1_ctrl_meshid_L;//����1����mesh id
	u8 st_pad1_ctrl_boardid;	//����1����board id
	u8 st_pad1_ctrl_action;	//����action 
	u8 st_pad1_ctrl_action_value;//����
	u8 st_pad2_ctrl_meshid_H;
	u8 st_pad2_ctrl_meshid_L;
	u8 st_pad2_ctrl_boardid;
	u8 st_pad2_ctrl_action;	//����action 
	u8 st_pad2_ctrl_action_value;//����
	u8 st_pad3_ctrl_meshid_H;
	u8 st_pad3_ctrl_meshid_L;
	u8 st_pad3_ctrl_boardid;
	u8 st_pad3_ctrl_action;	//����action 
	u8 st_pad3_ctrl_action_value;//����
	u8 st_ges1_ctrl_H;
	u8 st_ges1_ctrl_L;
	u8 st_ges1_ctrl_meshid_H;//Ԥ��4������
	u8 st_ges1_ctrl_meshid_L;
	u8 st_ges1_ctrl_boardid;
	u8 st_ges2_ctrl_H;
	u8 st_ges2_ctrl_L;
	u8 st_ges2_ctrl_meshid_H;
	u8 st_ges2_ctrl_meshid_L;
	u8 st_ges2_ctrl_boardid;
	u8 st_ges3_ctrl_H;
	u8 st_ges3_ctrl_L;
	u8 st_ges3_ctrl_meshid_H;
	u8 st_ges3_ctrl_meshid_L;
	u8 st_ges3_ctrl_boardid;
	u8 st_ges4_ctrl_H;
	u8 st_ges4_ctrl_L;
	u8 st_ges4_ctrl_meshid_H;
	u8 st_ges4_ctrl_meshid_L;
	u8 st_ges4_ctrl_boardid;
	u8 st_ges1_ctrl_action;	//����action
	u8 st_ges1_ctrl_action_value;//����
	u8 st_ges1_ctrl_action_time;	//ʱ��
	u8 st_ges2_ctrl_action;	//ͨ��
	u8 st_ges2_ctrl_action_value;//����
	u8 st_ges2_ctrl_action_time;	//����ʱ��
	u8 st_ges3_ctrl_action;	//ͨ��
	u8 st_ges3_ctrl_action_value;//����
	u8 st_ges3_ctrl_action_time;	//����ʱ��
	u8 st_ges4_ctrl_action;	//ͨ��
	u8 st_ges4_ctrl_action_value;//����
	u8 st_ges4_ctrl_action_time;	//����ʱ��
	u8 st_led_mode;//LEDģʽ
	u8 st_led_density;//LED������ɫʱ��ms
	u8 st_led_speed;//LED����ɫͣ��ʱ��
	u8 st_led_color1_H;//LED����ɫ1
	u8 st_led_color1_M;
	u8 st_led_color1_L;
	u8 st_led_color2_H;//LED����ɫ2
	u8 st_led_color2_M;
	u8 st_led_color2_L;
	u8 st_led_in;//�ڽ��������ɫ��ʱ�䣬��λ10ms	
	u8 st_led_duration;//����ɫͣ����ʱ�䣬��λ10ms
	u8 st_led_out;//����ɫ�����ɫ��ʱ�䣬��λ10ms	
	u8 st_led_blank;//�ں�ɫͣ����ʱ�䣬��λ10ms	
	u8 st_load_alert;//����IDΪst_load_alert�ı���Ԥ����Ϣ
}ST_Module;

typedef struct
{
	u8 slc_device_status;//bit7 STM8S,bit6 CSR1010,bit2 Dimmer3,bit1 Dimmer2,bit0 Dimmer1
}SLC_Module;

typedef struct
{
	u8 spc_device_status;//bit7 STM8S,bit6 CSR1010,bit3 ACS712,bit2 LED,bit1 Switch2,bit0 Switch1
}SPC_Module;

typedef struct
{
	u8 sc_device_status;//bit7 STM8S,bit6 CSR1010
	u8 slc_address;//bit7~bit4�ڼ���ģ��,bit2������3,bit1������2,bit0������1
	SLC_Module slc[15];//sc����15��slc
	u8 spc_address;//bit7~bit4�ڼ���ģ��,bit2����LED,bit1��������2,bit0��������1
	SPC_Module spc[15];//sc����15��spc	
}SC_Module;



UART_EXT union  FLAG 				UART1Flag1_;
#define UART1Flag 					UART1Flag1_._flag_byte;
#define rev_success					UART1Flag1_._flag_bit.bit0
#define cmd_data_flag				UART1Flag1_._flag_bit.bit1//��ȡST����������
#define cmd_refresh_flag		UART1Flag1_._flag_bit.bit2//ˢ��ST����������
#define cmd_status_flag			UART1Flag1_._flag_bit.bit3//��ȡST��ǰ�豸״̬
#define action_ctrlpad_flag	UART1Flag1_._flag_bit.bit4//ST�򿪻�ر�ST����
#define ble_data_frame			UART1Flag1_._flag_bit.bit5//�յ�BLE����֡,֡ͷ0xEE 0xEE
#define ble_ctrl_frame			UART1Flag1_._flag_bit.bit6//�յ�BLE����֡��֡ͷ0xDD,0xDD
#define rev_bleheartbeat		UART1Flag1_._flag_bit.bit7//���յ�1010������

UART_EXT union  FLAG 			UART1Flag2_;
#define UART2Flag 				UART1Flag2_._flag_byte;
#define gest_detect				UART1Flag2_._flag_bit.bit0//��⵽�����������Ʊ�־
#define near_detect				UART1Flag2_._flag_bit.bit1//��⵽�ӽ����Ʊ�־
#define gest1_confirm			UART1Flag2_._flag_bit.bit2//��⵽Ԥ����ָ������1
#define gest2_confirm			UART1Flag2_._flag_bit.bit3//��⵽Ԥ����ָ������1
#define gest3_confirm			UART1Flag2_._flag_bit.bit4//��⵽Ԥ����ָ������1
#define gest4_confirm			UART1Flag2_._flag_bit.bit5//��⵽Ԥ����ָ������1
//#define gest_configed			UART1Flag2_._flag_bit.bit6//�Ѿ���������
#define rev_host_mesh			UART1Flag2_._flag_bit.bit6

UART_EXT union  FLAG 			UART1Flag3_;
#define UART3Flag 				UART1Flag3_._flag_byte;
#define st_led_ctrl				UART1Flag3_._flag_bit.bit0//SS����Actionָ���LED
#define st_pad1_ctrl			UART1Flag3_._flag_bit.bit1//SS����ACtionָ��򿪴��ؿ���1
#define st_pad2_ctrl			UART1Flag3_._flag_bit.bit2//SS����ACtionָ��򿪴��ؿ���2
#define st_pad3_ctrl			UART1Flag3_._flag_bit.bit3//SS����ACtionָ��򿪴��ؿ���3
#define st_pad1_confirm		UART1Flag3_._flag_bit.bit4//��⵽Ԥ���ð���1������
#define st_pad2_confirm		UART1Flag3_._flag_bit.bit5//��⵽Ԥ���ð���1������
#define st_pad3_confirm		UART1Flag3_._flag_bit.bit6//��⵽Ԥ���ð���1������


UART_EXT union  FLAG 			UART1Flag4_;
#define UART4Flag 				UART1Flag4_._flag_byte;
#define kickout_flag			UART1Flag4_._flag_bit.bit0//ST��Device Info��SS�󣬼���Mesh����ʧ�ܣ����ػظ�AA 04
#define net_reset_flag		UART1Flag4_._flag_bit.bit1//�����ж������豸���Ϸ�ʱ���ͣ�ģ����յ��Զ��˳��� Mesh ���� 
#define led_ctrl_flag			UART1Flag4_._flag_bit.bit2//���յ�LEDָ���־
#define load_alert_flag   UART1Flag4_._flag_bit.bit3//����Ԥ�豨����Ϣ��־
#define report_fault_flag UART1Flag4_._flag_bit.bit4//�㱨Seraph����豸���� 

/*
**ST���ͣ����ж��Ƿ���յ���ִ
**Device Info
**��⵽����
*/
UART_EXT union  FLAG 					UART1Flag5_;
#define UART5Flag 						UART1Flag5_._flag_byte;
#define receipt_device_info1	UART1Flag5_._flag_bit.bit0//ST�յ�SS����״̬֡�ظ�Device Info��ִ
#define receipt_device_info2  UART1Flag5_._flag_bit.bit1//ST�յ�SS����״̬֡����mesh id���󣬻ظ�AA 03
#define receipt_gesture1			UART1Flag5_._flag_bit.bit2//ST�ϱ���Ԥ����ָ������Ƹ����أ��յ���ִ
#define receipt_gesture2			UART1Flag5_._flag_bit.bit3//ST����0x51����ָ���SC���յ���ִ
#define receipt_action_notify	UART1Flag5_._flag_bit.bit4//ST����0x08�첽֪ͨ��SS,�յ���ִ
#define receipt_send_failed		UART1Flag5_._flag_bit.bit5//ST����ʧ�ܣ�SS�ظ��������ط�
#define receipt_conf_pad1			UART1Flag5_._flag_bit.bit6//SS����ST����1\2\3��SC���ͻ�ִAA 01
#define receipt_conf_pad2			UART1Flag5_._flag_bit.bit7//SS����ST�����������ǰ���1\2\3��SC���ͻ�ִAA 03

UART_EXT union  FLAG 					UART1Flag6_;
#define UART6Flag 						UART1Flag6_._flag_byte;
#define receipt_conf_gest1		UART1Flag6_._flag_bit.bit0//SS����ST����1\2\3\4��SC���ͻ�ִAA 01
#define receipt_conf_gest2		UART1Flag6_._flag_bit.bit1//SS����ST����,����������1��2��3��4,SC���ͻ�ִAA 03
#define receipt_host_mesh			UART1Flag6_._flag_bit.bit2
/**
**�յ�AA 07ʱ�ط���
*/
UART_EXT u8 st1_st_ges_H_temp;
UART_EXT u8 st1_st_ges_L_temp;
UART_EXT union  FLAG st_pad_temp;

UART_EXT ST_Module st1;
UART_EXT u8 device_info_message_id;	//ST����Device Info����SS��message id
UART_EXT u8 gesture_noset_message_id;		//ST���ͷ�Ԥ���õ�ָ�������message id
UART_EXT u8 gesture_set_message_id;		//ST����Ԥ���õ�ָ�������message id
UART_EXT u8 pad_noset_message_id;			//ST���ͷ�Ԥ���ð���ָ��message id��SS
UART_EXT u8 pad_set_message_id;			//ST����Ԥ���ð���ָ��message id��SC
UART_EXT u8 action_notify_message_id;//ST����action_notify����SS��message id

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

UART_EXT u8 rev_message_id;
UART_EXT u8 rev_module_id;
UART_EXT u8 rev_message_length;
UART_EXT u8 rev_meshid_H;
UART_EXT u8 rev_meshid_L;
UART_EXT u8 send_message_length;
UART_EXT u8 send_cmd;
UART_EXT u8 send_meshid_H;
UART_EXT u8 send_meshid_L;
UART_EXT u8 generate_messageid;
UART_EXT u8 send_count;
UART_EXT u8 rev_count;
UART_EXT u16 send_fault_count;//ST��⵽���Ϸ��ʹ�,ÿ�뷢1��
UART_EXT u16 send_failed_count;//�յ�SS/SC����ʧ��ָ��,ÿ�� �ط�1��
UART_EXT u8 send_buf[30];
UART_EXT u8 rev_buf[30];
UART_EXT u8 sicp_buf[30];

UART_EXT u8 action_ctrl_address;

UART_EXT int addNodeToUart2TxSLLast(char *psave, int length);
UART_EXT int deleteNodeFromUart2TxSLHead(void);


UART_EXT void Init_uart2(void);
@interrupt void UART2_TX_ISR(void);
@interrupt void UART2_RX_ISR(void);
UART_EXT void UART2_Send_Data_Init(void);
UART_EXT void UART2_Send_Data_Start(void);
UART_EXT void clear_sicp_buf(void);
UART_EXT void clear_send_buf(void);
UART_EXT u8 Check_Sum(u8 *buf,u8 length);
UART_EXT void rev_deal(void);
UART_EXT u8 random(u8 xxx); 
UART_EXT void reve_analyze_reply(void);
UART_EXT void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len,u8 cmd);
UART_EXT void send_payload_init(u8 len,u8 cmd);
UART_EXT void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length);
UART_EXT bool rev_payload_anaylze(void);

UART_EXT void pad_confirm(void);
UART_EXT void gest_confirm(void);


#endif
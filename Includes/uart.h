#ifndef __UART_H
#define __UART_H

#ifndef _UART_GLOBAL
#define UART_EXT	extern
#else
#define UART_EXT
#endif



#define 	BLE_UART		(UART1)





/* 单向列表 */
typedef struct slnode_t{

	struct slnode_t *next;

	u16 len;		/* data的数据长度 */
	u16 hasWrite;	/* data已经发送的数据长度 */
	char *data;

} slnode_t;

UART_EXT u8 mutex2;
/* uart发送单项队列SingleList的表头 */
UART_EXT slnode_t *uart2TxSLHead;

/* uart发送单项队列SingleList的表尾 */
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
	        u8 detected:1;		//按键触发
	        u8 setted:1;		//按键已被设置了动作
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
	keypad_flag 	flag;			//标志 
	u8 	cnt;					//100ms计数
	
	u8 	status;			//触控状态，0关 100开

	u8 	actural_val;		//目标设备实际值
	u8 	actural_val_bak;	//目标设备实际值备份，用以判断该值是否发生改变

	u8 	meshid_h;		//3个按键
	u8 	meshid_l;		//按键1控制mesh id
	u8 	boardid;		//按键1控制board id
	u8 	action; 			//调光action 
	u8 	value;		//亮度
	u8 	time;		//时间
	
}keypad_t;	




typedef union{
	
	u8 byte;
	struct{
	        u8 detected:1;		//按键触发
	        u8 setted:1;		//按键已被设置了动作
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
	gesture_flag 	flag;			//标志 

	u8 	cnt;					//100ms计数
	
	u8 	ges_h;			//手势动作
	u8 	ges_l;
	u8 	meshid_h;		//3个按键
	u8 	meshid_l;		//按键1控制mesh id
	u8 	boardid;		//按键1控制board id
	u8 	action; 			//调光action 
	u8 	value;		//亮度
	u8 	time;		//时间
	
}gesture_t;	



typedef enum
{
	GET_SETTED_NUM = 1,		//获取已保存的位置
	GET_SAVING_NUM		//获取第一个空位置，来保存手势设置的动作
	
}GET_GESTURE_WAY;	



typedef struct
{

	u8 				deviceID[4];
	
	u8				scanDevFlag;	//扫描设备的标志

	u8				model;		//设备型号
	
	u8				firmware_version;
	u8				HW_version;

	u8				manaYear;
	u8				manaMonth;
	u8				manaDay;

	u16				bash;		//生产批次号
	u16				meshID;
	u16				GATTmeshID;

	char				coord[10];//设备在房间的位置
				
	u8				HWTtest;//故障信息，详见sidp第6点

	u8 st_load_alert;	//加载ID为st_load_alert的报警预设信息

	u8 ges_led_ctrl;		/* 控制LED显示 1,检测到一次手势  0xff，手势检测完成，保持三秒  */
	volatile u8 ges_cnt;		//当前检测到第几个手势
	volatile u8 ges_timer;	//从第一个手势开始计时，每固定时间清零一次手势，每100ms加一次
	volatile u8 ges_h;		//当前检测到手势高8位
	volatile u8 ges_l;		//当前检测到手势低8位

	keypad_t keypad[KEYPAY_NUMS];

	gesture_t gesture[GESTURE_NUMS];


	u8 st_led_status;		//触控板状态，LED状态,亮度百分制

	u8 st_ambient_light;		//环境光
	u8 st_color_sense_H;		//环境颜色
	u8 st_color_sense_M;
	u8 st_color_sense_L;
	
	u8 st_led_mode;	//LED模式
	u8 st_led_density;	//LED渐变颜色时间ms
	u8 st_led_speed;	//LED主颜色停留时间
	u8 st_led_color1_H;//LED主颜色1
	u8 st_led_color1_M;
	u8 st_led_color1_L;
	u8 st_led_color2_H;//LED主颜色2
	u8 st_led_color2_M;
	u8 st_led_color2_L;
	u8 st_led_in;		//黑渐变进主颜色的时间，单位10ms	
	u8 st_led_duration;//主颜色停留的时间，单位10ms
	u8 st_led_out;		//主颜色进入黑色的时间，单位10ms	
	u8 st_led_blank;		//在黑色停留的时间，单位10ms	

	
	
}ST_Module;



UART_EXT union  FLAG 		UART1Flag1_;
#define UART1Flag 				UART1Flag1_._flag_byte;
#define rev_success			UART1Flag1_._flag_bit.bit0



UART_EXT union  FLAG 		UART1Flag4_;
#define UART4Flag 				UART1Flag4_._flag_byte;
#define report_fault_flag 		UART1Flag4_._flag_bit.bit4	//汇报Seraph相关设备故障 
#define st_led_ctrl				UART1Flag4_._flag_bit.bit0	//SS发送Action指令打开LED
#define rev_ssbroadcast			UART1Flag4_._flag_bit.bit1




/**
**收到AA 07时重发用
*/
UART_EXT u8 st1_st_ges_H_temp;	//缓存ST手势触发时的手势值，如果接收到AA 07回复，则从该缓存中取值重发
UART_EXT u8 st1_st_ges_L_temp;
UART_EXT union  FLAG st_pad_temp; //缓存ST手势触发时的按键值，如果接收到AA 07回复，则从该缓存中取值重发



UART_EXT ST_Module st1;


/*
**网络状态缓存
*/
UART_EXT u8 	ns_signal;//network status signal信号强度
UART_EXT u8 	ns_status;//连接状态，0xFF,0x01~0x05
UART_EXT u8 	ns_phonenum;//连接手机数量
UART_EXT u8		ns_own_meshid_H;//本机Mesh ID
UART_EXT u8		ns_own_meshid_L;
UART_EXT u8		ns_host_meshid_H;//网关Mesh ID
UART_EXT u8		ns_host_meshid_L;

UART_EXT u8 rev_message_id;	//保存接收到的message id
UART_EXT u8 rev_meshid_H;
UART_EXT u8 rev_meshid_L;

UART_EXT u16 send_fault_count;//ST检测到故障发送错,每秒发1次
UART_EXT u16 send_failed_count;//收到SS/SC发送失败指令,每秒 重发1次


#define UART_BUF_LEN		32

UART_EXT u8 sicp_buf[UART_BUF_LEN];


typedef struct
{
	u8 txLen;			/* 发送字节总数 */
	u8 txCnt;			/* 发送字节计数，同时，大于0时标志有数据正在发送 */
	
	u8 rxCnt;			/* 接收中断用到的接收计数 */
	u8 rxLen;			/* 接收字节总数 */

	u8 rxBuf[UART_BUF_LEN];			/* 接收缓存 */
	u8 txBuf[UART_BUF_LEN];			/* 发送缓存 */

	
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

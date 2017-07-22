#ifndef __UART_H
#define __UART_H

#ifndef _UART_GLOBAL
#define UART_EXT	extern
#else
#define UART_EXT
#endif

#define MAX              255             //随机数最大值  
#define MIN              1              //随机数最小值 


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


typedef struct
{
	u8 st_ges_H;//当前检测到手势高8位
	u8 st_ges_L;//当前检测到手势低8位
	u8 st_device_status;	//bit7 STM8S,bit6 CSR1010,bit5 APDS9960,bit4 strip LED,bit3 Back LED,bit2 Touch3,bit1 Touch2,bit0 Touch0指示故障，有为0，无为1
	u8 st_ctrl_address;	//触控板编址，bit3背光LED,bit2触控开关3,bit1触控开关2,bit0触控开关1
	u8 st_ctrl_value;		//SS发送0x56修改触控板状态值
	u8 st_led_status;		//触控板状态，LED状态,亮度百分制
	u8 st_pad1_status;		//触控开关1状态，0关99开100长按
	u8 st_pad2_status;
	u8 st_pad3_status;
	u8 st_ambient_light;	//环境光
	u8 st_color_sense_H;		//环境颜色
	u8 st_color_sense_M;
	u8 st_color_sense_L;
	u8 st_pad1_ctrl_meshid_H;//3个按键
	u8 st_pad1_ctrl_meshid_L;//按键1控制mesh id
	u8 st_pad1_ctrl_boardid;	//按键1控制board id
	u8 st_pad1_ctrl_action;	//调光action 
	u8 st_pad1_ctrl_action_value;//亮度
	u8 st_pad2_ctrl_meshid_H;
	u8 st_pad2_ctrl_meshid_L;
	u8 st_pad2_ctrl_boardid;
	u8 st_pad2_ctrl_action;	//调光action 
	u8 st_pad2_ctrl_action_value;//亮度
	u8 st_pad3_ctrl_meshid_H;
	u8 st_pad3_ctrl_meshid_L;
	u8 st_pad3_ctrl_boardid;
	u8 st_pad3_ctrl_action;	//调光action 
	u8 st_pad3_ctrl_action_value;//亮度
	u8 st_ges1_ctrl_H;
	u8 st_ges1_ctrl_L;
	u8 st_ges1_ctrl_meshid_H;//预设4个手势
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
	u8 st_ges1_ctrl_action;	//调光action
	u8 st_ges1_ctrl_action_value;//亮度
	u8 st_ges1_ctrl_action_time;	//时间
	u8 st_ges2_ctrl_action;	//通道
	u8 st_ges2_ctrl_action_value;//亮度
	u8 st_ges2_ctrl_action_time;	//调光时间
	u8 st_ges3_ctrl_action;	//通道
	u8 st_ges3_ctrl_action_value;//亮度
	u8 st_ges3_ctrl_action_time;	//调光时间
	u8 st_ges4_ctrl_action;	//通道
	u8 st_ges4_ctrl_action_value;//亮度
	u8 st_ges4_ctrl_action_time;	//调光时间
	u8 st_led_mode;//LED模式
	u8 st_led_density;//LED渐变颜色时间ms
	u8 st_led_speed;//LED主颜色停留时间
	u8 st_led_color1_H;//LED主颜色1
	u8 st_led_color1_M;
	u8 st_led_color1_L;
	u8 st_led_color2_H;//LED主颜色2
	u8 st_led_color2_M;
	u8 st_led_color2_L;
	u8 st_led_in;//黑渐变进主颜色的时间，单位10ms	
	u8 st_led_duration;//主颜色停留的时间，单位10ms
	u8 st_led_out;//主颜色进入黑色的时间，单位10ms	
	u8 st_led_blank;//在黑色停留的时间，单位10ms	
	u8 st_load_alert;//加载ID为st_load_alert的报警预设信息
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
	u8 slc_address;//bit7~bit4第几个模块,bit2调光器3,bit1调光器2,bit0调光器1
	SLC_Module slc[15];//sc最多带15个slc
	u8 spc_address;//bit7~bit4第几个模块,bit2背光LED,bit1插销开关2,bit0插销开关1
	SPC_Module spc[15];//sc最多带15个spc	
}SC_Module;



UART_EXT union  FLAG 				UART1Flag1_;
#define UART1Flag 					UART1Flag1_._flag_byte;
#define rev_success					UART1Flag1_._flag_bit.bit0
#define cmd_data_flag				UART1Flag1_._flag_bit.bit1//获取ST传感器数据
#define cmd_refresh_flag		UART1Flag1_._flag_bit.bit2//刷新ST传感器数据
#define cmd_status_flag			UART1Flag1_._flag_bit.bit3//获取ST当前设备状态
#define action_ctrlpad_flag	UART1Flag1_._flag_bit.bit4//ST打开或关闭ST开关
#define ble_data_frame			UART1Flag1_._flag_bit.bit5//收到BLE数据帧,帧头0xEE 0xEE
#define ble_ctrl_frame			UART1Flag1_._flag_bit.bit6//收到BLE控制帧，帧头0xDD,0xDD
#define rev_bleheartbeat		UART1Flag1_._flag_bit.bit7//接收到1010心跳包

UART_EXT union  FLAG 			UART1Flag2_;
#define UART2Flag 				UART1Flag2_._flag_byte;
#define gest_detect				UART1Flag2_._flag_bit.bit0//检测到上下左右手势标志
#define near_detect				UART1Flag2_._flag_bit.bit1//检测到接近手势标志
#define gest1_confirm			UART1Flag2_._flag_bit.bit2//检测到预设置指令手势1
#define gest2_confirm			UART1Flag2_._flag_bit.bit3//检测到预设置指令手势1
#define gest3_confirm			UART1Flag2_._flag_bit.bit4//检测到预设置指令手势1
#define gest4_confirm			UART1Flag2_._flag_bit.bit5//检测到预设置指令手势1
//#define gest_configed			UART1Flag2_._flag_bit.bit6//已经配置手势
#define rev_host_mesh			UART1Flag2_._flag_bit.bit6

UART_EXT union  FLAG 			UART1Flag3_;
#define UART3Flag 				UART1Flag3_._flag_byte;
#define st_led_ctrl				UART1Flag3_._flag_bit.bit0//SS发送Action指令打开LED
#define st_pad1_ctrl			UART1Flag3_._flag_bit.bit1//SS发送ACtion指令打开触控开关1
#define st_pad2_ctrl			UART1Flag3_._flag_bit.bit2//SS发送ACtion指令打开触控开关2
#define st_pad3_ctrl			UART1Flag3_._flag_bit.bit3//SS发送ACtion指令打开触控开关3
#define st_pad1_confirm		UART1Flag3_._flag_bit.bit4//检测到预设置按键1被触发
#define st_pad2_confirm		UART1Flag3_._flag_bit.bit5//检测到预设置按键1被触发
#define st_pad3_confirm		UART1Flag3_._flag_bit.bit6//检测到预设置按键1被触发


UART_EXT union  FLAG 			UART1Flag4_;
#define UART4Flag 				UART1Flag4_._flag_byte;
#define kickout_flag			UART1Flag4_._flag_bit.bit0//ST发Device Info给SS后，加入Mesh网络失败，网关回复AA 04
#define net_reset_flag		UART1Flag4_._flag_bit.bit1//网关判断连接设备不合法时发送，模块接收到自动退出该 Mesh 网络 
#define led_ctrl_flag			UART1Flag4_._flag_bit.bit2//接收到LED指令标志
#define load_alert_flag   UART1Flag4_._flag_bit.bit3//加载预设报警信息标志
#define report_fault_flag UART1Flag4_._flag_bit.bit4//汇报Seraph相关设备故障 

/*
**ST发送，需判断是否接收到回执
**Device Info
**检测到手势
*/
UART_EXT union  FLAG 					UART1Flag5_;
#define UART5Flag 						UART1Flag5_._flag_byte;
#define receipt_device_info1	UART1Flag5_._flag_bit.bit0//ST收到SS网络状态帧回复Device Info回执
#define receipt_device_info2  UART1Flag5_._flag_bit.bit1//ST收到SS网络状态帧，但mesh id错误，回复AA 03
#define receipt_gesture1			UART1Flag5_._flag_bit.bit2//ST上报非预设置指令触发手势给网关，收到回执
#define receipt_gesture2			UART1Flag5_._flag_bit.bit3//ST发送0x51调光指令给SC，收到回执
#define receipt_action_notify	UART1Flag5_._flag_bit.bit4//ST发送0x08异步通知给SS,收到回执
#define receipt_send_failed		UART1Flag5_._flag_bit.bit5//ST发送失败，SS回复丢包，重发
#define receipt_conf_pad1			UART1Flag5_._flag_bit.bit6//SS配置ST按键1\2\3，SC发送回执AA 01
#define receipt_conf_pad2			UART1Flag5_._flag_bit.bit7//SS配置ST按键，但不是按键1\2\3，SC发送回执AA 03

UART_EXT union  FLAG 					UART1Flag6_;
#define UART6Flag 						UART1Flag6_._flag_byte;
#define receipt_conf_gest1		UART1Flag6_._flag_bit.bit0//SS配置ST手势1\2\3\4SC发送回执AA 01
#define receipt_conf_gest2		UART1Flag6_._flag_bit.bit1//SS配置ST手势,但不是手势1、2、3、4,SC发送回执AA 03
#define receipt_host_mesh			UART1Flag6_._flag_bit.bit2
/**
**收到AA 07时重发用
*/
UART_EXT u8 st1_st_ges_H_temp;
UART_EXT u8 st1_st_ges_L_temp;
UART_EXT union  FLAG st_pad_temp;

UART_EXT ST_Module st1;
UART_EXT u8 device_info_message_id;	//ST发送Device Info包给SS的message id
UART_EXT u8 gesture_noset_message_id;		//ST发送非预设置的指令触发手势message id
UART_EXT u8 gesture_set_message_id;		//ST发送预设置的指令触发手势message id
UART_EXT u8 pad_noset_message_id;			//ST发送非预设置按键指令message id给SS
UART_EXT u8 pad_set_message_id;			//ST发送预设置按键指令message id给SC
UART_EXT u8 action_notify_message_id;//ST发送action_notify包给SS的message id

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
UART_EXT u16 send_fault_count;//ST检测到故障发送错,每秒发1次
UART_EXT u16 send_failed_count;//收到SS/SC发送失败指令,每秒 重发1次
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
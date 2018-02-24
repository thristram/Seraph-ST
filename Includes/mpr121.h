
#ifndef __MPR121_H
#define __MPR121_H

#include "i2c_master_poll.h"

/* MPR121 I2C address */
#define MPR121_I2C_ADDR       0x5A





/* MPR121 Register Defines */

#define 	ELE_TOUCH_STATUS0	0x00
#define 	ELE_TOUCH_STATUS1	0x01


#define 	MHD_R			0x2B
#define 	NHD_R			0x2C
#define	NCL_R 			0x2D
#define	FDL_R			0x2E
#define	MHD_F			0x2F
#define	NHD_F			0x30
#define	NCL_F			0x31
#define	FDL_F			0x32

#define	ELE0_T			0x41
#define	ELE0_R			0x42
#define	ELE1_T			0x43
#define	ELE1_R			0x44
#define	ELE2_T			0x45
#define	ELE2_R			0x46
#define	ELE3_T			0x47
#define	ELE3_R			0x48
#define	ELE4_T			0x49
#define	ELE4_R			0x4A
#define	ELE5_T			0x4B
#define	ELE5_R			0x4C
#define	ELE6_T			0x4D
#define	ELE6_R			0x4E
#define	ELE7_T			0x4F
#define	ELE7_R			0x50
#define	ELE8_T			0x51
#define	ELE8_R			0x52
#define	ELE9_T			0x53
#define	ELE9_R			0x54
#define	ELE10_T			0x55
#define	ELE10_R			0x56
#define	ELE11_T			0x57
#define	ELE11_R			0x58

#define	FIL_CFG			0x5D
#define	ELE_CFG			0x5E

#define  	GPIO_CTRL0		0x73
#define	GPIO_CTRL1		0x74
#define  	GPIO_DATA		0x75
#define	GPIO_DIR		0x76
#define	GPIO_EN			0x77
#define	GPIO_SET		0x78
#define	GPIO_CLEAR		0x79
#define	GPIO_TOGGLE	0x7A
#define	ATO_CFG0		0x7B
#define	ATO_CFGU 		0x7D
#define	ATO_CFGL		0x7E
#define	ATO_CFGT		0x7F


/* Global Constants */
#define 	TOU_THRESH 		0x0B
#define	REL_THRESH	    	0x07

#define 	WR_ADDR   		0xB4
#define 	RD_ADDR    		0xB5











typedef union{
	
	u8 byte;
	struct{
	        u8 ele0:1;		/* slippad 0 */
	        u8 ele1:1;		/* slippad 1 */
	        u8 ele2:1;		/* slippad 2 */
	        u8 ele3:1;		/* slippad 3 */
	        u8 ele4:1;		/* slippad 4 */
	        u8 ele5:1;
	        u8 ele6:1;
	        u8 ele7:1;

  	}bit;
	
} mpr121_touchStatus0_t;


/* 所有key都表示独立按键 */

typedef union{
	
	u8 byte;
	struct{
	        u8 ele8:1;		
	        u8 ele9:1;		/* keypad 2 */
	        u8 ele10:1;	/* keypad 1 */
	        u8 ele11:1;	/* keypad 0 */
	        u8 eleprox:1;
	        u8 bit5:1;
	        u8 bit6:1;
	        u8 ovcf:1;

  	}bit;
	
} mpr121_touchStatus1_t;

typedef union{
	
	u8 byte;
	struct{
	        u8 slipPad0:1;		
	        u8 slipPad1:1;		
	        u8 slipPad2:1;
	        u8 slipPad3:1;
	        u8 slipPad4:1;
	        u8 bit5:1;
	        u8 bit6:1;
	        u8 bit7:1;

  	}bit;
	
} mpr121_slipPad_t;

typedef union{
	
	u8 byte;
	struct{
	        u8 keyPad0:1;		
	        u8 keyPad1:1;		
	        u8 keyPad2:1;
	        u8 bit3:1;
	        u8 bit4:1;
	        u8 bit5:1;
	        u8 bit6:1;
	        u8 bit7:1;

  	}bit;
	
} mpr121_keyPad_t;



#define	MPR121_SLIPPAD_NUMS			5
#define	MPR121_KEYPAD_NUMS			3
#define	MPR121_KEYPAD_HOLD_CNT		20			/* 2S */
#define	MPR121_LONG_TOUCH_HOLD_CNT	100			/* 10S */
#define	MPR121_MULTI_LONG_TOUCH_INTERVAL		3	/* 300MS */
#define	MPR121_KEYPAD_RELEASE_LED_DELAY		2	/* 300MS */

#define	MPR121_SLIPPAD_LEVELS_NUM		9	

#define	MPR121_LONG_TOUCH_CONFIRM_CNT		20		/* 3S */			
#define	MPR121_LONG_TOUCH_INVALID			0x0A		/*  长按启动滑动功能无效  */			

/*----------------------------------------------------------------------------
1、对于滑动调光，只有在所有按键释放时才发送数据，发送最后一次按键的值

2、对于单独的按键，需要独立分析按下的时长和释放的时间点

-----------------------------------------------------------------------------*/


typedef struct
{

	u8	keyHoldCnt[MPR121_KEYPAD_NUMS];		/* 按键维持时间，每100ms增加1，最多可支持25.5s */
	u8	keyWaitCnt[MPR121_KEYPAD_NUMS];		/* 长按对应调光的等待时间，每100ms增加1 */
	u8	keyLEDCnt[MPR121_KEYPAD_NUMS];		/* 按键LED显示计数 */
	u8	keyLEDStatus[MPR121_KEYPAD_NUMS];	/* 按键LED显示状态 0关闭 1开启 2 延迟20ms后关闭  3 启动滑动按键的长按，1s闪烁一次 */
	u8	keylongTouchSlipLevel[MPR121_KEYPAD_NUMS];	/* 长按对应的滑动调光等级 0-8 亮度等级 */

	mpr121_slipPad_t	slipTouch;			/* 滑动按键触发，新值  */
	u8				slipRelease;			/* 滑动按键释放，上一次滑动触发的值 */
	u8				slipConfirm;			/* 滑动按键确认，用来发送滑动上报 */
	u8				slipValue;				/* 实时滑动按键值 1-9 表示按键等级 对应0-8 亮度等级 主要用于LED显示 */
	u8				slipLevel;				/* 滑动按键本身的 0-8 亮度等级 */

	u8				longTouchHoldCnt;		/* 最后一个长按对应调光的等待时间，每100ms增加1 */
	u8				longTouchKey;		/* 最后一个长按对应的独立按键 1 2 3 ，大于0表示存在需要启动对应滑动按键的计数   */
	u8				longTouchSlipConfirm;	/* 数值等于longTouchKey时，即大于0时表示长按启动的滑动检测成功，led闪烁3次，屏蔽所有按键功能  */


	mpr121_keyPad_t	keyTouch;			/* 独立按键触发，新值 */
	u8				keyRelease;			/* 独立按键释放，上一次按键触发的值 */
	u8				keyComfirm;			/* 按键确认，用来发送按键上报 */
	u8				keyValue;			/* 按键确认的值，区分长按0,短按1 */



	mpr121_touchStatus0_t	ts0;
	mpr121_touchStatus1_t	ts1;
	
}mpr121_handle_t;	
















extern volatile u8 MPR121_ISR_FLAG;

extern mpr121_handle_t mpr121_handle;



uint8_t MPR121_WriteDataByte(uint8_t reg, uint8_t val);
uint8_t MPR121_ReadDataByte(uint8_t reg, uint8_t *val);
int MPR121_ReadDataBlock(uint8_t reg, uint8_t *val, unsigned int len);


void MPR121_init(void);
void MPR121_exti_config(void);

void MPR121_slipPad_or_longTouch_value_save(u8 which);
void MPR121_keyPad_hold_time_count(void);
void MPR121_keyPad_slipPad_post(void);
void MPR121_detect(void);





#endif

/**
  ******************************************************************************
  * @file    i2c_opt.h
  * @author  MCD Application Team
  * @version V0.0.3
  * @date    Feb 2010
  * @brief   This file contains definitions for optimized I2C software
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  *                     COPYRIGHT 2009 STMicroelectronics  
  */ 

/* Define to prevent recursive inclusion */
#ifndef __I2C_OPT_H
#define __I2C_OPT_H

//#include "stm8s.h"
//#include "stm8s_conf.h"
#include "stm8s_lib.h"
#include "stm8s_macro.h"
#include "stm8s_map.h"
#include "stm8s_type.h"
#include "stm8s_i2c.h"

// ************************** I2C Configuration Variables **************************

/* definition of fast or default standard mode (bus speed up to 400 or 100 kHz) */
//#define FAST_I2C_MODE

/* definition of 10-bit or default 7-bit slave address */
//#define TEN_BITS_ADDRESS

/* uncomment next line when stop request is required between device address sent and read data */
//#define NO_RESTART

#ifdef TEN_BITS_ADDRESS
#define SLAVE_ADDRESS  0x3F0
#else
#define SLAVE_ADDRESS  0x50
#endif

#define	IIC_SUCCESS					0
#define	IIC_ERROR_TIME_OUT	1
#define	IIC_ERROR_BUSY			2
#define	IIC_ERROR_NOT_ACK		3

#define uint8_t unsigned char
#define uint16_t unsigned short

// ************************* Function Declaration ***************************


uint8_t I2C_Config(void);
void My_TIM3_Init(void);
uint8_t I2C_WriteBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite, uint8_t TimeOutOfMs);
uint8_t I2C_ReadBytes(uint16_t SlaveAddr, uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs);
uint8_t I2C_WriteReadBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite,uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs);
void ErrProc(void);

/* flag clearing sequence - uncoment next for peripheral clock under 2MHz */
#define dead_time() { /* _asm("nop"); _asm("nop"); */ }
#define delay_ms(a)          { TIM3_tout= a; while(TIM3_tout); }
#define tout()            (TIM3_tout)
#define set_tout_ms(a)    { TIM3_tout= a; }
extern u16 TIM3_tout;


// ************************* Interrupt handler Declaration ***************************

#ifdef _COSMIC_
@far @interrupt void I2C_error_Interrupt_Handler (void);
#else
void I2CInterruptHandle (void) interrupt 19;
#endif
#ifdef _COSMIC_
@far @interrupt void TIM3InterruptHandle (void);
#else
void TIM3InterruptHandle (void) interrupt 23;
#endif


// ************************* I2C Example decalaration ***************************

#define MAX_DUMMY 10
//#define LED1  0x08
//#define switch_on(msk) GPIOA->ODR |= (msk) ;
//#define switch_off(msk) GPIOA->ODR &= ~(msk);


#endif /* __I2C_OPT_H */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/

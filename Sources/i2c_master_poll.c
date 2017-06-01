/**
  ******************************************************************************
  * @file    i2c_master_poll.c
  * @author  MCD Application Team
  * @version V0.0.3
  * @date    Oct 2010
  * @brief   This file contains optimized drivers for I2C master
  ******************************************************************************
  * @copy
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  */ 

#include "i2c_master_poll.h"
volatile u16 TIM3_tout;
/******************************************************************************
* Function name : I2C_Init
* Description 	: Initialize I2C peripheral
* Input param 	: None
* Return 		    : None
* See also 		  : None
*******************************************************************************/
uint8_t I2C_Config(void) {
	uint16_t time_out = 0;
	My_TIM3_Init();
	enableInterrupts();
	//GPIO_Init(GPIOB,GPIO_PIN_4,GPIO_MODE_OUT_OD_HIZ_SLOW);
	//GPIO_Init(GPIOB,GPIO_PIN_5,GPIO_MODE_OUT_OD_HIZ_SLOW);

	I2C_DeInit();
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
	I2C_Init(100000,0x50,I2C_DUTYCYCLE_2,I2C_ACK_CURR,I2C_ADDMODE_7BIT,CLK_GetClockFreq()/1000000);
	//I2C_ITConfig(I2C_IT_ERR,ENABLE);
	I2C_Cmd(ENABLE);
  while((I2C->SR3 & I2C_SR3_BUSY))       									// Wait while the bus is busy
  {
		set_tout_ms(10);
    I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
    while((I2C->CR2 & I2C_CR2_STOP) && tout());      								// wait until stop is performed
		time_out += 10;
		if(!tout()){
			I2C_SoftwareResetCmd(ENABLE);
			I2C_SoftwareResetCmd(DISABLE);
		}
		if(time_out > 500){
			return IIC_ERROR_BUSY;
		}
  }
	return IIC_SUCCESS;
}
/**
  * @brief  IIC写数据
  * @param  SlaveAddr 从机地址
	* @param  pWriteDataBuffer 写数据缓冲区指针
	* @param  NumByteToWrite 准备写数据字节数
	* @param  TimeOutOfMs 超时时间，必须大于数据发送完毕的最小时间
  * @retval 函数执行状态
  */
uint8_t I2C_WriteBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite, uint8_t TimeOutOfMs)
{
	set_tout_ms(TimeOutOfMs);
  while((I2C->SR3 & I2C_SR3_BUSY) && tout())       									// Wait while the bus is busy
  {
    I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
    while((I2C->CR2 & I2C_CR2_STOP) && tout());      								// wait until stop is performed
  }
	if(!tout()){return IIC_ERROR_BUSY;}
  I2C->CR2 |= I2C_CR2_START;                        									// START=1, generate start
  while(((I2C->SR1 & I2C_SR1_SB)==0) && tout()); 									// Wait for start bit detection (SB)
  dead_time();                          									// SB clearing sequence
  if(tout())
  {
    #ifdef TEN_BITS_ADDRESS															  // TEN_BIT_ADDRESS decalred in I2c_master_poll.h
      I2C->DR = (u8)(((SlaveAddr >> 7) & 6) | 0xF0);  		// Send header of 10-bit device address (R/W = 0)
      while(!(I2C->SR1 & I2C_SR1_ADD10) &&  tout());    							// Wait for header ack (ADD10)
      if(tout())
      {
        I2C->DR = (u8)(SlaveAddr);        								// Send lower 8-bit device address & Write 
      }
    #else
      I2C->DR = (u8)(SlaveAddr << 1);   									// Send 7-bit device address & Write (R/W = 0)
    #endif
  }else{
		return IIC_ERROR_TIME_OUT;
	}
  while(!(I2C->SR1 & I2C_SR1_ADDR) && tout());     									// Wait for address ack (ADDR)
	if(!tout()){
		I2C->CR2 |= I2C_CR2_STOP;
		return IIC_ERROR_NOT_ACK;
	}
  dead_time();                          									// ADDR clearing sequence
  I2C->SR3;
  while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  									// Wait for TxE
  if(NumByteToWrite)
	{
		while(NumByteToWrite--)
		{
			I2C->DR = *pWriteDataBuffer++; 
			while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  								// test EV8 - wait for TxE
			if(!tout()){
				break;
			}
		}
		while(((I2C->SR1 & (I2C_SR1_TXE|I2C_SR1_BTF)) != (I2C_SR1_TXE|I2C_SR1_BTF)) && tout()); 					// Wait for TxE & BTF
		dead_time();                          									// clearing sequence
	}
  
  I2C->CR2 |= I2C_CR2_STOP;                        									// generate stop here (STOP=1)
  while((I2C->CR2 & I2C_CR2_STOP) && tout());      									// wait until stop is performed  
	if(!tout()){
		return IIC_ERROR_TIME_OUT;
	}else{
		return IIC_SUCCESS;
	}
}

uint8_t I2C_ReadBytes(uint16_t SlaveAddr, uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
{
	set_tout_ms(TimeOutOfMs);
 /*--------------- BUSY? -> STOP request ---------------------*/
	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
  {
		I2C->CR2 |= I2C_CR2_STOP;                   				// STOP=1, generate stop
    while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// wait until stop is performed
	}
	if(!tout()){return IIC_ERROR_BUSY;}
	I2C->CR2 &= ~I2C_CR2_STOP;
  I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
  /*--------------- Start communication -----------------------*/  
  I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
  while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// wait for start bit detection (SB)
  /*------------------ Address send ---------------------------*/      
  #ifdef TEN_BITS_ADDRESS
    I2C->DR = (u8)(((SlaveAddr >> 7) & 6) | 0xF0);	// Send header of 10-bit device address (R/W = 0)
    while(!(I2C->SR1 & I2C_SR1_ADD10) &&  tout());			// Wait for header ack (ADD10)
    I2C->DR = (u8)(SlaveAddr);                			// Send lower 8-bit device address
		while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());			// Wait for address ack (ADDR)
		I2C->CR2 |= I2C_CR2_START;                    			// START=1, generate start
		while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());			// Wait for start bit detection (SB)
		I2C->DR = (u8)(((SlaveAddr >> 7) & 6) | 0xF1);	// Send header of 10-bit device address (R/W = 1)
	#else
    I2C->DR = (u8)(SlaveAddr << 1) | 1;       			// Send 7-bit device address & Write (R/W = 1)
  #endif  // TEN_BITS_ADDRESS
  while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());				// Wait for address ack (ADDR)
	if(!tout()){
		return IIC_ERROR_NOT_ACK;
	}
  /*------------------- Data Receive --------------------------*/
  if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
  {
    I2C->SR3;                                     			// ADDR clearing sequence    
    while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
    {
      while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
      --NumByteToRead;																		// Decrease Numbyte to reade by 1
    }
																												//last three bytes should be read
    while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
    I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
    disableInterrupts();                          			// Errata workaround (Disable interrupt)
    *pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
    I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
    *pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
    enableInterrupts();																	// Errata workaround (Enable interrupt)
    while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
    *pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
  }
  else
  {
    if(NumByteToRead == 2)                						// *** just two bytes are received? ***
    {
      I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->SR3;                                       	// Clear ADDR Flag
      I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK 
      enableInterrupts();																// Errata workaround (Enable interrupt)
      while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
      *pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
      enableInterrupts();																// Errata workaround (Enable interrupt)
			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
    }
    else                                      					// *** only one byte is received ***
    {
      I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK 
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->SR3;                                       	// Clear ADDR Flag   
      I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
      enableInterrupts();																// Errata workaround (Enable interrupt)
      while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
      *pReadDataBuffer = I2C->DR;                     		// Read Data byte
    }
  }
  /*--------------- All Data Received -----------------------*/
  while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
  I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
	if(!tout()){
		return IIC_ERROR_TIME_OUT;
	}else{
		return IIC_SUCCESS;
	}
}
#if 1
uint8_t I2C_WriteReadBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite,uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
{
	set_tout_ms(TimeOutOfMs);
 /*--------------- BUSY? -> STOP request ---------------------*/
	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
  {
		I2C->CR2 |= I2C_CR2_STOP;                   				// Generate stop here (STOP=1)
    while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// Wait until stop is performed
	}
	if(!tout()){return IIC_ERROR_BUSY;}
	I2C->CR2 &= ~I2C_CR2_STOP;
  I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
  /*--------------- Start communication -----------------------*/  
  I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
  while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// Wait for start bit detection (SB)
  /*------------------ Address send ---------------------------*/      
  if(tout())
  {
    #ifdef TEN_BITS_ADDRESS
      I2C->DR = (u8)(((SlaveAddr >> 7) & 6) | 0xF0);// Send header of 10-bit device address (R/W = 0)
      while(!(I2C->SR1 & I2C_SR1_ADD10) &&  tout());		// Wait for header ack (ADD10)
      if(tout())
      {
        I2C->DR = (u8)(SlaveAddr);                	// Send lower 8-bit device address & Write  
      }
    #else
      I2C->DR = (u8)(SlaveAddr << 1);   						// Send 7-bit device address & Write (R/W = 0)
    #endif // TEN_BITS_ADDRESS
  }
  while(!(I2C->SR1 & I2C_SR1_ADDR) &&  tout()); 				// test EV6 - wait for address ack (ADDR)
	if(!tout()){
		return IIC_ERROR_NOT_ACK;
	}
  dead_time();                                  				// ADDR clearing sequence
  I2C->SR3;
  /*--------------- Register/Command send ----------------------*/
	if(NumByteToWrite > 0){
		while(NumByteToWrite--){
			while(!(I2C->SR1 & I2C_SR1_TXE) &&  tout());  				// Wait for TxE
			if(tout())
			{  
				I2C->DR = *pWriteDataBuffer++;                         			// Send register address
			}                                            					// Wait for TxE & BTF
		}
		while((I2C->SR1 & (I2C_SR1_TXE | I2C_SR1_BTF)) != (I2C_SR1_TXE | I2C_SR1_BTF)  &&  tout()); 
		dead_time();  
	}                                				// clearing sequence
  /*-------------- Stop/Restart communication -------------------*/  
  #ifndef TEN_BITS_ADDRESS
    #ifdef NO_RESTART																		// if 7bit address and NO_RESTART setted
      I2C->CR2 |= I2C_CR2_STOP;                     		// STOP=1, generate stop
      while(I2C->CR2 & I2C_CR2_STOP  &&  tout());   		// wait until stop is performed
    #endif // NO_RESTART
  #endif // TEN_BITS_ADDRESS
  /*--------------- Restart communication ---------------------*/  
	I2C->CR2 &= ~I2C_CR2_STOP;
  I2C->CR2 |= I2C_CR2_START;                     				// START=1, generate re-start
  while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout()); 				// Wait for start bit detection (SB)
  /*------------------ Address send ---------------------------*/      
  if(tout())
  {
    #ifdef TEN_BITS_ADDRESS
      I2C->DR = (u8)(((SlaveAddr >> 7) & 6) | 0xF1);// send header of 10-bit device address (R/W = 1)
      #ifdef NO_RESTART
        while(!(I2C->SR1 & I2C_SR1_ADD10) &&  tout());	// Wait for header ack (ADD10)
        if(tout())
        {
          I2C->DR = (u8)(SlaveAddr);                // Send lower 8-bit device address & Write  
        }
      #endif // NO_RESTART
    #else
      I2C->DR = (u8)(SlaveAddr << 1) | 1;         	// Send 7-bit device address & Write (R/W = 1)
    #endif  // TEN_BITS_ADDRESS
  }
  while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());  			// Wait for address ack (ADDR)
	if(!tout()){
		return IIC_ERROR_NOT_ACK;
	}
  /*------------------- Data Receive --------------------------*/
  if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
  {
    I2C->SR3;                                     			// ADDR clearing sequence    
    while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
    {
      while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
      --NumByteToRead;																		// Decrease Numbyte to reade by 1
    }
																												//last three bytes should be read
    while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
    I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
    disableInterrupts();                          			// Errata workaround (Disable interrupt)
    *pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
    I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
    *pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
    enableInterrupts();																	// Errata workaround (Enable interrupt)
    while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
    *pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
  }
  else
  {
   if(NumByteToRead == 2)                						// *** just two bytes are received? ***
    {
      I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->SR3;                                       	// Clear ADDR Flag
      I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK 
      enableInterrupts();																// Errata workaround (Enable interrupt)
      while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
      *pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
      enableInterrupts();																// Errata workaround (Enable interrupt)
			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
    }
    else                                      					// *** only one byte is received ***
    {
      I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK 
      disableInterrupts();                          		// Errata workaround (Disable interrupt)
      I2C->SR3;                                       	// Clear ADDR Flag   
      I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
      enableInterrupts();																// Errata workaround (Enable interrupt)
      while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
      *pReadDataBuffer = I2C->DR;                     		// Read Data byte
    }
  }
  /*--------------- All Data Received -----------------------*/
  while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
  I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
	return IIC_SUCCESS;
}
#endif
/******************************************************************************
* Function name : ErrProc
* Description 	: Manage all I2C error detected by interrupt handler
* Input param 	: None
* Return 		    : None
* See also 		  : None
*******************************************************************************/
void ErrProc(void)
{
		// Clear Error Falg
    I2C->SR2= 0;
		// STOP=1, generate stop
	  I2C->CR2 |= 2;  
		// Disable Timout 
    TIM3_tout= 0;
		// Switch on LED3 for I2C Error detection
//    switch_on(LED1);
}



/******************************************************************************
* Function name : TIM4_Init
* Description 	: Initialize TIM4 peripheral
* Input param 	: None
* Return 		    : None
* See also 		  : None
*******************************************************************************/
void My_TIM3_Init (void) {
	TIM3->ARRH = 0;
  TIM3->ARRL = 0x80;                // init timer 4 1ms inetrrupts
  TIM3->PSCR= 7;
  TIM3->IER = 1;
  TIM3->CR1 |= 1;
	TIM3_tout = 0;
}

/******************************************************************************
* Function name : I2C_error_Interrupt_Handler
* Description 	: Manage all I2C error inetrrupts
* Input param 	: None
* Return 		    : None
* See also 		  : None
*******************************************************************************/
#ifdef _COSMIC_
@far @interrupt void I2C_error_Interrupt_Handler (void) {
#else
void I2CInterruptHandle (void) interrupt 19 {
#endif
ErrProc();
}

/******************************************************************************
* Function name : TIM4InterruptHandle
* Description 	: Testing load for Main 
* Input param 	: None
* Return 		    : None
* See also 		  : None
*******************************************************************************/
#ifdef _COSMIC_
@far @interrupt void TIM3InterruptHandle (void) {
#else
void TIM3InterruptHandle (void) interrupt 23 {
#endif
  u8 dly= 10;
  
  TIM3->SR1= 0;
  
  if(TIM3_tout)
    if(--TIM3_tout == 0)
#ifdef _COSMIC_
      _asm("nop");
#else
      _nop_();
#endif
  while(dly--);
}

/*	BASIC INTERRUPT VECTOR TABLE FOR STM8S devices
 *	Copyright (c) 2007 STMicroelectronics
 */

#include "main.h"
#include "uart.h"
#include "i2c_master_poll.h"
#include "timer.h"

typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt (void)
{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
	return;
}

extern void _stext();     /* startup routine */
void main(void);

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
//	{0x82, (interrupt_handler_t)main}, /* reset */
	{0x82, NonHandledInterrupt}, /* trap */
	{0x82, NonHandledInterrupt}, /* irq0 - tli */
	{0x82, NonHandledInterrupt}, /* irq1 - awu */
	{0x82, NonHandledInterrupt}, /* irq2 - clk */
	{0x82, (interrupt_handler_t)PORTA_EXT_ISR}, /* irq3 - exti0 */
	{0x82, NonHandledInterrupt}, /* irq4 - exti1 */
	{0x82, NonHandledInterrupt}, /* irq5 - exti2 */
	{0x82, NonHandledInterrupt}, /* irq6 - exti3 */
	{0x82, (interrupt_handler_t)PORTE_EXT_ISR}, /* irq7 - exti4 */
	{0x82, NonHandledInterrupt}, /* irq8 - can rx */
	{0x82, NonHandledInterrupt}, /* irq9 - can tx */
	{0x82, NonHandledInterrupt}, /* irq10 - spi*/
	{0x82, NonHandledInterrupt}, /* irq11 - tim1 */
	{0x82, NonHandledInterrupt}, /* irq12 - tim1 */
	{0x82, (interrupt_handler_t)timer2_ISR}, /* irq13 - tim2 */
	{0x82, NonHandledInterrupt}, /* irq14 - tim2 */
	{0x82, (interrupt_handler_t)TIM3InterruptHandle}, /* irq15 - tim3 */
	{0x82, NonHandledInterrupt}, /* irq16 - tim3 */
	{0x82, (interrupt_handler_t)BLE_UART_TX_ISR}, /* irq17 - uart1 */
	{0x82, (interrupt_handler_t)BLE_UART_RX_ISR}, /* irq18 - uart1 */
	{0x82, (interrupt_handler_t)I2C_error_Interrupt_Handler}, /* irq19 - i2c */
	{0x82, NonHandledInterrupt}, /* irq20 - uart2/3 */
	{0x82, NonHandledInterrupt}, /* irq21 - uart2/3 */
	{0x82, NonHandledInterrupt}, /* irq22 - adc */
	{0x82, NonHandledInterrupt}, /* irq23 - tim4 */
	{0x82, NonHandledInterrupt}, /* irq24 - flash */
	{0x82, NonHandledInterrupt}, /* irq25 - reserved */
	{0x82, NonHandledInterrupt}, /* irq26 - reserved */
	{0x82, NonHandledInterrupt}, /* irq27 - reserved */
	{0x82, NonHandledInterrupt}, /* irq28 - reserved */
	{0x82, NonHandledInterrupt}  /* irq29 - reserved */
};



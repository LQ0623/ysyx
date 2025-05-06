#ifndef __MEMORY_H__
#define __MEMORY_H__
#include <ysyxsoc.h>

// MROM
#define MROM_BASE 0x20000000
#define MROM_SIZE 0xfff 

// FLASH
#define FLASH_BASE 0x30000000
#define FLASH_SIZE 0x10000000

// SRAM
#define SRAM_BASE 0x0f000000
#define SRAM_SIZE 0x1fff

// UART
#define UART_BASE 0x10000000
#define UART_SIZE 0xfff
// uart寄存器地址
#define UART_REG_RB 0x10000000
#define UART_REG_LC  0x10000003
#define UART_REG_DL1 0x10000000
#define UART_REG_DL2 0x10000001
#define UART_REG_LS  0x10000005
// Line Status Register bits
#define UART_LS_DR	0	// Data ready
#define UART_LS_OE	1	// Overrun Error
#define UART_LS_PE	2	// Parity Error
#define UART_LS_FE	3	// Framing Error
#define UART_LS_BI	4	// Break interrupt
#define UART_LS_TFE	5	// Transmit FIFO is empty
#define UART_LS_TE	6	// Transmitter Empty indicator
#define UART_LS_EI	7	// Error indicator


#endif
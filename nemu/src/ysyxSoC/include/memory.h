#ifndef __MEMORY_H__
#define __MEMORY_H__
#include <ysyxsoc.h>

// MROM
#define MROM_BASE 0x20000000
#define MROM_SIZE 0xfff 

// SRAM
#define SRAM_BASE 0x0f000000
#define SRAM_SIZE 0x1fff

// UART
#define UART_BASE 0x10000000
#define UART_SIZE 0xfff
// uart寄存器地址
#define UART_REG_RB 0x10000000

#endif
#include <riscv/riscv.h>

//uart
#define UART_REG_RB  0x10000000
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


#define DEVICE_BASE 	0xa0000000
#define MMIO_BASE 	    0xa0000000

#define SERIAL_PORT     (DEVICE_BASE + 0x00003f8)
#define KBD_ADDR        (DEVICE_BASE + 0x0000060)
#define RTC_ADDR        (DEVICE_BASE + 0x0000048)
#define VGACTL_ADDR     (DEVICE_BASE + 0x0000100)
#define AUDIO_ADDR      (DEVICE_BASE + 0x0000200)
#define DISK_ADDR       (DEVICE_BASE + 0x0000300)
#define FB_ADDR         (MMIO_BASE   + 0x1000000)
#define AUDIO_SBUF_ADDR (MMIO_BASE   + 0x1200000)

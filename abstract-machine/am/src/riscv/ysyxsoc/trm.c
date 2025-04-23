#include <am.h>
#include <klib-macros.h>
#include "ysyxsoc.h"

extern char _heap_start,_heap_end;
int main(const char *args);

extern char _pmem_start;
#define PMEM_SIZE (128 * 1024 * 1024)
#define PMEM_END  ((uintptr_t)&_pmem_start + PMEM_SIZE)
#define npc_trap(code) asm volatile("mv a0, %0; ebreak" : :"r"(code))

Area heap = RANGE(&_heap_start, &_heap_end);
static const char mainargs[MAINARGS_MAX_LEN] = MAINARGS_PLACEHOLDER; // defined in CFLAGS

void init_uart(uint16_t div){
  // 允许访问 Divisor Latch 寄存器。
  outb(UART_REG_LC, 0b10000011);
  outb(UART_REG_DL2, (uint8_t)(div >> 8));
  outb(UART_REG_DL1, (uint8_t)div);
  // 关闭 Divisor Latch 寄存器设置
  outb(UART_REG_LC, 0b00000011);
}

void putch(char ch) {
  outb(UART_REG_RB, ch);
}

void halt(int code) {
  npc_trap(code);
  while (1);
}

void _trm_init() {
  init_uart(400);
  int ret = main(mainargs);
  halt(ret);
}

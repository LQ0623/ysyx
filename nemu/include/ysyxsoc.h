#ifndef __YSYXSOC_H__
#define __YSYXSOC_H__
#include <common.h>

extern uint8_t *mrom;
void init_soc();
bool in_socMem(paddr_t addr);       // 判断是否在SOC对应的存储中
bool in_Mrom(paddr_t addr);      // 判断是否在MROM中

word_t soc_read(paddr_t addr, int len);
void soc_write(paddr_t addr, int len, word_t data);


#endif
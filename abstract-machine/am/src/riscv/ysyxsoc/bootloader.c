// 需要将存储在MROM中的数据搬到SRAM中
#include <stdint.h>

void _trm_init();
void  bootloader() __attribute__((section(".text.boot")));

extern uint8_t _sdata_lma; // LMA:初始数据在MROM的地址
extern uint8_t _data;      // 运行时数据在SRAM的地址
extern uint8_t _edata;     // 数据段结束符号
extern uint8_t _bss_start; // bss段起始地址
extern uint8_t _bss_end;   // bss段结束地址

/**
 * 将 .data 段从 MROM 复制到 SRAM
 */
void copy_data(void){
    uint8_t *src = &_sdata_lma;
    uint8_t *dst = &_data;
    while(dst < &_edata){
        *dst++ = *src++;
    }
}

/**
 * 将 .bss 段全部归为0
 */
void set_bss_zero(void){
    uint8_t *dst = &_bss_start;
    int bss_size = &_bss_end - &_bss_start;
    while(bss_size--){
        *dst++ = 0;
    }
}

/**
 * 1. 复制 .data 段
 * 2. 清零 .bss 段
 * 3. 调用 trm_init
 */
void bootloader() {
    // 拷贝数据段
    int data_size = &_data - &_data;
    if(data_size > 0){
        copy_data();
    }

    // 清零bss段
    int bss_size = &_bss_end - &_bss_start;
    if(bss_size > 0){
        set_bss_zero();
    }

    _trm_init();
}
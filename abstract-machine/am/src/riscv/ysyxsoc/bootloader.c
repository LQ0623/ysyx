#include <stdint.h>

/* 声明外部符号 */
extern void _trm_init();
extern uint8_t _sdata_lma;  // 数据段在MROM的起始地址
extern uint8_t _data;       // 数据段在SRAM的起始地址
extern uint8_t _edata;      // 数据段在SRAM的结束地址
extern uint8_t _bss_start;  // BSS段起始地址
extern uint8_t _bss_end;    // BSS段结束地址

/**
 * 将 .data 段从 MROM 复制到 SRAM
 */
static void copy_data() {
    uint8_t *src = &_sdata_lma;  // MROM地址
    uint8_t *dst = &_data;       // SRAM地址
    while (dst < &_edata) {
        *dst++ = *src++;
    }
}

/**
 * 清零 BSS 段
 */
static void clear_bss() {
    uint8_t *dst = &_bss_start;
    while (dst < &_bss_end) {  // 修正为_bss_end
        *dst++ = 0;
    }
}

/**
 * Bootloader入口
 */
void bootloader() __attribute__((section(".text.boot")));
void bootloader() {
    /* 1. 复制数据段 */
    if (&_edata > &_data) {
        copy_data();
    }

    /* 2. 清零BSS段 */
    if (&_bss_end > &_bss_start) {
        clear_bss();
    }

    /* 3. 跳转到主程序 */
    _trm_init();  // 假设_trm_init是主程序入口
}
#include <stdint.h>

/* 声明外部符号 */
extern void _trm_init();
extern uint8_t _sdata_lma;      // 数据段在FLASH的起始地址
extern uint8_t _data;           // 数据段在PSRAM的起始地址
extern uint8_t _edata;          // 数据段在PSRAM的结束地址
extern uint8_t _bss_start;      // BSS段起始地址
extern uint8_t _bss_end;        // BSS段结束地址

/* mem-test段符号声明 */
extern uint8_t _stext_memtest_lma;
extern uint8_t _stext_memtest;
extern uint8_t _etext_memtest;

extern uint8_t _srodata_memtest_lma;
extern uint8_t _srodata_memtest;
extern uint8_t _erodata_memtest;

extern uint8_t _sdata_memtest_lma;
extern uint8_t _sdata_memtest;
extern uint8_t _edata_memtest;

extern uint8_t _sbss_memtest;
extern uint8_t _ebss_memtest;

/**
 * 将 .data 段从 FLASH 复制到 PSRAM
 */
void copy_data() {
    uint8_t *src = &_sdata_lma;
    uint8_t *dst = &_data;
    while (dst < &_edata) {
        *dst++ = *src++;
    }
}

/**
 * 清零 BSS 段
 */
void clear_bss() {
    uint8_t *dst = &_bss_start;
    while (dst < &_bss_end) {
        *dst++ = 0;
    }
}

/**
 * 将mem-test段从FLASH复制到SRAM
 */
void copy_memtest_to_sram() {
    // 复制代码段
    uint8_t *src = &_stext_memtest_lma;
    uint8_t *dst = &_stext_memtest;
    while (dst < &_etext_memtest) {
        *dst++ = *src++;
    }

    // 复制只读数据段
    src = &_srodata_memtest_lma;
    dst = &_srodata_memtest;
    while (dst < &_erodata_memtest) {
        *dst++ = *src++;
    }

    // 复制数据段
    src = &_sdata_memtest_lma;
    dst = &_sdata_memtest;
    while (dst < &_edata_memtest) {
        *dst++ = *src++;
    }

    // 清零BSS段
    uint8_t *bss = &_sbss_memtest;
    while (bss < &_ebss_memtest) {
        *bss++ = 0;
    }
}

/**
 * Bootloader入口
 */
void bootloader() __attribute__((section(".text.boot")));
void bootloader() {
    /* 1. 复制数据段到PSRAM */
    if (&_edata > &_data) {
        copy_data();
    }

    /* 2. 清零BSS段 */
    if (&_bss_end > &_bss_start) {
        clear_bss();
    }

    /* 3. 加载mem-test到SRAM */
    copy_memtest_to_sram();

    /* 4. 设置栈指针到SRAM顶部 */
    __asm volatile("la sp, _stack_pointer");

    /* 5. 跳转到mem-test执行 */
    void (*memtest_entry)();
    memtest_entry = (void*)&_stext_memtest;
    memtest_entry();

    // 不会返回
    while(1);
}
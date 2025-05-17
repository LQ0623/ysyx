#include <stdint.h>

/* 声明外部符号 */
extern void _trm_init();
extern char _boot;
extern char _text;       // 代码段在sram中的开始地址
extern char _etext;      // 代码段在sram中的结束地址
extern char _stext_lma;  // 代码段在MROM的起始地址
extern char _rodata;     // 只读数据段在sram中的开始地址
extern char _erodata;    // 只读数据段在sram中的结束地址
extern char _srodata_lma;// 代码段在MROM的起始地址
extern char _sdata_lma;  // 数据段在MROM的起始地址
extern char _data;       // 数据段在SRAM的起始地址
extern char _edata;      // 数据段在SRAM的结束地址
extern char _bss_start;  // BSS段起始地址
extern char _bss_end;    // BSS段结束地址

/**
 * 将 .text 段从 FLASH 复制到 SRAM
 */
void copy_text() {
    char *src = &_stext_lma;  // FLASH地址
    char *dst = &_text;       // SRAM地址
    while (dst < &_etext) {
        *dst++ = *src++;
    }
}


/**
 * 将 .data 段从 FLASH 复制到 PSRAM
 */
void copy_data() {
    char *src = &_sdata_lma;  // FLASH地址
    char *dst = &_data;       // SRAM地址
    while (dst < &_edata) {
        *dst++ = *src++;
    }
}

/**
 * 清零 BSS 段
 */
void clear_bss() {
    char *dst = &_bss_start;
    while (dst < &_bss_end) {  // 修正为_bss_end
        *dst++ = 0;
    }
}

/**
 * Bootloader入口
 */
void bootloader() __attribute__((section(".text.boot")));
void bootloader() {
    /* 0. 拷贝代码段 */
    // copy_text();
    char *src = &_stext_lma;  // FLASH地址
    char *dst = &_text;       // SRAM地址
    while (dst < &_edata) {
        *dst++ = *src++;
    }

    /* 拷贝只读数据段 */
    // src = &_srodata_lma;  // FLASH地址
    // dst = &_rodata;       // SRAM地址
    // while (dst < &_erodata) {
    //     *dst++ = *src++;
    // }

    // /* 1. 复制数据段 */
    // if (&_edata > &_data) {
    //     // copy_data();
    //     src = &_sdata_lma;  // FLASH地址
    //     dst = &_data;       // SRAM地址
    //     while (dst < &_edata) {
    //         *dst++ = *src++;
    //     }
    // }

    /* 2. 清零BSS段 */
    // TAG:使用readelf查看elf文件时，bss有大小是正确的，bss的size只是告诉 loader 要分配多少内存给bss
    // 它不会出现在 .bin 文件中，除非你用了 --set-section-flags .bss=alloc,contents，这样 objcopy 就会错误地试图把这 0x14 字节写入 .bin，哪怕 .bss 是 NOBITS 类型。
    // contents属性表示该段在目标文件中包含实际数据
    if (&_bss_end > &_bss_start) {
        // clear_bss();
        dst = &_bss_start;
        while (dst < &_bss_end) {  // 修正为_bss_end
            *dst++ = 0;
        }
    }

    /* 3. 跳转到主程序 */
    _trm_init();  // 假设_trm_init是主程序入口
}
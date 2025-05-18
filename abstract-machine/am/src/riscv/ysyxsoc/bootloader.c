#include <stdint.h>

/* 声明外部符号 */
extern void _trm_init();  // 主程序入口
extern char _boot;        // bootloader 起始地址
extern char _text;        // .text 段在 PSRAM 中的起始地址
extern char _etext;       // .text 段在 PSRAM 中的结束地址
extern char _stext_lma;   // .text 段在 Flash 中的起始地址
extern char _rodata;      // .rodata 段在 PSRAM 中的起始地址
extern char _erodata;     // .rodata 段在 PSRAM 中的结束地址
extern char _srodata_lma; // .rodata 段在 Flash 中的起始地址
extern char _data;        // .data 段在 PSRAM 中的起始地址
extern char _edata;       // .data 段在 PSRAM 中的结束地址
extern char _sdata_lma;   // .data 段在 Flash 中的起始地址
extern char _bss_start;   // BSS 段起始地址
extern char _bss_end;     // BSS 段结束地址

/**
 * 拷贝 .text 段从 Flash 到 PSRAM
 */
void copy_text() __attribute__((section(".text.bootloader")));
void copy_text() {
    char *src = &_stext_lma;
    char *dst = &_text;
    while (dst < &_etext) {
        *dst++ = *src++;
    }
}

/**
 * 拷贝 .rodata 段从 Flash 到 PSRAM
 */
void copy_rodata() __attribute__((section(".text.bootloader")));
void copy_rodata() {
    char *src = &_srodata_lma;
    char *dst = &_rodata;
    while (dst < &_erodata) {
        *dst++ = *src++;
    }
}

/**
 * 拷贝 .data 段从 Flash 到 PSRAM
 */
void copy_data() __attribute__((section(".text.bootloader")));
void copy_data() {
    char *src = &_sdata_lma;
    char *dst = &_data;
    while (dst < &_edata) {
        *dst++ = *src++;
    }
}

/**
 * 清零 BSS 段
 */
void clear_bss() __attribute__((section(".text.bootloader")));
void clear_bss() {
    char *dst = &_bss_start;
    while (dst < &_bss_end) {
        *dst++ = 0;
    }
}

/**
 * Bootloader 入口点
 */
void bootloader() __attribute__((section(".text.bootloader")));
void bootloader() {
    /* 1. 拷贝 .text 段 */
    copy_text();

    /* 2. 拷贝 .rodata 段 */
    copy_rodata();

    /* 3. 拷贝 .data 段 */
    if (&_edata > &_data) {
        copy_data();
    }

    /* 4. 清零 BSS 段 */
    clear_bss();

    /* 5. 跳转到主程序 */
    _trm_init();
}
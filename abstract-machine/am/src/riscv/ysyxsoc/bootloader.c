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
void copy_text() __attribute__((section(".text.boot")));
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
void copy_rodata() __attribute__((section(".text.boot")));
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
void copy_data() __attribute__((section(".text.boot")));
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
void clear_bss() __attribute__((section(".text.boot")));
void clear_bss() {
    char *dst = &_bss_start;
    while (dst < &_bss_end) {
        *dst++ = 0;
    }
}

/**
 * Bootloader 入口点
 */
void bootloader() __attribute__((section(".text.boot")));
void bootloader() {
    // .text、.rodata、.data段在Flash中是各自独立的段 ，其加载地址（LMA）可能不连续，因此不能简单地一次性复制整个区域

    /* 1. 拷贝 .text 段 */
    copy_text();

    /* 2. 拷贝 .rodata 段 */
    copy_rodata();

    /* 3. 拷贝 .data 段 */
    if (&_edata > &_data) {
        copy_data();
    }

    /* 4. 清零 BSS 段 */
    // TAG:使用readelf查看elf文件时，bss有大小是正确的，bss的size只是告诉 loader 要分配多少内存给bss
    // 它不会出现在 .bin 文件中，除非你用了 --set-section-flags .bss=alloc,contents，这样 objcopy 就会错误地试图把这 0x14 字节写入 .bin，哪怕 .bss 是 NOBITS 类型。
    // contents属性表示该段在目标文件中包含实际数据
    clear_bss();

    /* 5. 跳转到主程序 */
    _trm_init();
}
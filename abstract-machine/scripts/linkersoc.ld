ENTRY(_start)

PHDRS {
    text PT_LOAD;    /* 代码段加载到 MROM */
    data PT_LOAD;    /* 数据段加载到 MROM，但运行时在 SRAM */
}

MEMORY {
    MROM (rx) : ORIGIN = 0x20000000, LENGTH = 4K   /* 4KB MROM */
    SRAM (rwx): ORIGIN = 0x0F000000, LENGTH = 8K   /* 8KB SRAM */
}

SECTIONS {
    /* 代码段固定在 MROM */
    . = ORIGIN(MROM);    /* 起始地址 0x20000000 */
    .text : {
        *(entry)        /* 启动代码 */
        *(.text*)       /* 所有代码段 */
    } :text

    /* 只读数据段（仍放在 MROM） */
    .rodata : {
        *(.rodata*)
    } :text

    /* 初始化数据段（.data）：
       - LMA 在 MROM（紧随 .rodata 之后）
       - VMA 在 SRAM（运行时地址）
    */
    .data : ALIGN(4) {
        _data_lma = LOADADDR(.data);    /* LMA = MROM 中的地址 */
        _data_vma = .;                  /* VMA = SRAM 中的地址 */
        *(.data*)
    } > SRAM AT> MROM :data

    /* BSS 段（仅 VMA 在 SRAM，不占用二进制文件空间） */
    .bss : ALIGN(4) {
        _bss_start = .;
        *(.bss*)
        *(.sbss*)
        *(.scommon)
        _bss_end = .;
    } > SRAM

    /* 栈区设置在 SRAM 末尾 */
    . = ORIGIN(SRAM) + LENGTH(SRAM);
    _stack_top = . - 0x1000;    /* 4KB 栈空间 */
    _stack_pointer = _stack_top;

    /* 堆区起始地址 */
    _heap_start = ALIGN(4);
}
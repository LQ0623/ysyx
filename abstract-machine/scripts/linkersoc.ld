ENTRY(_start)

PHDRS {
  text PT_LOAD;
  data PT_LOAD;
}

MEMORY {
  mrom  : ORIGIN = 0x20000000, LENGTH = 4K
  flash : ORIGIN = 0x30000000, LENGTH = 16M
  psram : ORIGIN = 0x80000000, LENGTH = 4M
  sram  : ORIGIN = 0x0f000000, LENGTH = 8K
}

SECTIONS {
  _psram_start = ORIGIN(psram);
  _psram_end = _psram_start + LENGTH(psram);

  /* 主程序代码段 */
  .text : {
    *(entry)
    *(.text.boot)       /* bootloader代码 */
    *(.text*)
    _etext = .;
  } > flash AT > flash : text

  /* 只读数据段 */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    _erodata = .;
  } > flash AT > flash

  /* 主程序数据段 (加载到PSRAM) */
  .data : {
    _data = .;
    *(.data*)
    *(.sdata*)
    _edata = .;
  } > psram AT > flash : data

  /* 主程序BSS段 (不分配到任何PHDR) */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > psram

  /* mem-test代码段 (运行在SRAM) */
  .text_memtest : {
    _stext_memtest = .;
    *(.text.memtest)
    _etext_memtest = .;
  } > sram AT > flash : text

  /* mem-test只读数据段 (运行在SRAM) */
  .rodata_memtest : {
    _srodata_memtest = .;
    *(.rodata.memtest)
    _erodata_memtest = .;
  } > sram AT > flash

  /* mem-test数据段 (运行在SRAM) */
  .data_memtest : {
    _sdata_memtest = .;
    *(.data.memtest)
    *(.sdata.memtest)
    _edata_memtest = .;
  } > sram AT > flash : data

  /* mem-test BSS段 (运行在SRAM) */
  .bss_memtest (NOLOAD) : {
    _sbss_memtest = .;
    *(.bss.memtest)
    *(.sbss.memtest)
    _ebss_memtest = .;
  } > sram

  /* 堆区定义在SRAM中，避开已使用的段 */
  .heap (NOLOAD) : {
    . = ALIGN(4);
    _heap_start = .;
    . += 0x1000;  /* 堆区大小设为4KB，可根据需要调整 */
    _heap_end = .;
  } > sram

  /* 栈区定义在SRAM顶部 */
  .stack (NOLOAD) : {
    . = ALIGN(4);
    _stack_bottom = .;
    . = ORIGIN(sram) + LENGTH(sram);
    _stack_top = .;
    _stack_pointer = .;
    end = .;
    _end = .;
  } > sram

  /* 获取各段的加载地址 (LMA) */
  _sdata_lma = LOADADDR(.data);
  _sdata_memtest_lma = LOADADDR(.data_memtest);
  _stext_memtest_lma = LOADADDR(.text_memtest);
  _srodata_memtest_lma = LOADADDR(.rodata_memtest);
}
ENTRY(_start)
PHDRS {
  fsbl PT_LOAD FLAGS(RX); /* First Stage Bootloader */
  ssbl PT_LOAD FLAGS(RX); /* Second Stage Bootloader */
  text PT_LOAD FLAGS(RX); /* Code and read-only data */
  data PT_LOAD FLAGS(RW); /* Writable data */
}

MEMORY {
  mrom  : ORIGIN = 0x20000000, LENGTH = 4K
  flash : ORIGIN = 0x30000000, LENGTH = 16M
  /* psram : ORIGIN = 0x80000000, LENGTH = 512M */
  psram : ORIGIN = 0x80000000, LENGTH = 4M
  sram  : ORIGIN = 0x0F000000, LENGTH = 8K
}

SECTIONS {
  _psram_start = ORIGIN(psram);
  _psram_end = _psram_start + LENGTH(psram);

  /* first stage Bootloader 段（位于 Flash） */
  .text.fsbootloader :
  {
    *(entry)
    _fsbl = .;
    *(.text.fsbl)
    _efsbl = .;
  } > flash AT > flash : fsbl

  /* second stage Bootloader 段（位于 SRAM */
  .text.ssbootloader :
  {
    _ssbl = .;
    *(.text.ssbl)
    _essbl = .;
  } > sram AT >flash : ssbl

  /* 代码段（运行在 PSRAM） */
  .text : {
    _text = .;
    *(.text*)
    _etext = .;
  } > psram AT > flash : text

  /* 只读数据段（运行在 PSRAM） */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    *(.srodata*)
    _erodata = .;
  } > psram AT> flash : text

  /* 数据段（运行在 PSRAM） */
  .data : {
    _data = .;
    *(.data*)
    *(.sdata*)
    _edata = .;
  } > psram AT > flash : data

  /* 判断 RTT 中是否定义了 data_extra 和 bss_extra */
  _data_extra       = DEFINED(_data_extra)      ? _data_extra       : 0;
  _edata_extra      = DEFINED(_edata_extra)     ? _edata_extra      : 0;
  _data_extra_lma   = DEFINED(_data_extra_lma)  ? _data_extra_lma   : 0;
  _edata_extra_lma  = DEFINED(_edata_extra_lma) ? _edata_extra_lma  : 0;

  /* BSS 段（运行在 PSRAM） */
  .bss (NOLOAD) : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > psram

  /* 判断 RTT 中是否定义了 data_extra 和 bss_extra */
  _bss_extra        = DEFINED(_bss_extra)       ? _bss_extra        : 0;
  _ebss_extra       = DEFINED(_ebss_extra)      ? _ebss_extra       : 0;

  /* 堆栈（运行在 SRAM） */
  .stack (NOLOAD) : {
    . = ALIGN(0x10);
    _stack_bottom = .;
    . = ORIGIN(sram) + LENGTH(sram) - 0x100;
    _stack_top = .;
    _stack_pointer = .;
  } > sram

  /* 堆（运行在 PSRAM） */
  .heap (NOLOAD) : {
    . = ALIGN(0x10);
    _heap_start = .;
    . = ORIGIN(psram) + LENGTH(psram) - 0x100;
    _heap_end = .;
  } > psram

  /* 段加载地址（LMA）符号 */
  _ssbl_lma  = LOADADDR(.text.ssbootloader);
  _stext_lma = LOADADDR(.text);
  _srodata_lma = LOADADDR(.rodata);
  _sdata_lma = LOADADDR(.data);
  _edata_lma = _sdata_lma + SIZEOF(.data);
}
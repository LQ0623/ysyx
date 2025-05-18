ENTRY(_start)
PHDRS {
  boot PT_LOAD;  
  text PT_LOAD;  
  data PT_LOAD;  
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

  /* Bootloader 段（位于 Flash） */
  . = ORIGIN(flash);
  .text.bootloader : {
    *(entry)
    *(.text.boot)
    _boot = .;
  } > flash AT> flash : boot

  /* 代码段（运行在 PSRAM） */
  .text : {
    _text = .;
    *(.text*)
    _etext = .;
  } > psram AT> flash : text

  /* 只读数据段（运行在 PSRAM） */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    *(.srodata*)
    _erodata = .;
  } > psram AT> flash

  /* 数据段（运行在 PSRAM） */
  .data : {
    _data = .;
    *(.data*)
    *(.sdata*)
    _edata = .;
  } > psram AT> flash : data

  /* BSS 段（运行在 PSRAM） */
  .bss (NOLOAD) : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > psram

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
  _stext_lma = LOADADDR(.text);
  _srodata_lma = LOADADDR(.rodata);
  _sdata_lma = LOADADDR(.data);
  _edata_lma = _sdata_lma + SIZEOF(.data);
}
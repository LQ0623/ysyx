ENTRY(_start)
PHDRS { 
  text PT_LOAD; 
  data PT_LOAD; 
}

MEMORY {
  mrom : ORIGIN = 0x20000000, LENGTH = 4K
  sram : ORIGIN = 0x0f000000, LENGTH = 8K
}

SECTIONS {
  /* 代码段 */
  . = ORIGIN(mrom);
  .text : {
    *(entry)
    *(.text.boot)
    *(.text*)
    _etext = .;
  } > mrom AT > mrom : text
  etext = .;

  .rodata : {
    _rodata = .;
    *(.rodata*)
    _erodata = .;
  } > mrom AT > mrom

  .data : {
    _data = .;
    *(.data)
    _edata = .;
  } > sram AT > mrom : data

  /* BSS段放在SRAM低地址 */
  . = ORIGIN(sram);  /* 0x0F000000 */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > sram

  /* 栈从sram末尾往下 */
  _stack_pointer = ORIGIN(sram) + LENGTH(sram);  /* 0x0F002000 */
  _stack_top = _stack_pointer - 0x800;           /* 栈底（预留1KB） */

  end = .;
  _end = .;

  /* 堆放在 bss 之后，假设在栈和 bss 之间分配 */
  _heap_start = _bss_end;
  _heap_end = _stack_top;

  /* 加载地址符号 */
  _sdata_lma = LOADADDR(.data);
  _edata_lma = _sdata_lma + SIZEOF(.data);
}

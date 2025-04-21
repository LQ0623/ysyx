ENTRY(_start)
PHDRS { 
  text PT_LOAD; 
  data PT_LOAD; 
  /* bss  PT_NULL; */
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
    *(.text.boot)   /* bootloader代码 */
    *(.text*)
    _etext = .;
  } > mrom AT > mrom : text
  etext = .;
  /* _etext = .; */
  
  /* 只读数据段 */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    _erodata = .;
  } > mrom AT > mrom : text
  
  /* 数据段 */
  .data : {
    _data = .;
    *(.data)
    _edata = .;
  } > sram AT > mrom : data
  /* edata = .;
  _data = .; */
  
  /* SRAM布局 (0x0F000000-0x0F0001FFF) */
  . = _sram_start;         /* 起始地址0x0F000000 */
  
  /* BSS段 */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > sram AT > sram
  
  _stack_top = ADDR(.bss) + SIZEOF(.bss);
  . = _stack_top + 0x800;
  _stack_pointer = .;
  end = .;
  _end = .;

  _heap_start = _stack_pointer;
  _heap_end = _heap_start + 0x400;

  /* ==== 加载地址符号 ==== */
  _sdata_lma = LOADADDR(.data);  /* MROM中的LMA起始地址 */
  _edata_lma = _sdata_lma + SIZEOF(.data);
}
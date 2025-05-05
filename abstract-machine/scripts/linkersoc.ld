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
    *(.text.boot)       /* bootloader代码 */
    *(.text*)           /* 其他代码 */
    _etext = .;
  } > mrom AT > mrom : text
  etext = .;

  /* 只读数据段 */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    _erodata = .;
  } > mrom AT > mrom

  /* 可以在这里获取data段的地址,也可以在后面使用LOADADDR获取data段在MROM中的地址 */
  /* _sdata_lma = .; */
  /* 数据段 (从MROM加载到SRAM) */
  .data : {
    _data = .;
    *(.data*)           /* 包含所有.data子段 */
    *(.sdata*)          /* 显式包含.sdata.str1/.sdata.test */
    _edata = .;
  } > sram AT > mrom : data
  /* _edata = .; */

  /* BSS段 (不分配到任何PHDR) */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > sram

  /* SRAM布局 */
  /*. = ORIGIN(sram);     /* 起始地址0x0F000000 */

  /* 堆栈和堆定义 */
  /* _stack_top = ALIGN(0x10); */
  _stack_top = . + 0x200;   /* 这是为了测试flash中调用char-test */
  . = _stack_top + 0x800;
  _stack_pointer = .;
  end = .;
  _end = .;

  /* _heap_start = _stack_pointer; */
  _heap_start = ALIGN(0x10);
  _heap_end = _heap_start + 0x400;

  /* 数据段加载地址符号 */
  _sdata_lma = LOADADDR(.data);  /* MROM中数据段的起始地址,LOADADDR是获取data段的加载地址 */
  _edata_lma = _sdata_lma + SIZEOF(.data);
}
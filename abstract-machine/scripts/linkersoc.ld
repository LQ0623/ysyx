ENTRY(_start)
PHDRS { text PT_LOAD; data PT_LOAD; }

SECTIONS {
  /* 代码段 */
  . = _pmem_start + _entry_offset;
  .text : {
    *(entry)
    *(.text*)
  } : text
  etext = .;
  _etext = .;
  
  /* 只读数据段 */
  .rodata : {
    *(.rodata*)
  }
  
  /* 数据段 */
  .data : {
    *(.data)
  } : data
  edata = .;
  _data = .;
  
  /* SRAM布局 (0x0F000000-0x0F0001FFF) */
  . = _sram_start;         /* 起始地址0x0F000000 */
  
  /* BSS段 */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  }
  
  /* 堆区设置 */
  _heap_start = .;         /* 堆起始地址0x0F000000 */
  _heap_end = . + 0x1C00;  /* 堆结束地址0x0F001C00（7KB） */
  
  /* 栈区设置 */
  . = _heap_end;           /* 栈起始地址0x0F001C00 */
  _stack_top = .;
  . = . + 0x400;          /* 栈区大小1KB（实际结束地址0x0F002000，但需限制在SRAM内） */
  
  /* 强制限制在SRAM物理范围内 */
  . = _sram_start + 0x2000; /* SRAM实际结束地址0x0F0001FFF */
  _stack_pointer = .;      /* 正确栈指针地址0x0F001FFF */
  
  /* 调试符号 */
  end = .;
  _end = .;
}
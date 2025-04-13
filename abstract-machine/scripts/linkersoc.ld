ENTRY(_start)

PHDRS {
  text PT_LOAD;
  data PT_LOAD;
}

SECTIONS {
  /* 将代码段放入MROM区域，确保入口点是0x20000000 */
  . = _pmem_start + _entry_offset;  /* 代码段起始地址 */
  .text : {
    *(entry)       /* 启动代码 */
    *(.text*)       /* 所有代码段 */
  } :text
  _etext = .;       /* 代码段结束地址 */
  
  /* 只读数据段（如常量） */
  .rodata : {
    *(.rodata*)
  }

  /* 切换到SRAM区域 */
  . = 0x0f000000;   /* 数据段起始地址，SRAM区 */
  _data_start = .;
  .data : {
    *(.data*)       /* 初始化数据段 */
  } :data
  _edata = .;       /* 数据段结束地址 */

  /* BSS段（未初始化数据） */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  }

  /* 堆区和栈区的内存设置 */
  _stack_top = ALIGN(0x400);
  . = _stack_top + 0x1000;   /* 4KB栈空间 */
  _stack_pointer = .;
  _heap_start = ALIGN(0x400);
  _heap_end = 0x0f000fff;    /* SRAM末尾 */

  /* 确保堆区结束后，数据和代码不会发生重叠 */
  end = .;
  _end = .;
}

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
  sram  : ORIGIN = 0x0f000000, LENGTH = 8K
}

SECTIONS {
  _psram_start = ORIGIN(psram);
  _psram_end = _psram_start + LENGTH(psram);

  /* 代码段 */
  . = ORIGIN(flash);
  .text.bootloader : {
    *(entry)
    *(.text.boot)       /* bootloader代码 */
    _boot = .;
  } > flash AT > flash : boot

  .text : {
    _text = .;
    *(.text*)           /* 其他代码 */
    _etext = .;
  } > sram AT > flash : text

  /* 只读数据段 */
  .rodata : {
    _rodata = .;
    *(.rodata*)
    _erodata = .;
  } > sram AT > flash

  /* 可以在这里获取data段的地址,也可以在后面使用LOADADDR获取data段在FLASH中的地址 */
  /* 数据段 (加载到PSRAM) */
  .data : {
    _data = .;
    *(.data*)           /* 包含所有.data子段 */
    *(.sdata*)          /* 显式包含.sdata.str1/.sdata.test */
    _edata = .;
  } > sram AT > flash : data

  /* BSS段 (不分配到任何PHDR) */
  .bss : {
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    _bss_end = .;
  } > sram

  .rela ALIGN(4) :
  {
    _rela = .;
    *(.rela*);
    _erela = .;
  }

  /* 堆栈和堆定义 */
  /* 堆区定义在PSRAM的剩余空间 */
  /* 堆区现在的 . 就是PSRAM存放了data段和bss段之后的地址 */
  .heap (NOLOAD) : {
    . = ALIGN(0x10);  /* 对齐至16字节 */
    _heap_start = .;
    /* . = ORIGIN(psram) + LENGTH(psram); */
    . = . + 0x100;
    _heap_end = .;
  } > sram
  /* SRAM中的堆栈 */
  .stack (NOLOAD) : {
    . = ALIGN(0x10);
    _stack_bottom = .;
    . = ORIGIN(sram) + LENGTH(sram);
    _stack_top = .;
    _stack_pointer = .;
    end = .;
    _end = .;
  } > sram

  /* 数据段加载地址（LMA）符号 */
  _stext_lma = LOADADDR(.text); /* 代码段的加载起始地址 */
  _srodata_lma = LOADADDR(.rodata); /* 只读数据段的加载起始地址 */
  _sdata_lma = LOADADDR(.data);  /* 数据段的起始地址,LOADADDR是获取data段的加载地址 */
  _edata_lma = _sdata_lma + SIZEOF(.data);
}
#include <proc.h>
#include <elf.h>
#include <fs.h>
#include <stdio.h>

#define ELF_MAGIC "\x7f" "ELF"

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
# define Elf_Word Elf64_Word
# define Elf_Addr Elf64_Addr
# define Elf_Off  Elf64_Off
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
# define Elf_Word Elf32_Word
# define Elf_Addr Elf32_Addr
# define Elf_Off  Elf32_Off
#endif

// 写入数据
static void disk_mem(Elf_Off offset,Elf_Word file_size,Elf_Word mem_size,Elf_Addr vaddr){
  void* buf = malloc(file_size);
  ramdisk_read(buf, offset, mem_size);
  memcpy((void*)vaddr, buf, file_size);
  memset((void*)(vaddr+file_size), 0, mem_size - file_size);
}

static uintptr_t loader(PCB *pcb, const char *filename) {

  // 检查ELF文件头
  Elf_Ehdr elf_header;

  // 获取program header的信息
  Elf_Phdr *phdr = (Elf_Phdr*)malloc(elf_header.e_phnum * sizeof(Elf_Phdr));

  //循环遍历LOAD类型并加载到内存中
  //加载区间     [VirtAddr, VirtAddr + MemSiz)
  //.bss清零区间 [VirtAddr + FileSiz, VirtAddr + MemSiz)
  int program_headers_num = elf_header.e_phnum;
  for(int i = 0;i < program_headers_num;i++){
    if(phdr[i].p_type == PT_LOAD){
      disk_mem(phdr[i].p_offset, phdr[i].p_filesz, phdr[i].p_memsz, phdr[i].p_vaddr);
    }
  }

  return elf_header.e_entry;

  // TODO();
  // return 0;
}

void naive_uload(PCB *pcb, const char *filename) {;
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %d", entry);
  ((void(*)())entry) ();
}


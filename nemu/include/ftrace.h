#ifndef __FTRACE_H__
#define __FTRACE_H__

#include <common.h>
#include <elf.h>
#define MAX_FUNC 1024
#define MAX_recursion 1024

typedef struct analysis_elf
{
    char* name;
    Elf32_Addr addr;
} func_name_collation;

typedef struct tail_rec_node
{
	vaddr_t pc;
	int depth;
    char* name;
	struct tail_rec_node *next;
} TailRecNode;

void init_tail_rec_list();
void insert_tail_rec(vaddr_t pc, int depth,char* name);
void remove_tail_rec();
void init_ftrace(char* elf_file);
void analysis_elf(func_name_collation* func_name,char* elf_file);
void ftrace_function(char operate,vaddr_t addr_inv,vaddr_t addr_func);

#endif
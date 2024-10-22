#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

static const uint32_t inst[] = {
    0b00000000010100000000000010010011, //addi x1 x0 5
    0b00000000000100000000000100010011, //addi x2 x0 1
    0b00000000001000000000000100010011, //addi x2 x0 2
    0b00000000010100001000000100010011 //addi x2 x1 5
};

uint32_t *init_mem(){
    uint32_t* memory = (uint32_t*)malloc(sizeof(inst) * sizeof(uint32_t));
    if(memory == NULL){
        exit(0);
    }
    memcpy(memory,inst,sizeof(inst));
    return memory;
}

uint32_t guest_to_host(uint32_t addr){
    return addr-0x80000000;
}

uint32_t pmem_read(uint32_t *memory,uint32_t vaddr){
    uint32_t paddr = guest_to_host(vaddr);
    return memory[paddr/4];
}
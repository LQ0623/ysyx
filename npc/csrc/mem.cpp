#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

static const uint32_t inst[] = {

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
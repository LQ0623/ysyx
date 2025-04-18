#include "../include/memory.h"

uint8_t *mrom = NULL;
static uint8_t *sram = NULL;

void init_mrom(){
    mrom = malloc(0xfff);
    memset(mrom, 0, 0xfff);     // 使用实际分配的大小清零
    assert(mrom);
    Log("mrom area [" FMT_PADDR ", " FMT_PADDR "]", MROM_BASE, MROM_BASE + MROM_SIZE);
}

void init_sram(){
    sram = malloc(0x1fff);
    memset(sram, 0, 0x1fff);     // 使用实际分配的大小清零
    assert(sram);
    Log("sram area [" FMT_PADDR ", " FMT_PADDR "]", SRAM_BASE, SRAM_BASE + SRAM_SIZE);
}

void init_soc(){
    init_mrom();
    init_sram();
    Log("soc init");
}

inline bool in_Mrom(paddr_t addr){
    return addr - MROM_BASE < MROM_SIZE;
}

static inline bool in_Sram(paddr_t addr){
    return addr - SRAM_BASE < SRAM_SIZE;
}

bool in_socMem(paddr_t addr){
    return in_Mrom(addr) || in_Sram(addr);
}

word_t soc_read(paddr_t paddr, int len){
    uint8_t *ptr = NULL;
    if(in_Mrom(paddr)){
        ptr = mrom + paddr - MROM_BASE;
    } else if(in_Sram(paddr)){
        ptr = sram + paddr - SRAM_BASE;
    } else assert(0);

    switch (len) {
        case 1: return *(uint8_t  *)ptr;
        case 2: return *(uint16_t *)ptr;
        case 4: return *(uint32_t *)ptr;
        default: assert(0);
    }
    assert(0);      // 到达这里说明没有取出来数据
    return 0;
}

void soc_write(paddr_t paddr, int len, word_t data){
    uint8_t *ptr = NULL;
    if(in_Mrom(paddr)){
        ptr = mrom + paddr - MROM_BASE;
    } else if(in_Sram(paddr)){
        ptr = sram + paddr - SRAM_BASE;
    } else assert(0);

    switch (len) {
        case 1: *(uint8_t  *)ptr = data; return;
        case 2: *(uint16_t *)ptr = data; return;
        case 4: *(uint32_t *)ptr = data; return;
        default: assert(0);
    }
}
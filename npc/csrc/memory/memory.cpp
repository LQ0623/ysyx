#include <my_memory.h>
#include <common.h>
#include <mtrace.h>

static const uint32_t img[] = {
	0x00000413,
    0x00009117,
    0xffc10113,
    0x00c000ef,
    0x00000513,
    0x00008067,
    0xff410113,
    0x00000517,
    0x01c50513,
    0x00112423,
    0xfe9ff0ef,
    0x00050513,
    0x00100073,
    0x0000006f
};

static uint8_t *pmem = NULL;

void init_mem(size_t size){ 
	pmem = (uint8_t *)malloc(size * sizeof(uint8_t));
	memcpy(pmem , img , sizeof(img));
	if(pmem == NULL){exit(0);}
	printf("npc physical memory area [%#x, %#lx]\n",RESET_VECTOR, RESET_VECTOR + size * sizeof(uint8_t));
}

uint8_t *guest_to_host(uint32_t paddr){return pmem + (paddr - RESET_VECTOR);}

extern "C" uint32_t pmem_read(uint32_t paddr){
	if(!(paddr >= 0x80000000 && paddr <= 0x87ffffff)) 
		return 0;

	uint32_t *inst_paddr = (uint32_t *)guest_to_host(paddr);

	#ifdef CONFIG_MTRACE
		mtrace_log_write(paddr, 32, 'r', 0);
	#endif

	return *inst_paddr;
}

extern "C" void pmem_write(int waddr, int wdata,char wmask){
	if(!(waddr >= 0x80000000 && waddr <= 0x87ffffff)) 
		return ;
	
	#ifdef CONFIG_MTRACE
		mtrace_log_write(waddr, wmask, 'w', wdata);
	#endif

    // printf("data is %x\n",wdata);
	uint8_t *vaddr = guest_to_host(waddr);
	uint8_t *iaddr;
	int i;
	int j;
	for(i = 0,j = 0;i < 4;i++){
		if(wmask & (1 << i)){
			iaddr = vaddr + i;
			*iaddr = (wdata >> (j * 8)) & 0xFF;
			j++;
		}
	}
}
#include <my_memory.h>
#include <common.h>
#include <mtrace.h>
#include <device.h>
#include <vga.h>

extern bool is_skip_diff;
extern word_t pc,dnpc;
static int count = 0;
static uint64_t timer = 0;

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
static int cnt = 0;

void init_mem(size_t size){ 
	pmem = (uint8_t *)malloc(size * sizeof(uint8_t));
	memcpy(pmem , img , sizeof(img));
	if(pmem == NULL){exit(0);}
	printf("npc physical memory area [%#x, %#lx]\n",RESET_VECTOR, RESET_VECTOR + size * sizeof(uint8_t));
}

uint8_t *guest_to_host(uint32_t paddr){return pmem + (paddr - RESET_VECTOR);}


extern "C" void flash_read(int32_t addr, int32_t *data) { assert(0); }
extern "C" void mrom_read(int32_t addr, int32_t *data) {
    // MROM 地址范围为 0x20000000 ~ 0x20000FFF（4KB）
    constexpr int32_t MROM_BASE = 0x20000000;
    constexpr int32_t MROM_SIZE = 0x1000;
	int align_addr = addr & (~3);
	*data = *(int32_t *)guest_to_host(align_addr);

    // if (addr >= MROM_BASE && addr < MROM_BASE + MROM_SIZE) {
    //     *data = 0x00100073; // ebreak 指令
    // } else {
    //     *data = 0; // 非法地址返回 0 或触发错误
    //     // assert(0 && "Invalid MROM address");
    // }
}


extern "C" uint32_t pmem_read(uint32_t paddr){
	if(!((paddr >= 0x80000000 && paddr <= 0x87ffffff) || (paddr == RTC_ADDR) || (paddr == RTC_ADDR + 4) || (paddr == KBD_ADDR))) 
		return 0;

	/**
	 * 如果是设备访问内存，直接不用进行difftest
	 */
	if(paddr == RTC_ADDR || paddr == RTC_ADDR + 4 || paddr == KBD_ADDR){
		// printf("KBD_ADDR:%d\n",paddr==KBD_ADDR);
		is_skip_diff = true;
	}

	if(paddr == RTC_ADDR+4) {
		timer = get_time(); 
		return (uint32_t)(timer >> 32);
	}
	else if(paddr == RTC_ADDR) {
		return (uint32_t)timer;
	}
	else if(paddr == KBD_ADDR){
		return (uint32_t)key_dequeue();
	}
	else if(paddr == VGACTL_ADDR + 4){
		update_vga();
	}
	uint32_t *inst_paddr = (uint32_t *)guest_to_host(paddr);

	#ifdef CONFIG_MTRACE
		mtrace_log_write(paddr, 32, 'r', 0);
	#endif

	return *inst_paddr;
}

extern "C" void pmem_write(int waddr, int wdata,char wmask){
	if(!((waddr >= 0x80000000 && waddr <= 0x87ffffff) || (waddr == SERIAL_PORT))){
		return ;
	}
	
	if(waddr == SERIAL_PORT){
		// printf("now_pc:%#x\n",now_pc);
		is_skip_diff = true;
	}
	
	#ifdef CONFIG_MTRACE
		mtrace_log_write(waddr, wmask, 'w', wdata);
	#endif

	// device_write == 0 表示当前没有设备写入串口
	if(waddr == SERIAL_PORT) {
		putc((char)wdata,stderr);
		return;
	}
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

// 用于跳过访问UART、RTC等外设的指令
extern "C" void skip(){
	is_skip_diff = true;
	return;
}
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

// 输出ABCD两个字符
static const uint32_t img_char_test[] = {
	0x100007b7,
	0x04100713,
	0x00e78023,
	0x04200713,
	0x00e78023,
	0x04300713,
	0x00e78023,
	0x04400713,
	0x00e78023,
	0x0000006f
};

static uint8_t *pmem = NULL;
static uint8_t *mrom = NULL;
static uint8_t *flash = NULL;
static uint8_t *psram = NULL;
static int cnt = 0;
static uint8_t flash_src_data[FLASH_SIZE];  // 原始数据缓冲区

void init_mem(size_t size){ 
	pmem = (uint8_t *)malloc(size * sizeof(uint8_t));
	memcpy(pmem , img , sizeof(img));
	if(pmem == NULL){exit(0);}
	printf("npc physical memory area [%#x, %#lx]\n",PMEM_BASE, PMEM_BASE + size * sizeof(uint8_t));
}

void init_mrom(){
	mrom = (uint8_t *)malloc(MROM_SIZE * sizeof(uint8_t));
	memcpy(mrom, img, sizeof(img));
	if(mrom == NULL) assert(0);
	printf("mrom memory area [%#x, %#lx]\n",MROM_BASE, MROM_BASE + MROM_SIZE * sizeof(uint8_t));
}

// TAG:这里只是为了测试flash的读需要
void generate_pattern_data() {
    for (uint32_t addr = 0; addr < FLASH_SIZE; addr++) {
        // 混合特征生成策略
        flash_src_data[addr] = 
            (addr & 0xFF) |                  // 低8位直接映射
            ((addr >> 8) & 0x0F) << 4 |      // 高4位映射到bit4-7
            (addr % 3) << 2 |                // 3种循环模式
            ((addr & 0x100) ? 0x80 : 0x00);  // 地址bit8作为最高位
			// if(addr < 10){
			// 	printf("addr is %x,data is 0x%08x\n",addr,flash_src_data[addr]);
			// }
    }
}

void init_flash(){
	// TAG:下面三行是测试flash_read使用的，可以删除
	printf("generate START\n");
	generate_pattern_data();
	printf("generate END\n");
	flash = (uint8_t *)malloc(FLASH_SIZE * sizeof(uint8_t));
	memset(flash, 0, FLASH_SIZE);
	// memcpy(flash, flash_src_data, FLASH_SIZE);
	// memcpy(flash, img_char_test, sizeof(img_char_test));
	memcpy(flash, img, sizeof(img));

	if(flash == NULL) assert(0);
	printf("flash memory area [%#x, %#lx]\n",FLASH_BASE, FLASH_BASE + FLASH_SIZE * sizeof(uint8_t));
}

void init_psram(){
	psram = (uint8_t *)malloc(PSRAM_SIZE * sizeof(uint8_t));
	memcpy(psram, img, sizeof(img));
	
	if(psram == NULL) assert(0);
	printf("psram memory area [%#x, %#lx]\n",PSRAM_BASE, PSRAM_BASE + PSRAM_SIZE * sizeof(uint8_t));
}

uint8_t *guest_to_host(uint32_t paddr){
	if(in_mrom(paddr)){
		return mrom + (paddr - MROM_BASE);
	} else if(in_flash(paddr)){
		return flash + (paddr - FLASH_BASE);
	}
	#ifdef CONFIG_SOC
		else if(in_psram(paddr)){
			return psram + (paddr - PSRAM_BASE);
		} 
		
	#else 
		else if(in_pmem(paddr)){
			return pmem + (paddr - PMEM_BASE);
		}
	#endif
	else{
		panic("%#x is out of bound of npc",paddr);
	}
}

// TAG:FALSH的大小端转化可能后续需要调整一下位置，现在是在flash_read将小端序转化为了大端序，然后在flash.v中转化为了小端序进行执行
// flash读取出来的数据需要转化大小端，因为使用的flash是MSB优先的
extern "C" void flash_read(int32_t addr, int32_t *data) {
	addr = addr + FLASH_BASE;
	// printf("flash addr is 0x%08x\n",addr);
	int align_addr = addr & (~3);

	// 需要转化大小端
	uint32_t read_value;
	read_value = *(uint32_t *)guest_to_host(align_addr);
	// printf("real read value is %08x\n",read_value);

	// 手动交换32位数据的字节序
    uint32_t swapped_value = 
        ((read_value & 0x000000FF) << 24) |
        ((read_value & 0x0000FF00) << 8)  |
        ((read_value & 0x00FF0000) >> 8)  |
        ((read_value & 0xFF000000) >> 24);

	// 赋值给输出参数
    *data = (int32_t)swapped_value;

	// *data = *(int32_t *)guest_to_host(align_addr);
	// printf("real read value is %08x\n",*data);
}

extern "C" void psram_read(int32_t addr, int32_t *data){
	// printf("psram read addr is %08x\n",addr);
	addr = addr + PSRAM_BASE;	// 如果传过来的地址不只是偏移量，这个就可以直接删除
	
	int align_addr = addr & (~3);

	// 需要转化大小端
	// uint32_t read_value;
	// read_value = *(uint32_t *)guest_to_host(align_addr);
	// // printf("real read value is %08x\n",read_value);

	// // 手动交换32位数据的字节序
    // uint32_t swapped_value = 
    //     ((read_value & 0x000000FF) << 24) |
    //     ((read_value & 0x0000FF00) << 8)  |
    //     ((read_value & 0x00FF0000) >> 8)  |
    //     ((read_value & 0xFF000000) >> 24);

	// // 赋值给输出参数
    // *data = (int32_t)swapped_value;

	*data = *(int32_t *)guest_to_host(align_addr);
	// printf("READ addr = %#x , data = %#x\n",align_addr - PSRAM_BASE, *data);
}

extern "C" void psram_write(int addr, int data,int wstrb){
	// printf("psram write addr is %08x\n",addr);
	addr = addr + PSRAM_BASE;	// 如果传过来的地址不只是偏移量，这个就可以直接删除

	// int align_addr = addr & (~3);
	int align_addr = addr;		// 在这里写入不用进行对齐的操作
	switch (wstrb)
	{
		case 0b0001:
			*(uint8_t *)guest_to_host(align_addr) = (uint8_t)data;
			// printf("WRITE addr = %#x , data = %#x ,wstrb = %d\n",align_addr - PSRAM_BASE, data, wstrb);
			break;
		case 0b0011:
			*(uint16_t *)guest_to_host(align_addr) = (uint16_t)data;
			// printf("WRITE addr = %#x , data = %#x ,wstrb = %d\n",align_addr, data, wstrb);
			break;
		case 0b1111:
			*(uint32_t *)guest_to_host(align_addr) = (uint32_t)data;
			// printf("WRITE addr = %#x , data = %#x ,wstrb = %d\n",align_addr - PSRAM_BASE, data, wstrb);
			break;
		default:
			printf("wstrb is %x\n",wstrb);
			panic("DONOT SUPPORT THIS WSTRB");
			break;
	}
}

extern "C" void mrom_read(int32_t addr, int32_t *data) {
    // MROM 地址范围为 0x20000000 ~ 0x20000FFF（4KB）
    // constexpr int32_t MROM_BASE = 0x20000000;
    // constexpr int32_t MROM_SIZE = 0x1000;
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
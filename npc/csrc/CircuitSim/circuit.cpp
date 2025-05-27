#include <circuit.h>
#include <my_memory.h>
#include <common.h>
#include <ftrace.h>
#include <device.h>
#include <../monitor/sdb/sdb.h>

CPU *cpu;

extern "C" void disassemble(char *str, int size, uint64_t pc, uint8_t *code, int nbyte);
static void statistic();
void difftest_step();

#define MAX_INST_TO_PRINT 10
#define LOG_BUF_SIZE 256
uint64_t g_nr_guest_inst = 0;
static bool g_print_step = false;
word_t pc, snpc, dnpc, inst, prev_pc, PCW, if_valid, read_target_module;
uint64_t timer_start, timer_end,g_timer;	// 测试运行的时间的
uint64_t timer,count = 0;
static uint8_t opcode;

// TAG: 判断一条指令是否卡死使用
word_t prev_inst;
uint32_t ins_counter;	// 计数这个指令运行了多少个周期,超过一定的周期就停止

static bool is_change = false;	// 监视点是否有改变

void single_cycle(){  //  0 --> 0 > 1 --> 1 > 0 this is a cycle in cpu  _|-|_|-
	cpu->clock=0;   //negedge 1->0 no
    cpu->eval();  //process 0->0 refresh combination logic and make them stable
	#ifdef CONFIG_DUMP_WAVE
		dump_wave_inc();
	#endif
	cpu->clock=1;   //posedge 0->1 refresh sequential logic
    cpu->eval();  //process 1->1 refresh sequential logic(sim)
	#ifdef CONFIG_DUMP_WAVE
		dump_wave_inc();
	#endif
}

void reset_cpu(int n) {
	cpu->reset = 1;
 	while (n -- > 0) single_cycle();
	cpu->reset = 0;
}

void assert_fail_msg() {
  isa_reg_display();
  statistic();
}

/**
 * 反汇编以及写文件
 */
void instruction_disassemble(char *p, uint8_t *inst){
	char *ps = p;
	p += snprintf(p, LOG_BUF_SIZE, "%#x:",pc);
	int ilen = 4;
	int i;
	for (i = ilen - 1; i >= 0; i --) {
		p += snprintf(p, 4, " %02x", inst[i]);
	}
	int ilen_max = 4;
	int space_len = ilen_max - ilen;
	if (space_len < 0) space_len = 0;
	space_len = space_len * 3 + 1;
	memset(p, ' ', space_len);
	p += space_len;
	
	disassemble(p, ps + LOG_BUF_SIZE - p, (uint64_t)pc, inst, ilen);
}

/**
 * DiffTest
 */
static void trace_and_difftest() {

	/**
	 * 1、监视点的比较测试
	 */
	#ifdef CONFIG_CC_WATCHPOINT
		bool point_diff = point_difftest();
		if(point_diff == true){
			is_change = true;
		}
	#endif

	/**
	 * 2、是否开启instruction trace
	 */
	#ifdef CONFIG_ITRACE
		if(if_valid == 1){
			char log_buf[LOG_BUF_SIZE] = {0};
			
			// TAG:这里是为了找bug加入的,后面可以删除
			// printf("if_valid is %d\n",if_valid);
			// uint8_t *ptr = (uint8_t*)&inst; // 将指针转为uint8_t类型
			// for(int i=0; i<4; i++) {
			// 	printf("%02x", ptr[i]); // 通过索引访问连续字节
			// }
			// printf("\n");


			instruction_disassemble(log_buf, (uint8_t *)&inst);
			// 输出到屏幕
			if (g_print_step) { puts(log_buf); }
			// Write the log buffer to the log file
			log_write("%s\n", log_buf);
		}
	#endif

	/**
	 * 3、是否开启function trace
	 */
	#ifdef CONFIG_FTRACE
		opcode = BITS(inst, 6, 0);	
		if(opcode == 0b1101111){
			ftrace_function_call(pc, dnpc, false);
		}
		else if(opcode == 0b1100111){
  			int rd = BITS(inst, 11, 7);
			uint32_t imm = SEXT(BITS(inst, 31, 20), 12);
			if(inst == 0x00008067){
				ftrace_function_ret(pc);	// ret -> jalr x0, 0(x1)
			}else if(rd == 0 && imm == 0){
				ftrace_function_call(pc,dnpc,true);	// jr rs1 -> jalr x0, 0(rs1)
			}else {
				ftrace_function_call(pc,dnpc,false);
			}
		}
	#endif

	/**
	 * 4、是否开启diff test测试
	 */
	#ifdef CONFIG_DIFFTEST
		if(if_valid == 1){
			// printf("NPC: %x: %08x\n",pc,inst);
			difftest_step();
		}
	#endif
}


/* cpu single cycle in exec */
static void exec_once(){
	single_cycle();
}
extern bool is_skip_diff;
// TAG：这里如果执行的程序很大，需要改为uint64或者uint128，因为uint32可能不够
void cpu_exec(uint64_t n){
	//max inst to print to stdout
	g_print_step = (n < MAX_INST_TO_PRINT);
	
	// TAG: 判断一条指令是否卡死使用
	prev_inst	 = 0;
	ins_counter  = 0;

	while(n > 0){
		// timer = get_time() - timer_start;
		// if(timer / 1000000 == count){
		// 	printf("this is %d s\n\n",count++);
		// }

		prev_pc = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__pc_FD;
		exec_once();
		snpc = pc + 4;
		inst = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__sram_axi_rdata;
		pc = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__pc_FD;
		dnpc = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__IF__DOT__PC__DOT__real_npc;
		// PCW = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__PCW;
		read_target_module = cpu -> rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__arbiter__DOT__read_targeted_module;
		if_valid = cpu -> rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__sram_axi_rvalid & (read_target_module == 1);	// if_valid为高表示已经取到了指令，使用sram_axi_rvalid判断可能会有取数的指令干扰，所以需要加入read_targeted_module==1辅助判断是否为取指
		// printf("inst is %#x\n",inst);
		// printf("if_valid is %d\t",if_valid);
		// printf("PCW is %d\t",PCW);
		// printf("cpp pc is %#x\t",pc);
		// printf("cpp npc is %#x\t",dnpc);
		// printf("is_skip:%d\n",is_skip_diff);
		get_reg();
		g_nr_guest_inst ++;
		#ifdef CONFIG_TRACE
			trace_and_difftest();
			if(is_change){
				is_change = false;
				break;
			}
		#endif
		IFDEF(CONFIG_DEVICE, device_update());
		n--;

		// 判断指令的运行周期是否超过上限(存在卡死的情况)
		if(prev_inst == inst){
			ins_counter++;
			if(ins_counter >= MAX_NUM_CYC){
				printf("pc is %08x,inst is %#x\n",pc,inst);
				panic("The number of instruction execution cycles exceeds the maximum execution cycle");
			}
		}else{
			ins_counter = 0;
			prev_inst = inst;
		}
	}
}


static void statistic() {
	Log("total guest instructions = %lu\n", g_nr_guest_inst);
}

// TAG:测试开始的时间
extern "C" void time_start(){
	timer_start	= get_time();
}

// TAG:测试结束的时间
extern "C" void time_end(){
	timer_end	= get_time();
}

// timer_counter 是表示用了多少个时钟周期
extern "C" void npc_trap(int timer_counter){
	#ifdef CONFIG_DUMP_WAVE
		dump_wave_inc();
		close_wave();
	#endif
	bool success;
	word_t code = isa_reg_str2val("a0",&success);
	if(code == 0)
		Log("\033[1;32mHIT GOOD TRAP\033[0m");
	else
		Log("\033[1;31mHIT BAD TRAP\033[0m exit code = %d",code);
	Log("trap in %#x",pc);
	g_timer = timer_end - timer_start;
	Log("host time spent = %lu us",g_timer);
	Log("total cycle spent = %d",timer_counter);
	statistic();
	exit(0);
}

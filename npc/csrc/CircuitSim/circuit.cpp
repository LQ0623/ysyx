#include <circuit.h>
#include <my_memory.h>
#include <common.h>
#include <../monitor/sdb/sdb.h>

Vysyx_24100006_cpu *cpu;

extern "C" void disassemble(char *str, int size, uint64_t pc, uint8_t *code, int nbyte);
static void statistic();
void difftest_step();

#define MAX_INST_TO_PRINT 10
uint64_t g_nr_guest_inst = 0;
static bool g_print_step = false;
word_t pc, snpc, dnpc, inst, prev_pc;
static uint8_t opcode;

bool is_change = false;	// 监视点是否有改变

void single_cycle(){  //  0 --> 0 > 1 --> 1 > 0 this is a cycle in cpu  _|-|_|-
	cpu->clk=0;   //negedge 1->0 no
    cpu->eval();  //process 0->0 refresh combination logic and make them stable
	#ifdef CONFIG_DUMP_WAVE
		dump_wave_inc();
	#endif
	cpu->clk=1;   //posedge 0->1 refresh sequential logic
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
void record_inst_trace(char *p, uint8_t *inst){
	char *ps = p;
	p += snprintf(p,128, "%#x:",prev_pc);
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

	disassemble(p, ps+128-p, (uint64_t)prev_pc, inst, ilen);
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
		is_change = true;
	#endif

	/**
	 * 2、是否开启diff test测试
	 */
	// IFDEF(CONFIG_DIFFTEST, difftest_step(_this->pc, dnpc));

	/**
	 * 3、是否开启instruction trace
	 */
	#ifdef CONFIG_ITRACE
		char log_buf[256];
		instruction_disassemble(log_buf, (uint8_t *)&inst);
		// Write the log buffer to the log file
    	log_write("%s\n", log_buf);
		if (g_print_step) { puts(log_buf); }
	#endif
}


/* cpu single cycle in exec */
static void exec_once(){
	single_cycle();
}

void cpu_exec(uint32_t n){
	//max inst to print to stdout
	g_print_step = (n < MAX_INST_TO_PRINT);
	while(n > 0){
		prev_pc = cpu->rootp -> ysyx_24100006_cpu__DOT__pc;
		exec_once();
		snpc = pc + 4;
		inst = cpu->rootp -> ysyx_24100006_cpu__DOT__instruction;
		pc = cpu->rootp -> ysyx_24100006_cpu__DOT__pc;
		dnpc = cpu->rootp -> ysyx_24100006_cpu__DOT__npc;
		get_reg();
		g_nr_guest_inst ++;
		#ifdef CONFIG_TRACE
			trace_and_difftest();
			if(is_change){
				is_change = false;
				break;
			}
		#endif
		n--;
	}
}


static void statistic() {
  Log("total guest instructions = %lu\n", g_nr_guest_inst);
}

extern "C" void npc_trap(){
	#ifdef CONFIG_DUMP_WAVE
		dump_wave_inc();
		close_wave();
	#endif
	bool success;
	word_t code = isa_reg_str2val("a0",&success);
	// word_t code = cpu->rootp -> ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10];
	if(code == 0)
		Log("\033[1;32mHIT GOOD TRAP\033[0m");
	else
		Log("\033[1;31mHIT BAD TRAP\033[0m exit code = %d",code);
	Log("trap in %#x\n",pc);
	statistic();
	exit(0);
}

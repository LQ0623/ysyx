#include <circuit.h>
#include <my_memory.h>
#include <common.h>

Vysyx_24100006_cpu *cpu;

static void statistic();

#define MAX_INST_TO_PRINT 10
uint64_t g_nr_guest_inst = 0;
static bool g_print_step = false;
word_t pc, snpc, dnpc, inst , prev_pc;
static uint8_t opcode;

void single_cycle(){  //  0 --> 0 > 1 --> 1 > 0 this is a cycle in cpu  _|-|_|-
	cpu->clk=0;   //negedge 1->0 no
    cpu->eval();  //process 0->0 refresh combination logic and make them stable
	cpu->clk=1;   //posedge 0->1 refresh sequential logic
    cpu->eval();  //process 1->1 refresh sequential logic(sim)
	dump_wave_inc();
}

void reset_cpu(int n) {
	cpu->reset = 1;
 	while (n -- > 0) single_cycle();
	cpu->reset = 0;
	dump_wave_inc();
}

void assert_fail_msg() {
//   isa_reg_display();
  statistic();
}

static void statistic() {
  printf("total guest instructions = %lu", g_nr_guest_inst);
}

extern "C" void npc_trap(){
	dump_wave_inc();
	close_wave();
	// int code = cpu->rootp -> ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10];
	// if(code == 0)
	// 	printf("\033[1;32mHIT GOOD TRAP\033[0m");
	// else
	// 	printf("\033[1;31mHIT BAD TRAP\033[0m exit code = %d",code);
	printf(" trap in %#x\n",pc);
	statistic();
	exit(0);
}

void end(){
	close_wave();
}
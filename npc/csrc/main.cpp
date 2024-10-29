#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vysyx_24100006_cpu.h"
#include "Vysyx_24100006_cpu__Dpi.h"
#include "svdpi.h"
#include "Vysyx_24100006_cpu___024root.h"

static Vysyx_24100006_cpu *top;

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static int ebreak = 1;

void single_cycle(){
    top->clk = 0;top->eval();//contextp -> timeInc(1);tfp->dump(contextp->time());
    top->clk = 1;top->eval();//contextp -> timeInc(1);tfp->dump(contextp->time());
}

extern "C"  void npc_trap() {
    ebreak = 0;
    uint32_t code = top->rootp -> ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1];
    for(int i = 0;i < 32;i++){
        code = top->rootp -> ysyx_24100006_cpu__DOT__registerfile__DOT__rf[i];
        printf("code is %x\n",code);
    }
    if(code == 0)
		printf("\033[1;32mHIT GOOD TRAP\033[0m\n");
	else
		printf("\033[1;31mHIT BAD TRAP\033[0m exit code = %d\n",code);
}

static void reset_cpu(int n){
    top->reset = 1;
    while(n--) single_cycle();
    top->reset = 0;
}

int main() {
    
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vysyx_24100006_cpu;

    // contextp->traceEverOn(true);
    //Verilated::traceEverOn(true);

    //top->trace(tfp, 0) ;
    //tfp->open("build/sim.vcd") ;

    reset_cpu(10);
    //int count = 0;
    while(ebreak) {
        //printf("count is %d\n",count++);
        single_cycle();
    }
    //tfp -> close();
    return 0;
}

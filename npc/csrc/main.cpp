#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vysyx_24100006_cpu.h"
#include "Vysyx_24100006_cpu__Dpi.h"
#include "svdpi.h"

static Vysyx_24100006_cpu *top;

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static int ebreak = 1;

void single_cycle(){
    top->clk = 0;top->eval();contextp -> timeInc(1);tfp->dump(contextp->time());
    top->clk = 1;top->eval();contextp -> timeInc(1);tfp->dump(contextp->time());
}

extern "C"  void npc_trap() {
    ebreak = 0;
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

    contextp->traceEverOn(true);

    top->trace(tfp, 0) ;
    tfp->open("build/sim.vcd") ;

    reset_cpu(1);
    int count = 0;
    while(ebreak) {
        printf("count is %d\n",count++);
        single_cycle();
    }
    tfp -> close();
    return 0;
}

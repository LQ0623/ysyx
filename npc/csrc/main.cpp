#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vysyx_24100006_cpu.h"

static Vysyx_24100006_cpu *top;

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

uint32_t guest_to_host(uint32_t addr);

void single_cycle(){
    top->clk = 0;top->eval();
    top->clk = 1;top->eval();
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
    for(int i = 0;i < 5;i++) {
        single_cycle();
        contextp -> timeInc(1);
        tfp->dump(contextp->time());
    }
    tfp -> close();
    return 0;
}

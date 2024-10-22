#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vysyx_24100006_cpu.h"

static Vysyx_24100006_cpu *top;

VerilatedContext* contextp = NULL;
VerilatedFstC* tfp = NULL;

uint32_t *init_mem(size_t size);
uint32_t guest_to_host(uint32_t addr);
uint32_t pmem_read(uint32_t *memory, uint32_t vaddr);

void single_cycle(){
    top->clk = 0;top->eval();
    top->clk = 1;top->eval();
}

static void reset(int n){
    top->reset = 1;
    while(n--) single_cycle();
    top->reset = 0;
}

int main(int argc, char** argv) {
    
    uint32_t *memory;
    memory = init_mem(3);

    
    contextp = new VerilatedContext;
    contextp->traceEverOn(true);
    tfp = new VerilatedFstC;
    top = new Vysyx_24100006_cpu;

    top->trace(tfp, 5) ;
    tfp->open("build/waveform.fst") ;

    reset(10);
    while (1) {
    	top->instruction = pmem_read(memory,top->x_pc);
        single_cycle();
        tfp->dump(contextp->time());
        contextp -> timeInc(1);
    }
    tfp -> close();
    return 0;
}

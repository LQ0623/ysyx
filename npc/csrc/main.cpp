#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vysyx_24100006_cpu.h"

static Vysyx_24100006_cpu *dut;

VerilatedContext* contextp = NULL;
VerilatedFstC* tfp = NULL;

uint32_t *init_mem();
uint32_t guest_to_host(uint32_t addr);
uint32_t pmem_read(uint32_t *memory, uint32_t vaddr);

void single_cycle(){
    dut->clk = 0;dut->eval();
    dut->clk = 1;dut->eval();
}

static void reset(int n){
    dut->reset = 1;
    while(n--) single_cycle();
    dut->reset = 0;
}

int main(int argc, char** argv) {
    
    uint32_t *memory;
    memory = init_mem();

    Verilated::traceEver0n(true) ;
    contextp = new VerilatedContext;
    tfp = new VerilatedFstC;
    dut->trace(tfp, 0) ;
    tfp->open("build/waveform.fst") ;

    reset(10);
    while (1) {
    	dut->instruction = pmem_read(memory,dut->x_pc);
        single_cycle();
        tfp->dump(contextp->time());
        contextp -> timeInc(1);
    }
    tfp -> close();
    return 0;
}

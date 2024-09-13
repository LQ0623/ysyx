#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
//#include <nvboard.h>

#include "Vtop.h"
#include "verilated.h"
//#include "verilated_vcd_c.h"
#include "verilated_fst_c.h"

// static TOP_NAME dut;

// void nvboard_bind_all_pins(TOP_NAME* top);


int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

    /* generate VCD 格式 */
    // VerilatedVcdC* tfp = new VerilatedVcdC;
    /* generate FST 格式 */
    VerilatedFstC* tfp = new VerilatedFstC;
    contextp->traceEverOn(true);
    top->trace(tfp, 0); // 0 是自定义的起始时间
    tfp->open("simx.fst");
    
    // nvboard_bind_all_pins(&dut);
    // nvboard_init();

    while (1) {
    	// nvboard_update();
        contextp->timeInc(1);
        int a = rand() & 1;
        int b = rand() & 1;
        top->a = a;
        top->b = b;
        top->eval();
        printf("a = %d, b = %d, f = %d\n", a, b, top->f);
        assert(top->f == (a ^ b));
        tfp->dump(contextp->time());
    }
    delete top;
    tfp->close();
    delete contextp;
    return 0;
}

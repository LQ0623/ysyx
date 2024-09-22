#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <nvboard.h>

#include "Vtop.h"

static TOP_NAME dut;

void nvboard_bind_all_pins(TOP_NAME* top);


int main(int argc, char** argv) {
    
    nvboard_bind_all_pins(&dut);
    nvboard_init();

    while (1) {
    	nvboard_update();
        dut.eval();
        printf("a = %d, b = %d, f = %d\n", dut.a, dut.b, dut.f);
    }
    return 0;
}

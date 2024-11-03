#include <circuit.h>
#include <my_memory.h>

void reset_cpu(int n);
void single_cycle();
void init_wave();
void end();

int main() {
    init_wave();
    reset_cpu(10);
    while(1){
        single_cycle();
    }
    end();
    return 0;
}

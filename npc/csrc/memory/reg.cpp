#include <my_memory.h>
#include <svdpi.h>
#include <circuit.h>

word_t gpr[REGNUM];

void isa_reg_display();

extern Vysyx_24100006_cpu *cpu;
const char *regs[] = {
    "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

void get_reg(){
    for(int i = 0;i < REGNUM; i++){
        gpr[i] = cpu->rootp -> ysyx_24100006_cpu__DOT__registerfile__DOT__rf[i];
    }
}

void isa_reg_display(){
    for(int i = 0;i < REGNUM;i++){
        printf("%s = " FMT_WORD "\n",regs[i],gpr[i]);
    }
}

word_t isa_reg_str2val(const char *s, bool *success){
    // get_reg();
    for(int i = 0;i < REGNUM;i++){  
        if(strcmp(regs[i],s) == 0){
            *success = true;
            return gpr[i];
        }
    }
    if(strcmp("pc",s) == 0){
        *success = true;
        return pc;
    }
    *success = false;
    return 0;
}
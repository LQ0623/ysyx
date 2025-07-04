#include <my_memory.h>
#include <svdpi.h>
#include <circuit.h>

word_t gpr[REGNUM];
word_t csr[4];

void isa_reg_display();

const char *regs[] = {
    "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

const char *SysReg[] = {
    "mstatus", "mtvec", "mepc", "mcause"
};

void get_reg(){
#ifdef CONFIG_SOC
    for(int i = 0;i < REGNUM; i++){
        gpr[i] = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__ID__DOT__GPR__DOT__rf[i];
    }
    csr[0] = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__ID__DOT__CSR__DOT__rf[0];
    csr[1] = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__ID__DOT__CSR__DOT__rf[1];
    csr[2] = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__ID__DOT__CSR__DOT__rf[3];
    csr[3] = cpu->rootp -> ysyxSoCFull__DOT__asic__DOT__cpu__DOT__cpu__DOT__ID__DOT__CSR__DOT__rf[2];
    //0:mstatus 1:mtvec 2:mepc 3:mcause
#else
    for(int i = 0;i < REGNUM; i++){
        gpr[i] = cpu->rootp -> ysyx_24100006__DOT__ID__DOT__GPR__DOT__rf[i];
    }
    csr[0] = cpu->rootp -> ysyx_24100006__DOT__ID__DOT__CSR__DOT__rf[0];
    csr[1] = cpu->rootp -> ysyx_24100006__DOT__ID__DOT__CSR__DOT__rf[1];
    csr[2] = cpu->rootp -> ysyx_24100006__DOT__ID__DOT__CSR__DOT__rf[3];
    csr[3] = cpu->rootp -> ysyx_24100006__DOT__ID__DOT__CSR__DOT__rf[2];
    //0:mstatus 1:mtvec 2:mepc 3:mcause
#endif
}

void isa_reg_display(){
    for(int i = 0;i < REGNUM;i++){
        printf("%s = " FMT_WORD "\n",regs[i],gpr[i]);
    }
    printf("dut-mstatus = %#x\n",csr[0]);
    printf("dut-mtvec = %#x\n",csr[1]);
    printf("dut-mepc = %#x\n",csr[2]);
    printf("dut-mcause = %#x\n",csr[3]);
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
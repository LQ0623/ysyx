#include <dlfcn.h>
#include <my_memory.h>
#include <common.h>
#include <circuit.h>

struct CPU_state {
  word_t gpr[REGNUM];
  word_t pc;
};
bool is_skip_diff = false;
void (*ref_difftest_memcpy)(paddr_t addr, void *buf, size_t n, bool direction) = NULL;
void (*ref_difftest_regcpy)(void *dut, bool direction) = NULL;
void (*ref_difftest_exec)(uint64_t n) = NULL;
void (*ref_difftest_raise_intr)(uint64_t NO) = NULL;

enum { DIFFTEST_TO_DUT, DIFFTEST_TO_REF };

void init_difftest(char *ref_so_file, long img_size) {
    if(ref_so_file == NULL) return;

    void *handle;
    handle = dlopen(ref_so_file, RTLD_LAZY);
    assert(handle);

    ref_difftest_memcpy = (void(*)(paddr_t,void *,size_t,bool))dlsym(handle, "difftest_memcpy");
    assert(ref_difftest_memcpy);

    ref_difftest_regcpy = (void(*)(void *,bool))dlsym(handle, "difftest_regcpy");
    assert(ref_difftest_regcpy);

    ref_difftest_exec = (void(*)(uint64_t))dlsym(handle, "difftest_exec");
    assert(ref_difftest_exec);

    ref_difftest_raise_intr = (void(*)(uint64_t))dlsym(handle, "difftest_raise_intr");
    assert(ref_difftest_raise_intr);

    void (*ref_difftest_init)() = (void(*)())dlsym(handle, "difftest_init");
    assert(ref_difftest_init);

    #ifdef CONFIG_TRACE
        Log("Differential testing: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
        Log("The result of every instruction will be compared with %s. "
            "This will help you a lot for debugging, but also significantly reduce the performance. "
            "If it is not necessary, you can turn it off in menuconfig.", ref_so_file);
    #else
        Log("Differential testing: %s", ANSI_FMT("OFF", ANSI_FG_RED));
    #endif

    ref_difftest_init();
    ref_difftest_memcpy(RESET_VECTOR, (void *)guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF);
    //get dut reg into CPU_state struct
    CPU_state dut_r;
    dut_r.pc = 0x80000000;
    for(int i = 0;i < REGNUM;i++)
        dut_r.gpr[i] = gpr[i];
    ref_difftest_regcpy(&dut_r, DIFFTEST_TO_REF);
}

bool static checkregs(struct CPU_state *ref_r){
    bool flag = true;
    // printf("ref_r.pc : %#x,pc : %#x\n",ref_r->pc,pc);
    for(int i = 0;i < REGNUM;i++){
        // nemu的gpr与npc的gpr相比
        if(ref_r -> gpr[i] != gpr[i]){
            Log("PC = 0x%x, Difftest Reg Compare failed at %s, Difftest reg Get " FMT_WORD ", NPC reg Get " FMT_WORD, pc, regs[i], ref_r->gpr[i], gpr[i]);
            flag = false;
        }
    }
    if(ref_r -> pc != pc){
        Log("ref_r pc: " FMT_WORD "\tpc:" FMT_WORD "\tdnpc:" FMT_WORD, ref_r->pc, pc, dnpc);
        flag = false;
    }
    return flag;
}

void difftest_step() {
    if(ref_difftest_memcpy == NULL) return;

    CPU_state ref_r;
    ref_difftest_regcpy(&ref_r, DIFFTEST_TO_DUT);
    // 因为如果设备跳过之后，给定的pc是npc，所以在执行完一拍之后才能对上拍
    if(ref_r.pc == pc){
        return;
    }

    if(is_skip_diff == true){
        is_skip_diff = false;
        //get dut reg into CPU_state struct
        CPU_state dut_r;
        dut_r.pc = dnpc;
        for(int i = 0;i < REGNUM;i++){
            dut_r.gpr[i] = gpr[i];
        }
        // printf("%#x\n",dut_r.pc);
        //copy reg to ref to skip this inst
        ref_difftest_regcpy(&dut_r, DIFFTEST_TO_REF);
        return;
    }
    
    ref_difftest_exec(1);
    ref_difftest_regcpy(&ref_r, DIFFTEST_TO_DUT);
    // printf("ref_r.pc: %#x\n\n",ref_r.pc);

    if(!checkregs(&ref_r)){
        isa_reg_display();
        assert(0);
    }
}
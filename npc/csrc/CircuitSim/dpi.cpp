#include <common.h>
#include <circuit.h>

extern "C" void get_inst(int inst){
	inst = inst;
    // if(inst != 0){
    //     printf("inst is %x\n",inst);
    // }
}
extern "C" void get_pc(int pc){
    prev_pc = pc;
	pc = pc;
    // if(pc != 0){
    //     printf("pc is %x\t",pc);
    // }
}
extern "C" void get_npc(int npc){
	npc = npc;
}
extern "C" void get_PCW(svBit PCW){
	PCW = PCW;
}
extern "C" void get_if_valid(svBit if_valid){
	if_valid = if_valid;
}
extern "C" void get_wb_ready(svBit wb_ready){
	wb_ready = wb_ready;
}

// extern "C" void get_gpr(const svOpenArrayHandle rf){
//     // 获取数组指针
//     uint32_t *arr = (uint32_t *)svGetArrayPtr(rf);
//     if(arr == NULL){
//         assert(0);
//     }
//     for(int i = 0; i<REGNUM;i++){
//         printf("gpr[%d] is %x\n",i,arr[i]);
//     }
//     // 写入 gpr[0..31]
//     for (int i = 0; i < REGNUM; i++) {
//         gpr[i] = arr[i];
//     }
// }

// extern "C" void get_csr(const svOpenArrayHandle rf){
//     printf("a\n");
//     // 获取数组指针
//     uint32_t *arr = (uint32_t *)svGetArrayPtr(rf);
//     // 写入 csr[0..3]
//     for (int i = 0; i < 4; i++) {
//         csr[i] = arr[i];
//     }
// }
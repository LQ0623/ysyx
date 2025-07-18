/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <isa.h>
#include <cpu/cpu.h>
#include <difftest-def.h>
#include <memory/paddr.h>
#define NR_GPR 16
struct diff_context_t {
  word_t gpr[16];
  word_t pc;
  word_t csr[4];
};

/**
 * 内存拷贝
 */
__EXPORT void difftest_memcpy(paddr_t addr, void *buf, size_t n, bool direction) {
  // assert(0);
  printf("addr is %08x\n",addr);
  void *nemu_buf = (void *)guest_to_host(addr);
  if(direction == DIFFTEST_TO_REF)  //dut -> ref (buf -> addr(nemu_buf))
    memcpy(nemu_buf , buf , n);
  else                              //ref -> dut (addr(nemu_buf) -> buf)
    memcpy(buf , nemu_buf, n);
}

/**
 * 寄存器拷贝
 */
__EXPORT void difftest_regcpy(void *dut, bool direction) {
  // assert(0);
  int i = 0;
  struct diff_context_t *dut_state = (struct diff_context_t *)dut;
  if(direction == DIFFTEST_TO_REF){
    for(i = 0;i < NR_GPR ; i++){
      cpu.gpr[i] = dut_state->gpr[i];
    }
    cpu.pc = dut_state->pc;
  }
  else{
    for(i = 0;i < NR_GPR ; i++){
      dut_state->gpr[i] = cpu.gpr[i];
    }
    dut_state->pc = cpu.pc;
    dut_state->csr[0] = cpu.csr[0x300]; //mstatus
    dut_state->csr[1] = cpu.csr[0x305]; //mtvec
    dut_state->csr[2] = cpu.csr[0x341]; //mepc
    dut_state->csr[3] = cpu.csr[0x342]; //mcause
  }
}

/**
 * 差异执行
 */
__EXPORT void difftest_exec(uint64_t n) {
  // assert(0);
  cpu_exec(n);
}

__EXPORT void difftest_raise_intr(word_t NO) {
  assert(0);
}

__EXPORT void difftest_init(int port) {

  // void init_soc();
  // init_soc();
  void init_mem();
  init_mem();
  /* Perform ISA dependent initialization. */
  init_isa();
}

// 添加一个函数，用于跳过diff test
__EXPORT bool difftest_skip(){
  extern bool skip;
  bool skip_temp = skip;
  skip = false;
  return skip_temp;
}

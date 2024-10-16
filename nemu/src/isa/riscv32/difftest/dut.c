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
#include <cpu/difftest.h>
#include "../local-include/reg.h"

// 这里传入的参数是指ref执行之后的结果
bool isa_difftest_checkregs(CPU_state *ref_r, vaddr_t pc) {
  int reg_num = ARRLEN(cpu.gpr);
  for(int i = 0; i < reg_num;i++){
    if(cpu.gpr[i] != ref_r->gpr[i]){
      Log("gpr[%d] : ref_r.gpr[%d]: %x\tcpu.gpr[%d]: %x", i, i, ref_r->gpr[i], i, cpu.gpr[i]);
      return false;
    }
  }
  if(ref_r->pc != cpu.pc){
    Log("ref_r: %x\tpc: %x", ref_r->pc, cpu.pc);
    return false;
  }
  return true;
}

void isa_difftest_attach() {
}

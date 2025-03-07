#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

static Context* (*user_handler)(Event, Context*) = NULL;

Context* __am_irq_handle(Context *c) {
  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) {
      case EVENT_YIELD:
        ev.event = EVENT_YIELD;
        c->mepc += 0x4; 
        break;
      case 11:
        ev.event = EVENT_SYSCALL;
        c->mepc += 0x4;
        break;
      default: ev.event = EVENT_ERROR; break;
    }

    c = user_handler(ev, c);
    assert(c != NULL);
  }

  return c;
}

extern void __am_asm_trap(void);

bool cte_init(Context*(*handler)(Event, Context*)) {
  // initialize exception entry
  asm volatile("csrw mtvec, %0" : : "r"(__am_asm_trap));

  // register event handler
  user_handler = handler;

  return true;
}

/**
 * kstack是栈的范围 ，因为
 * entry是内核线程的入口 
 * arg则是内核线程的参数
 */
Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  // 需要在kstack的底部创建一个以entry为入口的上下文结构
  // 现在有了CP，只需要在CP的底部创建一个Context就行
  // Context *c    = (Context *)kstack.end - 1;
  Context *c  = (Context *)(kstack.end - sizeof(Context));
  c->mepc       = (uintptr_t)entry;
  c->mstatus    = 0x1800;
  // 在riscv32中，对于整数和指针类型的参数，前8个参数通常通过x10 - x17这8个通用寄存器来传递
  c->gpr[10]    = (uintptr_t)arg;
  return c;
}


void yield() {
#ifdef __riscv_e
  asm volatile("li a5, -1; ecall");
#else
  asm volatile("li a7, -1; ecall");
#endif
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}

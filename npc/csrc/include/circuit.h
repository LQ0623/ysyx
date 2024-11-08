#ifndef __CIRCUIT_H__
#define __CIRCUIT_H__
#include <Vysyx_24100006_cpu.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <svdpi.h>
#include <Vysyx_24100006_cpu__Dpi.h>
#include <Vysyx_24100006_cpu___024root.h>
#include <common.h>
extern Vysyx_24100006_cpu *cpu;
extern word_t inst,pc,dnpc;
//circuit
void single_cycle();
void cpu_exec(uint32_t n);
void reset_cpu(int n);
//wave
void init_wave();
void dump_wave_inc();
void close_wave();
//some simulator action
#define BITMASK(bits) ((1ull << (bits)) - 1)
#define BITS(x, hi, lo) (((int64_t)(x) >> (lo)) & BITMASK((hi) - (lo) + 1)) // similar to x[hi:lo] in verilog
#define SEXT(x, len) ({ struct { int64_t n : len; } __x = { .n = static_cast<int64_t>(x) }; (uint64_t)__x.n; })
#endif
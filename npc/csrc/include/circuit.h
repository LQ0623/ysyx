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
#endif
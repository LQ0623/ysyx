#ifndef __CIRCUIT_H__
#define __CIRCUIT_H__

#include <verilated.h>
#include <verilated_vcd_c.h>
#include <svdpi.h>
#ifdef CONFIG_SOC
#include <VysyxSoCFull.h>
#include <VysyxSoCFull__Dpi.h>
#include <VysyxSoCFull___024root.h>
#else
#include <Vysyx_24100006.h>
#include <Vysyx_24100006__Dpi.h>
#include <Vysyx_24100006___024root.h>
#endif

#include <common.h>
#ifdef CONFIG_SOC
#define CPU VysyxSoCFull
extern CPU *cpu;
#else
#define CPU Vysyx_24100006
extern CPU *cpu;
#endif
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
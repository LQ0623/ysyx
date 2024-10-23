// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vysyx_24100006_cpu.h for the primary calling header

#ifndef VERILATED_VYSYX_24100006_CPU___024ROOT_H_
#define VERILATED_VYSYX_24100006_CPU___024ROOT_H_  // guard

#include "verilated.h"

class Vysyx_24100006_cpu__Syms;
class Vysyx_24100006_cpu___024unit;


class Vysyx_24100006_cpu___024root final : public VerilatedModule {
  public:
    // CELLS
    Vysyx_24100006_cpu___024unit* __PVT____024unit;

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(reset,0,0);
    CData/*4:0*/ ysyx_24100006_cpu__DOT__rd;
    CData/*0:0*/ __Vtrigrprev__TOP__clk;
    CData/*0:0*/ __VactContinue;
    VL_OUT(result,31,0);
    VL_OUT(x_pc,31,0);
    IData/*31:0*/ ysyx_24100006_cpu__DOT__pc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__npc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__instruction;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__IM__DOT__i;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__registerfile__DOT__i;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 1024> ysyx_24100006_cpu__DOT__IM__DOT__instructions;
    VlUnpacked<IData/*31:0*/, 32> ysyx_24100006_cpu__DOT__registerfile__DOT__rf;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vysyx_24100006_cpu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vysyx_24100006_cpu___024root(Vysyx_24100006_cpu__Syms* symsp, const char* v__name);
    ~Vysyx_24100006_cpu___024root();
    VL_UNCOPYABLE(Vysyx_24100006_cpu___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard

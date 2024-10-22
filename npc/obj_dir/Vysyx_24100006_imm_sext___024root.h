// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vysyx_24100006_imm_sext.h for the primary calling header

#ifndef VERILATED_VYSYX_24100006_IMM_SEXT___024ROOT_H_
#define VERILATED_VYSYX_24100006_IMM_SEXT___024ROOT_H_  // guard

#include "verilated.h"

class Vysyx_24100006_imm_sext__Syms;

class Vysyx_24100006_imm_sext___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_OUT8(ysyx_24100006_MuxKey__02Eout,0,0);
    VL_IN8(ysyx_24100006_MuxKey__02Ekey,0,0);
    VL_IN8(ysyx_24100006_MuxKey__02Elut,3,0);
    VL_OUT8(ysyx_24100006_MuxKeyWithDefault__02Eout,0,0);
    VL_IN8(ysyx_24100006_MuxKeyWithDefault__02Ekey,0,0);
    VL_IN8(default_out,0,0);
    VL_IN8(ysyx_24100006_MuxKeyWithDefault__02Elut,3,0);
    VL_IN8(reset,0,0);
    CData/*0:0*/ ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out;
    CData/*0:0*/ ysyx_24100006_MuxKey__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out;
    CData/*0:0*/ ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__wen;
    CData/*4:0*/ ysyx_24100006_cpu__DOT__rd;
    CData/*4:0*/ ysyx_24100006_cpu__DOT__waddr;
    CData/*0:0*/ __Vtrigrprev__TOP__clk;
    CData/*0:0*/ __VactContinue;
    VL_IN(instruction,31,0);
    VL_OUT(result,31,0);
    VL_OUT(x_pc,31,0);
    IData/*31:0*/ ysyx_24100006_cpu__DOT__pc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__npc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__wdata;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VicoIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*1:0*/, 2> ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_MuxKey__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_MuxKey__DOT__i0__DOT__data_list;
    VlUnpacked<CData/*1:0*/, 2> ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list;
    VlUnpacked<IData/*31:0*/, 32> ysyx_24100006_cpu__DOT__registerfile__DOT__rf;
    VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vysyx_24100006_imm_sext__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vysyx_24100006_imm_sext___024root(Vysyx_24100006_imm_sext__Syms* symsp, const char* v__name);
    ~Vysyx_24100006_imm_sext___024root();
    VL_UNCOPYABLE(Vysyx_24100006_imm_sext___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard

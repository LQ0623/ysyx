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
    CData/*3:0*/ ysyx_24100006_cpu__DOT__aluop;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__Reg_Write;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__Mem_Write;
    CData/*1:0*/ ysyx_24100006_cpu__DOT__Reg_Write_RD;
    CData/*3:0*/ ysyx_24100006_cpu__DOT__Jump;
    CData/*2:0*/ ysyx_24100006_cpu__DOT__Imm_Type;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__AluSrcA;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__AluSrcB;
    CData/*4:0*/ ysyx_24100006_cpu__DOT__rd;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit;
    CData/*0:0*/ ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit;
    CData/*0:0*/ __Vtrigrprev__TOP__clk;
    CData/*0:0*/ __VactContinue;
    VL_OUT(x_result,31,0);
    VL_OUT(x_pc,31,0);
    IData/*31:0*/ ysyx_24100006_cpu__DOT__pc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__npc;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__instruction;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__wdata_reg;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__rs1_data;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__rs2_data;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu_result;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__sext_imm;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu_a_data;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu_b_data;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__registerfile__DOT__i;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu__DOT__complement;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out;
    IData/*31:0*/ ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 1024> ysyx_24100006_cpu__DOT__IM__DOT__instructions;
    VlUnpacked<QData/*33:0*/, 3> ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*1:0*/, 3> ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list;
    VlUnpacked<IData/*31:0*/, 3> ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list;
    VlUnpacked<IData/*31:0*/, 32> ysyx_24100006_cpu__DOT__registerfile__DOT__rf;
    VlUnpacked<QData/*34:0*/, 5> ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*2:0*/, 5> ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list;
    VlUnpacked<IData/*31:0*/, 5> ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list;
    VlUnpacked<QData/*32:0*/, 2> ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list;
    VlUnpacked<IData/*31:0*/, 2> ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list;
    VlUnpacked<QData/*32:0*/, 2> ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list;
    VlUnpacked<IData/*31:0*/, 2> ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list;
    VlUnpacked<QData/*35:0*/, 2> ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*3:0*/, 2> ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list;
    VlUnpacked<IData/*31:0*/, 2> ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list;
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

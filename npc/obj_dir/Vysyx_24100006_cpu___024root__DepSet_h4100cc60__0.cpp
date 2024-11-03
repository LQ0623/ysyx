// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu___024root.h"

void Vysyx_24100006_cpu___024root___eval_act(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vysyx_24100006_cpu___024root___nba_sequent__TOP__1(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___nba_sequent__TOP__1\n"); );
    // Body
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
        = ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
                       == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
                       [0U]))) & vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
                          == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
                          [1U]))) & vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
                          == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
                          [2U]))) & vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
                          == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
                          [3U]))) & vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list
              [3U]));
    vlSelf->ysyx_24100006_cpu__DOT__wdata_reg = vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out;
}

void Vysyx_24100006_cpu___024root___nba_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf);

void Vysyx_24100006_cpu___024root___eval_nba(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vysyx_24100006_cpu___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
        Vysyx_24100006_cpu___024root___nba_sequent__TOP__1(vlSelf);
    }
}

void Vysyx_24100006_cpu___024root___eval_triggers__act(Vysyx_24100006_cpu___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__act(Vysyx_24100006_cpu___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__nba(Vysyx_24100006_cpu___024root* vlSelf);
#endif  // VL_DEBUG

void Vysyx_24100006_cpu___024root___eval(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vysyx_24100006_cpu___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vysyx_24100006_cpu___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_cpu.v", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                Vysyx_24100006_cpu___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vysyx_24100006_cpu___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_cpu.v", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vysyx_24100006_cpu___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vysyx_24100006_cpu___024root___eval_debug_assertions(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG

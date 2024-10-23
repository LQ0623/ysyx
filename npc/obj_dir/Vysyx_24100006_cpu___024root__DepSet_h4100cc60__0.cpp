// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"

#include "Vysyx_24100006_cpu___024root.h"

void Vysyx_24100006_cpu___024root___eval_act(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vysyx_24100006_cpu___024root___nba_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___nba_sequent__TOP__0\n"); );
    // Body
    vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0U;
    vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32 = 0U;
    if (vlSelf->reset) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i = 0x20U;
        vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 1U;
        vlSelf->ysyx_24100006_cpu__DOT__pc = 0x80000000U;
    } else {
        vlSelf->ysyx_24100006_cpu__DOT__pc = vlSelf->ysyx_24100006_cpu__DOT__npc;
    }
    vlSelf->x_pc = vlSelf->ysyx_24100006_cpu__DOT__pc;
    vlSelf->ysyx_24100006_cpu__DOT__npc = ((IData)(4U) 
                                           + vlSelf->ysyx_24100006_cpu__DOT__pc);
}

VL_INLINE_OPT void Vysyx_24100006_cpu___024root___nba_sequent__TOP__1(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___nba_sequent__TOP__1\n"); );
    // Body
    vlSelf->__Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32 
        = vlSelf->result;
    vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32 = 1U;
    vlSelf->__Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32 
        = (0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                    >> 7U));
}

VL_INLINE_OPT void Vysyx_24100006_cpu___024root___nba_sequent__TOP__2(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___nba_sequent__TOP__2\n"); );
    // Body
    vlSelf->ysyx_24100006_cpu__DOT__instruction = vlSelf->ysyx_24100006_cpu__DOT__IM__DOT__instructions
        [(0x3ffU & (vlSelf->ysyx_24100006_cpu__DOT__pc 
                    >> 2U))];
    if (vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xaU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xbU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xcU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xdU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xeU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0xfU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x10U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x11U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x12U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x13U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x14U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x15U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x16U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x17U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x18U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x19U] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1aU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1bU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1cU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1dU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1eU] = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0x1fU] = 0U;
    }
    if (vlSelf->__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[vlSelf->__Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32] 
            = vlSelf->__Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v32;
    }
    vlSelf->result = (vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                      [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                 >> 0xfU))] + (((- (IData)(
                                                           (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                            >> 0x1fU))) 
                                                << 0xcU) 
                                               | (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x14U)));
}

void Vysyx_24100006_cpu___024root___eval_nba(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vysyx_24100006_cpu___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    if (vlSelf->__VnbaTriggered.at(1U)) {
        Vysyx_24100006_cpu___024root___nba_sequent__TOP__1(vlSelf);
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vysyx_24100006_cpu___024root___nba_sequent__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
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
    VlTriggerVec<2> __VpreTriggered;
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

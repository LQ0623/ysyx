// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_imm_sext.h for the primary calling header

#include "verilated.h"

#include "Vysyx_24100006_imm_sext___024root.h"

VL_INLINE_OPT void Vysyx_24100006_imm_sext___024root___ico_sequent__TOP__0(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___ico_sequent__TOP__0\n"); );
    // Body
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list[0U] 
        = (3U & (IData)(vlSelf->ysyx_24100006_MuxKey__02Elut));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list[1U] 
        = (3U & ((IData)(vlSelf->ysyx_24100006_MuxKey__02Elut) 
                 >> 2U));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list[0U] 
        = (3U & (IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list[1U] 
        = (3U & ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut) 
                 >> 2U));
    vlSelf->result = (vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                      [(0x1fU & (vlSelf->instruction 
                                 >> 0xfU))] + (((- (IData)(
                                                           (vlSelf->instruction 
                                                            >> 0x1fU))) 
                                                << 0xcU) 
                                               | (vlSelf->instruction 
                                                  >> 0x14U)));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list[0U] 
        = (1U & (IData)(vlSelf->ysyx_24100006_MuxKey__02Elut));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list[1U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKey__02Elut) 
                 >> 2U));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list[0U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut) 
                 >> 1U));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list[1U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut) 
                 >> 3U));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list[0U] 
        = (1U & (IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list[1U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut) 
                 >> 2U));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list[0U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKey__02Elut) 
                 >> 1U));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list[1U] 
        = (1U & ((IData)(vlSelf->ysyx_24100006_MuxKey__02Elut) 
                 >> 3U));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out 
        = (((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey) 
            == vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list
            [0U]) & vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey) 
           == vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out 
        = ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out) 
           | (((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey) 
               == vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list
               [1U]) & vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey) 
              == vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_MuxKeyWithDefault__02Eout 
        = ((IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit)
            ? (IData)(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out)
            : (IData)(vlSelf->default_out));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_MuxKey__02Ekey) 
           == vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_MuxKey__02Ekey) 
              == vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out 
        = (((IData)(vlSelf->ysyx_24100006_MuxKey__02Ekey) 
            == vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list
            [0U]) & vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out 
        = ((IData)(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out) 
           | (((IData)(vlSelf->ysyx_24100006_MuxKey__02Ekey) 
               == vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list
               [1U]) & vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_MuxKey__02Eout = vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out;
}

void Vysyx_24100006_imm_sext___024root___eval_ico(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_ico\n"); );
    // Body
    if (vlSelf->__VicoTriggered.at(0U)) {
        Vysyx_24100006_imm_sext___024root___ico_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Vysyx_24100006_imm_sext___024root___eval_act(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vysyx_24100006_imm_sext___024root___nba_sequent__TOP__0(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    IData/*31:0*/ __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    CData/*0:0*/ __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    // Body
    __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0U;
    if (vlSelf->ysyx_24100006_cpu__DOT__wen) {
        __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 
            = vlSelf->ysyx_24100006_cpu__DOT__wdata;
        __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 1U;
        __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 
            = vlSelf->ysyx_24100006_cpu__DOT__waddr;
    }
    vlSelf->ysyx_24100006_cpu__DOT__pc = ((IData)(vlSelf->reset)
                                           ? vlSelf->ysyx_24100006_cpu__DOT__npc
                                           : 0x80000000U);
    if (__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[__Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0] 
            = __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    }
    vlSelf->result = (vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                      [(0x1fU & (vlSelf->instruction 
                                 >> 0xfU))] + (((- (IData)(
                                                           (vlSelf->instruction 
                                                            >> 0x1fU))) 
                                                << 0xcU) 
                                               | (vlSelf->instruction 
                                                  >> 0x14U)));
    vlSelf->ysyx_24100006_cpu__DOT__npc = ((IData)(4U) 
                                           + vlSelf->ysyx_24100006_cpu__DOT__pc);
}

void Vysyx_24100006_imm_sext___024root___eval_nba(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vysyx_24100006_imm_sext___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
}

void Vysyx_24100006_imm_sext___024root___eval_triggers__ico(Vysyx_24100006_imm_sext___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__ico(Vysyx_24100006_imm_sext___024root* vlSelf);
#endif  // VL_DEBUG
void Vysyx_24100006_imm_sext___024root___eval_triggers__act(Vysyx_24100006_imm_sext___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__act(Vysyx_24100006_imm_sext___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__nba(Vysyx_24100006_imm_sext___024root* vlSelf);
#endif  // VL_DEBUG

void Vysyx_24100006_imm_sext___024root___eval(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval\n"); );
    // Init
    CData/*0:0*/ __VicoContinue;
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    vlSelf->__VicoIterCount = 0U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        __VicoContinue = 0U;
        Vysyx_24100006_imm_sext___024root___eval_triggers__ico(vlSelf);
        if (vlSelf->__VicoTriggered.any()) {
            __VicoContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VicoIterCount))) {
#ifdef VL_DEBUG
                Vysyx_24100006_imm_sext___024root___dump_triggers__ico(vlSelf);
#endif
                VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_IM.v", 4, "", "Input combinational region did not converge.");
            }
            vlSelf->__VicoIterCount = ((IData)(1U) 
                                       + vlSelf->__VicoIterCount);
            Vysyx_24100006_imm_sext___024root___eval_ico(vlSelf);
        }
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vysyx_24100006_imm_sext___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vysyx_24100006_imm_sext___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_IM.v", 4, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                Vysyx_24100006_imm_sext___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vysyx_24100006_imm_sext___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_IM.v", 4, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vysyx_24100006_imm_sext___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vysyx_24100006_imm_sext___024root___eval_debug_assertions(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->ysyx_24100006_MuxKey__02Ekey 
                     & 0xfeU))) {
        Verilated::overWidthError("ysyx_24100006_MuxKey.key");}
    if (VL_UNLIKELY((vlSelf->ysyx_24100006_MuxKey__02Elut 
                     & 0xf0U))) {
        Verilated::overWidthError("ysyx_24100006_MuxKey.lut");}
    if (VL_UNLIKELY((vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey 
                     & 0xfeU))) {
        Verilated::overWidthError("ysyx_24100006_MuxKeyWithDefault.key");}
    if (VL_UNLIKELY((vlSelf->default_out & 0xfeU))) {
        Verilated::overWidthError("default_out");}
    if (VL_UNLIKELY((vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut 
                     & 0xf0U))) {
        Verilated::overWidthError("ysyx_24100006_MuxKeyWithDefault.lut");}
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG

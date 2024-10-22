// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_imm_sext.h for the primary calling header

#include "verilated.h"

#include "Vysyx_24100006_imm_sext___024root.h"

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_static(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_initial(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vtrigrprev__TOP__clk = vlSelf->clk;
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_final(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_triggers__stl(Vysyx_24100006_imm_sext___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__stl(Vysyx_24100006_imm_sext___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_stl(Vysyx_24100006_imm_sext___024root* vlSelf);

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_settle(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        Vysyx_24100006_imm_sext___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                Vysyx_24100006_imm_sext___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_IM.v", 4, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            Vysyx_24100006_imm_sext___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__stl(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VstlTriggered.at(0U)) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___stl_sequent__TOP__0(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->ysyx_24100006_cpu__DOT__npc = ((IData)(4U) 
                                           + vlSelf->ysyx_24100006_cpu__DOT__pc);
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

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___eval_stl(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___eval_stl\n"); );
    // Body
    if (vlSelf->__VstlTriggered.at(0U)) {
        Vysyx_24100006_imm_sext___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__ico(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VicoTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VicoTriggered.at(0U)) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__act(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VactTriggered.at(0U)) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___dump_triggers__nba(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root___ctor_var_reset(Vysyx_24100006_imm_sext___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->ysyx_24100006_MuxKey__02Eout = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKey__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKey__02Elut = VL_RAND_RESET_I(4);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__02Eout = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey = VL_RAND_RESET_I(1);
    vlSelf->default_out = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut = VL_RAND_RESET_I(4);
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->instruction = VL_RAND_RESET_I(32);
    vlSelf->result = VL_RAND_RESET_I(32);
    vlSelf->x_pc = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__pc = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__npc = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__wen = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__rd = VL_RAND_RESET_I(5);
    vlSelf->ysyx_24100006_cpu__DOT__waddr = VL_RAND_RESET_I(5);
    vlSelf->ysyx_24100006_cpu__DOT__wdata = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->__Vtrigrprev__TOP__clk = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}

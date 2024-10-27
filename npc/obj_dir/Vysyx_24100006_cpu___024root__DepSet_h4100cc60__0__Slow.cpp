// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu___024root.h"

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_static(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_initial__TOP(Vysyx_24100006_cpu___024root* vlSelf);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_initial(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_initial\n"); );
    // Body
    Vysyx_24100006_cpu___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
    vlSelf->__Vm_traceActivity[0U] = 1U;
    vlSelf->__Vtrigrprev__TOP__clk = vlSelf->clk;
}

extern const VlWide<11>/*351:0*/ Vysyx_24100006_cpu__ConstPool__CONST_hb47a61ae_0;

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_initial__TOP(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_initial__TOP\n"); );
    // Body
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0U] = 2U;
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1U] = 1U;
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2U] = 0U;
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0U] = 4U;
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1U] = 3U;
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2U] = 2U;
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3U] = 1U;
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4U] = 0U;
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[0U] = 1U;
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[1U] = 0U;
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[0U] = 1U;
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[1U] = 0U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0U] = 9U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1U] = 8U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[2U] = 7U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[3U] = 6U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[4U] = 5U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[5U] = 4U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[6U] = 3U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[7U] = 2U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[8U] = 1U;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[9U] = 0U;
    VL_READMEM_N(true, 32, 1024, 0, VL_CVT_PACK_STR_NW(11, Vysyx_24100006_cpu__ConstPool__CONST_hb47a61ae_0)
                 ,  &(vlSelf->ysyx_24100006_cpu__DOT__IM__DOT__instructions)
                 , 0, ~0ULL);
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
    vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i = 0x20U;
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_final(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_triggers__stl(Vysyx_24100006_cpu___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__stl(Vysyx_24100006_cpu___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_stl(Vysyx_24100006_cpu___024root* vlSelf);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_settle(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        Vysyx_24100006_cpu___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                Vysyx_24100006_cpu___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("/home/lq/ysyx-workbench/npc/vsrc/ysyx_24100006_cpu.v", 1, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            Vysyx_24100006_cpu___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__stl(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VstlTriggered.at(0U)) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___stl_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_stl(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_stl\n"); );
    // Body
    if (vlSelf->__VstlTriggered.at(0U)) {
        Vysyx_24100006_cpu___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__act(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___dump_triggers__act\n"); );
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
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__nba(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___ctor_var_reset(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->x_result = VL_RAND_RESET_I(32);
    vlSelf->x_pc = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__pc = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__npc = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__instruction = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__write_sext = VL_RAND_RESET_I(2);
    vlSelf->ysyx_24100006_cpu__DOT__aluop = VL_RAND_RESET_I(4);
    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = VL_RAND_RESET_I(2);
    vlSelf->ysyx_24100006_cpu__DOT__Jump = VL_RAND_RESET_I(4);
    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = VL_RAND_RESET_I(3);
    vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask = VL_RAND_RESET_I(8);
    vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = VL_RAND_RESET_I(2);
    vlSelf->ysyx_24100006_cpu__DOT__rd = VL_RAND_RESET_I(5);
    vlSelf->ysyx_24100006_cpu__DOT__wdata_reg = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__rs1_data = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__rs2_data = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu_result = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__sext_imm = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__raddr = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__rdata = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__cf = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__IM__DOT__instructions[__Vi0] = VL_RAND_RESET_I(32);
    }
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_Q(34);
    }
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 5; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_Q(35);
    }
    for (int __Vi0 = 0; __Vi0 < 5; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(3);
    }
    for (int __Vi0 = 0; __Vi0 < 5; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_Q(33);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_Q(33);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 10; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_Q(36);
    }
    for (int __Vi0 = 0; __Vi0 < 10; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(4);
    }
    for (int __Vi0 = 0; __Vi0 < 10; ++__Vi0) {
        vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(32);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0 = 0;
    vlSelf->__VdfgTmp_hf65ad926__0 = 0;
    vlSelf->__Vtrigrprev__TOP__clk = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}

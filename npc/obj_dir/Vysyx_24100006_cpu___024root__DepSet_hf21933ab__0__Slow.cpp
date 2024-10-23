// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu__Syms.h"
#include "Vysyx_24100006_cpu___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__stl(Vysyx_24100006_cpu___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___eval_triggers__stl(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.at(0U) = (0U == vlSelf->__VstlIterCount);
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vysyx_24100006_cpu___024root___dump_triggers__stl(vlSelf);
    }
#endif
}

void Vysyx_24100006_cpu___024unit____Vdpiimwrap_is_ebreak_TOP____024unit(IData/*31:0*/ inst);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___stl_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->x_pc = vlSelf->ysyx_24100006_cpu__DOT__pc;
    vlSelf->ysyx_24100006_cpu__DOT__npc = ((IData)(4U) 
                                           + vlSelf->ysyx_24100006_cpu__DOT__pc);
    vlSelf->ysyx_24100006_cpu__DOT__instruction = vlSelf->ysyx_24100006_cpu__DOT__IM__DOT__instructions
        [(0x3ffU & (vlSelf->ysyx_24100006_cpu__DOT__pc 
                    >> 2U))];
    Vysyx_24100006_cpu___024unit____Vdpiimwrap_is_ebreak_TOP____024unit(vlSelf->ysyx_24100006_cpu__DOT__instruction);
    vlSelf->result = (vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                      [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                 >> 0xfU))] + (((- (IData)(
                                                           (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                            >> 0x1fU))) 
                                                << 0xcU) 
                                               | (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x14U)));
}

// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vysyx_24100006_cpu__Syms.h"


void Vysyx_24100006_cpu___024root__trace_chg_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst::Buffer* bufp);

void Vysyx_24100006_cpu___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_chg_top_0\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vysyx_24100006_cpu___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vysyx_24100006_cpu___024root__trace_chg_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    bufp->chgBit(oldp+0,(vlSelf->clk));
    bufp->chgBit(oldp+1,(vlSelf->reset));
    bufp->chgIData(oldp+2,(vlSelf->instruction),32);
    bufp->chgIData(oldp+3,(vlSelf->result),32);
    bufp->chgIData(oldp+4,(vlSelf->x_pc),32);
    bufp->chgIData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->chgIData(oldp+6,(((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc)),32);
    bufp->chgCData(oldp+7,((0x1fU & (vlSelf->instruction 
                                     >> 0xfU))),5);
    bufp->chgCData(oldp+8,((0x1fU & (vlSelf->instruction 
                                     >> 0x14U))),5);
    bufp->chgIData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                           [(0x1fU & (vlSelf->instruction 
                                      >> 0xfU))]),32);
    bufp->chgIData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                            [(0x1fU & (vlSelf->instruction 
                                       >> 0x14U))]),32);
    bufp->chgIData(oldp+11,((((- (IData)((vlSelf->instruction 
                                          >> 0x1fU))) 
                              << 0xcU) | (vlSelf->instruction 
                                          >> 0x14U))),32);
}

void Vysyx_24100006_cpu___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_cleanup\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
    // Body
    vlSymsp->__Vm_activity = false;
    __Vm_traceActivity[0U] = 0U;
}

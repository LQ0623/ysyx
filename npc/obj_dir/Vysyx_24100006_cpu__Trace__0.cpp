// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vysyx_24100006_cpu__Syms.h"


void Vysyx_24100006_cpu___024root__trace_chg_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vysyx_24100006_cpu___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_chg_top_0\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vysyx_24100006_cpu___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vysyx_24100006_cpu___024root__trace_chg_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    VlWide<3>/*95:0*/ __Vtemp_h6a294f06__0;
    VlWide<6>/*191:0*/ __Vtemp_h2759fd9d__0;
    VlWide<4>/*127:0*/ __Vtemp_h45c9da58__0;
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[0U])) {
        bufp->chgCData(oldp+0,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0]),4);
        bufp->chgCData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1]),4);
        bufp->chgCData(oldp+2,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0]),3);
        bufp->chgCData(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1]),3);
        bufp->chgCData(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2]),3);
        bufp->chgCData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3]),3);
        bufp->chgCData(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4]),3);
        bufp->chgCData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0]),2);
        bufp->chgCData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1]),2);
        bufp->chgCData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2]),2);
        bufp->chgIData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
        bufp->chgIData(oldp+12,(((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                  ? ((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc)
                                  : ((1U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                      ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                      : ((2U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                          ? (0xfffffffeU 
                                             & (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                                + vlSelf->ysyx_24100006_cpu__DOT__sext_imm))
                                          : (((~ (IData)(
                                                         (0U 
                                                          != vlSelf->ysyx_24100006_cpu__DOT__alu_result))) 
                                              & (3U 
                                                 == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                              ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                              : 0U))))),32);
        bufp->chgIData(oldp+13,(vlSelf->ysyx_24100006_cpu__DOT__instruction),32);
        bufp->chgCData(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__aluop),4);
        bufp->chgBit(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write));
        bufp->chgBit(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Write));
        bufp->chgCData(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD),2);
        bufp->chgCData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__Jump),4);
        bufp->chgCData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type),3);
        bufp->chgBit(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA));
        bufp->chgBit(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB));
        bufp->chgCData(oldp+22,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 0xfU))),5);
        bufp->chgCData(oldp+23,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 0x14U))),5);
        bufp->chgCData(oldp+24,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 7U))),5);
        bufp->chgIData(oldp+25,(vlSelf->ysyx_24100006_cpu__DOT__wdata_reg),32);
        bufp->chgIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__rs1_data),32);
        bufp->chgIData(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                                [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x14U))]),32);
        bufp->chgIData(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__alu_result),32);
        bufp->chgIData(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__sext_imm),32);
        bufp->chgBit(oldp+30,((1U & ((~ ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                          ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                         >> 0x1fU)) 
                                     & ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                         ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                        >> 0x1fU)))));
        bufp->chgBit(oldp+31,((1U & (~ (IData)((0U 
                                                != vlSelf->ysyx_24100006_cpu__DOT__alu_result))))));
        bufp->chgBit(oldp+32,((1U & (IData)((1ULL & 
                                             (((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__rs1_data)) 
                                               + ((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement)) 
                                                  + (QData)((IData)(
                                                                    (1U 
                                                                     & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))))) 
                                              >> 0x20U))))));
        bufp->chgIData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement),32);
        bufp->chgIData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result),32);
        __Vtemp_h6a294f06__0[0U] = (IData)((0x100000000ULL 
                                            | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))));
        __Vtemp_h6a294f06__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                     << 4U) | (IData)(
                                                      ((0x100000000ULL 
                                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))) 
                                                       >> 0x20U)));
        __Vtemp_h6a294f06__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                    >> 0x1cU);
        bufp->chgWData(oldp+35,(__Vtemp_h6a294f06__0),72);
        bufp->chgQData(oldp+38,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0]),36);
        bufp->chgQData(oldp+40,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1]),36);
        bufp->chgIData(oldp+42,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+45,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit));
        bufp->chgCData(oldp+46,((0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)),7);
        bufp->chgCData(oldp+47,((7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0xcU))),3);
        bufp->chgCData(oldp+48,((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                 >> 0x19U)),7);
        bufp->chgIData(oldp+49,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                              >> 0x1fU))) 
                                  << 0xbU) | (0x7ffU 
                                              & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                 >> 0x14U)))),32);
        bufp->chgIData(oldp+50,((0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)),32);
        bufp->chgIData(oldp+51,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                              >> 0x1fU))) 
                                  << 0x14U) | ((0xff000U 
                                                & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                               | ((0x800U 
                                                   & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                      >> 9U)) 
                                                  | (0x7feU 
                                                     & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                        >> 0x14U)))))),32);
        bufp->chgIData(oldp+52,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                              >> 0x1fU))) 
                                  << 0xbU) | ((0x7e0U 
                                               & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x14U)) 
                                              | (0x1fU 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    >> 7U))))),32);
        bufp->chgIData(oldp+53,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                              >> 0x1fU))) 
                                  << 0xcU) | ((0x800U 
                                               & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  << 4U)) 
                                              | ((0x7e0U 
                                                  & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                     >> 0x14U)) 
                                                 | (0x1eU 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       >> 7U)))))),32);
        __Vtemp_h2759fd9d__0[0U] = (IData)((0x400000000ULL 
                                            | (QData)((IData)(
                                                              (0xfffff000U 
                                                               & vlSelf->ysyx_24100006_cpu__DOT__instruction)))));
        __Vtemp_h2759fd9d__0[1U] = ((0xfffffff8U & 
                                     (((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                   >> 0x1fU))) 
                                       << 0xfU) | (
                                                   (0x4000U 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       << 7U)) 
                                                   | ((0x3f00U 
                                                       & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x11U)) 
                                                      | (0xf0U 
                                                         & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                            >> 4U)))))) 
                                    | (IData)(((0x400000000ULL 
                                                | (QData)((IData)(
                                                                  (0xfffff000U 
                                                                   & vlSelf->ysyx_24100006_cpu__DOT__instruction)))) 
                                               >> 0x20U)));
        __Vtemp_h2759fd9d__0[2U] = (0x18U | ((0xffffffc0U 
                                              & (((- (IData)(
                                                             (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                              >> 0x1fU))) 
                                                  << 0x11U) 
                                                 | ((0x1f800U 
                                                     & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                        >> 0xeU)) 
                                                    | (0x7c0U 
                                                       & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 1U))))) 
                                             | (7U 
                                                & ((- (IData)(
                                                              (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                               >> 0x1fU))) 
                                                   >> 0x11U))));
        __Vtemp_h2759fd9d__0[3U] = (0x80U | ((0xfffffe00U 
                                              & (((- (IData)(
                                                             (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                              >> 0x1fU))) 
                                                  << 0x1dU) 
                                                 | ((0x1fe00000U 
                                                     & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                        << 9U)) 
                                                    | ((0x100000U 
                                                        & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                                       | (0xffc00U 
                                                          & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                             >> 0xbU)))))) 
                                             | (0x3fU 
                                                & ((- (IData)(
                                                              (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                               >> 0x1fU))) 
                                                   >> 0xfU))));
        __Vtemp_h2759fd9d__0[4U] = (0x200U | ((0xfffff000U 
                                               & (((- (IData)(
                                                              (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                               >> 0x1fU))) 
                                                   << 0x17U) 
                                                  | (0x7ff000U 
                                                     & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                        >> 8U)))) 
                                              | (0x1ffU 
                                                 & ((- (IData)(
                                                               (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                                >> 0x1fU))) 
                                                    >> 3U))));
        __Vtemp_h2759fd9d__0[5U] = (0xfffU & ((- (IData)(
                                                         (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x1fU))) 
                                              >> 9U));
        bufp->chgWData(oldp+54,(__Vtemp_h2759fd9d__0),175);
        bufp->chgQData(oldp+60,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0]),35);
        bufp->chgQData(oldp+62,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1]),35);
        bufp->chgQData(oldp+64,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2]),35);
        bufp->chgQData(oldp+66,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3]),35);
        bufp->chgQData(oldp+68,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4]),35);
        bufp->chgIData(oldp+70,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+71,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+72,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2]),32);
        bufp->chgIData(oldp+73,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3]),32);
        bufp->chgIData(oldp+74,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4]),32);
        bufp->chgIData(oldp+75,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+76,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit));
        __Vtemp_h45c9da58__0[0U] = (IData)((0x200000000ULL 
                                            | (QData)((IData)(
                                                              ((IData)(4U) 
                                                               + vlSelf->ysyx_24100006_cpu__DOT__pc)))));
        __Vtemp_h45c9da58__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                     << 2U) | (IData)(
                                                      ((0x200000000ULL 
                                                        | (QData)((IData)(
                                                                          ((IData)(4U) 
                                                                           + vlSelf->ysyx_24100006_cpu__DOT__pc)))) 
                                                       >> 0x20U)));
        __Vtemp_h45c9da58__0[2U] = (4U | ((vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                           << 4U) | 
                                          (vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                           >> 0x1eU)));
        __Vtemp_h45c9da58__0[3U] = (vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                    >> 0x1cU);
        bufp->chgWData(oldp+77,(__Vtemp_h45c9da58__0),102);
        bufp->chgQData(oldp+81,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0]),34);
        bufp->chgQData(oldp+83,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1]),34);
        bufp->chgQData(oldp+85,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2]),34);
        bufp->chgIData(oldp+87,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+88,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+89,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2]),32);
        bufp->chgIData(oldp+90,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+91,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit));
        bufp->chgIData(oldp+92,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
        bufp->chgIData(oldp+93,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
        bufp->chgIData(oldp+94,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
        bufp->chgIData(oldp+95,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
        bufp->chgIData(oldp+96,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
        bufp->chgIData(oldp+97,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
        bufp->chgIData(oldp+98,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
        bufp->chgIData(oldp+99,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
        bufp->chgIData(oldp+100,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
        bufp->chgIData(oldp+101,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
        bufp->chgIData(oldp+102,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
        bufp->chgIData(oldp+103,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
        bufp->chgIData(oldp+104,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
        bufp->chgIData(oldp+105,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
        bufp->chgIData(oldp+106,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
        bufp->chgIData(oldp+107,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
        bufp->chgIData(oldp+108,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
        bufp->chgIData(oldp+109,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
        bufp->chgIData(oldp+110,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
        bufp->chgIData(oldp+111,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
        bufp->chgIData(oldp+112,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
        bufp->chgIData(oldp+113,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
        bufp->chgIData(oldp+114,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
        bufp->chgIData(oldp+115,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
        bufp->chgIData(oldp+116,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
        bufp->chgIData(oldp+117,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
        bufp->chgIData(oldp+118,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
        bufp->chgIData(oldp+119,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
        bufp->chgIData(oldp+120,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
        bufp->chgIData(oldp+121,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
        bufp->chgIData(oldp+122,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
        bufp->chgIData(oldp+123,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    }
    bufp->chgBit(oldp+124,(vlSelf->clk));
    bufp->chgBit(oldp+125,(vlSelf->reset));
    bufp->chgIData(oldp+126,(vlSelf->x_result),32);
    bufp->chgIData(oldp+127,(vlSelf->x_pc),32);
}

void Vysyx_24100006_cpu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_cleanup\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}

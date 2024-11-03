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
    VlWide<12>/*383:0*/ __Vtemp_hd6a05b0a__0;
    VlWide<3>/*95:0*/ __Vtemp_h570d9f26__0;
    VlWide<3>/*95:0*/ __Vtemp_h5a1cf979__0;
    VlWide<6>/*191:0*/ __Vtemp_h2759fd9d__0;
    VlWide<5>/*159:0*/ __Vtemp_hcb34483a__0;
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[0U])) {
        bufp->chgCData(oldp+0,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0]),4);
        bufp->chgCData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1]),4);
        bufp->chgCData(oldp+2,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[2]),4);
        bufp->chgCData(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[3]),4);
        bufp->chgCData(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[4]),4);
        bufp->chgCData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[5]),4);
        bufp->chgCData(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[6]),4);
        bufp->chgCData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[7]),4);
        bufp->chgCData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[8]),4);
        bufp->chgCData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[9]),4);
        bufp->chgBit(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[0]));
        bufp->chgBit(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[1]));
        bufp->chgBit(oldp+12,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[0]));
        bufp->chgBit(oldp+13,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[1]));
        bufp->chgCData(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0]),3);
        bufp->chgCData(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1]),3);
        bufp->chgCData(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2]),3);
        bufp->chgCData(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3]),3);
        bufp->chgCData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4]),3);
        bufp->chgCData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0]),2);
        bufp->chgCData(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1]),2);
        bufp->chgCData(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2]),2);
        bufp->chgCData(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[3]),2);
        bufp->chgIData(oldp+23,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+24,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
        bufp->chgIData(oldp+25,(((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
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
                                              : (((~ (IData)(
                                                             (0U 
                                                              != vlSelf->ysyx_24100006_cpu__DOT__alu_result))) 
                                                  & (4U 
                                                     == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                                  ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                  : 
                                                 (((5U 
                                                    == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)) 
                                                   & vlSelf->ysyx_24100006_cpu__DOT__alu_result)
                                                   ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                   : 
                                                  (((~ vlSelf->ysyx_24100006_cpu__DOT__alu_result) 
                                                    & (7U 
                                                       == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                                    ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                    : 
                                                   (((~ vlSelf->ysyx_24100006_cpu__DOT__alu_result) 
                                                     & (6U 
                                                        == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                                     ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                     : 
                                                    (((8U 
                                                       == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)) 
                                                      & vlSelf->ysyx_24100006_cpu__DOT__alu_result)
                                                      ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                      : 
                                                     ((IData)(4U) 
                                                      + vlSelf->ysyx_24100006_cpu__DOT__pc))))))))))),32);
        bufp->chgIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__instruction),32);
        bufp->chgBit(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write));
        bufp->chgBit(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA));
        bufp->chgBit(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB));
        bufp->chgBit(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Read));
        bufp->chgBit(oldp+31,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Write));
        bufp->chgCData(oldp+32,(vlSelf->ysyx_24100006_cpu__DOT__write_sext),2);
        bufp->chgCData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__aluop),4);
        bufp->chgCData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD),2);
        bufp->chgCData(oldp+35,(vlSelf->ysyx_24100006_cpu__DOT__Jump),4);
        bufp->chgCData(oldp+36,(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type),3);
        bufp->chgCData(oldp+37,(vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask),8);
        bufp->chgCData(oldp+38,(vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask),2);
        bufp->chgCData(oldp+39,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 0xfU))),5);
        bufp->chgCData(oldp+40,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 0x14U))),5);
        bufp->chgCData(oldp+41,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 7U))),5);
        bufp->chgIData(oldp+42,(vlSelf->ysyx_24100006_cpu__DOT__wdata_reg),32);
        bufp->chgIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__rs1_data),32);
        bufp->chgIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__rs2_data),32);
        bufp->chgIData(oldp+45,(vlSelf->ysyx_24100006_cpu__DOT__alu_result),32);
        bufp->chgIData(oldp+46,(vlSelf->ysyx_24100006_cpu__DOT__sext_imm),32);
        bufp->chgBit(oldp+47,((1U & ((~ ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                          ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                         >> 0x1fU)) 
                                     & ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                         ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                        >> 0x1fU)))));
        bufp->chgBit(oldp+48,((1U & (~ (IData)((0U 
                                                != vlSelf->ysyx_24100006_cpu__DOT__alu_result))))));
        bufp->chgBit(oldp+49,(vlSelf->ysyx_24100006_cpu__DOT__cf));
        bufp->chgIData(oldp+50,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data),32);
        bufp->chgIData(oldp+51,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data),32);
        bufp->chgBit(oldp+52,((1U & vlSelf->ysyx_24100006_cpu__DOT__alu_result)));
        bufp->chgIData(oldp+53,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement),32);
        bufp->chgIData(oldp+54,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result),32);
        bufp->chgIData(oldp+55,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                 & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
        bufp->chgIData(oldp+56,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                 | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
        bufp->chgIData(oldp+57,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                 ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
        bufp->chgIData(oldp+58,(vlSelf->__VdfgTmp_hf65ad926__0),32);
        bufp->chgIData(oldp+59,(((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                                  ? (1U & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                                  : 0U)),32);
        bufp->chgIData(oldp+60,(VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                                               (0x1fU 
                                                & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
        bufp->chgIData(oldp+61,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                 >> (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
        bufp->chgIData(oldp+62,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                 << (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
        __Vtemp_hd6a05b0a__0[0U] = (IData)((0x900000000ULL 
                                            | (QData)((IData)(
                                                              (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                               | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))));
        __Vtemp_hd6a05b0a__0[1U] = (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                      ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                     << 4U) | (IData)(
                                                      ((0x900000000ULL 
                                                        | (QData)((IData)(
                                                                          (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                                           | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))) 
                                                       >> 0x20U)));
        __Vtemp_hd6a05b0a__0[2U] = (0x80U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                               & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                              << 8U) 
                                             | ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                 ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                                >> 0x1cU)));
        __Vtemp_hd6a05b0a__0[3U] = (0x700U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                << 
                                                (0x1fU 
                                                 & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                               << 0xcU) 
                                              | ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                  & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                                 >> 0x18U)));
        __Vtemp_hd6a05b0a__0[4U] = (0x6000U | ((VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                                                               (0x1fU 
                                                                & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                                << 0x10U) 
                                               | ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                   << 
                                                   (0x1fU 
                                                    & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                                  >> 0x14U)));
        __Vtemp_hd6a05b0a__0[5U] = (0x50000U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                  >> 
                                                  (0x1fU 
                                                   & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                                 << 0x14U) 
                                                | (VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                                                                  (0x1fU 
                                                                   & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                                   >> 0x10U)));
        __Vtemp_hd6a05b0a__0[6U] = (0x400000U | (((IData)(vlSelf->__VdfgTmp_hf65ad926__0) 
                                                  << 0x18U) 
                                                 | ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                     >> 
                                                     (0x1fU 
                                                      & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                                    >> 0xcU)));
        __Vtemp_hd6a05b0a__0[7U] = (0x3000000U | ((
                                                   ((0U 
                                                     != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                                                     ? 
                                                    (1U 
                                                     & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                                                     : 0U) 
                                                   << 0x1cU) 
                                                  | ((IData)(vlSelf->__VdfgTmp_hf65ad926__0) 
                                                     >> 8U)));
        __Vtemp_hd6a05b0a__0[8U] = (0x20000000U | (
                                                   ((0U 
                                                     != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                                                     ? 
                                                    (1U 
                                                     & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                                                     : 0U) 
                                                   >> 4U));
        __Vtemp_hd6a05b0a__0[9U] = vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result;
        __Vtemp_hd6a05b0a__0[0xaU] = (1U | (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                            << 4U));
        __Vtemp_hd6a05b0a__0[0xbU] = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                      >> 0x1cU);
        bufp->chgWData(oldp+63,(__Vtemp_hd6a05b0a__0),360);
        bufp->chgQData(oldp+75,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0]),36);
        bufp->chgQData(oldp+77,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1]),36);
        bufp->chgQData(oldp+79,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[2]),36);
        bufp->chgQData(oldp+81,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[3]),36);
        bufp->chgQData(oldp+83,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[4]),36);
        bufp->chgQData(oldp+85,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[5]),36);
        bufp->chgQData(oldp+87,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[6]),36);
        bufp->chgQData(oldp+89,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[7]),36);
        bufp->chgQData(oldp+91,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[8]),36);
        bufp->chgQData(oldp+93,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[9]),36);
        bufp->chgIData(oldp+95,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+96,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+97,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[2]),32);
        bufp->chgIData(oldp+98,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[3]),32);
        bufp->chgIData(oldp+99,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[4]),32);
        bufp->chgIData(oldp+100,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[5]),32);
        bufp->chgIData(oldp+101,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[6]),32);
        bufp->chgIData(oldp+102,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[7]),32);
        bufp->chgIData(oldp+103,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[8]),32);
        bufp->chgIData(oldp+104,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[9]),32);
        bufp->chgIData(oldp+105,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+106,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit));
        __Vtemp_h570d9f26__0[0U] = (IData)((0x100000000ULL 
                                            | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))));
        __Vtemp_h570d9f26__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                     << 1U) | (IData)(
                                                      ((0x100000000ULL 
                                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))) 
                                                       >> 0x20U)));
        __Vtemp_h570d9f26__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                    >> 0x1fU);
        bufp->chgWData(oldp+107,(__Vtemp_h570d9f26__0),66);
        bufp->chgQData(oldp+110,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[0]),33);
        bufp->chgQData(oldp+112,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[1]),33);
        bufp->chgIData(oldp+114,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+115,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+116,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+117,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit));
        __Vtemp_h5a1cf979__0[0U] = (IData)((0x100000000ULL 
                                            | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))));
        __Vtemp_h5a1cf979__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                     << 1U) | (IData)(
                                                      ((0x100000000ULL 
                                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))) 
                                                       >> 0x20U)));
        __Vtemp_h5a1cf979__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                    >> 0x1fU);
        bufp->chgWData(oldp+118,(__Vtemp_h5a1cf979__0),66);
        bufp->chgQData(oldp+121,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[0]),33);
        bufp->chgQData(oldp+123,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[1]),33);
        bufp->chgIData(oldp+125,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+126,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+127,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+128,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit));
        bufp->chgCData(oldp+129,((0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)),7);
        bufp->chgCData(oldp+130,((7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                        >> 0xcU))),3);
        bufp->chgCData(oldp+131,((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                  >> 0x19U)),7);
        bufp->chgIData(oldp+132,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x1fU))) 
                                   << 0xbU) | (0x7ffU 
                                               & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x14U)))),32);
        bufp->chgIData(oldp+133,((0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)),32);
        bufp->chgIData(oldp+134,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x1fU))) 
                                   << 0x14U) | ((0xff000U 
                                                 & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                                | ((0x800U 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       >> 9U)) 
                                                   | (0x7feU 
                                                      & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                         >> 0x14U)))))),32);
        bufp->chgIData(oldp+135,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x1fU))) 
                                   << 0xbU) | ((0x7e0U 
                                                & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                   >> 0x14U)) 
                                               | (0x1fU 
                                                  & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                     >> 7U))))),32);
        bufp->chgIData(oldp+136,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
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
        bufp->chgWData(oldp+137,(__Vtemp_h2759fd9d__0),175);
        bufp->chgQData(oldp+143,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0]),35);
        bufp->chgQData(oldp+145,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1]),35);
        bufp->chgQData(oldp+147,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2]),35);
        bufp->chgQData(oldp+149,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3]),35);
        bufp->chgQData(oldp+151,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4]),35);
        bufp->chgIData(oldp+153,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+154,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+155,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2]),32);
        bufp->chgIData(oldp+156,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3]),32);
        bufp->chgIData(oldp+157,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4]),32);
        bufp->chgIData(oldp+158,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+159,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit));
        __Vtemp_hcb34483a__0[0U] = (IData)((0x300000000ULL 
                                            | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__Mem_rdata))));
        __Vtemp_hcb34483a__0[1U] = ((((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc) 
                                     << 2U) | (IData)(
                                                      ((0x300000000ULL 
                                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__Mem_rdata))) 
                                                       >> 0x20U)));
        __Vtemp_hcb34483a__0[2U] = (8U | ((vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                           << 4U) | 
                                          (((IData)(4U) 
                                            + vlSelf->ysyx_24100006_cpu__DOT__pc) 
                                           >> 0x1eU)));
        __Vtemp_hcb34483a__0[3U] = (0x10U | ((vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                              << 6U) 
                                             | (vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                                >> 0x1cU)));
        __Vtemp_hcb34483a__0[4U] = (vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                    >> 0x1aU);
        bufp->chgWData(oldp+160,(__Vtemp_hcb34483a__0),136);
        bufp->chgQData(oldp+165,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0]),34);
        bufp->chgQData(oldp+167,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1]),34);
        bufp->chgQData(oldp+169,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2]),34);
        bufp->chgQData(oldp+171,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[3]),34);
        bufp->chgIData(oldp+173,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0]),32);
        bufp->chgIData(oldp+174,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1]),32);
        bufp->chgIData(oldp+175,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2]),32);
        bufp->chgIData(oldp+176,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[3]),32);
        bufp->chgIData(oldp+177,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out),32);
        bufp->chgBit(oldp+178,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit));
        bufp->chgIData(oldp+179,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
        bufp->chgIData(oldp+180,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
        bufp->chgIData(oldp+181,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
        bufp->chgIData(oldp+182,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
        bufp->chgIData(oldp+183,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
        bufp->chgIData(oldp+184,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
        bufp->chgIData(oldp+185,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
        bufp->chgIData(oldp+186,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
        bufp->chgIData(oldp+187,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
        bufp->chgIData(oldp+188,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
        bufp->chgIData(oldp+189,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
        bufp->chgIData(oldp+190,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
        bufp->chgIData(oldp+191,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
        bufp->chgIData(oldp+192,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
        bufp->chgIData(oldp+193,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
        bufp->chgIData(oldp+194,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
        bufp->chgIData(oldp+195,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
        bufp->chgIData(oldp+196,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
        bufp->chgIData(oldp+197,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
        bufp->chgIData(oldp+198,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
        bufp->chgIData(oldp+199,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
        bufp->chgIData(oldp+200,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
        bufp->chgIData(oldp+201,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
        bufp->chgIData(oldp+202,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
        bufp->chgIData(oldp+203,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
        bufp->chgIData(oldp+204,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
        bufp->chgIData(oldp+205,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
        bufp->chgIData(oldp+206,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
        bufp->chgIData(oldp+207,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
        bufp->chgIData(oldp+208,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
        bufp->chgIData(oldp+209,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
        bufp->chgIData(oldp+210,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    }
    bufp->chgBit(oldp+211,(vlSelf->clk));
    bufp->chgBit(oldp+212,(vlSelf->reset));
    bufp->chgIData(oldp+213,(vlSelf->x_result),32);
    bufp->chgIData(oldp+214,(vlSelf->x_pc),32);
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

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

void Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit();
void Vysyx_24100006_cpu___024root____Vdpiimwrap_ysyx_24100006_cpu__DOT__mem__DOT__pmem_write_TOP(IData/*31:0*/ waddr, IData/*31:0*/ wdata);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root___stl_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->x_pc = vlSelf->ysyx_24100006_cpu__DOT__pc;
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0U] 
        = (0x200000000ULL | (QData)((IData)(((IData)(4U) 
                                             + vlSelf->ysyx_24100006_cpu__DOT__pc))));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0U] 
        = ((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc);
    vlSelf->ysyx_24100006_cpu__DOT__instruction = vlSelf->ysyx_24100006_cpu__DOT__IM__DOT__instructions
        [(0x3ffU & (vlSelf->ysyx_24100006_cpu__DOT__pc 
                    >> 2U))];
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0U] 
        = (0x400000000ULL | (QData)((IData)((0xfffff000U 
                                             & vlSelf->ysyx_24100006_cpu__DOT__instruction))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1U] 
        = (0x300000000ULL | (QData)((IData)((((- (IData)(
                                                         (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x1fU))) 
                                              << 0xcU) 
                                             | ((0x800U 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    << 4U)) 
                                                | ((0x7e0U 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       >> 0x14U)) 
                                                   | (0x1eU 
                                                      & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                         >> 7U))))))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2U] 
        = (0x200000000ULL | (QData)((IData)((((- (IData)(
                                                         (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x1fU))) 
                                              << 0xbU) 
                                             | ((0x7e0U 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    >> 0x14U)) 
                                                | (0x1fU 
                                                   & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                      >> 7U)))))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3U] 
        = (0x100000000ULL | (QData)((IData)((((- (IData)(
                                                         (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x1fU))) 
                                              << 0x14U) 
                                             | ((0xff000U 
                                                 & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                                | ((0x800U 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       >> 9U)) 
                                                   | (0x7feU 
                                                      & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                         >> 0x14U))))))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4U] 
        = (QData)((IData)((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                        >> 0x1fU))) 
                            << 0xbU) | (0x7ffU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x14U)))));
    vlSelf->ysyx_24100006_cpu__DOT__rs1_data = vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
        [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                   >> 0xfU))];
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0U] 
        = (0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction);
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1U] 
        = (((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                        >> 0x1fU))) << 0xcU) | ((0x800U 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    << 4U)) 
                                                | ((0x7e0U 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                       >> 0x14U)) 
                                                   | (0x1eU 
                                                      & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                         >> 7U)))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2U] 
        = (((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                        >> 0x1fU))) << 0xbU) | ((0x7e0U 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    >> 0x14U)) 
                                                | (0x1fU 
                                                   & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                      >> 7U))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3U] 
        = (((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                        >> 0x1fU))) << 0x14U) | ((0xff000U 
                                                  & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                                 | ((0x800U 
                                                     & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                        >> 9U)) 
                                                    | (0x7feU 
                                                       & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                          >> 0x14U)))));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4U] 
        = (((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                        >> 0x1fU))) << 0xbU) | (0x7ffU 
                                                & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                   >> 0x14U)));
    if (((((((((0x73U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)) 
               | (0x17U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
              | (0x37U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
             | (0x6fU == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
            | (0x67U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
           | (0x13U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
          | (0x33U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) 
         | (0x23U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)))) {
        if ((0x73U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit();
        } else if ((0x17U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 4U;
            vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        } else if ((0x37U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 4U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        } else if ((0x6fU == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 2U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        } else if ((0x67U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 2U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 2U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        } else if ((0x13U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            if ((0U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                              >> 0xcU)))) {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            }
        } else if ((0x33U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
            if ((0U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                              >> 0xcU)))) {
                if ((0U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                            >> 0x19U))) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                } else if ((0x20U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                      >> 0x19U))) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            }
        } else if ((2U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                 >> 0xcU)))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 2U;
            vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        } else {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        }
    } else if ((0x63U == (0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction))) {
        if ((0U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                          >> 0xcU)))) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 3U;
            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
            vlSelf->ysyx_24100006_cpu__DOT__aluop = 1U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        }
    }
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
           == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
              == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD) 
              == vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
           == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
              == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
              == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
              == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
              [3U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
              == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
              [4U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
        = ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
                       == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
                       [0U]))) & vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
                          == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
                          [1U]))) & vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
                          == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
                          [2U]))) & vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
                          == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
                          [3U]))) & vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list
              [3U]));
    vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type) 
                          == vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list
                          [4U]))) & vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list
              [4U]));
    vlSelf->ysyx_24100006_cpu__DOT__sext_imm = vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
           == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2U] 
        = vlSelf->ysyx_24100006_cpu__DOT__sext_imm;
    vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0 
        = (vlSelf->ysyx_24100006_cpu__DOT__pc + vlSelf->ysyx_24100006_cpu__DOT__sext_imm);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
        = (vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
           ^ (- (IData)((1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
        = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0U] 
        = (0x100000000ULL | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result)));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                       == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                       [0U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [1U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_result = vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out;
    vlSelf->x_result = vlSelf->ysyx_24100006_cpu__DOT__alu_result;
    if (vlSelf->ysyx_24100006_cpu__DOT__Mem_Write) {
        Vysyx_24100006_cpu___024root____Vdpiimwrap_ysyx_24100006_cpu__DOT__mem__DOT__pmem_write_TOP(vlSelf->ysyx_24100006_cpu__DOT__alu_result, 
                                                                                vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                                                                                [
                                                                                (0x1fU 
                                                                                & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                                                >> 0x14U))]);
    }
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1U] 
        = (0x100000000ULL | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu_result)));
    vlSelf->ysyx_24100006_cpu__DOT__npc = ((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                            ? ((IData)(4U) 
                                               + vlSelf->ysyx_24100006_cpu__DOT__pc)
                                            : ((1U 
                                                == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                                ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                : (
                                                   (2U 
                                                    == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
                                                    ? 
                                                   (0xfffffffeU 
                                                    & (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                                       + vlSelf->ysyx_24100006_cpu__DOT__sext_imm))
                                                    : 
                                                   (((~ (IData)(
                                                                (0U 
                                                                 != vlSelf->ysyx_24100006_cpu__DOT__alu_result))) 
                                                     & (3U 
                                                        == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                                     ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                                     : 0U))));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1U] 
        = vlSelf->ysyx_24100006_cpu__DOT__alu_result;
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
    vlSelf->ysyx_24100006_cpu__DOT__wdata_reg = vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out;
}

// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu__Syms.h"
#include "Vysyx_24100006_cpu___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vysyx_24100006_cpu___024root___dump_triggers__act(Vysyx_24100006_cpu___024root* vlSelf);
#endif  // VL_DEBUG

void Vysyx_24100006_cpu___024root___eval_triggers__act(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.at(0U) = ((IData)(vlSelf->clk) 
                                      & (~ (IData)(vlSelf->__Vtrigrprev__TOP__clk)));
    vlSelf->__Vtrigrprev__TOP__clk = vlSelf->clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vysyx_24100006_cpu___024root___dump_triggers__act(vlSelf);
    }
#endif
}

void Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit();

VL_INLINE_OPT void Vysyx_24100006_cpu___024root___nba_sequent__TOP__0(Vysyx_24100006_cpu___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    IData/*31:0*/ __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    CData/*0:0*/ __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0;
    // Body
    VL_WRITEF("instruction_opcode is %x\n\n",7,(0x7fU 
                                                & vlSelf->ysyx_24100006_cpu__DOT__instruction));
    __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 0U;
    if (vlSelf->ysyx_24100006_cpu__DOT__Reg_Write) {
        __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 
            = vlSelf->ysyx_24100006_cpu__DOT__wdata_reg;
        __Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 = 1U;
        __Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0 
            = (0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                        >> 7U));
    }
    vlSelf->ysyx_24100006_cpu__DOT__pc = ((IData)(vlSelf->reset)
                                           ? 0x80000000U
                                           : vlSelf->ysyx_24100006_cpu__DOT__npc);
    if (__Vdlyvset__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0) {
        vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[__Vdlyvdim0__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0] 
            = __Vdlyvval__ysyx_24100006_cpu__DOT__registerfile__DOT__rf__v0;
    }
    vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0U] = 0U;
    vlSelf->x_pc = vlSelf->ysyx_24100006_cpu__DOT__pc;
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[0U] 
        = (0x100000000ULL | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc)));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0U] 
        = (0x200000000ULL | (QData)((IData)(((IData)(4U) 
                                             + vlSelf->ysyx_24100006_cpu__DOT__pc))));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0U] 
        = ((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc);
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[0U] 
        = vlSelf->ysyx_24100006_cpu__DOT__pc;
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
    vlSelf->ysyx_24100006_cpu__DOT__rs2_data = vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
        [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                   >> 0x14U))];
    vlSelf->ysyx_24100006_cpu__DOT__rs1_data = vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
        [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                   >> 0xfU))];
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[1U] 
        = vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
        [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                   >> 0xfU))];
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[1U] 
        = vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
        [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                   >> 0x14U))];
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
    if ((0x40U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        if ((0x20U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((0x10U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit();
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 2U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 2U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 2U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((0x4000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 8U;
                                vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 2U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            } else {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 7U;
                                vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 2U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            }
                        } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 6U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 3U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 5U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 3U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 4U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 3U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 3U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            }
        } else {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        }
    } else if ((0x20U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        if ((0x10U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 4U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((0x4000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 7U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            } else {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 9U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            }
                        } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            if ((0U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                        >> 0x19U))) {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 4U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            } else if ((0x20U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 0x19U))) {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__aluop = 5U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            } else {
                                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                            }
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 8U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 2U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 3U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 6U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else if ((0U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0x19U))) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else if ((0x20U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                          >> 0x19U))) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            }
        } else if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((0U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                  >> 0xcU)))) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 2U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else if ((1U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                         >> 0xcU)))) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 2U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask = 3U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else if ((2U == (7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                         >> 0xcU)))) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 2U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask = 7U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            }
        } else {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        }
    } else if ((0x10U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 4U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            }
        } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((0x4000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 7U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 9U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        if ((0U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                    >> 0x19U))) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 4U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else if ((0x20U == (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                              >> 0x19U))) {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__aluop = 5U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        } else {
                            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                        }
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 8U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 2U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    } else {
                        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__aluop = 3U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                    }
                } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 6U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
            }
        } else {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        }
    } else if ((8U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
    } else if ((4U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
    } else if ((2U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
        if ((1U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
            if ((0x4000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 3U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 1U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 3U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 1U;
                }
            } else if ((0x2000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                } else {
                    vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 3U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 1U;
                    vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = 2U;
                    vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
                }
            } else if ((0x1000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)) {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 3U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 2U;
            } else {
                vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Imm_Type = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__aluop = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcA = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__AluSrcB = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD = 3U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 1U;
                vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask = 0U;
                vlSelf->ysyx_24100006_cpu__DOT__write_sext = 2U;
            }
        } else {
            vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
            vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
        }
    } else {
        vlSelf->ysyx_24100006_cpu__DOT__Jump = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Reg_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Write = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__Mem_Read = 0U;
        vlSelf->ysyx_24100006_cpu__DOT__write_sext = 0U;
    }
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[1U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__rs2_data));
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[1U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__rs1_data));
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
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
           == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [3U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [4U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [5U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [6U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [7U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [8U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
              [9U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA) 
           == vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out 
        = ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA) 
                       == vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list
                       [0U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list
                          [1U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_a_data = vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out;
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB) 
           == vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit 
        = ((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit) 
           | ((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB) 
              == vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list
              [1U]));
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
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[0U] 
        = (0x100000000ULL | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm)));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm));
    vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2U] 
        = vlSelf->ysyx_24100006_cpu__DOT__sext_imm;
    vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0 
        = (vlSelf->ysyx_24100006_cpu__DOT__pc + vlSelf->ysyx_24100006_cpu__DOT__sext_imm);
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[0U] 
        = vlSelf->ysyx_24100006_cpu__DOT__sext_imm;
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out 
        = ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB) 
                       == vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list
                       [0U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list
           [0U]);
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list
                          [1U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list
              [1U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_b_data = vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out;
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0U] 
        = (0x900000000ULL | (QData)((IData)((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                             | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1U] 
        = (0x800000000ULL | (QData)((IData)((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                             ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[2U] 
        = (0x700000000ULL | (QData)((IData)((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                             & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[3U] 
        = (0x600000000ULL | (QData)((IData)((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                             << (0x1fU 
                                                 & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[4U] 
        = (0x500000000ULL | (QData)((IData)(VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                                                           (0x1fU 
                                                            & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[5U] 
        = (0x400000000ULL | (QData)((IData)((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                             >> (0x1fU 
                                                 & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[2U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[3U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           << (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[4U] 
        = VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                         (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[5U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           >> (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_b_data 
           ^ (- (IData)((1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[8U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[9U] 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__cf = (1U & (IData)(
                                                       (1ULL 
                                                        & (((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data)) 
                                                            + 
                                                            ((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement)) 
                                                             + (QData)((IData)(
                                                                               (1U 
                                                                                & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))))) 
                                                           >> 0x20U))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
           + (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement 
              + (1U & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[7U] 
        = (0x200000000ULL | (QData)((IData)(((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                                              ? (1U 
                                                 & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                                              : 0U))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[7U] 
        = ((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
            ? (1U & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
            : 0U);
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[8U] 
        = (0x100000000ULL | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result)));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[9U] 
        = (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result));
    vlSelf->__VdfgTmp_hf65ad926__0 = (1U & ((vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                             >> 0x1fU) 
                                            ^ ((~ (
                                                   (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                    ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                                   >> 0x1fU)) 
                                               & ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                   ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                                  >> 0x1fU))));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[6U] 
        = (0x300000000ULL | (QData)((IData)(vlSelf->__VdfgTmp_hf65ad926__0)));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[6U] 
        = vlSelf->__VdfgTmp_hf65ad926__0;
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
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [2U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [2U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [3U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [3U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [4U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [4U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [5U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [5U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [6U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [6U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [7U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [7U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [8U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [8U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
        = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out 
           | ((- (IData)(((IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop) 
                          == vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list
                          [9U]))) & vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list
              [9U]));
    vlSelf->ysyx_24100006_cpu__DOT__alu_result = vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out;
    vlSelf->x_result = vlSelf->ysyx_24100006_cpu__DOT__alu_result;
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
                                                     : 
                                                    ((IData)(4U) 
                                                     + vlSelf->ysyx_24100006_cpu__DOT__pc)))));
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

// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vysyx_24100006_imm_sext__Syms.h"


VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_init_sub__TOP__0(Vysyx_24100006_imm_sext___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+52,"ysyx_24100006_MuxKey.out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+53,"ysyx_24100006_MuxKey.key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+54,"ysyx_24100006_MuxKey.lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+55,"ysyx_24100006_MuxKeyWithDefault.out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+56,"ysyx_24100006_MuxKeyWithDefault.key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+57,"default_out",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+58,"ysyx_24100006_MuxKeyWithDefault.lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBit(c+59,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+60,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+61,"instruction",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+62,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+63,"x_pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("ysyx_24100006_MuxKey ");
    tracep->declBus(c+68,"NR_KEY",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"KEY_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"DATA_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+52,"out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+53,"key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+54,"lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+68,"NR_KEY",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"KEY_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"DATA_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+70,"HAS_DEFAULT",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+52,"out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+53,"key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+71,"default_out",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+54,"lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+68,"PAIR_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+1+i*1,"pair_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 1,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+3+i*1,"key_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+5+i*1,"data_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 0,0);
    }
    tracep->declBus(c+7,"lut_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBit(c+8,"hit",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+72,"i",-1, FST_VD_IMPLICIT,FST_VT_VCD_INTEGER, false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("ysyx_24100006_MuxKeyWithDefault ");
    tracep->declBus(c+68,"NR_KEY",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"KEY_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"DATA_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+55,"out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+56,"key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+57,"default_out",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+58,"lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+68,"NR_KEY",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"KEY_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"DATA_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+69,"HAS_DEFAULT",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+55,"out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+56,"key",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+57,"default_out",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 0,0);
    tracep->declBus(c+58,"lut",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+68,"PAIR_LEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+9+i*1,"pair_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 1,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+11+i*1,"key_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+13+i*1,"data_list",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, true,(i+0), 0,0);
    }
    tracep->declBus(c+15,"lut_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBit(c+16,"hit",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+72,"i",-1, FST_VD_IMPLICIT,FST_VT_VCD_INTEGER, false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("ysyx_24100006_cpu ");
    tracep->declBit(c+59,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+60,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+61,"instruction",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+62,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+63,"x_pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+17,"pc",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+18,"npc",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+73,"wen",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+64,"rs",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+65,"rt",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+74,"rd",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+75,"waddr",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+76,"wdata",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+66,"rs1_data",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+19,"rs2_data",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+67,"sext_imm",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("NPC ");
    tracep->declBus(c+17,"pc",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+18,"npc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC ");
    tracep->declBit(c+59,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+60,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+18,"npc",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+17,"pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+66,"rs_data",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+67,"rt_data",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+62,"rd_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("imm_sext ");
    tracep->declBus(c+61,"inst",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+67,"sext_imm",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("registerfile ");
    tracep->declBus(c+77,"ADDR_WIDTH",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+78,"DATA_WIDTH",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+59,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+76,"wdata",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+75,"waddr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBit(c+73,"wen",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+64,"rs1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+74,"rs2",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+66,"rs1_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+19,"rs2_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+20+i*1,"rf",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, true,(i+0), 31,0);
    }
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_init_top(Vysyx_24100006_imm_sext___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root__trace_init_top\n"); );
    // Body
    Vysyx_24100006_imm_sext___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vysyx_24100006_imm_sext___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vysyx_24100006_imm_sext___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_register(Vysyx_24100006_imm_sext___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vysyx_24100006_imm_sext___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vysyx_24100006_imm_sext___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vysyx_24100006_imm_sext___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_full_sub_0(Vysyx_24100006_imm_sext___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root__trace_full_top_0\n"); );
    // Init
    Vysyx_24100006_imm_sext___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_imm_sext___024root*>(voidSelf);
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vysyx_24100006_imm_sext___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vysyx_24100006_imm_sext___024root__trace_full_sub_0(Vysyx_24100006_imm_sext___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_imm_sext__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_imm_sext___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullCData(oldp+1,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list[0]),2);
    bufp->fullCData(oldp+2,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__pair_list[1]),2);
    bufp->fullBit(oldp+3,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+4,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+5,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list[0]));
    bufp->fullBit(oldp+6,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__data_list[1]));
    bufp->fullBit(oldp+7,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__lut_out));
    bufp->fullBit(oldp+8,(vlSelf->ysyx_24100006_MuxKey__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+9,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list[0]),2);
    bufp->fullCData(oldp+10,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__pair_list[1]),2);
    bufp->fullBit(oldp+11,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+12,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+13,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list[0]));
    bufp->fullBit(oldp+14,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__data_list[1]));
    bufp->fullBit(oldp+15,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__lut_out));
    bufp->fullBit(oldp+16,(vlSelf->ysyx_24100006_MuxKeyWithDefault__DOT__i0__DOT__hit));
    bufp->fullIData(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->fullIData(oldp+18,(((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc)),32);
    bufp->fullIData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                             [vlSelf->ysyx_24100006_cpu__DOT__rd]),32);
    bufp->fullIData(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
    bufp->fullIData(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
    bufp->fullIData(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
    bufp->fullIData(oldp+23,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
    bufp->fullIData(oldp+24,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
    bufp->fullIData(oldp+25,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
    bufp->fullIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
    bufp->fullIData(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
    bufp->fullIData(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
    bufp->fullIData(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
    bufp->fullIData(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
    bufp->fullIData(oldp+31,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
    bufp->fullIData(oldp+32,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
    bufp->fullIData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
    bufp->fullIData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
    bufp->fullIData(oldp+35,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
    bufp->fullIData(oldp+36,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
    bufp->fullIData(oldp+37,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
    bufp->fullIData(oldp+38,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
    bufp->fullIData(oldp+39,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
    bufp->fullIData(oldp+40,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
    bufp->fullIData(oldp+41,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
    bufp->fullIData(oldp+42,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
    bufp->fullIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
    bufp->fullIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
    bufp->fullIData(oldp+45,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
    bufp->fullIData(oldp+46,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
    bufp->fullIData(oldp+47,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
    bufp->fullIData(oldp+48,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
    bufp->fullIData(oldp+49,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
    bufp->fullIData(oldp+50,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
    bufp->fullIData(oldp+51,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    bufp->fullBit(oldp+52,(vlSelf->ysyx_24100006_MuxKey__02Eout));
    bufp->fullBit(oldp+53,(vlSelf->ysyx_24100006_MuxKey__02Ekey));
    bufp->fullCData(oldp+54,(vlSelf->ysyx_24100006_MuxKey__02Elut),4);
    bufp->fullBit(oldp+55,(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Eout));
    bufp->fullBit(oldp+56,(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Ekey));
    bufp->fullBit(oldp+57,(vlSelf->default_out));
    bufp->fullCData(oldp+58,(vlSelf->ysyx_24100006_MuxKeyWithDefault__02Elut),4);
    bufp->fullBit(oldp+59,(vlSelf->clk));
    bufp->fullBit(oldp+60,(vlSelf->reset));
    bufp->fullIData(oldp+61,(vlSelf->instruction),32);
    bufp->fullIData(oldp+62,(vlSelf->result),32);
    bufp->fullIData(oldp+63,(vlSelf->x_pc),32);
    bufp->fullCData(oldp+64,((0x1fU & (vlSelf->instruction 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+65,((0x1fU & (vlSelf->instruction 
                                       >> 0x14U))),5);
    bufp->fullIData(oldp+66,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                             [(0x1fU & (vlSelf->instruction 
                                        >> 0xfU))]),32);
    bufp->fullIData(oldp+67,((((- (IData)((vlSelf->instruction 
                                           >> 0x1fU))) 
                               << 0xcU) | (vlSelf->instruction 
                                           >> 0x14U))),32);
    bufp->fullIData(oldp+68,(2U),32);
    bufp->fullIData(oldp+69,(1U),32);
    bufp->fullIData(oldp+70,(0U),32);
    bufp->fullBit(oldp+71,(0U));
    bufp->fullIData(oldp+72,(2U),32);
    bufp->fullBit(oldp+73,(vlSelf->ysyx_24100006_cpu__DOT__wen));
    bufp->fullCData(oldp+74,(vlSelf->ysyx_24100006_cpu__DOT__rd),5);
    bufp->fullCData(oldp+75,(vlSelf->ysyx_24100006_cpu__DOT__waddr),5);
    bufp->fullIData(oldp+76,(vlSelf->ysyx_24100006_cpu__DOT__wdata),32);
    bufp->fullIData(oldp+77,(5U),32);
    bufp->fullIData(oldp+78,(0x20U),32);
}

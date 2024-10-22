// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vysyx_24100006_cpu__Syms.h"


VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+36,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+37,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+38,"instruction",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+39,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+40,"x_pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("ysyx_24100006_cpu ");
    tracep->declBit(c+36,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+37,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+38,"instruction",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+39,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+40,"x_pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1,"pc",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2,"npc",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+46,"wen",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+41,"rs",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+42,"rt",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+47,"waddr",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+48,"wdata",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+43,"rs1_data",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+44,"rs2_data",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+45,"sext_imm",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("NPC ");
    tracep->declBus(c+1,"pc",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2,"npc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC ");
    tracep->declBit(c+36,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+37,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2,"npc",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1,"pc",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+43,"rs_data",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+45,"rt_data",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+39,"rd_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("imm_sext ");
    tracep->declBus(c+38,"inst",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+45,"sext_imm",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("registerfile ");
    tracep->declBus(c+49,"ADDR_WIDTH",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+50,"DATA_WIDTH",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+36,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+51,"reset",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+48,"wdata",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+47,"waddr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBit(c+46,"wen",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+41,"rs1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+42,"rs2",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+43,"rs1_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+44,"rs2_data",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+3+i*1,"rf",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, true,(i+0), 31,0);
    }
    tracep->declBus(c+35,"i",-1, FST_VD_IMPLICIT,FST_VT_VCD_INTEGER, false,-1, 31,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_init_top(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_init_top\n"); );
    // Body
    Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vysyx_24100006_cpu___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vysyx_24100006_cpu___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_register(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vysyx_24100006_cpu___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vysyx_24100006_cpu___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vysyx_24100006_cpu___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_full_top_0\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vysyx_24100006_cpu___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->fullIData(oldp+2,(((IData)(4U) + vlSelf->ysyx_24100006_cpu__DOT__pc)),32);
    bufp->fullIData(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
    bufp->fullIData(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
    bufp->fullIData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
    bufp->fullIData(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
    bufp->fullIData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
    bufp->fullIData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
    bufp->fullIData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
    bufp->fullIData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
    bufp->fullIData(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
    bufp->fullIData(oldp+12,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
    bufp->fullIData(oldp+13,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
    bufp->fullIData(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
    bufp->fullIData(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
    bufp->fullIData(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
    bufp->fullIData(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
    bufp->fullIData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
    bufp->fullIData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
    bufp->fullIData(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
    bufp->fullIData(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
    bufp->fullIData(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
    bufp->fullIData(oldp+23,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
    bufp->fullIData(oldp+24,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
    bufp->fullIData(oldp+25,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
    bufp->fullIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
    bufp->fullIData(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
    bufp->fullIData(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
    bufp->fullIData(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
    bufp->fullIData(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
    bufp->fullIData(oldp+31,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
    bufp->fullIData(oldp+32,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
    bufp->fullIData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
    bufp->fullIData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    bufp->fullIData(oldp+35,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    bufp->fullBit(oldp+36,(vlSelf->clk));
    bufp->fullBit(oldp+37,(vlSelf->reset));
    bufp->fullIData(oldp+38,(vlSelf->instruction),32);
    bufp->fullIData(oldp+39,(vlSelf->result),32);
    bufp->fullIData(oldp+40,(vlSelf->x_pc),32);
    bufp->fullCData(oldp+41,((0x1fU & (vlSelf->instruction 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+42,((0x1fU & (vlSelf->instruction 
                                       >> 0x14U))),5);
    bufp->fullIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                             [(0x1fU & (vlSelf->instruction 
                                        >> 0xfU))]),32);
    bufp->fullIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                             [(0x1fU & (vlSelf->instruction 
                                        >> 0x14U))]),32);
    bufp->fullIData(oldp+45,((((- (IData)((vlSelf->instruction 
                                           >> 0x1fU))) 
                               << 0xcU) | (vlSelf->instruction 
                                           >> 0x14U))),32);
    bufp->fullBit(oldp+46,(0U));
    bufp->fullCData(oldp+47,(vlSelf->ysyx_24100006_cpu__DOT__waddr),5);
    bufp->fullIData(oldp+48,(vlSelf->ysyx_24100006_cpu__DOT__wdata),32);
    bufp->fullIData(oldp+49,(5U),32);
    bufp->fullIData(oldp+50,(0x20U),32);
    bufp->fullBit(oldp+51,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__reset));
}

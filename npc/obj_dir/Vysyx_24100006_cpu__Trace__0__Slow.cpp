// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vysyx_24100006_cpu__Syms.h"


VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBit(c+126,"reset", false,-1);
    tracep->declBus(c+127,"x_result", false,-1, 31,0);
    tracep->declBus(c+128,"x_pc", false,-1, 31,0);
    tracep->pushNamePrefix("ysyx_24100006_cpu ");
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBit(c+126,"reset", false,-1);
    tracep->declBus(c+127,"x_result", false,-1, 31,0);
    tracep->declBus(c+128,"x_pc", false,-1, 31,0);
    tracep->declBus(c+12,"pc", false,-1, 31,0);
    tracep->declBus(c+13,"npc", false,-1, 31,0);
    tracep->declBus(c+14,"instruction", false,-1, 31,0);
    tracep->declBus(c+15,"aluop", false,-1, 3,0);
    tracep->declBit(c+16,"Reg_Write", false,-1);
    tracep->declBit(c+17,"Mem_Write", false,-1);
    tracep->declBus(c+18,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+19,"Jump", false,-1, 3,0);
    tracep->declBus(c+20,"Imm_Type", false,-1, 2,0);
    tracep->declBit(c+21,"AluSrcA", false,-1);
    tracep->declBit(c+22,"AluSrcB", false,-1);
    tracep->declBus(c+23,"rs", false,-1, 4,0);
    tracep->declBus(c+24,"rt", false,-1, 4,0);
    tracep->declBus(c+129,"rd", false,-1, 4,0);
    tracep->declBus(c+25,"waddr_reg", false,-1, 4,0);
    tracep->declBus(c+26,"wdata_reg", false,-1, 31,0);
    tracep->declBus(c+27,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+28,"rs2_data", false,-1, 31,0);
    tracep->declBus(c+29,"alu_result", false,-1, 31,0);
    tracep->declBus(c+30,"sext_imm", false,-1, 31,0);
    tracep->declBit(c+31,"of", false,-1);
    tracep->declBit(c+32,"zf", false,-1);
    tracep->declBit(c+33,"cf", false,-1);
    tracep->pushNamePrefix("IM ");
    tracep->declBus(c+12,"pc", false,-1, 31,0);
    tracep->declBus(c+14,"instruction", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("NPC ");
    tracep->declBus(c+12,"pc", false,-1, 31,0);
    tracep->declBus(c+19,"Skip_mode", false,-1, 3,0);
    tracep->declBus(c+30,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+27,"rs_data", false,-1, 31,0);
    tracep->declBit(c+32,"zf", false,-1);
    tracep->declBus(c+13,"npc", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC ");
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBit(c+126,"reset", false,-1);
    tracep->declBus(c+13,"npc", false,-1, 31,0);
    tracep->declBus(c+12,"pc", false,-1, 31,0);
    tracep->pushNamePrefix("pc1 ");
    tracep->declBus(c+130,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+131,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBit(c+126,"rst", false,-1);
    tracep->declBus(c+13,"din", false,-1, 31,0);
    tracep->declBus(c+12,"dout", false,-1, 31,0);
    tracep->declBit(c+132,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+27,"rs_data", false,-1, 31,0);
    tracep->declBus(c+30,"rt_data", false,-1, 31,0);
    tracep->declBus(c+15,"aluop", false,-1, 3,0);
    tracep->declBus(c+29,"result", false,-1, 31,0);
    tracep->declBit(c+31,"of", false,-1);
    tracep->declBit(c+33,"cf", false,-1);
    tracep->declBit(c+32,"zf", false,-1);
    tracep->declBus(c+34,"complement", false,-1, 31,0);
    tracep->declBus(c+35,"add_sub_result", false,-1, 31,0);
    tracep->pushNamePrefix("alumux ");
    tracep->declBus(c+133,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+134,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+29,"out", false,-1, 31,0);
    tracep->declBus(c+15,"key", false,-1, 3,0);
    tracep->declArray(c+36,"lut", false,-1, 71,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+133,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+134,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+135,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+29,"out", false,-1, 31,0);
    tracep->declBus(c+15,"key", false,-1, 3,0);
    tracep->declBus(c+136,"default_out", false,-1, 31,0);
    tracep->declArray(c+36,"lut", false,-1, 71,0);
    tracep->declBus(c+137,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+39+i*2,"pair_list", true,(i+0), 35,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+1+i*1,"key_list", true,(i+0), 3,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+43+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+45,"lut_out", false,-1, 31,0);
    tracep->declBit(c+46,"hit", false,-1);
    tracep->declBus(c+138,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("controller ");
    tracep->declBus(c+47,"opcode", false,-1, 6,0);
    tracep->declBus(c+48,"funct3", false,-1, 2,0);
    tracep->declBus(c+49,"funct7", false,-1, 6,0);
    tracep->declBus(c+15,"aluop", false,-1, 3,0);
    tracep->declBit(c+16,"Reg_Write", false,-1);
    tracep->declBus(c+18,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+19,"Jump", false,-1, 3,0);
    tracep->declBus(c+20,"Imm_Type", false,-1, 2,0);
    tracep->declBit(c+21,"AluSrcA", false,-1);
    tracep->declBit(c+22,"AluSrcB", false,-1);
    tracep->declBit(c+17,"Mem_Write", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("imm_sext ");
    tracep->declBus(c+14,"inst", false,-1, 31,0);
    tracep->declBus(c+20,"Imm_Type", false,-1, 2,0);
    tracep->declBus(c+30,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+50,"immI", false,-1, 31,0);
    tracep->declBus(c+51,"immU", false,-1, 31,0);
    tracep->declBus(c+52,"immJ", false,-1, 31,0);
    tracep->declBus(c+53,"immS", false,-1, 31,0);
    tracep->declBus(c+54,"immB", false,-1, 31,0);
    tracep->pushNamePrefix("imm_mux ");
    tracep->declBus(c+139,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+140,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+30,"out", false,-1, 31,0);
    tracep->declBus(c+20,"key", false,-1, 2,0);
    tracep->declArray(c+55,"lut", false,-1, 174,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+139,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+140,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+135,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+30,"out", false,-1, 31,0);
    tracep->declBus(c+20,"key", false,-1, 2,0);
    tracep->declBus(c+136,"default_out", false,-1, 31,0);
    tracep->declArray(c+55,"lut", false,-1, 174,0);
    tracep->declBus(c+141,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 5; ++i) {
        tracep->declQuad(c+61+i*2,"pair_list", true,(i+0), 34,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+3+i*1,"key_list", true,(i+0), 2,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+71+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+76,"lut_out", false,-1, 31,0);
    tracep->declBit(c+77,"hit", false,-1);
    tracep->declBus(c+142,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("mem ");
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBit(c+17,"Mem_Write", false,-1);
    tracep->declBus(c+29,"waddr", false,-1, 31,0);
    tracep->declBus(c+28,"wdata", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("reg_write_data_mux ");
    tracep->declBus(c+140,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+133,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+26,"out", false,-1, 31,0);
    tracep->declBus(c+18,"key", false,-1, 1,0);
    tracep->declArray(c+78,"lut", false,-1, 101,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+140,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+133,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+135,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+26,"out", false,-1, 31,0);
    tracep->declBus(c+18,"key", false,-1, 1,0);
    tracep->declBus(c+136,"default_out", false,-1, 31,0);
    tracep->declArray(c+78,"lut", false,-1, 101,0);
    tracep->declBus(c+143,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 3; ++i) {
        tracep->declQuad(c+82+i*2,"pair_list", true,(i+0), 33,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+8+i*1,"key_list", true,(i+0), 1,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+88+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+91,"lut_out", false,-1, 31,0);
    tracep->declBit(c+92,"hit", false,-1);
    tracep->declBus(c+144,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("registerfile ");
    tracep->declBus(c+139,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+130,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+125,"clk", false,-1);
    tracep->declBus(c+26,"wdata", false,-1, 31,0);
    tracep->declBus(c+25,"waddr", false,-1, 4,0);
    tracep->declBit(c+16,"wen", false,-1);
    tracep->declBus(c+23,"rs1", false,-1, 4,0);
    tracep->declBus(c+24,"rs2", false,-1, 4,0);
    tracep->declBus(c+27,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+28,"rs2_data", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+93+i*1,"rf", true,(i+0), 31,0);
    }
    tracep->declBus(c+11,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_init_top(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_init_top\n"); );
    // Body
    Vysyx_24100006_cpu___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vysyx_24100006_cpu___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vysyx_24100006_cpu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_register(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vysyx_24100006_cpu___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vysyx_24100006_cpu___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vysyx_24100006_cpu___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_full_top_0\n"); );
    // Init
    Vysyx_24100006_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vysyx_24100006_cpu___024root*>(voidSelf);
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vysyx_24100006_cpu___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vysyx_24100006_cpu___024root__trace_full_sub_0(Vysyx_24100006_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vysyx_24100006_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vysyx_24100006_cpu___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    VlWide<3>/*95:0*/ __Vtemp_h6a294f06__0;
    VlWide<6>/*191:0*/ __Vtemp_h2759fd9d__0;
    VlWide<4>/*127:0*/ __Vtemp_h45c9da58__0;
    // Body
    bufp->fullCData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0]),4);
    bufp->fullCData(oldp+2,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1]),4);
    bufp->fullCData(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0]),3);
    bufp->fullCData(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1]),3);
    bufp->fullCData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2]),3);
    bufp->fullCData(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3]),3);
    bufp->fullCData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4]),3);
    bufp->fullCData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0]),2);
    bufp->fullCData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1]),2);
    bufp->fullCData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2]),2);
    bufp->fullIData(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    bufp->fullIData(oldp+12,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->fullIData(oldp+13,(((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
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
                                           & (3U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump)))
                                           ? vlSelf->ysyx_24100006_cpu__DOT__NPC__DOT____VdfgTmp_hc1f7d439__0
                                           : 0U))))),32);
    bufp->fullIData(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__instruction),32);
    bufp->fullCData(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__aluop),4);
    bufp->fullBit(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write));
    bufp->fullBit(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Write));
    bufp->fullCData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD),2);
    bufp->fullCData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__Jump),4);
    bufp->fullCData(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type),3);
    bufp->fullBit(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA));
    bufp->fullBit(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB));
    bufp->fullCData(oldp+23,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+24,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0x14U))),5);
    bufp->fullCData(oldp+25,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 7U))),5);
    bufp->fullIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__wdata_reg),32);
    bufp->fullIData(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__rs1_data),32);
    bufp->fullIData(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf
                             [(0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                        >> 0x14U))]),32);
    bufp->fullIData(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__alu_result),32);
    bufp->fullIData(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__sext_imm),32);
    bufp->fullBit(oldp+31,((1U & ((~ ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                       ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                      >> 0x1fU)) & 
                                  ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                    ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                   >> 0x1fU)))));
    bufp->fullBit(oldp+32,((1U & (~ (IData)((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_result))))));
    bufp->fullBit(oldp+33,((1U & (IData)((1ULL & (((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__rs1_data)) 
                                                   + 
                                                   ((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement)) 
                                                    + (QData)((IData)(
                                                                      (1U 
                                                                       & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))))) 
                                                  >> 0x20U))))));
    bufp->fullIData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement),32);
    bufp->fullIData(oldp+35,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result),32);
    __Vtemp_h6a294f06__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))));
    __Vtemp_h6a294f06__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                 << 4U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))) 
                                                   >> 0x20U)));
    __Vtemp_h6a294f06__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                >> 0x1cU);
    bufp->fullWData(oldp+36,(__Vtemp_h6a294f06__0),72);
    bufp->fullQData(oldp+39,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0]),36);
    bufp->fullQData(oldp+41,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1]),36);
    bufp->fullIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+45,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+46,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+47,((0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)),7);
    bufp->fullCData(oldp+48,((7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+49,((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                              >> 0x19U)),7);
    bufp->fullIData(oldp+50,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0xbU) | (0x7ffU & 
                                           (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                            >> 0x14U)))),32);
    bufp->fullIData(oldp+51,((0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)),32);
    bufp->fullIData(oldp+52,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0x14U) | ((0xff000U 
                                             & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                            | ((0x800U 
                                                & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                   >> 9U)) 
                                               | (0x7feU 
                                                  & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                     >> 0x14U)))))),32);
    bufp->fullIData(oldp+53,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0xbU) | ((0x7e0U 
                                            & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x14U)) 
                                           | (0x1fU 
                                              & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                 >> 7U))))),32);
    bufp->fullIData(oldp+54,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
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
    __Vtemp_h2759fd9d__0[1U] = ((0xfffffff8U & (((- (IData)(
                                                            (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                             >> 0x1fU))) 
                                                 << 0xfU) 
                                                | ((0x4000U 
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
                                         | (7U & ((- (IData)(
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
                                         | (0x3fU & 
                                            ((- (IData)(
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
    bufp->fullWData(oldp+55,(__Vtemp_h2759fd9d__0),175);
    bufp->fullQData(oldp+61,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0]),35);
    bufp->fullQData(oldp+63,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1]),35);
    bufp->fullQData(oldp+65,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2]),35);
    bufp->fullQData(oldp+67,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3]),35);
    bufp->fullQData(oldp+69,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4]),35);
    bufp->fullIData(oldp+71,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+72,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+73,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+74,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3]),32);
    bufp->fullIData(oldp+75,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4]),32);
    bufp->fullIData(oldp+76,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+77,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit));
    __Vtemp_h45c9da58__0[0U] = (IData)((0x200000000ULL 
                                        | (QData)((IData)(
                                                          ((IData)(4U) 
                                                           + vlSelf->ysyx_24100006_cpu__DOT__pc)))));
    __Vtemp_h45c9da58__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                 << 2U) | (IData)((
                                                   (0x200000000ULL 
                                                    | (QData)((IData)(
                                                                      ((IData)(4U) 
                                                                       + vlSelf->ysyx_24100006_cpu__DOT__pc)))) 
                                                   >> 0x20U)));
    __Vtemp_h45c9da58__0[2U] = (4U | ((vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                       << 4U) | (vlSelf->ysyx_24100006_cpu__DOT__alu_result 
                                                 >> 0x1eU)));
    __Vtemp_h45c9da58__0[3U] = (vlSelf->ysyx_24100006_cpu__DOT__sext_imm 
                                >> 0x1cU);
    bufp->fullWData(oldp+78,(__Vtemp_h45c9da58__0),102);
    bufp->fullQData(oldp+82,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0]),34);
    bufp->fullQData(oldp+84,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1]),34);
    bufp->fullQData(oldp+86,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2]),34);
    bufp->fullIData(oldp+88,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+89,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+90,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+91,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+92,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit));
    bufp->fullIData(oldp+93,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
    bufp->fullIData(oldp+94,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
    bufp->fullIData(oldp+95,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
    bufp->fullIData(oldp+96,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
    bufp->fullIData(oldp+97,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
    bufp->fullIData(oldp+98,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
    bufp->fullIData(oldp+99,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
    bufp->fullIData(oldp+100,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
    bufp->fullIData(oldp+101,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
    bufp->fullIData(oldp+102,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
    bufp->fullIData(oldp+103,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
    bufp->fullIData(oldp+104,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
    bufp->fullIData(oldp+105,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
    bufp->fullIData(oldp+106,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
    bufp->fullIData(oldp+107,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
    bufp->fullIData(oldp+108,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
    bufp->fullIData(oldp+109,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
    bufp->fullIData(oldp+110,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
    bufp->fullIData(oldp+111,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
    bufp->fullIData(oldp+112,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
    bufp->fullIData(oldp+113,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
    bufp->fullIData(oldp+114,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
    bufp->fullIData(oldp+115,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
    bufp->fullIData(oldp+116,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
    bufp->fullIData(oldp+117,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
    bufp->fullIData(oldp+118,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
    bufp->fullIData(oldp+119,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
    bufp->fullIData(oldp+120,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
    bufp->fullIData(oldp+121,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
    bufp->fullIData(oldp+122,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
    bufp->fullIData(oldp+123,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
    bufp->fullIData(oldp+124,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    bufp->fullBit(oldp+125,(vlSelf->clk));
    bufp->fullBit(oldp+126,(vlSelf->reset));
    bufp->fullIData(oldp+127,(vlSelf->x_result),32);
    bufp->fullIData(oldp+128,(vlSelf->x_pc),32);
    bufp->fullCData(oldp+129,(vlSelf->ysyx_24100006_cpu__DOT__rd),5);
    bufp->fullIData(oldp+130,(0x20U),32);
    bufp->fullIData(oldp+131,(0x80000000U),32);
    bufp->fullBit(oldp+132,(1U));
    bufp->fullIData(oldp+133,(2U),32);
    bufp->fullIData(oldp+134,(4U),32);
    bufp->fullIData(oldp+135,(0U),32);
    bufp->fullIData(oldp+136,(0U),32);
    bufp->fullIData(oldp+137,(0x24U),32);
    bufp->fullIData(oldp+138,(2U),32);
    bufp->fullIData(oldp+139,(5U),32);
    bufp->fullIData(oldp+140,(3U),32);
    bufp->fullIData(oldp+141,(0x23U),32);
    bufp->fullIData(oldp+142,(5U),32);
    bufp->fullIData(oldp+143,(0x22U),32);
    bufp->fullIData(oldp+144,(3U),32);
}

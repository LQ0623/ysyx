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
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBit(c+153,"reset", false,-1);
    tracep->declBus(c+154,"x_result", false,-1, 31,0);
    tracep->declBus(c+155,"x_pc", false,-1, 31,0);
    tracep->pushNamePrefix("ysyx_24100006_cpu ");
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBit(c+153,"reset", false,-1);
    tracep->declBus(c+154,"x_result", false,-1, 31,0);
    tracep->declBus(c+155,"x_pc", false,-1, 31,0);
    tracep->declBus(c+16,"pc", false,-1, 31,0);
    tracep->declBus(c+17,"npc", false,-1, 31,0);
    tracep->declBus(c+18,"instruction", false,-1, 31,0);
    tracep->declBus(c+19,"aluop", false,-1, 3,0);
    tracep->declBit(c+20,"Reg_Write", false,-1);
    tracep->declBit(c+156,"Mem_Write", false,-1);
    tracep->declBus(c+21,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+22,"Jump", false,-1, 3,0);
    tracep->declBus(c+23,"Imm_Type", false,-1, 2,0);
    tracep->declBit(c+24,"AluSrcA", false,-1);
    tracep->declBit(c+25,"AluSrcB", false,-1);
    tracep->declBus(c+26,"rs", false,-1, 4,0);
    tracep->declBus(c+27,"rt", false,-1, 4,0);
    tracep->declBus(c+157,"rd", false,-1, 4,0);
    tracep->declBus(c+28,"waddr_reg", false,-1, 4,0);
    tracep->declBus(c+29,"wdata_reg", false,-1, 31,0);
    tracep->declBus(c+30,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+31,"rs2_data", false,-1, 31,0);
    tracep->declBus(c+32,"alu_result", false,-1, 31,0);
    tracep->declBus(c+33,"sext_imm", false,-1, 31,0);
    tracep->declBit(c+34,"of", false,-1);
    tracep->declBit(c+35,"zf", false,-1);
    tracep->declBit(c+36,"cf", false,-1);
    tracep->declBus(c+37,"alu_a_data", false,-1, 31,0);
    tracep->declBus(c+38,"alu_b_data", false,-1, 31,0);
    tracep->pushNamePrefix("IM ");
    tracep->declBus(c+16,"pc", false,-1, 31,0);
    tracep->declBus(c+18,"instruction", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("NPC ");
    tracep->declBus(c+16,"pc", false,-1, 31,0);
    tracep->declBus(c+22,"Skip_mode", false,-1, 3,0);
    tracep->declBus(c+33,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+30,"rs_data", false,-1, 31,0);
    tracep->declBit(c+35,"zf", false,-1);
    tracep->declBus(c+17,"npc", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC ");
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBit(c+153,"reset", false,-1);
    tracep->declBus(c+17,"npc", false,-1, 31,0);
    tracep->declBus(c+16,"pc", false,-1, 31,0);
    tracep->pushNamePrefix("pc1 ");
    tracep->declBus(c+158,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+159,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBit(c+153,"rst", false,-1);
    tracep->declBus(c+17,"din", false,-1, 31,0);
    tracep->declBus(c+16,"dout", false,-1, 31,0);
    tracep->declBit(c+160,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+37,"rs_data", false,-1, 31,0);
    tracep->declBus(c+38,"rt_data", false,-1, 31,0);
    tracep->declBus(c+19,"aluop", false,-1, 3,0);
    tracep->declBus(c+32,"result", false,-1, 31,0);
    tracep->declBit(c+34,"of", false,-1);
    tracep->declBit(c+36,"cf", false,-1);
    tracep->declBit(c+35,"zf", false,-1);
    tracep->declBus(c+39,"complement", false,-1, 31,0);
    tracep->declBus(c+40,"add_sub_result", false,-1, 31,0);
    tracep->pushNamePrefix("alumux ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+162,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+32,"out", false,-1, 31,0);
    tracep->declBus(c+19,"key", false,-1, 3,0);
    tracep->declArray(c+41,"lut", false,-1, 71,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+162,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+163,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+32,"out", false,-1, 31,0);
    tracep->declBus(c+19,"key", false,-1, 3,0);
    tracep->declBus(c+164,"default_out", false,-1, 31,0);
    tracep->declArray(c+41,"lut", false,-1, 71,0);
    tracep->declBus(c+165,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+44+i*2,"pair_list", true,(i+0), 35,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+1+i*1,"key_list", true,(i+0), 3,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+48+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+50,"lut_out", false,-1, 31,0);
    tracep->declBit(c+51,"hit", false,-1);
    tracep->declBus(c+166,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("alu_a_data_mux ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+167,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+37,"out", false,-1, 31,0);
    tracep->declBus(c+24,"key", false,-1, 0,0);
    tracep->declArray(c+52,"lut", false,-1, 65,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+167,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+163,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+37,"out", false,-1, 31,0);
    tracep->declBus(c+24,"key", false,-1, 0,0);
    tracep->declBus(c+164,"default_out", false,-1, 31,0);
    tracep->declArray(c+52,"lut", false,-1, 65,0);
    tracep->declBus(c+168,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+55+i*2,"pair_list", true,(i+0), 32,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+3+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+59+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+61,"lut_out", false,-1, 31,0);
    tracep->declBit(c+62,"hit", false,-1);
    tracep->declBus(c+166,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu_b_data_mux ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+167,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+38,"out", false,-1, 31,0);
    tracep->declBus(c+25,"key", false,-1, 0,0);
    tracep->declArray(c+63,"lut", false,-1, 65,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+161,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+167,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+163,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+38,"out", false,-1, 31,0);
    tracep->declBus(c+25,"key", false,-1, 0,0);
    tracep->declBus(c+164,"default_out", false,-1, 31,0);
    tracep->declArray(c+63,"lut", false,-1, 65,0);
    tracep->declBus(c+168,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+66+i*2,"pair_list", true,(i+0), 32,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+5+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+70+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+72,"lut_out", false,-1, 31,0);
    tracep->declBit(c+73,"hit", false,-1);
    tracep->declBus(c+166,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("controller ");
    tracep->declBus(c+74,"opcode", false,-1, 6,0);
    tracep->declBus(c+75,"funct3", false,-1, 2,0);
    tracep->declBus(c+76,"funct7", false,-1, 6,0);
    tracep->declBus(c+19,"aluop", false,-1, 3,0);
    tracep->declBit(c+20,"Reg_Write", false,-1);
    tracep->declBus(c+21,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+22,"Jump", false,-1, 3,0);
    tracep->declBus(c+23,"Imm_Type", false,-1, 2,0);
    tracep->declBit(c+24,"AluSrcA", false,-1);
    tracep->declBit(c+25,"AluSrcB", false,-1);
    tracep->declBit(c+156,"Mem_Write", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("imm_sext ");
    tracep->declBus(c+18,"inst", false,-1, 31,0);
    tracep->declBus(c+23,"Imm_Type", false,-1, 2,0);
    tracep->declBus(c+33,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+77,"immI", false,-1, 31,0);
    tracep->declBus(c+78,"immU", false,-1, 31,0);
    tracep->declBus(c+79,"immJ", false,-1, 31,0);
    tracep->declBus(c+80,"immS", false,-1, 31,0);
    tracep->declBus(c+81,"immB", false,-1, 31,0);
    tracep->pushNamePrefix("imm_mux ");
    tracep->declBus(c+169,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+170,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+33,"out", false,-1, 31,0);
    tracep->declBus(c+23,"key", false,-1, 2,0);
    tracep->declArray(c+82,"lut", false,-1, 174,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+169,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+170,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+163,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+33,"out", false,-1, 31,0);
    tracep->declBus(c+23,"key", false,-1, 2,0);
    tracep->declBus(c+164,"default_out", false,-1, 31,0);
    tracep->declArray(c+82,"lut", false,-1, 174,0);
    tracep->declBus(c+171,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 5; ++i) {
        tracep->declQuad(c+88+i*2,"pair_list", true,(i+0), 34,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+7+i*1,"key_list", true,(i+0), 2,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+98+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+103,"lut_out", false,-1, 31,0);
    tracep->declBit(c+104,"hit", false,-1);
    tracep->declBus(c+172,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("mem ");
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBit(c+156,"Mem_Write", false,-1);
    tracep->declBus(c+32,"waddr", false,-1, 31,0);
    tracep->declBus(c+31,"wdata", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("reg_write_data_mux ");
    tracep->declBus(c+170,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+161,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+29,"out", false,-1, 31,0);
    tracep->declBus(c+21,"key", false,-1, 1,0);
    tracep->declArray(c+105,"lut", false,-1, 101,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+170,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+161,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+163,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+29,"out", false,-1, 31,0);
    tracep->declBus(c+21,"key", false,-1, 1,0);
    tracep->declBus(c+164,"default_out", false,-1, 31,0);
    tracep->declArray(c+105,"lut", false,-1, 101,0);
    tracep->declBus(c+173,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 3; ++i) {
        tracep->declQuad(c+109+i*2,"pair_list", true,(i+0), 33,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+12+i*1,"key_list", true,(i+0), 1,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+115+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+118,"lut_out", false,-1, 31,0);
    tracep->declBit(c+119,"hit", false,-1);
    tracep->declBus(c+174,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("registerfile ");
    tracep->declBus(c+169,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+158,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+152,"clk", false,-1);
    tracep->declBus(c+29,"wdata", false,-1, 31,0);
    tracep->declBus(c+28,"waddr", false,-1, 4,0);
    tracep->declBit(c+20,"wen", false,-1);
    tracep->declBus(c+26,"rs1", false,-1, 4,0);
    tracep->declBus(c+27,"rs2", false,-1, 4,0);
    tracep->declBus(c+30,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+31,"rs2_data", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+120+i*1,"rf", true,(i+0), 31,0);
    }
    tracep->declBus(c+15,"i", false,-1, 31,0);
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
    VlWide<3>/*95:0*/ __Vtemp_h570d9f26__0;
    VlWide<3>/*95:0*/ __Vtemp_h5a1cf979__0;
    VlWide<6>/*191:0*/ __Vtemp_h2759fd9d__0;
    VlWide<4>/*127:0*/ __Vtemp_h45c9da58__0;
    // Body
    bufp->fullCData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0]),4);
    bufp->fullCData(oldp+2,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1]),4);
    bufp->fullBit(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[1]));
    bufp->fullCData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0]),3);
    bufp->fullCData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1]),3);
    bufp->fullCData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2]),3);
    bufp->fullCData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3]),3);
    bufp->fullCData(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4]),3);
    bufp->fullCData(oldp+12,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0]),2);
    bufp->fullCData(oldp+13,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1]),2);
    bufp->fullCData(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2]),2);
    bufp->fullIData(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    bufp->fullIData(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->fullIData(oldp+17,(((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
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
                                           : ((IData)(4U) 
                                              + vlSelf->ysyx_24100006_cpu__DOT__pc)))))),32);
    bufp->fullIData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__instruction),32);
    bufp->fullCData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__aluop),4);
    bufp->fullBit(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write));
    bufp->fullCData(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD),2);
    bufp->fullCData(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__Jump),4);
    bufp->fullCData(oldp+23,(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type),3);
    bufp->fullBit(oldp+24,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA));
    bufp->fullBit(oldp+25,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB));
    bufp->fullCData(oldp+26,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+27,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0x14U))),5);
    bufp->fullCData(oldp+28,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 7U))),5);
    bufp->fullIData(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__wdata_reg),32);
    bufp->fullIData(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__rs1_data),32);
    bufp->fullIData(oldp+31,(vlSelf->ysyx_24100006_cpu__DOT__rs2_data),32);
    bufp->fullIData(oldp+32,(vlSelf->ysyx_24100006_cpu__DOT__alu_result),32);
    bufp->fullIData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__sext_imm),32);
    bufp->fullBit(oldp+34,((1U & ((~ ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                       ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                      >> 0x1fU)) & 
                                  ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                    ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                   >> 0x1fU)))));
    bufp->fullBit(oldp+35,((1U & (~ (IData)((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_result))))));
    bufp->fullBit(oldp+36,((1U & (IData)((1ULL & (((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data)) 
                                                   + 
                                                   ((QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement)) 
                                                    + (QData)((IData)(
                                                                      (1U 
                                                                       & (IData)(vlSelf->ysyx_24100006_cpu__DOT__aluop)))))) 
                                                  >> 0x20U))))));
    bufp->fullIData(oldp+37,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data),32);
    bufp->fullIData(oldp+38,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data),32);
    bufp->fullIData(oldp+39,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement),32);
    bufp->fullIData(oldp+40,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result),32);
    __Vtemp_h6a294f06__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))));
    __Vtemp_h6a294f06__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                 << 4U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result))) 
                                                   >> 0x20U)));
    __Vtemp_h6a294f06__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result 
                                >> 0x1cU);
    bufp->fullWData(oldp+41,(__Vtemp_h6a294f06__0),72);
    bufp->fullQData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0]),36);
    bufp->fullQData(oldp+46,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1]),36);
    bufp->fullIData(oldp+48,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+49,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+50,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+51,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit));
    __Vtemp_h570d9f26__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))));
    __Vtemp_h570d9f26__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                 << 1U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))) 
                                                   >> 0x20U)));
    __Vtemp_h570d9f26__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                >> 0x1fU);
    bufp->fullWData(oldp+52,(__Vtemp_h570d9f26__0),66);
    bufp->fullQData(oldp+55,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[0]),33);
    bufp->fullQData(oldp+57,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[1]),33);
    bufp->fullIData(oldp+59,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+60,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+61,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+62,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit));
    __Vtemp_h5a1cf979__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))));
    __Vtemp_h5a1cf979__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                 << 1U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))) 
                                                   >> 0x20U)));
    __Vtemp_h5a1cf979__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                >> 0x1fU);
    bufp->fullWData(oldp+63,(__Vtemp_h5a1cf979__0),66);
    bufp->fullQData(oldp+66,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[0]),33);
    bufp->fullQData(oldp+68,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[1]),33);
    bufp->fullIData(oldp+70,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+71,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+72,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+73,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+74,((0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)),7);
    bufp->fullCData(oldp+75,((7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+76,((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                              >> 0x19U)),7);
    bufp->fullIData(oldp+77,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0xbU) | (0x7ffU & 
                                           (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                            >> 0x14U)))),32);
    bufp->fullIData(oldp+78,((0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)),32);
    bufp->fullIData(oldp+79,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0x14U) | ((0xff000U 
                                             & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                            | ((0x800U 
                                                & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                   >> 9U)) 
                                               | (0x7feU 
                                                  & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                     >> 0x14U)))))),32);
    bufp->fullIData(oldp+80,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                           >> 0x1fU))) 
                               << 0xbU) | ((0x7e0U 
                                            & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x14U)) 
                                           | (0x1fU 
                                              & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                 >> 7U))))),32);
    bufp->fullIData(oldp+81,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
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
    bufp->fullWData(oldp+82,(__Vtemp_h2759fd9d__0),175);
    bufp->fullQData(oldp+88,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0]),35);
    bufp->fullQData(oldp+90,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1]),35);
    bufp->fullQData(oldp+92,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2]),35);
    bufp->fullQData(oldp+94,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3]),35);
    bufp->fullQData(oldp+96,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4]),35);
    bufp->fullIData(oldp+98,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+99,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+100,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+101,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3]),32);
    bufp->fullIData(oldp+102,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4]),32);
    bufp->fullIData(oldp+103,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+104,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit));
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
    bufp->fullWData(oldp+105,(__Vtemp_h45c9da58__0),102);
    bufp->fullQData(oldp+109,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0]),34);
    bufp->fullQData(oldp+111,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1]),34);
    bufp->fullQData(oldp+113,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2]),34);
    bufp->fullIData(oldp+115,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+116,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+117,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+118,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+119,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit));
    bufp->fullIData(oldp+120,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
    bufp->fullIData(oldp+121,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
    bufp->fullIData(oldp+122,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
    bufp->fullIData(oldp+123,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
    bufp->fullIData(oldp+124,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
    bufp->fullIData(oldp+125,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
    bufp->fullIData(oldp+126,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
    bufp->fullIData(oldp+127,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
    bufp->fullIData(oldp+128,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
    bufp->fullIData(oldp+129,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
    bufp->fullIData(oldp+130,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
    bufp->fullIData(oldp+131,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
    bufp->fullIData(oldp+132,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
    bufp->fullIData(oldp+133,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
    bufp->fullIData(oldp+134,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
    bufp->fullIData(oldp+135,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
    bufp->fullIData(oldp+136,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
    bufp->fullIData(oldp+137,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
    bufp->fullIData(oldp+138,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
    bufp->fullIData(oldp+139,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
    bufp->fullIData(oldp+140,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
    bufp->fullIData(oldp+141,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
    bufp->fullIData(oldp+142,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
    bufp->fullIData(oldp+143,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
    bufp->fullIData(oldp+144,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
    bufp->fullIData(oldp+145,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
    bufp->fullIData(oldp+146,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
    bufp->fullIData(oldp+147,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
    bufp->fullIData(oldp+148,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
    bufp->fullIData(oldp+149,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
    bufp->fullIData(oldp+150,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
    bufp->fullIData(oldp+151,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    bufp->fullBit(oldp+152,(vlSelf->clk));
    bufp->fullBit(oldp+153,(vlSelf->reset));
    bufp->fullIData(oldp+154,(vlSelf->x_result),32);
    bufp->fullIData(oldp+155,(vlSelf->x_pc),32);
    bufp->fullBit(oldp+156,(0U));
    bufp->fullCData(oldp+157,(vlSelf->ysyx_24100006_cpu__DOT__rd),5);
    bufp->fullIData(oldp+158,(0x20U),32);
    bufp->fullIData(oldp+159,(0x80000000U),32);
    bufp->fullBit(oldp+160,(1U));
    bufp->fullIData(oldp+161,(2U),32);
    bufp->fullIData(oldp+162,(4U),32);
    bufp->fullIData(oldp+163,(0U),32);
    bufp->fullIData(oldp+164,(0U),32);
    bufp->fullIData(oldp+165,(0x24U),32);
    bufp->fullIData(oldp+166,(2U),32);
    bufp->fullIData(oldp+167,(1U),32);
    bufp->fullIData(oldp+168,(0x21U),32);
    bufp->fullIData(oldp+169,(5U),32);
    bufp->fullIData(oldp+170,(3U),32);
    bufp->fullIData(oldp+171,(0x23U),32);
    bufp->fullIData(oldp+172,(5U),32);
    bufp->fullIData(oldp+173,(0x22U),32);
    bufp->fullIData(oldp+174,(3U),32);
}

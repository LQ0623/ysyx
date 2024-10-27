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
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBit(c+207,"reset", false,-1);
    tracep->declBus(c+208,"x_result", false,-1, 31,0);
    tracep->declBus(c+209,"x_pc", false,-1, 31,0);
    tracep->pushNamePrefix("ysyx_24100006_cpu ");
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBit(c+207,"reset", false,-1);
    tracep->declBus(c+208,"x_result", false,-1, 31,0);
    tracep->declBus(c+209,"x_pc", false,-1, 31,0);
    tracep->declBus(c+24,"pc", false,-1, 31,0);
    tracep->declBus(c+25,"npc", false,-1, 31,0);
    tracep->declBus(c+26,"instruction", false,-1, 31,0);
    tracep->declBit(c+27,"Reg_Write", false,-1);
    tracep->declBit(c+28,"AluSrcA", false,-1);
    tracep->declBit(c+29,"AluSrcB", false,-1);
    tracep->declBit(c+30,"Mem_Read", false,-1);
    tracep->declBit(c+31,"Mem_Write", false,-1);
    tracep->declBus(c+32,"write_sext", false,-1, 1,0);
    tracep->declBus(c+33,"aluop", false,-1, 3,0);
    tracep->declBus(c+34,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+35,"Jump", false,-1, 3,0);
    tracep->declBus(c+36,"Imm_Type", false,-1, 2,0);
    tracep->declBus(c+37,"Mem_WMask", false,-1, 7,0);
    tracep->declBus(c+38,"Mem_RMask", false,-1, 1,0);
    tracep->declBus(c+39,"rs", false,-1, 4,0);
    tracep->declBus(c+40,"rt", false,-1, 4,0);
    tracep->declBus(c+210,"rd", false,-1, 4,0);
    tracep->declBus(c+41,"waddr_reg", false,-1, 4,0);
    tracep->declBus(c+42,"wdata_reg", false,-1, 31,0);
    tracep->declBus(c+43,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+44,"rs2_data", false,-1, 31,0);
    tracep->declBus(c+45,"alu_result", false,-1, 31,0);
    tracep->declBus(c+46,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+211,"raddr", false,-1, 31,0);
    tracep->declBus(c+212,"rdata", false,-1, 31,0);
    tracep->declBit(c+47,"of", false,-1);
    tracep->declBit(c+48,"zf", false,-1);
    tracep->declBit(c+49,"cf", false,-1);
    tracep->declBus(c+50,"alu_a_data", false,-1, 31,0);
    tracep->declBus(c+51,"alu_b_data", false,-1, 31,0);
    tracep->pushNamePrefix("IM ");
    tracep->declBus(c+24,"pc", false,-1, 31,0);
    tracep->declBus(c+26,"instruction", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("NPC ");
    tracep->declBus(c+24,"pc", false,-1, 31,0);
    tracep->declBus(c+35,"Skip_mode", false,-1, 3,0);
    tracep->declBus(c+46,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+43,"rs_data", false,-1, 31,0);
    tracep->declBit(c+48,"zf", false,-1);
    tracep->declBus(c+25,"npc", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC ");
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBit(c+207,"reset", false,-1);
    tracep->declBus(c+25,"npc", false,-1, 31,0);
    tracep->declBus(c+24,"pc", false,-1, 31,0);
    tracep->pushNamePrefix("pc1 ");
    tracep->declBus(c+213,"WIDTH", false,-1, 31,0);
    tracep->declBus(c+214,"RESET_VAL", false,-1, 31,0);
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBit(c+207,"rst", false,-1);
    tracep->declBus(c+25,"din", false,-1, 31,0);
    tracep->declBus(c+24,"dout", false,-1, 31,0);
    tracep->declBit(c+215,"wen", false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+50,"rs_data", false,-1, 31,0);
    tracep->declBus(c+51,"rt_data", false,-1, 31,0);
    tracep->declBus(c+33,"aluop", false,-1, 3,0);
    tracep->declBus(c+45,"result", false,-1, 31,0);
    tracep->declBit(c+47,"of", false,-1);
    tracep->declBit(c+49,"cf", false,-1);
    tracep->declBit(c+48,"zf", false,-1);
    tracep->declBus(c+52,"complement", false,-1, 31,0);
    tracep->declBus(c+53,"add_sub_result", false,-1, 31,0);
    tracep->declBus(c+54,"and_result", false,-1, 31,0);
    tracep->declBus(c+55,"or_result", false,-1, 31,0);
    tracep->declBus(c+56,"xor_result", false,-1, 31,0);
    tracep->declBus(c+57,"cmp_result", false,-1, 31,0);
    tracep->declBus(c+58,"cmpu_result", false,-1, 31,0);
    tracep->declBus(c+59,"sra_result", false,-1, 31,0);
    tracep->declBus(c+60,"srl_result", false,-1, 31,0);
    tracep->declBus(c+61,"sll_result", false,-1, 31,0);
    tracep->pushNamePrefix("alumux ");
    tracep->declBus(c+216,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+217,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+45,"out", false,-1, 31,0);
    tracep->declBus(c+33,"key", false,-1, 3,0);
    tracep->declArray(c+62,"lut", false,-1, 359,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+216,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+217,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+218,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+45,"out", false,-1, 31,0);
    tracep->declBus(c+33,"key", false,-1, 3,0);
    tracep->declBus(c+219,"default_out", false,-1, 31,0);
    tracep->declArray(c+62,"lut", false,-1, 359,0);
    tracep->declBus(c+220,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 10; ++i) {
        tracep->declQuad(c+74+i*2,"pair_list", true,(i+0), 35,0);
    }
    for (int i = 0; i < 10; ++i) {
        tracep->declBus(c+1+i*1,"key_list", true,(i+0), 3,0);
    }
    for (int i = 0; i < 10; ++i) {
        tracep->declBus(c+94+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+104,"lut_out", false,-1, 31,0);
    tracep->declBit(c+105,"hit", false,-1);
    tracep->declBus(c+221,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("alu_a_data_mux ");
    tracep->declBus(c+222,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+223,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+50,"out", false,-1, 31,0);
    tracep->declBus(c+28,"key", false,-1, 0,0);
    tracep->declArray(c+106,"lut", false,-1, 65,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+222,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+223,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+218,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+50,"out", false,-1, 31,0);
    tracep->declBus(c+28,"key", false,-1, 0,0);
    tracep->declBus(c+219,"default_out", false,-1, 31,0);
    tracep->declArray(c+106,"lut", false,-1, 65,0);
    tracep->declBus(c+224,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+109+i*2,"pair_list", true,(i+0), 32,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+11+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+113+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+115,"lut_out", false,-1, 31,0);
    tracep->declBit(c+116,"hit", false,-1);
    tracep->declBus(c+225,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu_b_data_mux ");
    tracep->declBus(c+222,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+223,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+51,"out", false,-1, 31,0);
    tracep->declBus(c+29,"key", false,-1, 0,0);
    tracep->declArray(c+117,"lut", false,-1, 65,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+222,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+223,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+218,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+51,"out", false,-1, 31,0);
    tracep->declBus(c+29,"key", false,-1, 0,0);
    tracep->declBus(c+219,"default_out", false,-1, 31,0);
    tracep->declArray(c+117,"lut", false,-1, 65,0);
    tracep->declBus(c+224,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 2; ++i) {
        tracep->declQuad(c+120+i*2,"pair_list", true,(i+0), 32,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+13+i*1,"key_list", true,(i+0), 0,0);
    }
    for (int i = 0; i < 2; ++i) {
        tracep->declBus(c+124+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+126,"lut_out", false,-1, 31,0);
    tracep->declBit(c+127,"hit", false,-1);
    tracep->declBus(c+225,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("controller ");
    tracep->declBus(c+128,"opcode", false,-1, 6,0);
    tracep->declBus(c+129,"funct3", false,-1, 2,0);
    tracep->declBus(c+130,"funct7", false,-1, 6,0);
    tracep->declBus(c+33,"aluop", false,-1, 3,0);
    tracep->declBit(c+27,"Reg_Write", false,-1);
    tracep->declBus(c+34,"Reg_Write_RD", false,-1, 1,0);
    tracep->declBus(c+35,"Jump", false,-1, 3,0);
    tracep->declBus(c+36,"Imm_Type", false,-1, 2,0);
    tracep->declBit(c+28,"AluSrcA", false,-1);
    tracep->declBit(c+29,"AluSrcB", false,-1);
    tracep->declBit(c+30,"Mem_Read", false,-1);
    tracep->declBus(c+38,"Mem_RMask", false,-1, 1,0);
    tracep->declBit(c+31,"Mem_Write", false,-1);
    tracep->declBus(c+37,"Mem_WMask", false,-1, 7,0);
    tracep->declBus(c+32,"write_sext", false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("imm_sext ");
    tracep->declBus(c+26,"inst", false,-1, 31,0);
    tracep->declBus(c+36,"Imm_Type", false,-1, 2,0);
    tracep->declBus(c+46,"sext_imm", false,-1, 31,0);
    tracep->declBus(c+131,"immI", false,-1, 31,0);
    tracep->declBus(c+132,"immU", false,-1, 31,0);
    tracep->declBus(c+133,"immJ", false,-1, 31,0);
    tracep->declBus(c+134,"immS", false,-1, 31,0);
    tracep->declBus(c+135,"immB", false,-1, 31,0);
    tracep->pushNamePrefix("imm_mux ");
    tracep->declBus(c+226,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+227,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+46,"out", false,-1, 31,0);
    tracep->declBus(c+36,"key", false,-1, 2,0);
    tracep->declArray(c+136,"lut", false,-1, 174,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+226,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+227,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+218,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+46,"out", false,-1, 31,0);
    tracep->declBus(c+36,"key", false,-1, 2,0);
    tracep->declBus(c+219,"default_out", false,-1, 31,0);
    tracep->declArray(c+136,"lut", false,-1, 174,0);
    tracep->declBus(c+228,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 5; ++i) {
        tracep->declQuad(c+142+i*2,"pair_list", true,(i+0), 34,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+15+i*1,"key_list", true,(i+0), 2,0);
    }
    for (int i = 0; i < 5; ++i) {
        tracep->declBus(c+152+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+157,"lut_out", false,-1, 31,0);
    tracep->declBit(c+158,"hit", false,-1);
    tracep->declBus(c+229,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("mem ");
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBit(c+31,"Mem_Write", false,-1);
    tracep->declBus(c+37,"Mem_WMask", false,-1, 7,0);
    tracep->declBus(c+45,"waddr", false,-1, 31,0);
    tracep->declBus(c+44,"wdata", false,-1, 31,0);
    tracep->declBit(c+30,"Mem_Read", false,-1);
    tracep->declBus(c+211,"raddr", false,-1, 31,0);
    tracep->declBus(c+212,"rdata", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("reg_write_data_mux ");
    tracep->declBus(c+227,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+222,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+42,"out", false,-1, 31,0);
    tracep->declBus(c+34,"key", false,-1, 1,0);
    tracep->declArray(c+159,"lut", false,-1, 101,0);
    tracep->pushNamePrefix("i0 ");
    tracep->declBus(c+227,"NR_KEY", false,-1, 31,0);
    tracep->declBus(c+222,"KEY_LEN", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_LEN", false,-1, 31,0);
    tracep->declBus(c+218,"HAS_DEFAULT", false,-1, 31,0);
    tracep->declBus(c+42,"out", false,-1, 31,0);
    tracep->declBus(c+34,"key", false,-1, 1,0);
    tracep->declBus(c+219,"default_out", false,-1, 31,0);
    tracep->declArray(c+159,"lut", false,-1, 101,0);
    tracep->declBus(c+230,"PAIR_LEN", false,-1, 31,0);
    for (int i = 0; i < 3; ++i) {
        tracep->declQuad(c+163+i*2,"pair_list", true,(i+0), 33,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+20+i*1,"key_list", true,(i+0), 1,0);
    }
    for (int i = 0; i < 3; ++i) {
        tracep->declBus(c+169+i*1,"data_list", true,(i+0), 31,0);
    }
    tracep->declBus(c+172,"lut_out", false,-1, 31,0);
    tracep->declBit(c+173,"hit", false,-1);
    tracep->declBus(c+231,"i", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("registerfile ");
    tracep->declBus(c+226,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+213,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+206,"clk", false,-1);
    tracep->declBus(c+42,"wdata", false,-1, 31,0);
    tracep->declBus(c+41,"waddr", false,-1, 4,0);
    tracep->declBit(c+27,"wen", false,-1);
    tracep->declBus(c+39,"rs1", false,-1, 4,0);
    tracep->declBus(c+40,"rs2", false,-1, 4,0);
    tracep->declBus(c+43,"rs1_data", false,-1, 31,0);
    tracep->declBus(c+44,"rs2_data", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+174+i*1,"rf", true,(i+0), 31,0);
    }
    tracep->declBus(c+23,"i", false,-1, 31,0);
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
    VlWide<12>/*383:0*/ __Vtemp_hd6a05b0a__0;
    VlWide<3>/*95:0*/ __Vtemp_h570d9f26__0;
    VlWide<3>/*95:0*/ __Vtemp_h5a1cf979__0;
    VlWide<6>/*191:0*/ __Vtemp_h2759fd9d__0;
    VlWide<4>/*127:0*/ __Vtemp_h45c9da58__0;
    // Body
    bufp->fullCData(oldp+1,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[0]),4);
    bufp->fullCData(oldp+2,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[1]),4);
    bufp->fullCData(oldp+3,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[2]),4);
    bufp->fullCData(oldp+4,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[3]),4);
    bufp->fullCData(oldp+5,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[4]),4);
    bufp->fullCData(oldp+6,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[5]),4);
    bufp->fullCData(oldp+7,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[6]),4);
    bufp->fullCData(oldp+8,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[7]),4);
    bufp->fullCData(oldp+9,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[8]),4);
    bufp->fullCData(oldp+10,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__key_list[9]),4);
    bufp->fullBit(oldp+11,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+12,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__key_list[1]));
    bufp->fullBit(oldp+13,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[0]));
    bufp->fullBit(oldp+14,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__key_list[1]));
    bufp->fullCData(oldp+15,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[0]),3);
    bufp->fullCData(oldp+16,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[1]),3);
    bufp->fullCData(oldp+17,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[2]),3);
    bufp->fullCData(oldp+18,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[3]),3);
    bufp->fullCData(oldp+19,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__key_list[4]),3);
    bufp->fullCData(oldp+20,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[0]),2);
    bufp->fullCData(oldp+21,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[1]),2);
    bufp->fullCData(oldp+22,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__key_list[2]),2);
    bufp->fullIData(oldp+23,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__i),32);
    bufp->fullIData(oldp+24,(vlSelf->ysyx_24100006_cpu__DOT__pc),32);
    bufp->fullIData(oldp+25,(((0U == (IData)(vlSelf->ysyx_24100006_cpu__DOT__Jump))
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
    bufp->fullIData(oldp+26,(vlSelf->ysyx_24100006_cpu__DOT__instruction),32);
    bufp->fullBit(oldp+27,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write));
    bufp->fullBit(oldp+28,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcA));
    bufp->fullBit(oldp+29,(vlSelf->ysyx_24100006_cpu__DOT__AluSrcB));
    bufp->fullBit(oldp+30,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Read));
    bufp->fullBit(oldp+31,(vlSelf->ysyx_24100006_cpu__DOT__Mem_Write));
    bufp->fullCData(oldp+32,(vlSelf->ysyx_24100006_cpu__DOT__write_sext),2);
    bufp->fullCData(oldp+33,(vlSelf->ysyx_24100006_cpu__DOT__aluop),4);
    bufp->fullCData(oldp+34,(vlSelf->ysyx_24100006_cpu__DOT__Reg_Write_RD),2);
    bufp->fullCData(oldp+35,(vlSelf->ysyx_24100006_cpu__DOT__Jump),4);
    bufp->fullCData(oldp+36,(vlSelf->ysyx_24100006_cpu__DOT__Imm_Type),3);
    bufp->fullCData(oldp+37,(vlSelf->ysyx_24100006_cpu__DOT__Mem_WMask),8);
    bufp->fullCData(oldp+38,(vlSelf->ysyx_24100006_cpu__DOT__Mem_RMask),2);
    bufp->fullCData(oldp+39,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+40,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 0x14U))),5);
    bufp->fullCData(oldp+41,((0x1fU & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                       >> 7U))),5);
    bufp->fullIData(oldp+42,(vlSelf->ysyx_24100006_cpu__DOT__wdata_reg),32);
    bufp->fullIData(oldp+43,(vlSelf->ysyx_24100006_cpu__DOT__rs1_data),32);
    bufp->fullIData(oldp+44,(vlSelf->ysyx_24100006_cpu__DOT__rs2_data),32);
    bufp->fullIData(oldp+45,(vlSelf->ysyx_24100006_cpu__DOT__alu_result),32);
    bufp->fullIData(oldp+46,(vlSelf->ysyx_24100006_cpu__DOT__sext_imm),32);
    bufp->fullBit(oldp+47,((1U & ((~ ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                       ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement) 
                                      >> 0x1fU)) & 
                                  ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                    ^ vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result) 
                                   >> 0x1fU)))));
    bufp->fullBit(oldp+48,((1U & (~ (IData)((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_result))))));
    bufp->fullBit(oldp+49,(vlSelf->ysyx_24100006_cpu__DOT__cf));
    bufp->fullIData(oldp+50,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data),32);
    bufp->fullIData(oldp+51,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data),32);
    bufp->fullIData(oldp+52,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__complement),32);
    bufp->fullIData(oldp+53,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__add_sub_result),32);
    bufp->fullIData(oldp+54,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                              & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
    bufp->fullIData(oldp+55,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                              | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
    bufp->fullIData(oldp+56,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                              ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)),32);
    bufp->fullIData(oldp+57,(vlSelf->__VdfgTmp_hf65ad926__0),32);
    bufp->fullIData(oldp+58,(((0U != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                               ? (1U & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                               : 0U)),32);
    bufp->fullIData(oldp+59,(VL_SHIFTRS_III(32,32,5, vlSelf->ysyx_24100006_cpu__DOT__alu_a_data, 
                                            (0x1fU 
                                             & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
    bufp->fullIData(oldp+60,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                              >> (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
    bufp->fullIData(oldp+61,((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                              << (0x1fU & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data))),32);
    __Vtemp_hd6a05b0a__0[0U] = (IData)((0x900000000ULL 
                                        | (QData)((IData)(
                                                          (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                           | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))));
    __Vtemp_hd6a05b0a__0[1U] = (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                  ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                 << 4U) | (IData)((
                                                   (0x900000000ULL 
                                                    | (QData)((IData)(
                                                                      (vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                                                       | vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)))) 
                                                   >> 0x20U)));
    __Vtemp_hd6a05b0a__0[2U] = (0x80U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                           & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                          << 8U) | 
                                         ((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                           ^ vlSelf->ysyx_24100006_cpu__DOT__alu_b_data) 
                                          >> 0x1cU)));
    __Vtemp_hd6a05b0a__0[3U] = (0x700U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                            << (0x1fU 
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
                                               << (0x1fU 
                                                   & vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)) 
                                              >> 0x14U)));
    __Vtemp_hd6a05b0a__0[5U] = (0x50000U | (((vlSelf->ysyx_24100006_cpu__DOT__alu_a_data 
                                              >> (0x1fU 
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
    __Vtemp_hd6a05b0a__0[7U] = (0x3000000U | ((((0U 
                                                 != vlSelf->ysyx_24100006_cpu__DOT__alu_b_data)
                                                 ? 
                                                (1U 
                                                 & (~ (IData)(vlSelf->ysyx_24100006_cpu__DOT__cf)))
                                                 : 0U) 
                                               << 0x1cU) 
                                              | ((IData)(vlSelf->__VdfgTmp_hf65ad926__0) 
                                                 >> 8U)));
    __Vtemp_hd6a05b0a__0[8U] = (0x20000000U | (((0U 
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
    bufp->fullWData(oldp+62,(__Vtemp_hd6a05b0a__0),360);
    bufp->fullQData(oldp+74,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[0]),36);
    bufp->fullQData(oldp+76,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[1]),36);
    bufp->fullQData(oldp+78,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[2]),36);
    bufp->fullQData(oldp+80,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[3]),36);
    bufp->fullQData(oldp+82,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[4]),36);
    bufp->fullQData(oldp+84,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[5]),36);
    bufp->fullQData(oldp+86,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[6]),36);
    bufp->fullQData(oldp+88,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[7]),36);
    bufp->fullQData(oldp+90,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[8]),36);
    bufp->fullQData(oldp+92,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__pair_list[9]),36);
    bufp->fullIData(oldp+94,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+95,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+96,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+97,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[3]),32);
    bufp->fullIData(oldp+98,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[4]),32);
    bufp->fullIData(oldp+99,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[5]),32);
    bufp->fullIData(oldp+100,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[6]),32);
    bufp->fullIData(oldp+101,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[7]),32);
    bufp->fullIData(oldp+102,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[8]),32);
    bufp->fullIData(oldp+103,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__data_list[9]),32);
    bufp->fullIData(oldp+104,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+105,(vlSelf->ysyx_24100006_cpu__DOT__alu__DOT__alumux__DOT__i0__DOT__hit));
    __Vtemp_h570d9f26__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))));
    __Vtemp_h570d9f26__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                 << 1U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__pc))) 
                                                   >> 0x20U)));
    __Vtemp_h570d9f26__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs1_data 
                                >> 0x1fU);
    bufp->fullWData(oldp+106,(__Vtemp_h570d9f26__0),66);
    bufp->fullQData(oldp+109,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[0]),33);
    bufp->fullQData(oldp+111,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__pair_list[1]),33);
    bufp->fullIData(oldp+113,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+114,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+115,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+116,(vlSelf->ysyx_24100006_cpu__DOT__alu_a_data_mux__DOT__i0__DOT__hit));
    __Vtemp_h5a1cf979__0[0U] = (IData)((0x100000000ULL 
                                        | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))));
    __Vtemp_h5a1cf979__0[1U] = ((vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                 << 1U) | (IData)((
                                                   (0x100000000ULL 
                                                    | (QData)((IData)(vlSelf->ysyx_24100006_cpu__DOT__sext_imm))) 
                                                   >> 0x20U)));
    __Vtemp_h5a1cf979__0[2U] = (vlSelf->ysyx_24100006_cpu__DOT__rs2_data 
                                >> 0x1fU);
    bufp->fullWData(oldp+117,(__Vtemp_h5a1cf979__0),66);
    bufp->fullQData(oldp+120,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[0]),33);
    bufp->fullQData(oldp+122,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__pair_list[1]),33);
    bufp->fullIData(oldp+124,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+125,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+126,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+127,(vlSelf->ysyx_24100006_cpu__DOT__alu_b_data_mux__DOT__i0__DOT__hit));
    bufp->fullCData(oldp+128,((0x7fU & vlSelf->ysyx_24100006_cpu__DOT__instruction)),7);
    bufp->fullCData(oldp+129,((7U & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                     >> 0xcU))),3);
    bufp->fullCData(oldp+130,((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                               >> 0x19U)),7);
    bufp->fullIData(oldp+131,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                            >> 0x1fU))) 
                                << 0xbU) | (0x7ffU 
                                            & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                               >> 0x14U)))),32);
    bufp->fullIData(oldp+132,((0xfffff000U & vlSelf->ysyx_24100006_cpu__DOT__instruction)),32);
    bufp->fullIData(oldp+133,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                            >> 0x1fU))) 
                                << 0x14U) | ((0xff000U 
                                              & vlSelf->ysyx_24100006_cpu__DOT__instruction) 
                                             | ((0x800U 
                                                 & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                    >> 9U)) 
                                                | (0x7feU 
                                                   & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                      >> 0x14U)))))),32);
    bufp->fullIData(oldp+134,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                            >> 0x1fU))) 
                                << 0xbU) | ((0x7e0U 
                                             & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                >> 0x14U)) 
                                            | (0x1fU 
                                               & (vlSelf->ysyx_24100006_cpu__DOT__instruction 
                                                  >> 7U))))),32);
    bufp->fullIData(oldp+135,((((- (IData)((vlSelf->ysyx_24100006_cpu__DOT__instruction 
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
    bufp->fullWData(oldp+136,(__Vtemp_h2759fd9d__0),175);
    bufp->fullQData(oldp+142,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[0]),35);
    bufp->fullQData(oldp+144,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[1]),35);
    bufp->fullQData(oldp+146,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[2]),35);
    bufp->fullQData(oldp+148,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[3]),35);
    bufp->fullQData(oldp+150,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__pair_list[4]),35);
    bufp->fullIData(oldp+152,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+153,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+154,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+155,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[3]),32);
    bufp->fullIData(oldp+156,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__data_list[4]),32);
    bufp->fullIData(oldp+157,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+158,(vlSelf->ysyx_24100006_cpu__DOT__imm_sext__DOT__imm_mux__DOT__i0__DOT__hit));
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
    bufp->fullWData(oldp+159,(__Vtemp_h45c9da58__0),102);
    bufp->fullQData(oldp+163,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[0]),34);
    bufp->fullQData(oldp+165,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[1]),34);
    bufp->fullQData(oldp+167,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__pair_list[2]),34);
    bufp->fullIData(oldp+169,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[0]),32);
    bufp->fullIData(oldp+170,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[1]),32);
    bufp->fullIData(oldp+171,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__data_list[2]),32);
    bufp->fullIData(oldp+172,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__lut_out),32);
    bufp->fullBit(oldp+173,(vlSelf->ysyx_24100006_cpu__DOT__reg_write_data_mux__DOT__i0__DOT__hit));
    bufp->fullIData(oldp+174,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[0]),32);
    bufp->fullIData(oldp+175,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[1]),32);
    bufp->fullIData(oldp+176,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[2]),32);
    bufp->fullIData(oldp+177,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[3]),32);
    bufp->fullIData(oldp+178,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[4]),32);
    bufp->fullIData(oldp+179,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[5]),32);
    bufp->fullIData(oldp+180,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[6]),32);
    bufp->fullIData(oldp+181,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[7]),32);
    bufp->fullIData(oldp+182,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[8]),32);
    bufp->fullIData(oldp+183,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[9]),32);
    bufp->fullIData(oldp+184,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[10]),32);
    bufp->fullIData(oldp+185,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[11]),32);
    bufp->fullIData(oldp+186,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[12]),32);
    bufp->fullIData(oldp+187,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[13]),32);
    bufp->fullIData(oldp+188,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[14]),32);
    bufp->fullIData(oldp+189,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[15]),32);
    bufp->fullIData(oldp+190,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[16]),32);
    bufp->fullIData(oldp+191,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[17]),32);
    bufp->fullIData(oldp+192,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[18]),32);
    bufp->fullIData(oldp+193,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[19]),32);
    bufp->fullIData(oldp+194,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[20]),32);
    bufp->fullIData(oldp+195,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[21]),32);
    bufp->fullIData(oldp+196,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[22]),32);
    bufp->fullIData(oldp+197,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[23]),32);
    bufp->fullIData(oldp+198,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[24]),32);
    bufp->fullIData(oldp+199,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[25]),32);
    bufp->fullIData(oldp+200,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[26]),32);
    bufp->fullIData(oldp+201,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[27]),32);
    bufp->fullIData(oldp+202,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[28]),32);
    bufp->fullIData(oldp+203,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[29]),32);
    bufp->fullIData(oldp+204,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[30]),32);
    bufp->fullIData(oldp+205,(vlSelf->ysyx_24100006_cpu__DOT__registerfile__DOT__rf[31]),32);
    bufp->fullBit(oldp+206,(vlSelf->clk));
    bufp->fullBit(oldp+207,(vlSelf->reset));
    bufp->fullIData(oldp+208,(vlSelf->x_result),32);
    bufp->fullIData(oldp+209,(vlSelf->x_pc),32);
    bufp->fullCData(oldp+210,(vlSelf->ysyx_24100006_cpu__DOT__rd),5);
    bufp->fullIData(oldp+211,(vlSelf->ysyx_24100006_cpu__DOT__raddr),32);
    bufp->fullIData(oldp+212,(vlSelf->ysyx_24100006_cpu__DOT__rdata),32);
    bufp->fullIData(oldp+213,(0x20U),32);
    bufp->fullIData(oldp+214,(0x80000000U),32);
    bufp->fullBit(oldp+215,(1U));
    bufp->fullIData(oldp+216,(0xaU),32);
    bufp->fullIData(oldp+217,(4U),32);
    bufp->fullIData(oldp+218,(0U),32);
    bufp->fullIData(oldp+219,(0U),32);
    bufp->fullIData(oldp+220,(0x24U),32);
    bufp->fullIData(oldp+221,(0xaU),32);
    bufp->fullIData(oldp+222,(2U),32);
    bufp->fullIData(oldp+223,(1U),32);
    bufp->fullIData(oldp+224,(0x21U),32);
    bufp->fullIData(oldp+225,(2U),32);
    bufp->fullIData(oldp+226,(5U),32);
    bufp->fullIData(oldp+227,(3U),32);
    bufp->fullIData(oldp+228,(0x23U),32);
    bufp->fullIData(oldp+229,(5U),32);
    bufp->fullIData(oldp+230,(0x22U),32);
    bufp->fullIData(oldp+231,(3U),32);
}

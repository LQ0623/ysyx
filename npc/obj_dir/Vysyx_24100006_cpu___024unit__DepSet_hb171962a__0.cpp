// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu__Syms.h"
#include "Vysyx_24100006_cpu___024unit.h"

extern "C" void npc_trap();

VL_INLINE_OPT void Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit() {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vysyx_24100006_cpu___024unit____Vdpiimwrap_npc_trap_TOP____024unit\n"); );
    // Body
    npc_trap();
}

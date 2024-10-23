// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu__Syms.h"
#include "Vysyx_24100006_cpu___024unit.h"

extern "C" void is_ebreak(int inst);

VL_INLINE_OPT void Vysyx_24100006_cpu___024unit____Vdpiimwrap_is_ebreak_TOP____024unit(IData/*31:0*/ inst) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vysyx_24100006_cpu___024unit____Vdpiimwrap_is_ebreak_TOP____024unit\n"); );
    // Body
    int inst__Vcvt;
    for (size_t inst__Vidx = 0; inst__Vidx < 1; ++inst__Vidx) inst__Vcvt = inst;
    is_ebreak(inst__Vcvt);
}

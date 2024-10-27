// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vysyx_24100006_cpu.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vysyx_24100006_cpu__Syms.h"
#include "Vysyx_24100006_cpu___024unit.h"

void Vysyx_24100006_cpu___024unit___ctor_var_reset(Vysyx_24100006_cpu___024unit* vlSelf);

Vysyx_24100006_cpu___024unit::Vysyx_24100006_cpu___024unit(Vysyx_24100006_cpu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vysyx_24100006_cpu___024unit___ctor_var_reset(this);
}

void Vysyx_24100006_cpu___024unit::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vysyx_24100006_cpu___024unit::~Vysyx_24100006_cpu___024unit() {
}

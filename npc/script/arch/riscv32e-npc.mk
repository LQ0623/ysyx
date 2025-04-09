#top name
TOPNAME = ysyx_24100006

#verilator flag
VERILATOR_CFLAGS += -MMD -cc -O3 --x-assign fast --x-initial fast --noassert -autoflush
VERILATOR_CFLAGS += --trace
VERILATOR_CFLAGS += --timescale "1ns/1ns" --no-timing

#source code
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
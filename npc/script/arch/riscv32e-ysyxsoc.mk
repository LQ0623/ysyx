#top name
TOPNAME = ysyxSoCFull

#ysyxSoC
YSYXSoC = ../ysyxSoC

#verilator flag
# 将ysyxSoC/perip/uart16550/rtl和ysyxSoC/perip/spi/rtl两个目录加入verilator的include搜索路径中
VERILATOR_INC += -I$(YSYXSoC)/perip/uart16550/rtl -I$(YSYXSoC)/perip/spi/rtl
# 加入autoflush参数是为了 ​​禁用标准输出（stdout）的缓冲机制,使得每次调用 printf 或 cout 时立即刷新输出内容，而无需等待换行符（\n）或手动调用 fflush(stdout)。
VERILATOR_CFLAGS += -MMD -cc -O3 --x-assign fast --x-initial fast --noassert -autoflush
VERILATOR_CFLAGS += --trace
VERILATOR_CFLAGS += --timescale "1ns/1ns" --no-timing
VERILATOR_CFLAGS += $(VERILATOR_INC)

#source code
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
# 将ysySoc/perip目录下面的所有的.v文件加入verilator的Verilog文件列表
VSRCS += $(shell find $(abspath $(YSYXSoC)/perip) -name "*.v")
VSRCS += $(shell find $(abspath $(YSYXSoC)/build) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")

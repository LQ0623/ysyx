# MAKE_FILE = V$(TOPNAME).mk
# $(info TOPNAME in rewrite.mk: $(TOPNAME))
# include $(MAKE_FILE)
include VysyxSoCFull.mk

CPPFLAGS += -I$(NPC_HOME)/csrc/include

# 是否开启波形生成
ENABLE_WAVE ?= 1
ifeq ($(ENABLE_WAVE), 1)
    CPPFLAGS += -DCONFIG_DUMP_WAVE
endif

# 是否开启监视点的差异比较
ENABLE_WATCHPOINT ?= 0
ifeq ($(ENABLE_WATCHPOINT), 1)
    CPPFLAGS += -DCONFIG_CC_WATCHPOINT
endif

# 是否开启trace功能
ENABLE_TRACE ?= 1
ifeq ($(ENABLE_TRACE), 1)
    CPPFLAGS += -DCONFIG_TRACE
endif

# 是否记录执行的指令到log文件中
# 记录执行过的指令的功能不要开(因为这里没有给char-test建文件夹,导致执行过的指令无法写入到npc-log.txt中就会直接输出到终端)
ENABLE_ITRACE ?= 0
ifeq ($(ENABLE_ITRACE), 1)
    CPPFLAGS += -DCONFIG_ITRACE
endif

# 是否开启ftrace
ENABLE_FTRACE ?= 0
ifeq ($(ENABLE_FTRACE), 1)
    CPPFLAGS += -DCONFIG_FTRACE
endif

# 是否开启mtrace
ENABLE_MTRACE ?= 1
ifeq ($(ENABLE_MTRACE), 1)
    CPPFLAGS += -DCONFIG_MTRACE
endif

# 是否开启difftest
ENABLE_DIFFTEST ?= 0
ifeq ($(ENABLE_DIFFTEST), 1)
    CPPFLAGS += -DCONFIG_DIFFTEST
endif

# 是否是接入ysyxsoc
ENABLE_SOC  ?= 1
ifeq ($(ENABLE_SOC), 1)
    CPPFLAGS += -DCONFIG_SOC
endif

ENABLE_DEVICE ?= 1
ifeq ($(ENABLE_DEVICE), 1)
    CPPFLAGS += -DCONFIG_DEVICE
endif

ENBALE_KEYBOARD ?= 1
ifeq ($(ENBALE_KEYBOARD), 1)
    CPPFLAGS += -DCONFIG_KEYBOARD
endif

ENBALE_VGA ?= 1
ifeq ($(ENBALE_VGA), 1)
    CPPFLAGS += -DCONFIG_VGA
endif

# 开启反汇编
ENABLE_DISASSEMBLE ?= 1

ifeq ($(ENABLE_DISASSEMBLE), 0)
SRCS-BLACKLIST-y += $(NPC_HOME)/csrc/utils/disasm.cpp
else
LIBCAPSTONE = $(NPC_HOME)/tools/capstone/repo/libcapstone.so.5
CPPFLAGS += -I$(NPC_HOME)/tools/capstone/repo/include -DLIBCAPSTONE=\"$(LIBCAPSTONE)\"
csrc/utils/disasm.cpp: $(LIBCAPSTONE)
$(LIBCAPSTONE):
    # 使用 Tab 键进行缩进，不要用空格
	$(MAKE) -C $(NPC_HOME)/tools/capstone
endif

# LIBS += -lreadline
LIBS += -lreadline $(shell pkg-config --libs sdl2)

LINK := g++

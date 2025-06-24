# 在命令行没有定义的话，后续使用的ARCH就是riscv32e-npc
ARCH ?= riscv32e-npc
TOPNAME ?= ysyxSoCFull

#设置构建文件夹信息
BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

# 一些配置信息
REWRITE = $(NPC_HOME)/script/rewrite.mk

#verilator variable
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
endif

# ARCH logic
ARCHS = $(basename $(notdir $(shell ls $(AM_HOME)/scripts/*.mk)))
ifeq ($(filter $(ARCHS), $(ARCH)), )
  $(error Expected $$ARCH in {$(ARCHS)}, Got "$(ARCH)")
endif
# Print build info message
-include $(NPC_HOME)/script/arch/$(ARCH).mk

# nvboard
# rules for NVBoard
include $(NVBOARD_HOME)/scripts/nvboard.mk

#sim
include $(NPC_HOME)/script/sim.mk

#trace
# rules for trace
include $(NPC_HOME)/script/trace.mk

#main makefile in all project
include ../Makefile

COLOR_RED   		= \033[1;31m
COLOR_GREEN 		= \033[1;32m
COLOR_YELLOW 		= \033[33m
COLOR_NONE  		= \033[0m

clean:
	-rm -rf $(BUILD_DIR) tools/performance-trace/*.png tools/performance-trace/*.txt result

.PHONY:clean run 
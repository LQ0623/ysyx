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
# ARCH ?= riscv32e-npc
ARCH ?= riscv32e-ysyxsoc
# Print build info message
-include $(NPC_HOME)/script/arch/$(ARCH).mk

# nvboard
# rules for NVBoard
include $(NVBOARD_HOME)/scripts/nvboard.mk

#sim
include $(NPC_HOME)/script/sim.mk

#main makefile in all project
include ../Makefile

COLOR_RED   		= \033[1;31m
COLOR_GREEN 		= \033[1;32m
COLOR_YELLOW 		= \033[33m
COLOR_NONE  		= \033[0m

clean:
	-rm -rf $(BUILD_DIR) result top.dot top.png vsrc/*.png

.PHONY:clean run 
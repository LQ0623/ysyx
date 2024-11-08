#top name
TOPNAME = ysyx_24100006_cpu

#设置构建文件夹信息
BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

REWRITE = $(NPC_HOME)/script/rewrite.mk

#verilator variable
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
endif

#verilator flag
VERILATOR_CFLAGS += -MMD -cc -O3 --x-assign fast --x-initial fast --noassert
VERILATOR_CFLAGS += --trace

#source code
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")

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
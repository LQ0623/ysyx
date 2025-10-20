# ===== 基本配置 =====
VERILOG_DIR := verilog        # 你的 RTL 和 testbench 所在目录（可含子目录）
BUILD       := build
TOP_TB      := testbench      # 你的 testbench 顶层模块名

# 源码与 include 目录（递归收集）
VSRCS  := $(shell find $(VERILOG_DIR) -type f \( -name "*.v" -o -name "*.sv" \))
INCDIR := $(shell find $(VERILOG_DIR) -type d)
INCS   := $(addprefix -I, $(INCDIR))

# ELF文件搜索目录（用于 run/run-all/list）
# $(DIR) ?= ELF/cpu-test
# $(ELF) ?= ELF/cpu-test/dummy-riscv32e-npc.elf

# 预处理宏：默认打开 NPC（你 RTL 里有 `ifndef NPC`）
NPC ?= 1
DEFINES :=
ifeq ($(NPC),1)
  DEFINES += -DNPC -DVERILATOR_SIM
endif

# RISC-V 工具 & 平移基址（与你内存 BASE_ADDR=0x80000000 对应）
OBJCOPY  ?= riscv64-unknown-elf-objcopy
VMA_BASE ?= 0x80000000

# iverilog 输出
VVP := $(BUILD)/sim.vvp

.PHONY: run run-all list build-sim clean help

help:
	@echo "用法："
	@echo "  make run DIR=out/             # 在 out/ 里递归查找最新 .elf，转换并运行一次"
	@echo "  make run ELF=out/foo.elf      # 指定某个 .elf 运行一次"
	@echo "  make run-all DIR=out/         # 在 out/ 里递归查找所有 .elf，逐个转换并运行"
	@echo "  make list DIR=out/            # 列出找到的 .elf（按时间倒序）"
	@echo "  make clean                    # 清理构建产物"
	@echo ""
	@echo "可选：NPC=0 关闭 -DNPC；VMA_BASE=0x80000000 调整 objcopy 平移基址"

list:
	@if [ -z "$(DIR)" ]; then echo "[ERR] 请指定 DIR，例如：make list DIR=out/"; exit 1; fi; \
	if [ ! -d "$(DIR)" ]; then echo "[ERR] 目录不存在: $(DIR)"; exit 1; fi; \
	echo "[INFO] 在目录中搜索 ELF：$(DIR)"; \
	find "$(DIR)" -type f -name '*.elf' 2>/dev/null | xargs -r ls -lht 2>/dev/null || true

# 只编译一次仿真（RTL 变化时才会触发）
build-sim: $(VVP)

$(VVP): $(VSRCS) | $(BUILD)
	@echo "[CC ] iverilog -> $(VVP)"
	iverilog -g2012 $(DEFINES) -o $@ -s $(TOP_TB) $(INCS) $(VSRCS)

$(BUILD):
	@mkdir -p $@

# 单个运行：指定 ELF=... 或 DIR=...（自动选最新）
run: build-sim
	@set -e; \
	if [ -n "$(ELF)" ]; then target="$(ELF)"; \
	else \
	  if [ -z "$(DIR)" ]; then echo "[ERR] 请指定 DIR=... 或 ELF=..."; exit 1; fi; \
	  if [ ! -d "$(DIR)" ]; then echo "[ERR] 目录不存在: $(DIR)"; exit 1; fi; \
	  target="$$(find "$(DIR)" -type f -name '*.elf' -print0 | xargs -0 ls -t 2>/dev/null | head -n 1)"; \
	fi; \
	if [ -z "$$target" ]; then echo "[ERR] 未找到 .elf"; exit 1; fi; \
	base="$$(basename "$$target" .elf)"; \
	hex="$(BUILD)/$$base.hex"; \
	echo "[HEX] $$target -> $$hex"; \
	$(OBJCOPY) -O verilog --adjust-vma -$(VMA_BASE) "$$target" "$$hex"; \
	echo "[RUN] $$base  (cd $(BUILD) && vvp sim.vvp +img=$$base.hex)"; \
	( cd $(BUILD) && vvp sim.vvp +img="$$base.hex" ); \
	if [ -f "$(BUILD)/wave.vcd" ]; then \
	  echo "[WAVE] $(BUILD)/wave.vcd 已生成/覆盖"; \
	else \
	  echo "[WARN] 未发现 wave.vcd（检查 testbench 的 \$dumpfile(\"wave.vcd\")）"; \
	fi

# 批量运行：DIR 下所有 .elf
run-all: build-sim
	@if [ -z "$(DIR)" ]; then echo "[ERR] 请指定 DIR，例如：make run-all DIR=out/"; exit 1; fi; \
	if [ ! -d "$(DIR)" ]; then echo "[ERR] 目录不存在: $(DIR)"; exit 1; fi; \
	set -e; \
	elves="$$(find "$(DIR)" -type f -name '*.elf' | sort)"; \
	if [ -z "$$elves" ]; then echo "[ERR] 未在 $(DIR) 找到 .elf"; exit 1; fi; \
	for elf in $$elves; do \
	  base="$$(basename "$$elf" .elf)"; \
	  hex="$(BUILD)/$$base.hex"; \
	  echo ""; \
	  echo "[HEX] $$elf -> $$hex"; \
	  $(OBJCOPY) -O verilog --adjust-vma -$(VMA_BASE) "$$elf" "$$hex"; \
	  echo "[RUN] $$base  (cd $(BUILD) && vvp sim.vvp +img=$$base.hex)"; \
	  ( cd $(BUILD) && vvp sim.vvp +img="$$base.hex" ); \
	  if [ -f "$(BUILD)/wave.vcd" ]; then \
	    echo "[WAVE] $(BUILD)/wave.vcd 已生成/覆盖"; \
	  else \
	    echo "[WARN] 未发现 wave.vcd（检查 testbench 的 \$dumpfile(\"wave.vcd\")）"; \
	  fi; \
	done

clean:
	rm -rf $(BUILD) wave.vcd
	@echo "[CLEAN] done"

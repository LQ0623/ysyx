AM_SRCS := riscv/ysyxsoc/start.S \
           riscv/ysyxsoc/trm.c \
           riscv/ysyxsoc/ioe.c \
           riscv/ysyxsoc/timer.c \
           riscv/ysyxsoc/input.c \
           riscv/ysyxsoc/cte.c \
           riscv/ysyxsoc/trap.S \
           platform/dummy/vme.c \
           platform/dummy/mpe.c

CFLAGS    += -fdata-sections -ffunction-sections
LDSCRIPTS += $(AM_HOME)/scripts/linkersoc.ld
LDFLAGS   += --defsym=_pmem_start=0x20000000 --defsym=_entry_offset=0x0
LDFLAGS   += --defsym=_sram_start=0x0f000000 --defsym=_sram_offset=0x0
LDFLAGS   += --gc-sections -e _start 

# CFLAGS += -fsanitize=address         # 启用 ASan
# LDFLAGS += -fsanitize=address        # 链接 ASan 库

# NPC的一些参数
NPCFLAGS += -l $(shell dirname $(IMAGE).bin)/npc_log.txt
NPCFLAGS += -e $(IMAGE).elf	#这是elf文件

NPCFLAGS += -d /home/lq/ysyx-workbench/npc/tools/nemu-diff/riscv32-nemu-interpreter-so	#加入difftest测试
#NPCFLAGS += -d /home/lq/ysyx-workbench/npc/tools/spike-diff/build/riscv32-spike-so
NPCFLAGS += -b

MAINARGS_MAX_LEN = 64
MAINARGS_PLACEHOLDER = The insert-arg rule in Makefile will insert mainargs here.
CFLAGS += -DMAINARGS_MAX_LEN=$(MAINARGS_MAX_LEN) -DMAINARGS_PLACEHOLDER=\""$(MAINARGS_PLACEHOLDER)"\"

insert-arg: image
	@python $(AM_HOME)/tools/insert-arg.py $(IMAGE).bin $(MAINARGS_MAX_LEN) "$(MAINARGS_PLACEHOLDER)" "$(mainargs)"

image: image-dep
	@$(OBJDUMP) -d $(IMAGE).elf > $(IMAGE).txt
	@echo + OBJCOPY "->" $(IMAGE_REL).bin
	@$(OBJCOPY) -S --set-section-flags .bss=alloc,contents -O binary $(IMAGE).elf $(IMAGE).bin

run: insert-arg
	$(MAKE) -C $(NPC_HOME) ISA=$(ISA) run ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin

.PHONY: insert-arg

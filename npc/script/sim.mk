NPC_EXEC := $(BIN) $(ARGS) $(IMG)

JOBS      ?= $(shell nproc)      # 默认使用全部核心
THREADS   ?= $(shell nproc)      # 仿真线程数 = 编译线程数
#sim
$(BIN): $(VSRCS) $(CSRCS)
	@echo "$(COLOR_YELLOW)[VERILATE]$(COLOR_NONE) $(notdir $(BUILD_DIR))/$(notdir $(BIN))"
	@rm -rf $(OBJ_DIR)
	@mkdir -p $(BUILD_DIR)
	@$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		--threads $(THREADS) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
	@make -s -C $(OBJ_DIR) -f $(REWRITE)

run: $(BIN)	
	@echo "$(COLOR_YELLOW)[Run CPU]$(COLOR_NONE)"
	$(NPC_EXEC)

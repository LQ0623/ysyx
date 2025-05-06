NPC_EXEC := $(BIN) $(ARGS) $(IMG)

THREADS ?= 8  # 默认线程数，可通过 make THREADS=8 覆盖
VERILATOR_CFLAGS += -pthread  # 添加线程支持
#sim
$(BIN): $(VSRCS) $(CSRCS)
	@echo "$(COLOR_YELLOW)[VERILATE]$(COLOR_NONE) $(notdir $(BUILD_DIR))/$(notdir $(BIN))"
	@rm -rf $(OBJ_DIR)
	@mkdir -p $(BUILD_DIR)
	@$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
	@make -s -C $(OBJ_DIR) -f $(REWRITE)

run: $(BIN)	
	@echo "$(COLOR_YELLOW)[Run CPU]$(COLOR_NONE)"
	$(NPC_EXEC)

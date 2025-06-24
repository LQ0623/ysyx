NPC_EXEC := $(BIN) $(ARGS) $(IMG)
#sim
$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@echo "$(COLOR_YELLOW)[VERILATE]$(COLOR_NONE) $(notdir $(BUILD_DIR))/$(notdir $(BIN))"
	@rm -rf $(OBJ_DIR)
	@mkdir -p $(BUILD_DIR)
	@$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
# 加上一个TOPNAME是为了能够在rewrite中能够识别到使用的是哪一个TOPNAME 
	@make -s -C $(OBJ_DIR) -f $(REWRITE) TOPNAME=$(TOPNAME)

run: $(BIN)	
	@echo "$(COLOR_YELLOW)[Run CPU]$(COLOR_NONE)"
	$(NPC_EXEC)

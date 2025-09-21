BUILD_DIR = $(BRANCHSIM_HOME)/build

# 默认文件路径
TEXT_BTRACE ?= $(NEMU_HOME)/build/btrace.log

# 编译选项
CPPFLAGS = -std=c++17 -O2
INCLUDE_FLAG = -I$(BRANCHSIM_HOME)/include


# 默认目标
all: $(BRANCHSIM_BIN) $(COMPRESS_BIN)

# 构建缓存模拟器
$(BRANCHSIM_BIN): $(filter-out $(COMPRESS_SRC), $(SRCS))
	@echo "#[Building BranchSim]"
	@mkdir -p $(BUILD_DIR)
	@g++ $(CPPFLAGS) -o $@ $(INCLUDE_FLAG) $^

# 运行缓存模拟器（使用压缩后的 trace）
run: $(BRANCHSIM_BIN)
	@echo "#[Running BranchSim with compressed trace]"
	@$(BRANCHSIM_BIN) $(TEXT_BTRACE)

# 清理构建文件
clean:
	@echo "#[Cleaning up]"
	@rm -rf $(BUILD_DIR) $(BRANCHSIM_BIN) $(COMPRESS_BIN)

BUILD_DIR = $(CACHE_SIM_HOME)/build

# 默认文件路径
TEXT_TRACE ?= $(NEMU_HOME)/build/itrace.log
COMPRESSED_TRACE ?= $(BUILD_DIR)/itrace.bin

# 源文件和工具
SRCS = $(shell find $(CACHE_SIM_HOME)/src/ -name "*.cpp")
COMPRESS_SRC = $(CACHE_SIM_HOME)/src/compress_trace.cpp

# 编译选项
CPPFLAGS = -std=c++17 -O2
INCLUDE_FLAG = -I$(CACHE_SIM_HOME)/include

# 目标二进制
CACHESIM_BIN = $(BUILD_DIR)/cachesim
COMPRESS_BIN = $(BUILD_DIR)/compress_trace

# 默认参数值（可被命令行覆盖）
SETS ?= 16
WAYS ?= 1
BLOCK_SIZE ?= 4
POLICY ?= fifo

# 默认目标
all: $(CACHESIM_BIN) $(COMPRESS_BIN)

# 构建缓存模拟器
$(CACHESIM_BIN): $(filter-out $(COMPRESS_SRC), $(SRCS))
	@echo "#[Building CacheSim]"
	@mkdir -p $(BUILD_DIR)
	@g++ $(CPPFLAGS) -o $@ $(INCLUDE_FLAG) $^

# 构建压缩工具
$(COMPRESS_BIN): $(COMPRESS_SRC)
	@echo "#[Building Trace Compressor]"
	@mkdir -p $(BUILD_DIR)
	@g++ $(CPPFLAGS) -o $@ $(INCLUDE_FLAG) $<

# 压缩规则：将文本 itrace 压缩为二进制格式
$(COMPRESSED_TRACE): $(COMPRESS_BIN) $(TEXT_TRACE)
	@echo "#[Compressing trace file]"
	@$(COMPRESS_BIN) $(TEXT_TRACE) $(COMPRESSED_TRACE)
	@echo "Compressed trace saved to: $(COMPRESSED_TRACE)"

# 保留原来的 phony target 方便手动执行
compress: $(COMPRESSED_TRACE)

# 运行缓存模拟器（使用压缩后的 trace）,默认icache的组合就16 1 4 fifo
run: $(CACHESIM_BIN) $(COMPRESSED_TRACE)
	@echo "#[Running CacheSim with compressed trace]"
	@$(CACHESIM_BIN) $(COMPRESSED_TRACE) $(SETS) $(WAYS) $(BLOCK_SIZE) $(POLICY)

# 新增规则：运行多个参数组合
run-combinations: $(CACHESIM_BIN) compress
	@echo "#[Running multiple parameter combinations]"
	@rm -rf $(BUILD_DIR)/results
	@mkdir -p $(BUILD_DIR)/results
	./script/run_combinations.sh

# 分析上面多个参数组合运行的结果
analyze-result : 
	python3 ./script/parse_results.py

# 清理
clean:
	@rm -rf $(BUILD_DIR)
	@echo "Cleaned build directory"

.PHONY: all compress run run-text clean clean-traces clean-all
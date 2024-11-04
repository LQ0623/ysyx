TOPNAME = ysyx_24100006_cpu

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert
VERILATOR_CFLAGS += --trace

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))


# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")


CPPFLAGS += -I$(NPC_HOME)/csrc/include

NPC_EXEC := $(BIN) $(ARGS) $(IMG)

$(BIN): $(VSRCS) $(CSRCS) 
	@rm -rf $(OBJ_DIR)
	@mkdir $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all: default

run: $(BIN)
	@echo "start build"
	$(NPC_EXEC)

clean:
	rm -rf $(BUILD_DIR) ./obj_dir


all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

	verilator -Wall -I$(NPC_HOME)/csrc/include --trace --cc --exe --build --top-module $(TOPNAME) $(VSRCS) $(CSRCS)

# verilator -Wall --trace-fst --cc --exe --build --top-module $(TOPNAME) $(VSRCS) $(CSRCS)
include ../Makefile


.PHONY: all clean run

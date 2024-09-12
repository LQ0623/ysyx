all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

	verilator -Wall --trace --cc --exe --build ./vsrc/example.v ./csrc/main.cpp

include ../Makefile

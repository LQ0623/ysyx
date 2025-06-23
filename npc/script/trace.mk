PF_TRACE_NUM = $(NPC_HOME)/tools/performance-trace/perf_trace_num.py
PF_TRACE_TIME = $(NPC_HOME)/tools/performance-trace/perf_trace_time.py
PF_TRACE1 = $(NPC_HOME)/tools/performance-trace/trace.csv
PF_TRACE2 = $(NPC_HOME)/tools/performance-trace/trace2.csv
#pf_trace
pft_num:
	python $(PF_TRACE_NUM)
pft_time:
	python $(PF_TRACE_TIME)
#perf
MICROBENCH_DIR = $(AM_KERNEL_HOME)/benchmarks/microbench
perf:
	make -C $(MICROBENCH_DIR) ARCH=riscv32e-ysyxsoc run mainargs=train

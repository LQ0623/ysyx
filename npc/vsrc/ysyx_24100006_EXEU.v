/**
    执行模块
*/
module ysyx_24100006_exeu(
	input 			clk,
    input 			reset,

	// 是否为ebreak指令
	input           is_break_i,
    output    		is_break_o,
	// from icache
	input 			icache_flush_done,	// icache是否刷新完毕

	// from IDU
	input [31:0] 	pc_E,
    input [31:0] 	sext_imm_E,
    input [31:0] 	rs1_data_E,
    input [31:0] 	rs2_data_E,
	input [31:0] 	rdata_csr_E,
	input [31:0] 	mtvec,
	input [31:0] 	mepc,

	// control signal from IDU
	input 			is_fence_i,	// 是否刷新icache

	input 			irq_E,
	input [7:0] 	irq_no_E,
    input [3:0] 	aluop,
	input 			AluSrcA,
    input 			AluSrcB,
    input [3:0] 	Jump,
	input 			Gpr_Write_E,
	input 			Csr_Write_E,
	input [3:0]     Gpr_Write_Addr_E,
    input [11:0]    Csr_Write_Addr_E,
	input [2:0] 	Gpr_Write_RD_E,
	input [1:0] 	Csr_Write_RD_E,
	input [7:0] 	Mem_WMask_E,
	input [2:0] 	Mem_RMask_E,
	input [1:0]		sram_read_write_E,

	// 握手机制使用
	input           exe_out_valid,   // ID_EXE -> IDU 	(上游 valid)
    output          exe_out_ready,   // EXEU -> ID_EXE  (上游 ready)
    output          exe_in_valid,    // EXEU -> EXE_MEM (下游 valid)
    input           exe_in_ready,    // EXE_MEM -> IDU 	(下游 ready)

	// to IFU
	output [31:0] 	npc_E,
	output 			redirect_valid,
	
	// to MEMU
	output [31:0] 	pc_M,
	output [31:0] 	alu_result,
	output [31:0] 	sext_imm_M,
	output [31:0] 	rs1_data_M,
    output [31:0] 	rs2_data_M,
	output [31:0] 	rdata_csr_M,

	// control signal
	output 			irq_M,
	output [7:0] 	irq_no_M,
	output 			Gpr_Write_M,
	output 			Csr_Write_M,
	output [3:0]    Gpr_Write_Addr_M,
    output [11:0]   Csr_Write_Addr_M,
	output [2:0] 	Gpr_Write_RD_M,
	output [1:0] 	Csr_Write_RD_M,
	output [7:0] 	Mem_WMask_M,
	output [2:0] 	Mem_RMask_M,
	output [1:0] 	sram_read_write_M
);

	// 组合握手：当需要等待 icache 刷新时，对上游施加反压、对下游不发 valid
	// The stall signal is asserted when a fence.i instruction is encountered and the icache has not finished flushing.
	// This ensures the pipeline waits for the icache to complete before proceeding.
	wire stall;
	assign stall = is_fence_i && !icache_flush_done;

	// 握手机制
	// 下游 valid：上游 valid 且本级不 stall
	assign exe_in_valid  = exe_out_valid & !stall;
	// 上游 ready：下游 ready 且本级不 stall
    assign exe_out_ready = exe_in_ready & !stall;

	// 计算
    wire [31:0] alu_a_data,alu_b_data;
	wire [31:0] alu_result_temp;
	wire of,cf,zf;

	// 选择进入加法器的内容
	ysyx_24100006_MuxKey#(2,1,32) alu_a_data_mux(alu_a_data,AluSrcA,{
		1'b0,rs1_data_E,
		1'b1,pc_E
	});
	ysyx_24100006_MuxKey#(2,1,32) alu_b_data_mux(alu_b_data,AluSrcB,{
		1'b0,rs2_data_E,
		1'b1,sext_imm_E
	});

	// 运算器
	ysyx_24100006_alu alu(
		.rs_data(alu_a_data),
		.aluop(aluop),
		.rt_data(alu_b_data),
		.result(alu_result_temp),
		.of(of),
		.cf(cf),
		.zf(zf)
	);

    // 计算npc
	wire [31:0] npc_temp;
	ysyx_24100006_npc NPC(
		.pc(pc_E),
		.mtvec(mtvec),
		.mepc(mepc),
		.Skip_mode(Jump),
		.sext_imm(sext_imm_E),
		.rs_data(rs1_data_E),
		.cmp_result(alu_result_temp[0]),
		.zf(zf),
		.npc(npc_temp)
	);

	// 当是跳转指令且目标地址与pc+4不同时，才重定向
	assign redirect_valid = (exe_out_valid == 1 && Jump != 0 && npc_E != (pc_E + 32'd4)) ? 1'b1 : 1'b0;

	// 直接透传到 EXE_MEM（它会寄存）
    assign pc_M            		= pc_E;
    assign sext_imm_M      		= sext_imm_E;
    assign rs1_data_M      		= rs1_data_E;
    assign rs2_data_M      		= rs2_data_E;
    assign rdata_csr_M     		= rdata_csr_E;
	assign alu_result			= alu_result_temp;

    assign irq_M           		= irq_E;
    assign irq_no_M        		= irq_no_E;
    assign Gpr_Write_M     		= Gpr_Write_E;
    assign Csr_Write_M     		= Csr_Write_E;
    assign Gpr_Write_RD_M  		= Gpr_Write_RD_E;
    assign Csr_Write_RD_M  		= Csr_Write_RD_E;
    assign Mem_WMask_M     		= Mem_WMask_E;
    assign Mem_RMask_M     		= Mem_RMask_E;
	assign sram_read_write_M	= sram_read_write_E;
	
	assign Gpr_Write_Addr_M		= Gpr_Write_Addr_E;
	assign Csr_Write_Addr_M		= Csr_Write_Addr_E;

	assign npc_E				= npc_temp;
	assign is_break_o			= is_break_i;

endmodule
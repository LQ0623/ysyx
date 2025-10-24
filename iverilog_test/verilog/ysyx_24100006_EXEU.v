/**
    执行模块
*/
module ysyx_24100006_exeu(
	input 			clk,
    input 			reset,

`ifdef VERILATOR_SIM
	// 调试使用
	input [31:0] 	pc_E,
	output [31:0] 	pc_M,
`endif

	// 是否为ebreak指令
	input           is_break_i,
    output    		is_break_o,
	// from icache
	input 			icache_flush_done,	// icache是否刷新完毕

	// from IDU
	// control signal from IDU
	input 			is_fence_i,	// 是否刷新icache

	input 			irq_E,
    input [3:0] 	aluop,
    input [2:0] 	Jump,
	input 			Gpr_Write_E,
	input 			Csr_Write_E,
	input [3:0]     Gpr_Write_Addr_E,
    input [11:0]    Csr_Write_Addr_E,
	input [1:0] 	Gpr_Write_RD_E,
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
	output [31:0] 	alu_result,

	// control signal
	output 			irq_M,
	output 			Gpr_Write_M,
	output 			Csr_Write_M,
	output [3:0]    Gpr_Write_Addr_M,
    output [11:0]   Csr_Write_Addr_M,
	output [1:0] 	Gpr_Write_RD_M,
	output [1:0] 	sram_read_write_M

	// 面积优化
	,input 	[31:0]  pc_j_m_e_n_E        // NO_JUMP/MRET/ECALL三种跳转的地址
    ,input 	[31:0]  alu_a_data_E
    ,input 	[31:0]  alu_b_data_E
    ,input 	[31:0]  pc_add_imm_E

	,input 	[31:0]  wdata_gpr_E
	,input 	[31:0]  wdata_csr_E
    ,output [31:0]  wdata_gpr_M
    ,output [31:0]  wdata_csr_M
    
	,input  [2:0]   Mem_Mask_E
    ,output [2:0]   Mem_Mask_M

	,input  [31:0]	pc_add_4

	// 前递单元设计
	,output 		exe_is_load
	,output	[31:0]	exe_fw_data
);

	// 组合握手：当需要等待 icache 刷新时，对上游施加反压、对下游不发 valid
	// The stall signal is asserted when a fence.i instruction is encountered and the icache has not finished flushing.
	// This ensures the pipeline waits for the icache to complete before proceeding.
	// wire stall;
	// assign stall = is_fence_i && !icache_flush_done;

	// 握手机制
	// 下游 valid：上游 valid 且本级不 stall
	assign exe_in_valid  = exe_out_valid;
	// 上游 ready：下游 ready 且本级不 stall
    assign exe_out_ready = exe_in_ready;

	// 计算
    // wire [31:0] alu_a_data,alu_b_data;
	wire [31:0] alu_result_temp;
	wire of,cf,zf;


	// 运算器
	ysyx_24100006_alu alu(
		.rs_data(alu_a_data_E),
		.aluop(aluop),
		.rt_data(alu_b_data_E),
		.result(alu_result_temp)
		// ,.of(of),
		// .cf(cf),
		,.zf(zf)
	);

    // 计算npc
	wire [31:0] npc_temp;
	// 约定：alu_result_temp[0] = 本条指令需要的<比较结果位>
	// 对于 {BLT,BLTU} 取 cmp；{BGE,BGEU} 取 ~cmp（通过与 Jump[0] 异或实现）

	wire j2 = Jump[2];
	wire j1 = Jump[1];
	wire j0 = Jump[0];

	wire cmp = alu_result_temp[0];  // 来自 ALU 的比较结果位
	wire cond_eq = zf  ^ j0;        // BEQ(010): j0=0 -> zf； BNE(011): j0=1 -> ~zf
	wire cond_lt = cmp ^ j0;        // BLT/BLTU(1x0): j0=0 -> cmp；BGE/BGEU(1x1): j0=1 -> ~cmp

	// 当 j2=0：{000,001,010,011}
	//   - j1=0 -> {000,001}：直接输出 j0（NJUMP=0, JAL=1）
	//   - j1=1 -> {010,011}：用 cond_eq
	// 当 j2=1：{100,101,110,111}：用 cond_lt
	wire br_taken = j2 ? cond_lt
					: (j1 ? cond_eq : j0);

	assign npc_temp = br_taken ? pc_add_imm_E : pc_j_m_e_n_E;
	// ysyx_24100006_npc NPC(
	// 	.Skip_mode(Jump),
	// 	.pc_n_m_e(pc_j_m_e_n_E),
	// 	.pc_add_imm(pc_add_imm_E),
	// 	.cmp_result(alu_result_temp[0]),
	// 	.zf(zf),
	// 	.npc(npc_temp)
	// );

	// 当是跳转指令且目标地址与pc+4不同时，才重定向
	// 若是 jal 指令不需要要重定向，因为前面已经计算好了 npc
	assign redirect_valid = (exe_out_valid == 1 && Jump != 1 && npc_temp[31:2] != pc_add_4[31:2]) ? 1'b1 : 1'b0;

	// 直接透传到 EXE_MEM（它会寄存）
`ifdef VERILATOR_SIM
	// 调试使用
    assign pc_M            		= pc_E;
`endif

	assign alu_result			= alu_result_temp;

    assign irq_M           		= irq_E;
    assign Gpr_Write_M     		= Gpr_Write_E;
    assign Csr_Write_M     		= Csr_Write_E;
    assign Gpr_Write_RD_M  		= Gpr_Write_RD_E;
	assign sram_read_write_M	= sram_read_write_E;
	
	assign Gpr_Write_Addr_M		= Gpr_Write_Addr_E;
	assign Csr_Write_Addr_M		= Csr_Write_Addr_E;

	assign npc_E				= npc_temp;
	assign is_break_o			= is_break_i;

	// 面积优化
	// 如果真实写回寄存器的值时读内存的值，那么后续在MEMU会进行替换的
	assign wdata_gpr_M			= (Gpr_Write_RD_M[0] == 1'b1) ? alu_result_temp : wdata_gpr_E;
	assign wdata_csr_M			= wdata_csr_E;

	assign Mem_Mask_M			= Mem_Mask_E;

	// 前递单元设计
	assign exe_is_load 			= 	(sram_read_write_M[0] == 1'b1) ? 1'b1 : 1'b0;
	assign exe_fw_data 			= 	wdata_gpr_M;

endmodule
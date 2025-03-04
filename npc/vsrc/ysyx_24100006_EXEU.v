/**
    执行模块
*/
module ysyx_24100006_exeu(
	input clk,
    input reset,
	// from IDU
	input [31:0] pc_E,
    input [31:0] sext_imm_E,
    input [31:0] rs1_data_E,
    input [31:0] rs2_data_E,
	input [31:0] rdata_csr_E,
	input [31:0] mtvec,
	input [31:0] mepc,

	// control signal from IDU
	input irq_E,
	input PCW_E,
    input [3:0] aluop,
	input AluSrcA,
    input AluSrcB,
    input [3:0] Jump,
	input Gpr_Write_E,
	input Csr_Write_E,
	input [2:0] Gpr_Write_RD_E,
	input [1:0] Csr_Write_RD_E,
	input Mem_Read_E,
	input Mem_Write_E,
	input [7:0] Mem_WMask_E,
	input [2:0] Mem_RMask_E,

	// to IFU
	output [31:0] npc,
	
	// to MEMU
	output [31:0] pc_M,
	output [31:0] alu_result,
	output [31:0] sext_imm_M,
	output [31:0] rs1_data_M,
    output [31:0] rs2_data_M,
	output [31:0] rdata_csr_M,

	// control signal
	output irq_M,
	output PCW_M,
	output Gpr_Write_M,
	output Csr_Write_M,
	output [2:0] Gpr_Write_RD_M,
	output [1:0] Csr_Write_RD_M,
	output Mem_Read_M,
	output Mem_Write_M,
	output [7:0] Mem_WMask_M,
	output [2:0] Mem_RMask_M
);

	assign pc_M 			= pc_E;
	assign sext_imm_M 		= sext_imm_E;
	assign rs1_data_M 		= rs1_data_E;
    assign rs2_data_M 		= rs2_data_E;
	assign rdata_csr_M 		= rdata_csr_E;

	// control signal
	assign irq_M 			= irq_E;
	assign PCW_M			= PCW_E;
	assign Gpr_Write_M 		= Gpr_Write_E;
	assign Csr_Write_M		= Csr_Write_E;
	assign Gpr_Write_RD_M	= Gpr_Write_RD_E;
	assign Csr_Write_RD_M	= Csr_Write_RD_E;
	assign Mem_Read_M		= Mem_Read_E;
	assign Mem_Write_M		= Mem_Write_E;
	assign Mem_WMask_M		= Mem_WMask_E;
	assign Mem_RMask_M		= Mem_RMask_E;


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

    /**
		alu_res寄存器：保存alu计算的结果
	*/
	ysyx_24100006_Reg #(32,32'h00000000) alu_res(
		.clk(clk),
		.rst(reset),
		.din(alu_result_temp),
		.dout(alu_result),
		.wen(1'b1)
	);

    // 计算npc
	ysyx_24100006_npc NPC(
		.clk(clk),	// 增加一个周期的延迟
		.pc(pc_E),
		.mtvec(mtvec),
		.mepc(mepc),
		.Skip_mode(Jump),
		.sext_imm(sext_imm_E),
		.rs_data(rs1_data_E),
		.cmp_result(alu_result[0]),
		.zf(zf),
		.npc(npc)
	);

endmodule
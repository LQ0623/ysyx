module ysyx_24100006_cpu(
	input clk,
	input reset
);

	// EXEU -> IFU
	wire PCW_EM;
	wire [31:0] npc_EF;

	// IFU -> IDU
	wire [31:0] pc_FD;
	wire [31:0] instruction;   // 读出的指令
	// IDU -> EXEU
	wire [31:0] pc_DE;
	wire [31:0] sext_imm_DE;
	wire [31:0] rs1_data_DE;
	wire [31:0] rs2_data_DE;
	wire [31:0] rdata_csr_DE;
	wire PCW_DE;
	wire irq_DF;
	wire irq_DE;
	wire [3:0] aluop_DE;
	wire AluSrcA_DE;
	wire AluSrcB_DE;
	wire Gpr_Write_DE;
	wire Csr_Write_DE;
	wire [2:0] Gpr_Write_RD_DE;
	wire [1:0] Csr_Write_RD_DE;
	wire Mem_Read_DE;
	wire Mem_Write_DE;
	wire [3:0] Jump_DE;
	wire [7:0] Mem_WMask_DE;
	wire [2:0] Mem_RMask_DE;
	wire [31:0] mtvec_DE;
	wire [31:0] mepc_DE;
	// EXEU -> MEMU
	wire [31:0] pc_EM;
	wire [31:0] alu_result_EM;
	wire [31:0] sext_imm_EM;
	wire [31:0] rs1_data_EM;
    wire [31:0] rs2_data_EM;
	wire [31:0] rdata_csr_EM;
	wire irq_EM;
	wire Gpr_Write_EM;
	wire Csr_Write_EM;
	wire [2:0] Gpr_Write_RD_EM;
	wire [1:0] Csr_Write_RD_EM;
	wire Mem_Read_EM;
	wire Mem_Write_EM;
	wire [7:0] Mem_WMask_EM;
	wire [2:0] Mem_RMask_EM;
	// MEMU -> WBU
	wire [31:0] pc_MW;
	wire [31:0] sext_imm_MW;
	wire [31:0] alu_result_MW;
	wire [31:0] rs1_data_MW;
	wire [31:0] rdata_csr_MW;
	wire [31:0] Mem_rdata_extend;
	wire irq_MW;
	wire PCW_MW;
	wire Gpr_Write_MW;
	wire Csr_Write_MW;
	wire [2:0] Gpr_Write_RD_MW;
	wire [1:0] Csr_Write_RD_MW;
	// WBU -> IDU
	wire Gpr_Write_WD;
	wire Csr_Write_WD;
	wire [31:0] wdata_gpr_WD;
	wire [31:0] wdata_csr_WD;
    
	ysyx_24100006_ifu IF(
		.clk(clk),
		.reset(reset),
		.npc(npc_EF),
		.PCW(PCW_EM),
		.pc_F(pc_FD),
		.instruction(instruction)
	);
	
	ysyx_24100006_idu ID(
		.clk(clk),
		.reset(reset),
		.instruction(instruction),
		.pc_D(pc_FD),
		.Gpr_Write_W(Gpr_Write_WD),
		.Csr_Write_W(Csr_Write_WD),
		.wdata_gpr_W(wdata_gpr_WD),
		.wdata_csr_W(wdata_csr_WD),
		.pc_E(pc_DE),
		.sext_imm(sext_imm_DE),
		.rs1_data(rs1_data_DE),
		.rs2_data(rs2_data_DE),
		.rdata_csr(rdata_csr_DE),
		.PCW(PCW_DE),
		.irq_F(irq_DF),
		.irq_E(irq_DE),
		.aluop(aluop_DE),
		.AluSrcA(AluSrcA_DE),
		.AluSrcB(AluSrcB_DE),
		.Gpr_Write_E(Gpr_Write_DE),
		.Csr_Write_E(Csr_Write_DE),
		.Gpr_Write_RD(Gpr_Write_RD_DE),
		.Csr_Write_RD(Csr_Write_RD_DE),
		.Mem_Read(Mem_Read_DE),
		.Mem_Write(Mem_Write_DE),
		.Jump(Jump_DE),
		.Mem_WMask(Mem_WMask_DE),
		.Mem_RMask(Mem_RMask_DE),
		.mtvec(mtvec_DE),
		.mepc(mepc_DE)
	);

	ysyx_24100006_exeu EXE(
		.clk(clk),
		.reset(reset),
		.pc_E(pc_DE),
		.sext_imm_E(sext_imm_DE),
		.rs1_data_E(rs1_data_DE),
		.rs2_data_E(rs2_data_DE),
		.rdata_csr_E(rdata_csr_DE),
		.mtvec(mtvec_DE),
		.mepc(mepc_DE),
		.irq_E(irq_DE),
		.PCW_E(PCW_DE),
		.aluop(aluop_DE),
		.AluSrcA(AluSrcA_DE),
		.AluSrcB(AluSrcB_DE),
		.Jump(Jump_DE),
		.Gpr_Write_E(Gpr_Write_DE),
		.Csr_Write_E(Csr_Write_DE),
		.Gpr_Write_RD_E(Gpr_Write_RD_DE),
		.Csr_Write_RD_E(Csr_Write_RD_DE),
		.Mem_Read_E(Mem_Read_DE),
		.Mem_Write_E(Mem_Write_DE),
		.Mem_WMask_E(Mem_WMask_DE),
		.Mem_RMask_E(Mem_RMask_DE),
		.npc(npc_EF),
		.pc_M(pc_EM),
		.alu_result(alu_result_EM),
		.sext_imm_M(sext_imm_EM),
		.rs1_data_M(rs1_data_EM),
		.rs2_data_M(rs2_data_EM),
		.rdata_csr_M(rdata_csr_EM),
		.irq_M(irq_EM),
		.PCW_M(PCW_EM),
		.Gpr_Write_M(Gpr_Write_EM),
		.Csr_Write_M(Csr_Write_EM),
		.Gpr_Write_RD_M(Gpr_Write_RD_EM),
		.Csr_Write_RD_M(Csr_Write_RD_EM),
		.Mem_Read_M(Mem_Read_EM),
		.Mem_Write_M(Mem_Write_EM),
		.Mem_WMask_M(Mem_WMask_EM),
		.Mem_RMask_M(Mem_RMask_EM)
	);

	ysyx_24100006_memu MEM(
		.clk(clk),
		.pc_M(pc_EM),
		.alu_result_M(alu_result_EM),
		.sext_imm_M(sext_imm_EM),
		.rs1_data_M(rs1_data_EM),
		.rs2_data_M(rs2_data_EM),
		.rdata_csr_M(rdata_csr_EM),
		.irq_M(irq_EM),
		.PCW_M(PCW_EM),
		.Gpr_Write_M(Gpr_Write_EM),
		.Csr_Write_M(Csr_Write_EM),
		.Gpr_Write_RD_M(Gpr_Write_RD_EM),
		.Csr_Write_RD_M(Csr_Write_RD_EM),
		.Mem_Read_M(Mem_Read_EM),
		.Mem_Write_M(Mem_Write_EM),
		.Mem_WMask_M(Mem_WMask_EM),
		.Mem_RMask_M(Mem_RMask_EM),
		.pc_W(pc_MW),
		.sext_imm_W(sext_imm_MW),
		.alu_result_W(alu_result_MW),
		.rs1_data_W(rs1_data_MW),
		.rdata_csr_W(rdata_csr_MW),
		.Mem_rdata_extend(Mem_rdata_extend),
		.irq_W(irq_MW),
		.PCW_W(PCW_MW),
		.Gpr_Write_W(Gpr_Write_MW),
		.Csr_Write_W(Csr_Write_MW),
		.Gpr_Write_RD_W(Gpr_Write_RD_MW),
		.Csr_Write_RD_W(Csr_Write_RD_MW)
	);

	ysyx_24100006_wbu WB(
		.pc(pc_MW),
		.sext_imm(sext_imm_MW),
		.alu_result(alu_result_MW),
		.Mem_rdata_extend(Mem_rdata_extend),
		.rdata_csr(rdata_csr_MW),
		.rs1_data(rs1_data_MW),
		.Gpr_Write(Gpr_Write_MW),
		.Csr_Write(Csr_Write_MW),
		.Gpr_Write_RD(Gpr_Write_RD_MW),
		.Csr_Write_RD(Csr_Write_RD_MW),
		.Gpr_Write_WD(Gpr_Write_WD),
		.Csr_Write_WD(Csr_Write_WD),
		.wdata_gpr(wdata_gpr_WD),
		.wdata_csr(wdata_csr_WD)
	);

	// always @(posedge PCW_EM) begin
	// 	$display(" %x %x %x",Jump_DE,pc_FD,instruction);
	// end

endmodule

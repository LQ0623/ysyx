module ysyx_24100006_cpu(
	input clk,
	input reset
);

	// 模块的信号
	// EXEU -> IFU
	wire [31:0] npc_EF;

	// IFU -> IDU
	wire [31:0] pc_FD;
	wire [31:0] instruction;   // 读出的指令
	wire PCW;
	// IDU -> EXEU
	wire [31:0] pc_DE;
	wire [31:0] sext_imm_DE;
	wire [31:0] rs1_data_DE;
	wire [31:0] rs2_data_DE;
	wire [31:0] rdata_csr_DE;
	wire irq_DF;
	wire irq_DE;
	wire [7:0] irq_no_DE;
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
	wire [7:0] irq_no_EM;
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
	wire [7:0] irq_no_MW;
	wire Gpr_Write_MW;
	wire Csr_Write_MW;
	wire [2:0] Gpr_Write_RD_MW;
	wire [1:0] Csr_Write_RD_MW;
	// WBU -> IDU
	wire irq_WD;
	wire [7:0] irq_no_WD;
	wire Gpr_Write_WD;
	wire Csr_Write_WD;
	wire [31:0] wdata_gpr_WD;
	wire [31:0] wdata_csr_WD;

	// MEMU -> MEM
	wire [7:0] RealMemWmask_M;	// 真正的Mem写的掩码
	wire [31:0] mem_addr_M;		// 对齐到四字节边界的地址
	wire [31:0] rdraw_M;		// 从mem读取出来的内容

	wire sram_read_write;


	// 握手机制
	wire if_valid;
	wire id_ready;
	wire id_valid;
	wire exe_ready;
	wire exe_valid;
	wire mem_ready;
	wire mem_valid;
	wire wb_ready;


	// AXI-Lite
	// IFU -> IM
	// read data addr
	reg axi_arready_if;
	reg axi_arvalid_if;
	// read data
	reg axi_rvalid_if;
	reg axi_rready_if;
	reg axi_rresp_if;
	// write data addr
	reg axi_awvalid_if;
	reg axi_awready_if;
	// write data
	reg axi_wvalid_if;
	reg axi_wready_if;
	// response
	reg axi_bvalid_if;
	reg axi_bready_if;

	// MEMU -> MEM
	// read data addr
	reg axi_arready_mem;
	reg axi_arvalid_mem;
	// read data
	reg axi_rvalid_mem;
	reg axi_rready_mem;
	reg axi_rresp_mem;
	// write data addr
	reg axi_awvalid_mem;
	reg axi_awready_mem;
	// write data
	reg axi_wvalid_mem;
	reg axi_wready_mem;
	// response
	reg axi_bvalid_mem;
	reg axi_bready_mem;
	reg [1:0] axi_bresp_mem;

	// SRAM模块
	// 指令SRAM
	ysyx_24100006_im IM(
		.clk(clk),
		.reset(reset),
		.axi_araddr(pc_FD),
		.axi_wdata(32'b0),
		// axi控制信号
		// read data addr
		.axi_arvalid(axi_arvalid_if),
		.axi_arready(axi_arready_if),
		// read data
		.axi_rready(axi_rready_if),
		.axi_rvalid(axi_rvalid_if),
		// write data addr
		.axi_awvalid(axi_awvalid_if),
		.axi_awready(axi_awready_if),
		// write data
		.axi_wvalid(axi_wvalid_if),
		.axi_wready(axi_wready_if),
		// response
		.axi_bready(axi_bready_if),
		.axi_bvalid(axi_bvalid_if),
		.axi_rdata(instruction)
	);
	
	// 内存操作
	// 内存SRAM
	ysyx_24100006_mem mem(
		.clk(clk),
		.reset(reset),
		.sram_read_write(sram_read_write),
		// 内存写入和读取是否有效
		.Mem_Write(Mem_Write_EM),
		.Mem_Read(Mem_Read_EM),
		
		// axi 写入和读取地址
		.axi_araddr(mem_addr_M),
		.axi_awaddr(mem_addr_M),
		// axi 写入数据和写入使用的掩码
		.axi_wdata(rs2_data_EM),
		.axi_wstrb(RealMemWmask_M),

		// axi控制信号
		// read data addr
		.axi_arvalid(axi_arvalid_mem),
		.axi_arready(axi_arready_mem),
		// read data
		.axi_rready(axi_rready_mem),
		.axi_rvalid(axi_rvalid_mem),
		// write data addr
		.axi_awvalid(axi_awvalid_mem),
		.axi_awready(axi_awready_mem),
		// write data
		.axi_wvalid(axi_wvalid_mem),
		.axi_wready(axi_wready_mem),
		// response
		.axi_bready(axi_bready_mem),
		.axi_bvalid(axi_bvalid_mem),
		.axi_bresp(axi_bresp_mem),

		// axi读取的回应
		.axi_rresp(axi_rresp_mem),
		// axi读取的数据
		.axi_rdata(rdraw_M)
	);
    
	ysyx_24100006_ifu IF(
		.clk(clk),
		.reset(reset),
		.npc(npc_EF),
		// AXI 接口信号
		// read data addr
		.axi_arready(axi_arready_if),
		.axi_arvalid(axi_arvalid_if),
		// read data
		.axi_rvalid(axi_rvalid_if),
		.axi_rready(axi_rready_if),
		// write data addr
		.axi_awvalid(axi_awvalid_if),
		.axi_awready(axi_awready_if),
		// write data
		.axi_wvalid(axi_wvalid_if),
		.axi_wready(axi_wready_if),
		// response
		.axi_bvalid(axi_bvalid_if),
		.axi_bready(axi_bready_if),
		// 模块握手信号
		.id_ready(id_ready),
		.if_valid(if_valid),
		.pc_F(pc_FD),
		.PCW(PCW)
	);
	
	ysyx_24100006_idu ID(
		.clk(clk),
		.reset(reset),
		.instruction(instruction),
		.PCW(PCW),
		.pc_D(pc_FD),
		.irq_W(irq_WD),
		.irq_no_W(irq_no_WD),
		.Gpr_Write_W(Gpr_Write_WD),
		.Csr_Write_W(Csr_Write_WD),
		.wdata_gpr_W(wdata_gpr_WD),
		.wdata_csr_W(wdata_csr_WD),
		.wb_ready(wb_ready),
		.mem_valid(mem_valid),
		.if_valid(if_valid),
		.exe_ready(exe_ready),
		.id_valid(id_valid),
		.id_ready(id_ready),
		.pc_E(pc_DE),
		.sext_imm(sext_imm_DE),
		.rs1_data(rs1_data_DE),
		.rs2_data(rs2_data_DE),
		.rdata_csr(rdata_csr_DE),
		.irq_F(irq_DF),
		.irq_E(irq_DE),
		.irq_no(irq_no_DE),
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
		.sram_read_write(sram_read_write),
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
		.irq_no_E(irq_no_DE),
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
		.id_valid(id_valid),
		.mem_ready(mem_ready),
		.exe_valid(exe_valid),
		.exe_ready(exe_ready),
		.npc_E(npc_EF),
		.pc_M(pc_EM),
		.alu_result(alu_result_EM),
		.sext_imm_M(sext_imm_EM),
		.rs1_data_M(rs1_data_EM),
		.rs2_data_M(rs2_data_EM),
		.rdata_csr_M(rdata_csr_EM),
		.irq_M(irq_EM),
		.irq_no_M(irq_no_EM),
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
		.reset(reset),
		.sram_read_write(sram_read_write),
		.pc_M(pc_EM),
		.alu_result_M(alu_result_EM),
		.sext_imm_M(sext_imm_EM),
		.rs1_data_M(rs1_data_EM),
		.rs2_data_M(rs2_data_EM),
		.rdata_csr_M(rdata_csr_EM),
		.rdraw(rdraw_M),
		.irq_M(irq_EM),
		.irq_no_M(irq_no_EM),
		.Gpr_Write_M(Gpr_Write_EM),
		.Csr_Write_M(Csr_Write_EM),
		.Gpr_Write_RD_M(Gpr_Write_RD_EM),
		.Csr_Write_RD_M(Csr_Write_RD_EM),
		.Mem_Read_M(Mem_Read_EM),
		.Mem_Write_M(Mem_Write_EM),
		.Mem_WMask_M(Mem_WMask_EM),
		.Mem_RMask_M(Mem_RMask_EM),
		// AXI 接口信号
		// read data addr
		.axi_arready(axi_arready_mem),
		.axi_arvalid(axi_arvalid_mem),
		// read data
		.axi_rvalid(axi_rvalid_mem),
		.axi_rready(axi_rready_mem),
		// write data addr
		.axi_awvalid(axi_awvalid_mem),
		.axi_awready(axi_awready_mem),
		// write data
		.axi_wvalid(axi_wvalid_mem),
		.axi_wready(axi_wready_mem),
		// response
		.axi_bvalid(axi_bvalid_mem),
		.axi_bready(axi_bready_mem),
		// 模块握手信号
		.exe_valid(exe_valid),
		.wb_ready(wb_ready),
		.mem_valid(mem_valid),
		.mem_ready(mem_ready),

		.mem_addr(mem_addr_M),
		.RealMemWmask(RealMemWmask_M),
		.pc_W(pc_MW),
		.sext_imm_W(sext_imm_MW),
		.alu_result_W(alu_result_MW),
		.rs1_data_W(rs1_data_MW),
		.rdata_csr_W(rdata_csr_MW),
		.Mem_rdata_extend(Mem_rdata_extend),
		.irq_W(irq_MW),
		.irq_no_W(irq_no_MW),
		.Gpr_Write_W(Gpr_Write_MW),
		.Csr_Write_W(Csr_Write_MW),
		.Gpr_Write_RD_W(Gpr_Write_RD_MW),
		.Csr_Write_RD_W(Csr_Write_RD_MW)
	);

	ysyx_24100006_wbu WB(
		.clk(clk),
		.reset(reset),
		.pc(pc_MW),
		.sext_imm(sext_imm_MW),
		.alu_result(alu_result_MW),
		.Mem_rdata_extend(Mem_rdata_extend),
		.rdata_csr(rdata_csr_MW),
		.rs1_data(rs1_data_MW),
		.irq_W(irq_MW),
		.irq_no_W(irq_no_MW),
		.Gpr_Write(Gpr_Write_MW),
		.Csr_Write(Csr_Write_MW),
		.Gpr_Write_RD(Gpr_Write_RD_MW),
		.Csr_Write_RD(Csr_Write_RD_MW),
		
		.mem_valid(mem_valid),
		.wb_ready(wb_ready),

		.irq_WD(irq_WD),
		.irq_no_WD(irq_no_WD),
		.Gpr_Write_WD(Gpr_Write_WD),
		.Csr_Write_WD(Csr_Write_WD),
		.wdata_gpr(wdata_gpr_WD),
		.wdata_csr(wdata_csr_WD)
	);

	// always @(*) begin
	// 	if(instruction == 32'h00100073)begin
	// 		$display(" %x %x %x",Jump_DE,pc_FD,instruction);
	// 	end
	// end

endmodule

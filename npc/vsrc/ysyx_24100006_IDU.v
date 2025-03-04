/**
    译码模块
*/
// TODO: 这里不知道是否需要把irq和irq_no传出去，然后在WB级在写回
module ysyx_24100006_idu(
	input clk,
	input reset,
	// from IFU
	input [31:0] instruction,
	input [31:0] pc_D,

	// from WBU(一些从写回级来的信号，比如写入的数据是什么)
	input Gpr_Write_W,
	input Csr_Write_W,
	input [31:0] wdata_gpr_W,
	input [31:0] wdata_csr_W,

	// to EXEU
	output [31:0] pc_E,
	// 位扩展的立即数
	output [31:0] sext_imm,
	// GPR寄存器取出的值
	output [31:0] rs1_data,
	output [31:0] rs2_data,
	// CSR寄存器取出的值
	output [31:0] rdata_csr,

	// control signal
	output PCW,	// 控制是否取下一条pc的

	output irq_F,	// IF使用的irq信号
	output irq_E,
	output [3:0] aluop,
	output AluSrcA,
	output AluSrcB,
	output Gpr_Write_E,
	output Csr_Write_E,
	output [2:0] Gpr_Write_RD,
	output [1:0] Csr_Write_RD,
	output Mem_Read,
	output Mem_Write,
	output [3:0] Jump,
	output [7:0] Mem_WMask,
	output [2:0] Mem_RMask,

	// TO IFU
	// CSR寄存器取出的异常PC
	output [31:0] mtvec,
	output [31:0] mepc
);

	wire [2:0] Imm_Type;
	wire irq;
	wire [7:0] irq_no;

	assign pc_E = pc_D;

    // 生成控制信号
	ysyx_24100006_controller_remake controller(
		.clk(clk),
		.reset(reset),
		.PCW(PCW),
		.opcode(instruction[6:0]),
		.funct3(instruction[14:12]),
		.funct7(instruction[31:25]),
		.funct12(instruction[31:20]),
		.irq(irq),
		.irq_no(irq_no),
		.aluop(aluop),
		.Gpr_Write(Gpr_Write_E),
		.Gpr_Write_RD(Gpr_Write_RD),
		.Csr_Write(Csr_Write_E),
		.Csr_Write_RD(Csr_Write_RD),
		.Jump(Jump),
		.Imm_Type(Imm_Type),
		.AluSrcA(AluSrcA),
		.AluSrcB(AluSrcB),
		.Mem_Read(Mem_Read),
		.Mem_RMask(Mem_RMask),
		.Mem_Write(Mem_Write),
		.Mem_WMask(Mem_WMask)
	);

	assign irq_F = irq;
	assign irq_E = irq;

	// 读取寄存器的值
	wire [31:0] rs1_data_temp;
	wire [31:0] rs2_data_temp;

	// 通用寄存器堆
	ysyx_24100006_GPR GPR(
		.clk(clk),
		.wdata(wdata_gpr_W),
		.waddr(instruction[11:7]),
		.wen(Gpr_Write_W),
		.rs1(instruction[19:15]),
		.rs2(instruction[24:20]),
		.rs1_data(rs1_data_temp),
		.rs2_data(rs2_data_temp)
	);

	/**
		alu_src_a寄存器：保存寄存器取出的值
	*/
	ysyx_24100006_Reg #(32,32'h00000000) alu_src_a(
		.clk(clk),
		.rst(reset),
		.din(rs1_data_temp),
		.dout(rs1_data),
		.wen(1'b1)
	);

	ysyx_24100006_Reg #(32,32'h00000000) alu_src_b(
		.clk(clk),
		.rst(reset),
		.din(rs2_data_temp),
		.dout(rs2_data),
		.wen(1'b1)
	);

	// 系统寄存器
	// TODO:需要写CSR寄存器的指令有mret、csrrs、csrrw三条，所以这里的wdata和waddr需要使用MUX进行选值
	ysyx_24100006_CSR CSR(
		.clk(clk),
		.irq(irq),
		.irq_no(irq_no),
		.wdata(wdata_csr_W),
		.waddr(instruction[31:20]),
		.wen(Csr_Write_W),
		.raddr(instruction[31:20]),
		.rdata(rdata_csr),
		.mtvec(mtvec),
		.mepc(mepc)
	);
	
	// 立即数符号扩展
	ysyx_24100006_imm_sext imm_sext(
		.inst(instruction),
		.Imm_Type(Imm_Type),
		.sext_imm(sext_imm)
	);

endmodule
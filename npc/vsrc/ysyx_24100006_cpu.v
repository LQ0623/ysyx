module ysyx_24100006_cpu(
	input clk,
	input reset
);
	wire [31:0]pc;
	wire [31:0]npc;
	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.npc(npc),
		.pc(pc)
	);

	wire [31:0] instruction;
	ysyx_24100006_im IM(
		.pc(pc),
		.instruction(instruction)
	);

	/* verilator lint_off UNUSEDSIGNAL */
	wire Gpr_Write,Csr_Write;
	wire AluSrcA,AluSrcB;
	wire Mem_Read,Mem_Write;
	wire [3:0] aluop;
	wire [2:0] Gpr_Write_RD;
	wire [1:0] Csr_Write_RD;
	wire [3:0] Jump;
	wire [2:0] Imm_Type;	
	wire [7:0] Mem_WMask;
	wire [2:0] Mem_RMask;
	wire irq;
	wire [7:0] irq_no;
	/* verilator lint_off UNUSEDSIGNAL */

	ysyx_24100006_controller controller(
		.opcode(instruction[6:0]),
		.funct3(instruction[14:12]),
		.funct7(instruction[31:25]),
		.funct12(instruction[31:20]),
		.irq(irq),
		.irq_no(irq_no),
		.aluop(aluop),
		.Gpr_Write(Gpr_Write),
		.Gpr_Write_RD(Gpr_Write_RD),
		.Csr_Write(Csr_Write),
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

	wire [4:0] 	rs;
	wire [4:0] 	rt;
	/* verilator lint_off UNDRIVEN */
	/* verilator lint_off UNUSEDSIGNAL */
	// 下面是GPR使用的信号
	wire [4:0] 	rd;
	wire [4:0] 	waddr_gpr;
	wire [31:0] wdata_gpr;
	wire [31:0] rs1_data;
	wire [31:0] rs2_data;
	wire [31:0] alu_result;
	wire [31:0] sext_imm;
	wire [31:0] Mem_rdata,Mem_rdata_extend;

	// new
	wire [31:0] mem_addr;
	wire [7:0] RealMemWmask;
	wire [31:0] place;
	wire [31:0] rdraw;
	
	wire of,zf,cf;
	/* verilator lint_off UNDRIVEN */
	/* verilator lint_off UNUSEDSIGNAL */
	
	assign waddr_gpr 	= instruction[11:7];
	assign rs 			= instruction[19:15];
	assign rt 			= instruction[24:20];

	// 选择写入通用寄存器的内容
	ysyx_24100006_MuxKey#(5,3,32) gpr_write_data_mux(wdata_gpr,Gpr_Write_RD,{
		3'b000, sext_imm,
		3'b001, alu_result,
		3'b010, (pc+4),
		3'b011, Mem_rdata_extend,
		3'b100, rdata_csr
	});

	// 通用寄存器堆
	ysyx_24100006_GPR GPR(
		.clk(clk),
		.wdata(wdata_gpr),
		.waddr(waddr_gpr),
		.wen(Gpr_Write),
		.rs1(rs),
		.rs2(rt),
		.rs1_data(rs1_data),
		.rs2_data(rs2_data)
	);


	// CSR使用的信号
	wire [11:0] waddr_csr;
	wire [31:0] wdata_csr;
	wire [31:0] rdata_csr;
	wire [31:0] mtvec;
	wire [31:0] mepc;

	assign waddr_csr 	= instruction[31:20];
	// 选择写入系统寄存器的内容
	ysyx_24100006_MuxKey#(3,2,32) csr_write_data_mux(wdata_csr,Csr_Write_RD,{
		2'b00,pc,
		2'b01,rs1_data,
		2'b10,(rdata_csr | rs1_data)
	});

	// 系统寄存器
	// TODO:需要写CSR寄存器的指令有mret、csrrs、csrrw三条，所以这里的wdata和waddr需要使用MUX进行选值
	ysyx_24100006_CSR CSR(
		.clk(clk),
		.irq(irq),
		.irq_no(irq_no),
		.wdata(wdata_csr),
		.waddr(waddr_csr),
		.wen(Csr_Write),
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
	
	wire [31:0] alu_a_data,alu_b_data;

	// 选择进入加法器的内容
	ysyx_24100006_MuxKey#(2,1,32) alu_a_data_mux(alu_a_data,AluSrcA,{
		1'b0,rs1_data,
		1'b1,pc
	});
	ysyx_24100006_MuxKey#(2,1,32) alu_b_data_mux(alu_b_data,AluSrcB,{
		1'b0,rs2_data,
		1'b1,sext_imm
	});

	// 运算器
	ysyx_24100006_alu alu(
		.rs_data(alu_a_data),
		.aluop(aluop),
		.rt_data(alu_b_data),
		.result(alu_result),
		.of(of),
		.cf(cf),
		.zf(zf)
	);
	
	assign mem_addr = alu_result & (~32'h3);	// 对齐到4字节边界
	assign place = alu_result - mem_addr;		// 计算实际地址与字节之间的偏移
	assign RealMemWmask = Mem_WMask << place;	// 
	
	// 内存操作
	ysyx_24100006_mem mem(
		.clk(clk),
		.Mem_Write(Mem_Write),
		.Mem_WMask(RealMemWmask),
		.waddr(mem_addr),
		.wdata(rs2_data),
		.Mem_Read(Mem_Read),
		.raddr(mem_addr),
		.rdata(rdraw)
	);

	/**
		写入内存的内容，半字或者一个字
	*/
	// rdplace 的计算涉及将读取到的数据 rdraw 按照 place 的值进行右移操作。由于 place 表示的是字节偏移量，而每个字节有8位，所以 place << 3 实际上是将字节偏移量转换为位偏移量（即乘以 8）。这样可以确保数据对齐到正确的位位置。
	assign Mem_rdata = rdraw >> (place << 3);	// 将读取到的数据 rdraw 右移 (place << 3) 位。因为 place 表示字节偏移，乘以 8（即左移3位）得到位偏移量。右移操作可以将数据对齐到正确的位置

	ysyx_24100006_MuxKey#(5,3,32) mem_rdata_extend(Mem_rdata_extend,Mem_RMask,{
		3'b000,{{24{Mem_rdata[7]}},Mem_rdata[7:0]},
		3'b001,{24'b0,Mem_rdata[7:0]},
		3'b010,{{16{Mem_rdata[15]}},Mem_rdata[15:0]},
		3'b011,{16'b0,Mem_rdata[15:0]},
		3'b100,Mem_rdata[31:0]
	});

	// 计算npc
	ysyx_24100006_npc NPC(
		.pc(pc),
		.mtvec(mtvec),
		.mepc(mepc),
		.Skip_mode(Jump),
		.sext_imm(sext_imm),
		.rs_data(rs1_data),
		.cmp_result(alu_result[0]),
		.zf(zf),
		.npc(npc)
	);

endmodule

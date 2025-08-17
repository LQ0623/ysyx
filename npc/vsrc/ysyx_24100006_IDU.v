/**
    译码模块
*/
// TAG: 这里不知道是否需要把irq和irq_no传出去，然后在WB级在写回
module ysyx_24100006_idu(
	input 			clk,
	input 			reset,
	// from IFU
	input [31:0] 	instruction,
	input [31:0] 	pc_D,

    // === 新增：stall from hazard unit,防止数据冒险 ===
    input           stall_id,

	// from WBU(一些从写回级来的信号，比如写入的数据是什么)
	input 			irq_W,
	input [7:0] 	irq_no_W,
	input 			Gpr_Write_W,
	input 			Csr_Write_W,
    input [3:0]     Gpr_Write_Addr_W,
    input [11:0]    Csr_Write_Addr_W,
	input [31:0] 	wdata_gpr_W,
	input [31:0] 	wdata_csr_W,

	// 握手机制使用
	input           id_out_valid,   // IF_ID -> IDU (上游 valid)
    output          id_out_ready,   // IDU -> IF_ID  (上游 ready)
    output          id_in_valid,    // IDU -> ID_EXE (下游 valid)
    input           id_in_ready,    // ID_EXE -> IDU (下游 ready)

    // === 新增：输出 rs1 / rs2 读使能 ===
    output          rs1_ren,
    output          rs2_ren,
    output          is_break, // 是否是ebreak指令

	// to EXEU
	output [31:0] 	pc_E,
	// 位扩展的立即数
	output [31:0] 	sext_imm,
	// GPR寄存器取出的值
	output [31:0] 	rs1_data,
	output [31:0] 	rs2_data,
	// CSR寄存器取出的值
	output [31:0] 	rdata_csr,

	// control signal
	output 			is_fence_i, // 是否刷新icache
	output 			irq_E,
	// 异常号
	output [7:0] 	irq_no,
	output [3:0] 	aluop,
	output 			AluSrcA,
	output 			AluSrcB,
	output 			Gpr_Write_E,
	output 			Csr_Write_E,
    output [3:0]    Gpr_Write_Addr,
    output [11:0]   Csr_Write_Addr,
	output [2:0] 	Gpr_Write_RD,
	output [1:0] 	Csr_Write_RD,
	output [3:0] 	Jump,
	output [7:0] 	Mem_WMask,
	output [2:0] 	Mem_RMask,

	output [1:0] 	sram_read_write,

	// TO IFU
	// CSR寄存器取出的异常PC
	output [31:0] 	mtvec,
	output [31:0] 	mepc
);

	// 握手机制
    assign id_in_valid  = id_out_valid & ~stall_id; // If there is a hazard, do not continue passing data
    assign id_out_ready = id_in_ready & ~stall_id; // If there's a hazard, don't continue passing data


	// GPR combinational read outputs
    wire [31:0] rs1_data_comb;
    wire [31:0] rs2_data_comb;

	// 通用寄存器堆
	ysyx_24100006_GPR GPR(
		.clk(clk),
		.wdata(wdata_gpr_W),
		.waddr(Gpr_Write_Addr_W),
		.wen(Gpr_Write_W),
		.rs1(instruction[18:15]),
		.rs2(instruction[23:20]),
		.rs1_data(rs1_data_comb),
		.rs2_data(rs2_data_comb)
	);

	// CSR read (combinational rdata)
	// 系统寄存器
	// TAG:需要写CSR寄存器的指令有mret、csrrs、csrrw三条，所以这里的wdata和waddr需要使用MUX进行选值
    wire [31:0] rdata_csr_comb;
    wire [31:0] mtvec_comb;
    wire [31:0] mepc_comb;
    ysyx_24100006_CSR CSR(
        .clk(clk),
        .irq(irq_W),
        .irq_no(irq_no_W),
        .wdata(wdata_csr_W),
        .waddr(Csr_Write_Addr_W),
        .wen(Csr_Write_W),
        .raddr(instruction[31:20]),
        .rdata(rdata_csr_comb),
        .mtvec(mtvec_comb),
        .mepc(mepc_comb)
    );

	// immediate sign-extend (combinational)
    wire [2:0] Imm_Type;
    wire [31:0] sext_imm_wire;
    ysyx_24100006_imm_sext imm_sext(
        .inst(instruction),
        .Imm_Type(Imm_Type),
        .sext_imm(sext_imm_wire)
    );

	// controller_remake
    wire [3:0]  ctrl_aluop;
    wire        ctrl_Gpr_Write;
    wire [2:0]  ctrl_Gpr_Write_RD;
    wire        ctrl_Csr_Write;
    wire [1:0]  ctrl_Csr_Write_RD;
    wire [3:0]  ctrl_Jump;
    wire        ctrl_AluSrcA;
    wire        ctrl_AluSrcB;
    wire [2:0]  ctrl_Mem_RMask;
    wire [7:0]  ctrl_Mem_WMask;
    wire [1:0]  ctrl_sram_read_write;
    wire        ctrl_is_fence_i;
    wire        ctrl_irq;
    wire [7:0]  ctrl_irq_no;

	ysyx_24100006_controller_remake controller(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .funct12(instruction[31:20]),

        .rs1_ren(rs1_ren), // 是否需要读rs1寄存器
        .rs2_ren(rs2_ren), // 是否需要读rs2寄存器
        .is_ebreak(is_break), // 是否是ebreak指令

        .irq(ctrl_irq),
        .irq_no(ctrl_irq_no),
        .aluop(ctrl_aluop),
        .Gpr_Write(ctrl_Gpr_Write),
        .Gpr_Write_RD(ctrl_Gpr_Write_RD),
        .Csr_Write(ctrl_Csr_Write),
        .Csr_Write_RD(ctrl_Csr_Write_RD),
        .Jump(ctrl_Jump),
        .Imm_Type(Imm_Type),
        .AluSrcA(ctrl_AluSrcA),
        .AluSrcB(ctrl_AluSrcB),
        .Mem_RMask(ctrl_Mem_RMask),
        .Mem_WMask(ctrl_Mem_WMask),
        .sram_read_write(ctrl_sram_read_write),
        .is_fence_i(ctrl_is_fence_i)
    );

	
	// ---------------- map combinational outputs ----------------
    assign pc_E        		= pc_D;
    assign sext_imm    		= sext_imm_wire;
    assign rs1_data    		= rs1_data_comb;
    assign rs2_data    		= rs2_data_comb;
    assign rdata_csr   		= rdata_csr_comb;
    assign mtvec       		= mtvec_comb;
    assign mepc        		= mepc_comb;

    assign aluop       		= ctrl_aluop;
    assign AluSrcA     		= ctrl_AluSrcA;
    assign AluSrcB     		= ctrl_AluSrcB;
    assign Gpr_Write_Addr   = instruction[10:7];
    assign Gpr_Write_E 		= ctrl_Gpr_Write;
    assign Gpr_Write_RD		= ctrl_Gpr_Write_RD;
    assign Csr_Write_Addr   = instruction[31:20];
    assign Csr_Write_E 		= ctrl_Csr_Write;
    assign Csr_Write_RD		= ctrl_Csr_Write_RD;
    assign Jump        		= ctrl_Jump;
    assign Mem_WMask   		= ctrl_Mem_WMask;
    assign Mem_RMask   		= ctrl_Mem_RMask;
    assign sram_read_write 	= ctrl_sram_read_write;
    assign is_fence_i  		= ctrl_is_fence_i;
    assign irq_E       		= ctrl_irq;
    assign irq_no      		= ctrl_irq_no;

    // TODO:如果透传出现问题，则需要使用下面的
    // -------------------- 握手逻辑 --------------------
    // reg valid_temp;
    // assign id_in_valid  = valid_temp;
    // assign id_out_ready = (!valid_temp) || (id_in_ready && valid_temp);

    // always @(posedge clk) begin
    //     if (reset) begin
    //         valid_temp <= 1'b0;
    //         pc_E <= 0; sext_imm <= 0; rs1_data <= 0; rs2_data <= 0; rdata_csr <= 0;
    //         mtvec <= 0; mepc <= 0;
    //         aluop <= 0; AluSrcA <= 0; AluSrcB <= 0; Gpr_Write_E <= 0; Gpr_Write_RD <= 0;
    //         Csr_Write_E <= 0; Csr_Write_RD <= 0; Jump <= 0;
    //         Mem_WMask <= 0; Mem_RMask <= 0; sram_read_write <= 0; is_fence_i <= 0;
    //         irq_E <= 0; irq_no <= 0;
    //     end else if (id_out_ready) begin
    //         valid_temp <= id_out_valid;
    //         if (id_out_valid) begin
    //             pc_E        <= pc_D;
    //             sext_imm    <= sext_imm_wire;
    //             rs1_data    <= rs1_data_comb;
    //             rs2_data    <= rs2_data_comb;
    //             rdata_csr   <= rdata_csr_comb;
    //             mtvec       <= mtvec_comb;
    //             mepc        <= mepc_comb;

    //             aluop       <= ctrl_aluop;
    //             AluSrcA     <= ctrl_AluSrcA;
    //             AluSrcB     <= ctrl_AluSrcB;
    //             Gpr_Write_E <= ctrl_Gpr_Write;
    //             Gpr_Write_RD<= ctrl_Gpr_Write_RD;
    //             Csr_Write_E <= ctrl_Csr_Write;
    //             Csr_Write_RD<= ctrl_Csr_Write_RD;
    //             Jump        <= ctrl_Jump;
    //             Mem_WMask   <= ctrl_Mem_WMask;
    //             Mem_RMask   <= ctrl_Mem_RMask;
    //             sram_read_write <= ctrl_sram_read_write;
    //             is_fence_i  <= ctrl_is_fence_i;
    //             irq_E       <= ctrl_irq;
    //             irq_no      <= ctrl_irq_no;
    //         end
    //     end
    // end

endmodule
/**
    译码模块
*/
// TAG: 这里不知道是否需要把irq和irq_no传出去，然后在WB级在写回
module ysyx_24100006_idu(
	input 			clk,
	input 			reset,
	// from IFU
	input [31:0] 	instruction,


    //调试使用
	input [31:0] 	pc_D,
`ifdef VERILATOR_SIM
    output [31:0] 	pc_E,
`endif

    // === 新增：stall from hazard unit,防止数据冒险 ===
    input           stall_id,

	// from WBU(一些从写回级来的信号，比如写入的数据是什么)
	input 			irq_W,
	// input [3:0] 	irq_no_W,
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
	// control signal
	output 			is_fence_i, // 是否刷新icache
	output [3:0] 	aluop,
	output 			Gpr_Write_E,
	output 			Csr_Write_E,
    output [3:0]    Gpr_Write_Addr,
    output [11:0]   Csr_Write_Addr,
	output [1:0] 	Gpr_Write_RD,
	output [2:0] 	Jump,

	output [1:0] 	sram_read_write,

	// TO IFU
	// CSR寄存器取出的异常PC,ecall指令使用的,mret指令直接在内部就会计算一个pc
	output [31:0] 	mtvec

    // 异常处理相关
    ,output         irq_D

    // 面积优化
    ,output [31:0]  pc_j_m_e_n_D        // NO_JUMP/MRET/ECALL三种跳转的地址
    ,output [31:0]  alu_a_data_D
    ,output [31:0]  alu_b_data_D
    ,output [31:0]  pc_add_imm_D

    ,output [31:0]  wdata_csr_D
    ,output [31:0]  wdata_gpr_D

    ,output [2:0]   Mem_Mask

    ,output [31:0]  pc_add_4_o

    // 前递单元设计
    ,input [1:0]    forwardA
    ,input [1:0]    forwardB
    ,input [31:0]   exe_fw_data
    ,input [31:0]   mem_fw_data
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

    wire [31:0]immI;
	wire [31:0]immU;
	wire [31:0]immJ;
	wire [31:0]immS;
	wire [31:0]immB;

    assign immI = {{21{instruction[31]}},instruction[30:20]};
	assign immU = {instruction[31:12],12'b0};
	assign immJ = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0};
	assign immS = {{21{instruction[31]}},instruction[30:25],instruction[11:7]};
	assign immB = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};

	assign sext_imm_wire = (Imm_Type[2] == 1'b1) ? immU : 
						((Imm_Type[1:0] == 2'b00) ? immI: 
						(Imm_Type[1:0] == 2'b01) ? immJ: 
						(Imm_Type[1:0] == 2'b11) ? immB: immS);

	// controller_remake
    wire [3:0]  ctrl_aluop;
    wire        ctrl_Gpr_Write;
    wire [2:0]  ctrl_Gpr_Write_RD;
    wire        ctrl_Csr_Write;
    wire [1:0]  ctrl_Csr_Write_RD;
    wire [2:0]  ctrl_Jump;
    wire        ctrl_AluSrcA;
    wire        ctrl_AluSrcB;
    wire [2:0]  ctrl_Mem_RMask;
    wire [2:0]  ctrl_Mem_WMask;
    wire [1:0]  ctrl_sram_read_write;
    wire        ctrl_is_fence_i;
    wire        ctrl_irq;

    // 新增：来自 controller 的 jalr/mret 指示
    wire        ctrl_is_jalr;
    wire        ctrl_is_mret;

	ysyx_24100006_controller_remake controller(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .funct12(instruction[31:20]),

        .rs1_ren(rs1_ren), // 是否需要读rs1寄存器
        .rs2_ren(rs2_ren), // 是否需要读rs2寄存器
        .is_ebreak(is_break), // 是否是ebreak指令

        .irq(ctrl_irq),
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
        // 新增输出
        ,.is_jalr(ctrl_is_jalr),
        .is_mret(ctrl_is_mret)
    );

    // 前递单元设计
    wire [31:0] rs1_data_fw;
    wire [31:0] rs2_data_fw;
    assign rs1_data_fw = (forwardA == 2'b00) ? rs1_data_comb :
                        (forwardA == 2'b01) ? exe_fw_data :
                        (forwardA == 2'b10) ? mem_fw_data : 32'b0;

    assign rs2_data_fw = (forwardB == 2'b00) ? rs2_data_comb :
                        (forwardB == 2'b01) ? exe_fw_data : 
                        (forwardB == 2'b10) ? mem_fw_data : 32'b0;

	
	// ---------------- map combinational outputs ----------------

`ifdef VERILATOR_SIM
    // 调试使用
    assign pc_E        		= pc_D;
`endif

    assign mtvec       		= mtvec_comb;

    assign aluop       		= ctrl_aluop;
    assign Gpr_Write_Addr   = instruction[10:7];
    assign Gpr_Write_E 		= ctrl_Gpr_Write;
    assign Gpr_Write_RD		= ctrl_Gpr_Write_RD[1:0];
    assign Csr_Write_Addr   = instruction[31:20];
    assign Csr_Write_E 		= ctrl_Csr_Write;
    assign Jump        		= ctrl_Jump;
    assign sram_read_write 	= ctrl_sram_read_write;
    assign is_fence_i  		= (reset == 1 || id_out_valid == 0) ? 0 : ctrl_is_fence_i;

    // 异常处理相关
    assign irq_D       		= ctrl_irq;

    // 面积优化
    // assign pc_add_4_o           =   pc_D + 4;
    // wire [31:0] rs1_add_imm_D   =   (rs1_data_fw + sext_imm_wire) & (~32'b1);
    // assign pc_j_m_e_n_D         =   (instruction[6:0] == 7'b1100111) ? rs1_add_imm_D :               // JALR
    //                                 (instruction[6:0] == 7'b1110011 && instruction[31:20] == 12'b001100000010) ? mepc_comb : pc_add_4_o;     // MRET，ECALL指令并不会产生跳转指令，因为属于异常处理

    // 面积优化：PC 选择仅依赖控制信号，不再重复比较 opcode
    assign pc_add_4_o           = {(pc_D[31:2] + 1'b1), 2'b00};
    wire [31:0] rs1_add_imm_D   = (rs1_data_fw + sext_imm_wire) & (~32'b1);
    assign pc_j_m_e_n_D         = ctrl_is_jalr ? rs1_add_imm_D :
                                  ctrl_is_mret ? mepc_comb    :
                                                 pc_add_4_o;

    assign alu_a_data_D     = (ctrl_AluSrcA == 1'b0) ? rs1_data_fw : pc_D;
    assign alu_b_data_D     = (ctrl_AluSrcB == 1'b0) ? rs2_data_fw : sext_imm_wire;
    assign pc_add_imm_D     = pc_D + sext_imm_wire;

    
    assign wdata_gpr_D      = (ctrl_sram_read_write[1] == 1'b1) ? rs2_data_fw : ((ctrl_Gpr_Write_RD[2] == 1'b1) ? rdata_csr_comb : ((ctrl_Gpr_Write_RD[1] == 1'b1) ? pc_add_4_o : sext_imm_wire));
    assign wdata_csr_D      = (ctrl_Csr_Write_RD[1] == 1'b1) ? (rdata_csr_comb | rs1_data_fw) : ((ctrl_Csr_Write_RD[0] == 1'b1) ? rs1_data_fw : pc_D);

    assign Mem_Mask         = (ctrl_sram_read_write[0] == 1'b1) ? ctrl_Mem_RMask :    // load
                                                                ctrl_Mem_WMask;     // write

endmodule
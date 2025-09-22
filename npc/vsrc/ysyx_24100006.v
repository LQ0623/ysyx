module ysyx_24100006(
	input			clock,
    input			reset
`ifndef NPC
	,

	input 			io_interrupt,

	//-----------------------------
    // AXI4 主设备接口 (物理总线侧)
    //-----------------------------
    // 写地址通道
	input			io_master_awready,
	output			io_master_awvalid,
	output  [31:0]  io_master_awaddr,
	output  [3:0]  	io_master_awid,
	output  [7:0]  	io_master_awlen,
	output  [2:0]  	io_master_awsize,
	output  [1:0]  	io_master_awburst,

	// 写数据通道
	input			io_master_wready,
	output          io_master_wvalid,
	output  [31:0]  io_master_wdata,
	output  [3:0]  	io_master_wstrb,
	output  		io_master_wlast,

	// 写响应通道
	output			io_master_bready,
	input			io_master_bvalid,
	input   [1:0]  	io_master_bresp,
	input   [3:0]  	io_master_bid,

	// 读地址通道
	input           io_master_arready,
	output          io_master_arvalid,
	output  [31:0]  io_master_araddr,
	output  [3:0]  	io_master_arid,
	output  [7:0]  	io_master_arlen,
	output  [2:0]  	io_master_arsize,
	output  [1:0]  	io_master_arburst,

	// 读数据通道
	output  		io_master_rready,
	input           io_master_rvalid,
	input   [1:0]  	io_master_rresp,
	input   [31:0]  io_master_rdata,
	input           io_master_rlast,
	input   [3:0]  	io_master_rid,

	//-----------------------------
    // 写地址通道 (Slave 接收 Master 的请求)
    //-----------------------------
    output wire        io_slave_awready,  // Slave 准备好接收地址
    input  wire        io_slave_awvalid,  // Master 地址有效
    input  wire [31:0] io_slave_awaddr,   // 地址
    input  wire [3:0]  io_slave_awid,     // 事务 ID
    input  wire [7:0]  io_slave_awlen,    // 突发长度
    input  wire [2:0]  io_slave_awsize,   // 突发大小
    input  wire [1:0]  io_slave_awburst,  // 突发类型

    //-----------------------------
    // 写数据通道 (Slave 接收数据)
    //-----------------------------
    output wire        io_slave_wready,   // Slave 准备好接收数据
    input  wire        io_slave_wvalid,   // Master 数据有效
    input  wire [31:0] io_slave_wdata,    // 数据
    input  wire [3:0]  io_slave_wstrb,    // 字节选通
    input  wire        io_slave_wlast,    // 最后一个数据包

    //-----------------------------
    // 写响应通道 (Slave 返回响应)
    //-----------------------------
    input  wire        io_slave_bready,   // Master 准备好接收响应
    output wire        io_slave_bvalid,   // Slave 响应有效
    output wire [1:0]  io_slave_bresp,    // 响应状态
    output wire [3:0]  io_slave_bid,      // 事务 ID

    //-----------------------------
    // 读地址通道 (Slave 接收读请求)
    //-----------------------------
    output wire        io_slave_arready,  // Slave 准备好接收地址
    input  wire        io_slave_arvalid,  // Master 地址有效
    input  wire [31:0] io_slave_araddr,   // 地址
    input  wire [3:0]  io_slave_arid,     // 事务 ID
    input  wire [7:0]  io_slave_arlen,    // 突发长度
    input  wire [2:0]  io_slave_arsize,   // 突发大小
    input  wire [1:0]  io_slave_arburst,  // 突发类型

    //-----------------------------
    // 读数据通道 (Slave 返回数据)
    //-----------------------------
    input  wire        io_slave_rready,   // Master 准备好接收数据
    output wire        io_slave_rvalid,   // Slave 数据有效
    output wire [1:0]  io_slave_rresp,    // 响应状态
    output wire [31:0] io_slave_rdata,    // 数据
    output wire        io_slave_rlast,    // 最后一个数据包
    output wire [3:0]  io_slave_rid       // 事务 ID
	
`endif
);

`ifndef NPC
	//-----------------------------
	// 所有 output 信号强制置零
	//-----------------------------
	assign io_slave_awready   = 1'b0;   // 1-bit
	assign io_slave_wready    = 1'b0;   // 1-bit
	assign io_slave_bvalid    = 1'b0;   // 1-bit
	assign io_slave_bresp     = 2'h0;   // 2-bit
	assign io_slave_bid       = 4'h0;   // 4-bit
	assign io_slave_arready   = 1'b0;   // 1-bit
	assign io_slave_rvalid    = 1'b0;   // 1-bit
	assign io_slave_rresp     = 2'h0;   // 2-bit
	assign io_slave_rdata     = 32'h0;  // 32-bit
	assign io_slave_rlast     = 1'b0;   // 1-bit
	assign io_slave_rid       = 4'h0;   // 4-bit
`endif

	// 模块的信号
	// Icache -> EXEU
	wire icache_flush_done_CE;
	// hazard -> IDU;
	// === Hazard wires ===
	wire        stall_id;
	// IDU -> hazard
	wire		rs1_ren_D;
	wire		rs2_ren_D;
	// MEMU -> hazard
	// 是否是lw指令
	wire is_load;

	// EXEU -> IFU
	wire [31:0] npc_E_F;              	// EXE->IFU传递的下一条PC
	wire		redirect_valid_E_F;
	// WBU -> IDU
	wire irq_WD;
	wire [7:0] 	irq_no_WD;
	wire [3:0] 	Gpr_Write_Addr_WD;
	wire [11:0]	Csr_Write_Addr_WD;
	wire 		Gpr_Write_WD;
	wire 		Csr_Write_WD;
	wire [31:0] wdata_gpr_WD;
	wire [31:0] wdata_csr_WD;




	// IF阶段信号
	wire		irq_F;
	wire [7:0]	irq_no_F;
	wire [31:0] pc_F;                 	// IF阶段PC
	wire [31:0]	inst_F;					// IF阶段instruction

	// IF_ID输出信号
	wire		irq_F_D;			  	// IF->ID传递的中断标志
	wire [7:0]	irq_no_F_D;		  		// IF->ID传递的中断号
	wire [31:0] pc_F_D;               	// IF->ID传递的PC
	wire [31:0] instruction_F_D;      	// IF->ID传递的指令

	// ID阶段信号
	wire [31:0] pc_D;                 	// ID阶段PC
	wire [31:0] sext_imm_D;           	// ID阶段符号扩展立即数
	wire [31:0] rs1_data_D;           	// ID阶段rs1数据
	wire [31:0] rs2_data_D;           	// ID阶段rs2数据
	wire [31:0] rdata_csr_D;          	// ID阶段CSR数据
	wire [3:0]  alu_op_D;             	// ID阶段ALU操作码
	wire [3:0]	Gpr_Write_Addr_D;	  	// ID阶段GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_D;	  	// ID阶段CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_D;       	// ID阶段GPR写寄存器
	wire [1:0]  Csr_Write_RD_D;       	// ID阶段CSR写寄存器
	wire [3:0]  Jump_D;               	// ID阶段跳转控制
	wire [7:0]  Mem_WMask_D;          	// ID阶段写掩码
	wire [2:0]  Mem_RMask_D;          	// ID阶段读掩码
	wire [7:0]  irq_no_D;             	// ID阶段中断号
	wire [31:0] mtvec_D;              	// ID阶段mtvec值
	wire [31:0] mepc_D;               	// ID阶段mepc值
	wire        is_fence_i_D;         	// ID阶段fence.i标志
	wire        irq_D;                	// ID阶段中断标志
	wire        AluSrcA_D;            	// ID阶段ALU源A选择
	wire        AluSrcB_D;            	// ID阶段ALU源B选择
	wire        Gpr_Write_D;          	// ID阶段GPR写使能
	wire        Csr_Write_D;          	// ID阶段CSR写使能
	wire		is_break_D;			  	// ID阶段break指令标志
	wire [1:0]	sram_read_write_D;    	// ID阶段SRAM读写使能，这个是在MEMU中判断是LOAD操作还是STORE操作使用

	// ID_EXE输出信号
	wire [31:0] pc_D_E;               	// ID->EXE传递的PC
	wire [31:0] sext_imm_D_E;         	// ID->EXE传递的立即数
	wire [31:0] rs1_data_D_E;         	// ID->EXE传递的rs1数据
	wire [31:0] rs2_data_D_E;         	// ID->EXE传递的rs2数据
	wire [31:0] rdata_csr_D_E;        	// ID->EXE传递的CSR数据
	wire [3:0]  alu_op_D_E;           	// ID->EXE传递的ALU操作码
	wire [3:0]	Gpr_Write_Addr_D_E;	  	// ID->EXE传递的GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_D_E;	  	// ID->EXE传递的CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_D_E;     	// ID->EXE传递的GPR写寄存器
	wire [1:0]  Csr_Write_RD_D_E;     	// ID->EXE传递的CSR写寄存器
	wire [3:0]  Jump_D_E;             	// ID->EXE传递的跳转控制
	wire [7:0]  Mem_WMask_D_E;        	// ID->EXE传递的写掩码
	wire [2:0]  Mem_RMask_D_E;        	// ID->EXE传递的读掩码
	wire [7:0]  irq_no_D_E;           	// ID->EXE传递的中断号
	wire [31:0] mtvec_D_E;            	// ID->EXE传递的mtvec值
	wire [31:0] mepc_D_E;             	// ID->EXE传递的mepc值
	wire        is_fence_i_D_E;       	// ID->EXE传递的fence.i标志
	wire        irq_D_E;             	// ID->EXE传递的中断标志
	wire        AluSrcA_D_E;          	// ID->EXE传递的ALU源A选择
	wire		AluSrcB_D_E;	 	  	// ID->EXE传递的ALU源B选择
	wire        Gpr_Write_D_E;        	// ID->EXE传递的GPR写使能
	wire        Csr_Write_D_E;        	// ID->EXE传递的CSR写使能
	wire		is_break_D_E; 		  	// ID->EXE传递的break指令标志
	wire [1:0]	sram_read_write_D_E;  	// ID->EXE传递的SRAM读写使能，这个是在MEMU中判断是LOAD操作还是STORE操作使用

	// EXE阶段信号
	wire [31:0] pc_E;                 	// EXE阶段PC
	wire		redirect_valid_E;	  	// 是否使用EXE级的结果更新PC
	wire [31:0] npc_E;                	// EXE阶段下一条PC
	wire [31:0] alu_result_E;        	// EXE阶段ALU结果
	wire [31:0] sext_imm_E;          	// EXE阶段立即数
	wire [31:0] rs1_data_E;           	// EXE阶段rs1数据
	wire [31:0] rs2_data_E;           	// EXE阶段rs2数据
	wire [31:0] rdata_csr_E;          	// EXE阶段CSR数据
	wire [3:0]	Gpr_Write_Addr_E;	  	// EXE级GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_E;	  	// EXE级CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_E;       	// EXE阶段GPR写寄存器
	wire [1:0]  Csr_Write_RD_E;       	// EXE阶段CSR写寄存器
	wire [7:0]  Mem_WMask_E;          	// EXE阶段写掩码
	wire [2:0]  Mem_RMask_E;          	// EXE阶段读掩码
	wire [7:0]  irq_no_E;             	// EXE阶段中断号
	wire        irq_E;                	// EXE阶段中断标志
	wire        Gpr_Write_E;          	// EXE阶段GPR写使能
	wire        Csr_Write_E;          	// EXE阶段CSR写使能
	wire		is_break_E; 		  	// EXE->EXE_MEM传递的break指令标志
	wire [1:0]	sram_read_write_E;    	// EXE阶段SRAM读写使能，这个是在MEMU中判断是LOAD操作还是STORE操作使用

	// EXE_MEM输出信号
	wire [31:0] pc_E_M;               	// EXE->MEM传递的P
	wire [31:0] alu_result_E_M;       	// EXE->MEM传递的ALU结果
	wire [31:0] sext_imm_E_M;         	// EXE->MEM传递的立即数
	wire [31:0] rs1_data_E_M;         	// EXE->MEM传递的rs1数据
	wire [31:0] rs2_data_E_M;         	// EXE->MEM传递的rs2数据
	wire [31:0] rdata_csr_E_M;        	// EXE->MEM传递的CSR数据
	wire [3:0]	Gpr_Write_Addr_E_M;	  	// EXE->MEM传递的GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_E_M;	  	// EXE->MEM传递的CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_E_M;     	// EXE->MEM传递的GPR写寄存器
	wire [1:0]  Csr_Write_RD_E_M;     	// EXE->MEM传递的CSR写寄存器
	wire [7:0]  Mem_WMask_E_M;        	// EXE->MEM传递的写掩码
	wire [2:0]  Mem_RMask_E_M;        	// EXE->MEM传递的读掩码
	wire [7:0]  irq_no_E_M;           	// EXE->MEM传递的中断号
	wire        irq_E_M;              	// EXE->MEM传递的中断标志
	wire        Gpr_Write_E_M;        	// EXE->MEM传递的GPR写使能
	wire        Csr_Write_E_M;        	// EXE->MEM传递的CSR写使能
	wire		is_break_E_M; 		  	// EXE_MEM->MEM传递的break指令标志
	wire [1:0]	sram_read_write_E_M;  	// EXE->MEM传递的SRAM读写使能，这个是在MEMU中判断是LOAD操作还是STORE操作使用

	// MEM阶段信号
	wire [31:0] pc_M;                 	// MEM阶段PC
	wire [31:0] alu_result_M;         	// MEM阶段ALU结果
	wire [31:0] sext_imm_M;           	// MEM阶段立即数
	wire [31:0] Mem_rdata_M;          	// MEM阶段内存读数据
	wire [31:0] rs1_data_M;           	// MEM阶段rs1数据
	wire [31:0] rdata_csr_M;          	// MEM阶段CSR数据
	wire [3:0]	Gpr_Write_Addr_M;	  	// MEM级GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_M;	  	// MEM级CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_M;       	// MEM阶段GPR写寄存器
	wire [1:0]  Csr_Write_RD_M;       	// MEM阶段CSR写寄存器
	wire [7:0]  irq_no_M;             	// MEM阶段中断号
	wire        irq_M;                	// MEM阶段中断标志
	wire        Gpr_Write_M;          	// MEM阶段GPR写使能
	wire        Csr_Write_M;          	// MEM阶段CSR写使能
	wire		is_break_M; 		  	// MEM->MEM_WB传递的break指令标志

	// MEM_WB输出信号
	wire [31:0] pc_M_W;               	// MEM->WB传递的PC
	wire [31:0] alu_result_M_W;       	// MEM->WB传递的ALU结果
	wire [31:0] sext_imm_M_W;         	// MEM->WB传递的立即数
	wire [31:0] Mem_rdata_M_W;        	// MEM->WB传递的内存读数据
	wire [31:0] rs1_data_M_W;         	// MEM->WB传递的rs1数据
	wire [31:0] rdata_csr_M_W;        	// MEM->WB传递的CSR数据
	wire [3:0]	Gpr_Write_Addr_M_W;	  	// MEM->WB传递的GPR写寄存器的地址
	wire [11:0]	Csr_Write_Addr_M_W;	  	// MEM->WB传递的CSR写寄存器的地址 
	wire [2:0]  Gpr_Write_RD_M_W;     	// MEM->WB传递的GPR写寄存器
	wire [1:0]  Csr_Write_RD_M_W;     	// MEM->WB传递的CSR写寄存器
	wire [7:0]  irq_no_M_W;           	// MEM->WB传递的中断号
	wire        irq_M_W;              	// MEM->WB传递的中断标志
	wire        Gpr_Write_M_W;        	// MEM->WB传递的GPR写使能
	wire        Csr_Write_M_W;        	// MEM->WB传递的CSR写使能
	wire		is_break_M_W; 			// MEM_WB->WBU传递的break指令标志


	// 握手机制
	// IF_ID
	wire if_in_valid;
	wire if_in_ready;
	wire id_out_valid;
	wire id_out_ready;
	
	// ID_EXE
	wire id_in_valid;
	wire id_in_ready;
	wire exe_out_valid;
	wire exe_out_ready;
	
	// EXE_MEM
	wire exe_in_valid;
	wire exe_in_ready;
	wire mem_out_valid;
	wire mem_out_ready;

	// MEM_WB
	wire mem_in_valid;
	wire mem_in_ready;
	wire wb_out_valid;
	wire wb_out_ready;
	wire wb_in_valid;
	wire wb_in_ready;
	

	// AXI-Lite
	// IFU -> IM
	// read data addr
	reg [31:0]	axi_araddr_if;
	reg 		axi_arready_if;
	reg 		axi_arvalid_if;
	// read data
	reg 		axi_rvalid_if;
	reg 		axi_rready_if;
	reg [31:0]	axi_rdata_if;
	reg [1:0] 	axi_rresp_if;
	// write data addr
	reg 		axi_awvalid_if;
	reg 		axi_awready_if;
	// write data
	reg 		axi_wvalid_if;
	reg 		axi_wready_if;
	// response
	reg 		axi_bvalid_if;
	reg 		axi_bready_if;
	// 新增AXI信号
	reg	[7:0]	axi_arlen_if;
	reg	[2:0]	axi_arsize_if;
	reg			axi_rlast_if;

	// MEMU -> MEM
	// read data addr
	reg [31:0]	axi_araddr_mem;
	reg 		axi_arready_mem;
	reg 		axi_arvalid_mem;
	// read data
	reg	[31:0]	axi_rdata_mem;
	reg 		axi_rvalid_mem;
	reg 		axi_rready_mem;
	reg [1:0] 	axi_rresp_mem;
	// write data addr
	reg [31:0]	axi_awaddr_mem;
	reg 		axi_awvalid_mem;
	reg 		axi_awready_mem;
	// write data
	reg 		axi_wvalid_mem;
	reg [31:0]	axi_wdata_mem;
	reg 		axi_wready_mem;
	// response
	reg 		axi_bvalid_mem;
	reg 		axi_bready_mem;
	reg [1:0] 	axi_bresp_mem;
	// 新增AXI信号
	reg	[7:0]	axi_arlen_mem;
	reg	[2:0]	axi_arsize_mem;
	reg			axi_rlast_mem;
	reg	[7:0]	axi_awlen_mem;
	reg	[2:0]	axi_awsize_mem;
	reg	[3:0]	axi_wstrb_mem;
	reg			axi_wlast_mem;

	// 用于分辨原始的地址的后两位
	reg [1:0]	axi_addr_suffix_mem;
    
	// 下面的SRAM_axi_信号是指从xbar输出的信号，连接到axi模块的，本来是连接到存储SRAM（即mem）
	// 读地址通道
	wire       		sram_axi_arvalid;
    wire       		sram_axi_arready;
    wire [31:0]  	sram_axi_araddr;
    // 读数据通道
    wire         	sram_axi_rvalid;
    wire        	sram_axi_rready;
    wire [1:0]		sram_axi_rresp;
    wire [31:0]   	sram_axi_rdata;
    // 写地址通道
    wire         	sram_axi_awvalid;
    wire          	sram_axi_awready;
    wire [31:0]  	sram_axi_awaddr;
    // 写数据通道
    wire          	sram_axi_wvalid;
    wire        	sram_axi_wready;
    wire [31:0] 	sram_axi_wdata;
    // 写响应通道
    wire         	sram_axi_bvalid;
    wire        	sram_axi_bready;
    wire [1:0]  	sram_axi_bresp;

	// AXI新增信号
	wire [7:0]		sram_axi_arlen;
	wire [2:0]		sram_axi_arsize;
	wire			sram_axi_rlast;
	wire [7:0]		sram_axi_awlen;
	wire [2:0]		sram_axi_awsize;
	wire [3:0]		sram_axi_wstrb;
	wire			sram_axi_wlast;

`ifndef NPC
	// TAG: 时钟相关的部分
	// CLINT实例化
	// 读地址通道
	wire       		clint_axi_arvalid;
    wire       		clint_axi_arready;
    wire [31:0]  	clint_axi_araddr;
    // 读数据通道
    wire         	clint_axi_rvalid;
    wire        	clint_axi_rready;
    wire [1:0]		clint_axi_rresp;
    wire [31:0]   	clint_axi_rdata;
	wire			clint_axi_rlast;
    // 写地址通道
    wire         	clint_axi_awvalid;
    wire          	clint_axi_awready;
    wire [31:0]  	clint_axi_awaddr;
    // 写数据通道
    wire          	clint_axi_wvalid;
    wire        	clint_axi_wready;
    wire [31:0] 	clint_axi_wdata;
    // 写响应通道
    wire         	clint_axi_bvalid;
    wire        	clint_axi_bready;
    wire [1:0]  	clint_axi_bresp;

	ysyx_24100006_clint clint(
		.clk(clock),
		.reset(reset),
		
		// axi 写入和读取地址
		.axi_araddr(clint_axi_araddr),
		.axi_awaddr(clint_axi_awaddr),
		// axi 写入数据和写入使用的掩码
		.axi_wdata(clint_axi_wdata),
		// axi控制信号
		// read data addr
		.axi_arvalid(clint_axi_arvalid),
		.axi_arready(clint_axi_arready),
		// read data
		.axi_rready(clint_axi_rready),
		.axi_rvalid(clint_axi_rvalid),
		// write data addr
		.axi_awvalid(clint_axi_awvalid),
		.axi_awready(clint_axi_awready),
		// write data
		.axi_wvalid(clint_axi_wvalid),
		.axi_wready(clint_axi_wready),
		// response
		.axi_bready(clint_axi_bready),
		.axi_bvalid(clint_axi_bvalid),
		.axi_bresp(clint_axi_bresp),

		// axi读取的回应
		.axi_rresp(clint_axi_rresp),
		// axi读取的数据
		.axi_rdata(clint_axi_rdata),
		.axi_rlast(clint_axi_rlast)
	);

`else
// TAG:NPC使用的ram
	ysyx_24100006_mem u_mem (
        // 系统时钟和复位
        .clk              (clock),
        .reset            (reset),
        
        // AXI 地址接口
        .axi_araddr       (sram_axi_araddr),
        .axi_awaddr       (sram_axi_awaddr),
        
        // AXI 数据接口
        .axi_wdata        (sram_axi_wdata),
        .axi_wstrb        (sram_axi_wstrb),  // 字节掩码
        
        // AXI 控制信号 - 读通道
        .axi_arvalid      (sram_axi_arvalid),
        .axi_arready      (sram_axi_arready),  // 从模块输出
        
        .axi_rready       (sram_axi_rready),
        .axi_rvalid       (sram_axi_rvalid),  // 从模块输出
        .axi_rresp        (sram_axi_rresp),   // 从模块输出
        .axi_rdata        (sram_axi_rdata),   // 从模块输出
        
        // AXI 控制信号 - 写通道
        .axi_awvalid      (sram_axi_awvalid),
        .axi_awready      (sram_axi_awready), // 从模块输出
        
        .axi_wvalid       (sram_axi_wvalid),
        .axi_wready       (sram_axi_wready),  // 从模块输出
        
        // AXI 控制信号 - 响应通道
        .axi_bready       (sram_axi_bready),
        .axi_bvalid       (sram_axi_bvalid),  // 从模块输出
        .axi_bresp        (sram_axi_bresp),    // 从模块输出

		// 新增信号
		.axi_arlen		  (sram_axi_arlen),
		.axi_arsize 	  (sram_axi_arsize),
		.axi_rlast	 	  (sram_axi_rlast),
		.axi_awlen	  	  (sram_axi_awlen),
		.axi_awsize		  (sram_axi_awsize),
		.axi_wlast		  (sram_axi_wlast)
    );
// TAG: 实例化NPC使用的UART
// 实例化 UART 模块

	// 读地址通道
	wire       		uart_axi_arvalid;
    wire       		uart_axi_arready;
    wire [31:0]  	uart_axi_araddr;
    // 读数据通道
    wire         	uart_axi_rvalid;
    wire        	uart_axi_rready;
    wire [1:0]		uart_axi_rresp;
    wire [31:0]   	uart_axi_rdata;
    // 写地址通道
    wire         	uart_axi_awvalid;
    wire          	uart_axi_awready;
    wire [31:0]  	uart_axi_awaddr;
    // 写数据通道
    wire          	uart_axi_wvalid;
    wire        	uart_axi_wready;
    wire [31:0] 	uart_axi_wdata;
    wire [3:0]   	uart_axi_wstrb;
    // 写响应通道
    wire         	uart_axi_bvalid;
    wire        	uart_axi_bready;
    wire [1:0]  	uart_axi_bresp;

    ysyx_24100006_uart uart(
		.clk(clock),
		.reset(reset),
		
		// axi 写入和读取地址
		.axi_araddr(uart_axi_araddr),
		.axi_awaddr(uart_axi_awaddr),
		// axi 写入数据和写入使用的掩码
		.axi_wdata(uart_axi_wdata),
		.axi_wstrb(uart_axi_wstrb),
		// axi控制信号
		// read data addr
		.axi_arvalid(uart_axi_arvalid),
		.axi_arready(uart_axi_arready),
		// read data
		.axi_rready(uart_axi_rready),
		.axi_rvalid(uart_axi_rvalid),
		// write data addr
		.axi_awvalid(uart_axi_awvalid),
		.axi_awready(uart_axi_awready),
		// write data
		.axi_wvalid(uart_axi_wvalid),
		.axi_wready(uart_axi_wready),
		// response
		.axi_bready(uart_axi_bready),
		.axi_bvalid(uart_axi_bvalid),
		.axi_bresp(uart_axi_bresp),

		// axi读取的回应
		.axi_rresp(uart_axi_rresp),
		// axi读取的数据
		.axi_rdata(uart_axi_rdata)
	);

// TAG: 时钟相关的部分
	// CLINT实例化
	// 读地址通道
	wire       		clint_axi_arvalid;
    wire       		clint_axi_arready;
    wire [31:0]  	clint_axi_araddr;
    // 读数据通道
    wire         	clint_axi_rvalid;
    wire        	clint_axi_rready;
    wire [1:0]		clint_axi_rresp;
    wire [31:0]   	clint_axi_rdata;
	wire			clint_axi_rlast;
    // 写地址通道
    wire         	clint_axi_awvalid;
    wire          	clint_axi_awready;
    wire [31:0]  	clint_axi_awaddr;
    // 写数据通道
    wire          	clint_axi_wvalid;
    wire        	clint_axi_wready;
    wire [31:0] 	clint_axi_wdata;
    // 写响应通道
    wire         	clint_axi_bvalid;
    wire        	clint_axi_bready;
    wire [1:0]  	clint_axi_bresp;

	ysyx_24100006_clint #(
		.BASE_ADDR( 32'ha000_0048 )
	) clint(
		.clk(clock),
		.reset(reset),
		
		// axi 写入和读取地址
		.axi_araddr(clint_axi_araddr),
		.axi_awaddr(clint_axi_awaddr),
		// axi 写入数据和写入使用的掩码
		.axi_wdata(clint_axi_wdata),
		// axi控制信号
		// read data addr
		.axi_arvalid(clint_axi_arvalid),
		.axi_arready(clint_axi_arready),
		// read data
		.axi_rready(clint_axi_rready),
		.axi_rvalid(clint_axi_rvalid),
		// write data addr
		.axi_awvalid(clint_axi_awvalid),
		.axi_awready(clint_axi_awready),
		// write data
		.axi_wvalid(clint_axi_wvalid),
		.axi_wready(clint_axi_wready),
		// response
		.axi_bready(clint_axi_bready),
		.axi_bvalid(clint_axi_bvalid),
		.axi_bresp(clint_axi_bresp),

		// axi读取的回应
		.axi_rresp(clint_axi_rresp),
		// axi读取的数据
		.axi_rdata(clint_axi_rdata),
		.axi_rlast(clint_axi_rlast)
	);

`endif

	// Icache
	wire			axi_arvalid_icache;
	wire			axi_arready_icache;
	wire [31:0]		axi_araddr_icache;
	wire			axi_rvalid_icache;
	wire			axi_rready_icache;
	wire [31:0]		axi_rdata_icache;
	wire [7:0]		axi_arlen_icache;
	wire [2:0]		axi_arsize_icache;
	wire [1:0]		axi_arburst_icache;
	wire 			axi_rlast_icache;
	wire			icache_hit;
	Icache u_icache (
        .clk            (clock), 				// 系统时钟
        .rst            (reset),				// 系统复位
        
		.fence_i_i		(is_fence_i_D),		// 是否刷新icache的cache块

        // CPU -> Icache接口
        .cpu_arvalid_i  (axi_arvalid_if),	 	// CPU地址有效
        .cpu_arready_o  (axi_arready_if), 		// Icache地址就绪
        .cpu_araddr_i   (axi_araddr_if), 		// 取指地址
        
        // Icache -> CPU接口
        .cpu_rvalid_o   (axi_rvalid_if),	 	// 指令数据有效
        .cpu_rready_i   (axi_rready_if),	 	// CPU接收就绪
        .cpu_rdata_o    (axi_rdata_if),			// 返回的指令数据
        
        // Icache -> AXI接口
        .axi_arvalid_o  (axi_arvalid_icache),   // 到AXI的地址有效
        .axi_arready_i  (axi_arready_icache),   // AXI地址就绪
        .axi_araddr_o   (axi_araddr_icache),	// AXI取指地址
		.axi_arlen_o	(axi_arlen_icache),
		.axi_arsize_o	(axi_arsize_icache),
		.axi_arburst_o	(axi_arburst_icache),
        
        // AXI -> Icache接口
        .axi_rvalid_i   (axi_rvalid_icache),    // AXI数据有效
        .axi_rready_o   (axi_rready_icache),    // Icache接收就绪
        .axi_rdata_i    (axi_rdata_icache),		// AXI返回的数据
		.axi_rlast_i	(axi_rlast_icache),
		.hit			(icache_hit),
		.icache_flush_done(icache_flush_done_CE)
    );


	// TAG：下面就是加入UART之后需要的，如果接入了其他的UART之后，就可以删除了。就是arbiter暴露给xbar的握手接口
	wire         m_axi_awvalid;
	wire         m_axi_awready;
	wire [31:0]  m_axi_awaddr;

	wire         m_axi_wvalid;
	wire         m_axi_wready;
	wire [31:0]  m_axi_wdata;

	wire         m_axi_bvalid;
	wire         m_axi_bready;
	wire [1:0]   m_axi_bresp;

	// 读通道
	wire         m_axi_arvalid;
	wire         m_axi_arready;
	wire [31:0]  m_axi_araddr;

	wire         m_axi_rvalid;
	wire         m_axi_rready;
	wire [31:0]  m_axi_rdata;
	wire [1:0]   m_axi_rresp;

	// AXI新增信号
	wire [7:0]	m_axi_arlen;
	wire [2:0]	m_axi_arsize;
	wire		m_axi_rlast;
	wire [7:0]	m_axi_awlen;
	wire [2:0]	m_axi_awsize;
	wire [3:0]	m_axi_wstrb;
	wire		m_axi_wlast;
	wire [1:0]	m_axi_addr_suffix;
	// Access Fault异常信号
	wire [1:0] 	Access_Fault;

	// 仲裁器
	ysyx_24100006_axi_arbiter arbiter(
		.clk(clock),
		.reset(reset),
		// TAG：没有使用的信号都暂时没有接入
		// ================== IFU接口 ==================
		// 读地址通道
		.ifu_axi_arvalid(axi_arvalid_icache),
		.ifu_axi_arready(axi_arready_icache),
		.ifu_axi_araddr(axi_araddr_icache),
		// 读数据通道
		.ifu_axi_rvalid(axi_rvalid_icache),
		.ifu_axi_rready(axi_rready_icache),
		.ifu_axi_rresp(axi_rresp_if),
		.ifu_axi_rdata(axi_rdata_icache),
		// AXI新增信号
		.ifu_axi_arlen(axi_arlen_icache),
		.ifu_axi_arsize(axi_arsize_icache),
		.ifu_axi_rlast(axi_rlast_icache),

		// ================== MEMU接口 ==================
		// 读地址通道
		.mem_axi_arvalid(axi_arvalid_mem),
		.mem_axi_arready(axi_arready_mem),
		.mem_axi_araddr(axi_araddr_mem),
		// 读数据通道
		.mem_axi_rvalid(axi_rvalid_mem),
		.mem_axi_rready(axi_rready_mem),
		.mem_axi_rresp(axi_rresp_mem),
		.mem_axi_rdata(axi_rdata_mem),
		// 写地址通道
		.mem_axi_awvalid(axi_awvalid_mem),
		.mem_axi_awready(axi_awready_mem),
		.mem_axi_awaddr(axi_awaddr_mem),
		// 写数据通道
		.mem_axi_wvalid(axi_wvalid_mem),
		.mem_axi_wready(axi_wready_mem),
		.mem_axi_wdata(axi_wdata_mem),
		// 写响应通道
		.mem_axi_bvalid(axi_bvalid_mem),
		.mem_axi_bready(axi_bready_mem),
		.mem_axi_bresp(axi_bresp_mem),
		// AXI新增信号
		.mem_axi_arlen(axi_arlen_mem),
		.mem_axi_arsize(axi_arsize_mem),
		.mem_axi_rlast(axi_rlast_mem),
		.mem_axi_awlen(axi_awlen_mem),
		.mem_axi_awsize(axi_awsize_mem),
		.mem_axi_wstrb(axi_wstrb_mem),
		.mem_axi_wlast(axi_wlast_mem),
		.mem_axi_addr_suffix(axi_addr_suffix_mem),
		// ================== SRAM接口 ==================
		// TAG：现在下面的连接的就是xbar了
		// 读地址通道
		.sram_axi_arvalid(m_axi_arvalid),
		.sram_axi_arready(m_axi_arready),
		.sram_axi_araddr(m_axi_araddr),
		// 读数据通道
		.sram_axi_rvalid(m_axi_rvalid),
		.sram_axi_rready(m_axi_rready),
		.sram_axi_rresp(m_axi_rresp),
		.sram_axi_rdata(m_axi_rdata),
		// 写地址通道
		.sram_axi_awvalid(m_axi_awvalid),
		.sram_axi_awready(m_axi_awready),
		.sram_axi_awaddr(m_axi_awaddr),
		// 写数据通道
		.sram_axi_wvalid(m_axi_wvalid),
		.sram_axi_wready(m_axi_wready),
		.sram_axi_wdata(m_axi_wdata),
		// 写响应通道
		.sram_axi_bvalid(m_axi_bvalid),
		.sram_axi_bready(m_axi_bready),
		.sram_axi_bresp(m_axi_bresp),

		// AXI新增信号
		.sram_axi_arlen(m_axi_arlen),
		.sram_axi_arsize(m_axi_arsize),
		.sram_axi_rlast(m_axi_rlast),
		.sram_axi_awlen(m_axi_awlen),
		.sram_axi_awsize(m_axi_awsize),
		.sram_axi_wstrb(m_axi_wstrb),
		.sram_axi_wlast(m_axi_wlast),
		.sram_axi_addr_suffix(m_axi_addr_suffix)
	);

`ifndef NPC
	// YSYXSOC使用的axi模块和xbar模块
	ysyx_24100006_axi #(
		.AXI_DATA_WIDTH    (32),
		.AXI_ADDR_WIDTH    (32),
		.AXI_ID_WIDTH      (4),
		.AXI_STRB_WIDTH    (4),
		.AXI_RESP_WIDTH    (2),
		.AXI_LEN_WIDTH     (8),
		.AXI_SIZE_WIDTH    (3),
		.AXI_BURST_WIDTH   (2)
	) axi4_inst (
		// 全局信号
		.clk                      (clock),
		.reset                    (reset),
		
		//-----------------------------
		// 用户侧接口 (CPU侧)
		//-----------------------------
		// 读地址通道
		.axi_arvalid_i            (sram_axi_arvalid),
		.axi_arready_o            (sram_axi_arready),
		.axi_araddr_i             (sram_axi_araddr),
		
		// 读数据通道
		.axi_rvalid_o             (sram_axi_rvalid),
		.axi_rready_i             (sram_axi_rready),
		.axi_rresp_o              (sram_axi_rresp),
		.axi_rdata_o              (sram_axi_rdata),
		
		// 写地址通道
		.axi_awvalid_i            (sram_axi_awvalid),
		.axi_awready_o            (sram_axi_awready),
		.axi_awaddr_i             (sram_axi_awaddr),
		
		// 写数据通道
		.axi_wvalid_i             (sram_axi_wvalid),
		.axi_wready_o             (sram_axi_wready),
		.axi_wdata_i              (sram_axi_wdata),
		.axi_wstrb_i              (sram_axi_wstrb),
		
		// 写响应通道
		.axi_bvalid_o             (sram_axi_bvalid),
		.axi_bready_i             (sram_axi_bready),
		.axi_bresp_o              (sram_axi_bresp),
		
		// 突发配置
		.axi_arlen_i              (sram_axi_arlen),
		.axi_awlen_i              (sram_axi_awlen),
		.axi_arsize_i             (sram_axi_arsize),
		.axi_awsize_i             (sram_axi_awsize),
		.axi_rlast_o              (sram_axi_rlast),
		.axi_wlast_o              (sram_axi_wlast),
		
		//-----------------------------
		// AXI4主设备接口 (物理总线侧)
		//-----------------------------
		// 写地址通道
		.io_master_awready_i      (io_master_awready),
		.io_master_awvalid_o      (io_master_awvalid),
		.io_master_awaddr_o       (io_master_awaddr),
		.io_master_awid_o         (io_master_awid),          	// 无对应信号，强制置零
		.io_master_awlen_o        (io_master_awlen),
		.io_master_awsize_o       (io_master_awsize),
		.io_master_awburst_o      (io_master_awburst),			// 无对应信号，强制置零
		
		// 写数据通道
		.io_master_wready_i       (io_master_wready),
		.io_master_wvalid_o       (io_master_wvalid),
		.io_master_wdata_o        (io_master_wdata),
		.io_master_wstrb_o        (io_master_wstrb),
		.io_master_wlast_o        (io_master_wlast),
		
		// 写响应通道
		.io_master_bready_o       (io_master_bready),
		.io_master_bvalid_i       (io_master_bvalid),
		.io_master_bresp_i        (io_master_bresp),
		.io_master_bid_i          (io_master_bid),          	// 无对应信号，强制置零
		
		// 读地址通道
		.io_master_arready_i      (io_master_arready),
		.io_master_arvalid_o      (io_master_arvalid),
		.io_master_araddr_o       (io_master_araddr),
		.io_master_arid_o         (io_master_arid),          	// 无对应信号，强制置零
		.io_master_arlen_o        (io_master_arlen),
		.io_master_arsize_o       (io_master_arsize),
		.io_master_arburst_o      (io_master_arburst),          // 无对应信号，强制置零
		
		// 读数据通道
		.io_master_rready_o       (io_master_rready),
		.io_master_rvalid_i       (io_master_rvalid),
		.io_master_rresp_i        (io_master_rresp),
		.io_master_rdata_i        (io_master_rdata),
		.io_master_rlast_i        (io_master_rlast),
		.io_master_rid_i          (io_master_rid)           	// 无对应信号，强制置零
	);

	ysyx_24100006_axi_xbar xbar (
		// 时钟和复位
		.clk(clock),
		.reset(reset),
		
		// 主设备接口 (写通道)
		.m_axi_awvalid(m_axi_awvalid),
		.m_axi_awready(m_axi_awready),
		.m_axi_awaddr(m_axi_awaddr),
		
		.m_axi_wvalid(m_axi_wvalid),
		.m_axi_wready(m_axi_wready),
		.m_axi_wdata(m_axi_wdata),
		
		.m_axi_bvalid(m_axi_bvalid),
		.m_axi_bready(m_axi_bready),
		.m_axi_bresp(m_axi_bresp),

		// 主设备接口 (读通道)
		.m_axi_arvalid(m_axi_arvalid),
		.m_axi_arready(m_axi_arready),
		.m_axi_araddr(m_axi_araddr),
		
		.m_axi_rvalid(m_axi_rvalid),
		.m_axi_rready(m_axi_rready),
		.m_axi_rdata(m_axi_rdata),
		.m_axi_rresp(m_axi_rresp),

		// AXI新增信号
		.m_axi_arlen(m_axi_arlen),
		.m_axi_arsize(m_axi_arsize),
		.m_axi_rlast(m_axi_rlast),
		.m_axi_awlen(m_axi_awlen),
		.m_axi_awsize(m_axi_awsize),
		.m_axi_wstrb(m_axi_wstrb),
		.m_axi_wlast(m_axi_wlast),

		.m_addr_suffix(m_axi_addr_suffix),
		

		// SRAM 从设备接口 (写通道)
		.sram_axi_awvalid(sram_axi_awvalid),
		.sram_axi_awready(sram_axi_awready),
		.sram_axi_awaddr(sram_axi_awaddr),
		
		.sram_axi_wvalid(sram_axi_wvalid),
		.sram_axi_wready(sram_axi_wready),
		.sram_axi_wdata(sram_axi_wdata),
		
		.sram_axi_bvalid(sram_axi_bvalid),
		.sram_axi_bready(sram_axi_bready),
		.sram_axi_bresp(sram_axi_bresp),

		// SRAM 从设备接口 (读通道)
		.sram_axi_arvalid(sram_axi_arvalid),
		.sram_axi_arready(sram_axi_arready),
		.sram_axi_araddr(sram_axi_araddr),
		
		.sram_axi_rvalid(sram_axi_rvalid),
		.sram_axi_rready(sram_axi_rready),
		.sram_axi_rdata(sram_axi_rdata),
		.sram_axi_rresp(sram_axi_rresp),

		// AXI新增信号
		.sram_axi_arlen(sram_axi_arlen),
		.sram_axi_arsize(sram_axi_arsize),
		.sram_axi_rlast(sram_axi_rlast),
		.sram_axi_awlen(sram_axi_awlen),
		.sram_axi_awsize(sram_axi_awsize),
		.sram_axi_wstrb(sram_axi_wstrb),
		.sram_axi_wlast(sram_axi_wlast),

		// CLINT 从设备接口 (写通道)
		.clint_axi_awvalid(clint_axi_awvalid),
		.clint_axi_awready(clint_axi_awready),
		.clint_axi_awaddr(clint_axi_awaddr),
		
		.clint_axi_wvalid(clint_axi_wvalid),
		.clint_axi_wready(clint_axi_wready),
		.clint_axi_wdata(clint_axi_wdata),
		
		.clint_axi_bvalid(clint_axi_bvalid),
		.clint_axi_bready(clint_axi_bready),
		.clint_axi_bresp(clint_axi_bresp),

		// CLINT 从设备接口 (读通道)
		.clint_axi_arvalid(clint_axi_arvalid),
		.clint_axi_arready(clint_axi_arready),
		.clint_axi_araddr(clint_axi_araddr),
		
		.clint_axi_rvalid(clint_axi_rvalid),
		.clint_axi_rready(clint_axi_rready),
		.clint_axi_rdata(clint_axi_rdata),
		.clint_axi_rresp(clint_axi_rresp),
		.clint_axi_rlast(clint_axi_rlast),

		// Access Fault异常
		.Access_Fault(Access_Fault)
	);

`else
	// 为NPC定义的xbar
	ysyx_24100006_axi_xbar xbar (
		// 时钟和复位
		.clk(clock),
		.reset(reset),
		
		// 主设备接口 (写通道)
		.m_axi_awvalid(m_axi_awvalid),
		.m_axi_awready(m_axi_awready),
		.m_axi_awaddr(m_axi_awaddr),
		
		.m_axi_wvalid(m_axi_wvalid),
		.m_axi_wready(m_axi_wready),
		.m_axi_wdata(m_axi_wdata),
		
		.m_axi_bvalid(m_axi_bvalid),
		.m_axi_bready(m_axi_bready),
		.m_axi_bresp(m_axi_bresp),

		// 主设备接口 (读通道)
		.m_axi_arvalid(m_axi_arvalid),
		.m_axi_arready(m_axi_arready),
		.m_axi_araddr(m_axi_araddr),
		
		.m_axi_rvalid(m_axi_rvalid),
		.m_axi_rready(m_axi_rready),
		.m_axi_rdata(m_axi_rdata),
		.m_axi_rresp(m_axi_rresp),

		// AXI新增信号
		.m_axi_arlen(m_axi_arlen),
		.m_axi_arsize(m_axi_arsize),
		.m_axi_rlast(m_axi_rlast),
		.m_axi_awlen(m_axi_awlen),
		.m_axi_awsize(m_axi_awsize),
		.m_axi_wstrb(m_axi_wstrb),
		.m_axi_wlast(m_axi_wlast),

		.m_addr_suffix(m_axi_addr_suffix),
		

		// SRAM 从设备接口 (写通道)
		.sram_axi_awvalid(sram_axi_awvalid),
		.sram_axi_awready(sram_axi_awready),
		.sram_axi_awaddr(sram_axi_awaddr),
		
		.sram_axi_wvalid(sram_axi_wvalid),
		.sram_axi_wready(sram_axi_wready),
		.sram_axi_wdata(sram_axi_wdata),
		
		.sram_axi_bvalid(sram_axi_bvalid),
		.sram_axi_bready(sram_axi_bready),
		.sram_axi_bresp(sram_axi_bresp),

		// SRAM 从设备接口 (读通道)
		.sram_axi_arvalid(sram_axi_arvalid),
		.sram_axi_arready(sram_axi_arready),
		.sram_axi_araddr(sram_axi_araddr),
		
		.sram_axi_rvalid(sram_axi_rvalid),
		.sram_axi_rready(sram_axi_rready),
		.sram_axi_rdata(sram_axi_rdata),
		.sram_axi_rresp(sram_axi_rresp),

		// AXI新增信号
		.sram_axi_arlen(sram_axi_arlen),
		.sram_axi_arsize(sram_axi_arsize),
		.sram_axi_rlast(sram_axi_rlast),
		.sram_axi_awlen(sram_axi_awlen),
		.sram_axi_awsize(sram_axi_awsize),
		.sram_axi_wstrb(sram_axi_wstrb),
		.sram_axi_wlast(sram_axi_wlast),

		// UART 从设备接口 (写通道)
		.uart_axi_awvalid(uart_axi_awvalid),
		.uart_axi_awready(uart_axi_awready),
		.uart_axi_awaddr(uart_axi_awaddr),
		
		.uart_axi_wvalid(uart_axi_wvalid),
		.uart_axi_wready(uart_axi_wready),
		.uart_axi_wdata(uart_axi_wdata),
		.uart_axi_wstrb(uart_axi_wstrb),
		
		.uart_axi_bvalid(uart_axi_bvalid),
		.uart_axi_bready(uart_axi_bready),
		.uart_axi_bresp(uart_axi_bresp),

		// UART 从设备接口 (读通道)
		.uart_axi_arvalid(uart_axi_arvalid),
		.uart_axi_arready(uart_axi_arready),
		.uart_axi_araddr(uart_axi_araddr),
		
		.uart_axi_rvalid(uart_axi_rvalid),
		.uart_axi_rready(uart_axi_rready),
		.uart_axi_rdata(uart_axi_rdata),
		.uart_axi_rresp(uart_axi_rresp),

		// CLINT 从设备接口 (写通道)
		.clint_axi_awvalid(clint_axi_awvalid),
		.clint_axi_awready(clint_axi_awready),
		.clint_axi_awaddr(clint_axi_awaddr),
		
		.clint_axi_wvalid(clint_axi_wvalid),
		.clint_axi_wready(clint_axi_wready),
		.clint_axi_wdata(clint_axi_wdata),
		
		.clint_axi_bvalid(clint_axi_bvalid),
		.clint_axi_bready(clint_axi_bready),
		.clint_axi_bresp(clint_axi_bresp),

		// CLINT 从设备接口 (读通道)
		.clint_axi_arvalid(clint_axi_arvalid),
		.clint_axi_arready(clint_axi_arready),
		.clint_axi_araddr(clint_axi_araddr),
		
		.clint_axi_rvalid(clint_axi_rvalid),
		.clint_axi_rready(clint_axi_rready),
		.clint_axi_rdata(clint_axi_rdata),
		.clint_axi_rresp(clint_axi_rresp),
		.clint_axi_rlast(clint_axi_rlast),

		// Access Fault异常
		.Access_Fault(Access_Fault)
	);

`endif

// 这是为了diff test而加的npc信号
wire [31:0] npc_M, npc_E_old, npc_E_M, npc_M_W, npc_W;

	// 前递单元
	wire		exe_is_load;
	wire		exe_mem_is_load;
	wire [1:0] 	forwardA, forwardB;
	wire [31:0] exe_fw_data, mem_fw_data;

	// TAG:pipeline Reg
	// IF_ID 模块实例化
	ysyx_24100006_IF_ID u_IF_ID (
		.clk            	(clock),
		.reset          	(reset),
		.flush_i        	(redirect_valid_E_F || irq_WD || (is_fence_i_D && !icache_flush_done_CE)),   // 当是跳转指令或者发生异常时冲刷
		.in_valid       	(if_in_valid),		// 来自IFU
		.in_ready       	(if_in_ready),		// 输出到IFU
		.pc_i           	(pc_F),         	// IF阶段PC输入
		.instruction_i  	(inst_F),			// IF阶段指令输入

		.out_valid      	(id_out_valid),		// 输出到IDU
		.out_ready      	(id_out_ready),		// 来自IDU
		.pc_o           	(pc_F_D),       	// 输出到ID阶段
		.instruction_o  	(instruction_F_D)	// 输出到ID阶段

		// 异常处理相关
		,.irq_i(irq_F)
		,.irq_no_i(irq_no_F)
    	,.irq_o(irq_F_D)
		,.irq_no_o(irq_no_F_D)
	);

	// ID_EXE 模块实例化
	ysyx_24100006_ID_EXE u_ID_EXE (
		.clk            	(clock),
		.reset          	(reset),
		.flush_i        	(redirect_valid_E_F || irq_WD),   // 当是跳转指令或者发生异常时冲刷
		.is_break_i     	(is_break_D),     			// 是否是断点指令
		.is_break_o     	(is_break_D_E),   			// 输出到EXEU

		.in_valid       	(id_in_valid),		// 来自IDU
		.in_ready       	(id_in_ready),		// 输出到IDU
		.pc_i           	(pc_D),         	// ID阶段PC输入
		.sext_imm_i     	(sext_imm_D),
		.rs1_data_i     	(rs1_data_D),
		.rs2_data_i     	(rs2_data_D),
		.rdata_csr_i    	(rdata_csr_D),
		.alu_op_i       	(alu_op_D),
		.Gpr_Write_Addr_i	(Gpr_Write_Addr_D),
		.Csr_Write_Addr_i	(Csr_Write_Addr_D),
		.Gpr_Write_RD_i 	(Gpr_Write_RD_D),
		.Csr_Write_RD_i 	(Csr_Write_RD_D),
		.Jump_i         	(Jump_D),
		.Mem_WMask_i    	(Mem_WMask_D),
		.Mem_RMask_i    	(Mem_RMask_D),
		.irq_no_i       	(irq_no_D),
		.mtvec_i        	(mtvec_D),
		.mepc_i         	(mepc_D),
		.is_fence_i_i   	(is_fence_i_D),
		.irq_i          	(irq_D),
		.AluSrcA_i      	(AluSrcA_D),
		.AluSrcB_i			(AluSrcB_D),
		.Gpr_Write_i    	(Gpr_Write_D),
		.Csr_Write_i    	(Csr_Write_D),
		.sram_read_write_i 	(sram_read_write_D),

		.out_valid      	(exe_out_valid),    	// 输出到EXEU
		.out_ready      	(exe_out_ready),    	// 来自EXEU
		.pc_o           	(pc_D_E),
		.sext_imm_o     	(sext_imm_D_E),
		.rs1_data_o     	(rs1_data_D_E),
		.rs2_data_o     	(rs2_data_D_E),
		.rdata_csr_o    	(rdata_csr_D_E),
		.alu_op_o       	(alu_op_D_E),
		.Gpr_Write_Addr_o	(Gpr_Write_Addr_D_E),
		.Csr_Write_Addr_o	(Csr_Write_Addr_D_E),
		.Gpr_Write_RD_o 	(Gpr_Write_RD_D_E),
		.Csr_Write_RD_o 	(Csr_Write_RD_D_E),
		.Jump_o         	(Jump_D_E),
		.Mem_WMask_o    	(Mem_WMask_D_E),
		.Mem_RMask_o    	(Mem_RMask_D_E),
		.irq_no_o       	(irq_no_D_E),
		.mtvec_o        	(mtvec_D_E),
		.mepc_o         	(mepc_D_E),
		.is_fence_i_o   	(is_fence_i_D_E),
		.irq_o          	(irq_D_E),
		.AluSrcA_o      	(AluSrcA_D_E),
		.AluSrcB_o			(AluSrcB_D_E),
		.Gpr_Write_o    	(Gpr_Write_D_E),
		.Csr_Write_o    	(Csr_Write_D_E),
		.sram_read_write_o 	(sram_read_write_D_E)
	);

	// EXE_MEM 模块实例化
	ysyx_24100006_EXE_MEM u_EXE_MEM (
		.clk            	(clock),
		.reset          	(reset),
// 调试信息
.npc_E(npc_E_old),
.npc_M(npc_E_M),

		.flush_i        	(irq_WD),   // 发生异常时需要冲刷流水线

		.is_break_i     	(is_break_E),     			// 是否是断点指令
		.is_break_o     	(is_break_E_M),   			// 输出到MEMU

		.in_valid       	(exe_in_valid), 	// 来自EXEU
		.in_ready       	(exe_in_ready),     // 输出到EXEU
		.pc_i           	(pc_E),
		.npc_i          	(npc_E),
		.redirect_valid_i	(redirect_valid_E),
		.alu_result_i   	(alu_result_E),
		.sext_imm_i     	(sext_imm_E),
		.rs1_data_i     	(rs1_data_E),
		.rs2_data_i     	(rs2_data_E),
		.rdata_csr_i     	(rdata_csr_E),
		.Gpr_Write_Addr_i	(Gpr_Write_Addr_E),
		.Csr_Write_Addr_i	(Csr_Write_Addr_E),
		.Gpr_Write_RD_i 	(Gpr_Write_RD_E),
		.Csr_Write_RD_i 	(Csr_Write_RD_E),
		.Mem_WMask_i    	(Mem_WMask_E),
		.Mem_RMask_i    	(Mem_RMask_E),
		.irq_no_i       	(irq_no_E),
		.irq_i          	(irq_E),
		.Gpr_Write_i    	(Gpr_Write_E),
		.Csr_Write_i    	(Csr_Write_E),
		.sram_read_write_i 	(sram_read_write_E),

		.out_valid      	(mem_out_valid),    	// 输出到MEMU
		.out_ready      	(mem_out_ready),    	// 来自MEMU
		.pc_o           	(pc_E_M),
		.npc_o          	(npc_E_F),
		.redirect_valid_o	(redirect_valid_E_F),
		.alu_result_o   	(alu_result_E_M),
		.sext_imm_o     	(sext_imm_E_M),
		.rs1_data_o     	(rs1_data_E_M),
		.rs2_data_o     	(rs2_data_E_M),
		.rdata_csr_o     	(rdata_csr_E_M),
		.Gpr_Write_Addr_o	(Gpr_Write_Addr_E_M),
		.Csr_Write_Addr_o	(Csr_Write_Addr_E_M),
		.Gpr_Write_RD_o 	(Gpr_Write_RD_E_M),
		.Csr_Write_RD_o 	(Csr_Write_RD_E_M),
		.Mem_WMask_o    	(Mem_WMask_E_M),
		.Mem_RMask_o    	(Mem_RMask_E_M),
		.irq_no_o       	(irq_no_E_M),
		.irq_o          	(irq_E_M),
		.Gpr_Write_o    	(Gpr_Write_E_M),
		.Csr_Write_o    	(Csr_Write_E_M),
		.sram_read_write_o 	(sram_read_write_E_M)
	);

	// MEM_WB 模块实例化
	ysyx_24100006_MEM_WB u_MEM_WB (
		.clk            	(clock),
		.reset          	(reset),
// 调试信息
.npc_M(npc_M),
.npc_W(npc_M_W),

		.flush_i        	(irq_WD),   // 发生异常时需要冲刷流水线

		.is_break_i     	(is_break_M),     			// 是否是断点指令
		.is_break_o     	(is_break_M_W),   			// 输出到WBU

		.in_valid       	(mem_in_valid),     // 来自MEMU
		.in_ready       	(mem_in_ready),     // 输出到MEMU
		.pc_i           	(pc_M),
		.alu_result_i   	(alu_result_M),
		.sext_imm_i     	(sext_imm_M),
		.Mem_rdata_i    	(Mem_rdata_M),
		.rs1_data_i     	(rs1_data_M),
		.rdata_csr_i    	(rdata_csr_M),
		.Gpr_Write_Addr_i	(Gpr_Write_Addr_M),
		.Csr_Write_Addr_i	(Csr_Write_Addr_M),
		.Gpr_Write_RD_i 	(Gpr_Write_RD_M),
		.Csr_Write_RD_i 	(Csr_Write_RD_M),
		.irq_no_i       	(irq_no_M),
		.irq_i          	(irq_M),
		.Gpr_Write_i    	(Gpr_Write_M),
		.Csr_Write_i    	(Csr_Write_M),

		.out_valid      	(wb_out_valid),			// 输出到WBU
		.out_ready      	(wb_out_ready),    		// 来自WBU
		.pc_o           	(pc_M_W),
		.alu_result_o   	(alu_result_M_W),
		.sext_imm_o     	(sext_imm_M_W),
		.Mem_rdata_o    	(Mem_rdata_M_W),
		.rs1_data_o     	(rs1_data_M_W),
		.rdata_csr_o    	(rdata_csr_M_W),
		.Gpr_Write_Addr_o	(Gpr_Write_Addr_M_W),
		.Csr_Write_Addr_o	(Csr_Write_Addr_M_W),
		.Gpr_Write_RD_o 	(Gpr_Write_RD_M_W),
		.Csr_Write_RD_o 	(Csr_Write_RD_M_W),
		.irq_no_o       	(irq_no_M_W),
		.irq_o          	(irq_M_W),
		.Gpr_Write_o    	(Gpr_Write_M_W),
		.Csr_Write_o    	(Csr_Write_M_W)
	);
	
	ysyx_24100006_hazard u_hazard(
		// ID 当前指令寄存器号：使用 IF_ID 之后、IDU 看到的那条指令
		.id_rs1        	(instruction_F_D[18:15]),
		.id_rs2        	(instruction_F_D[23:20]),
		.id_rs1_ren    	(rs1_ren_D),   // 来自 IDU 新增输出
		.id_rs2_ren    	(rs2_ren_D),
		.id_rd			(Gpr_Write_Addr_D),
		.id_wen			(Gpr_Write_D),
		.id_out_valid	(id_out_valid),
		.is_load		(is_load),
		// EX 阶段（忙判断：exe_out_valid | ~exe_out_ready）
		.ex_out_valid	(exe_in_valid),
		.ex_out_ready   (exe_in_ready),
		.ex_rd         	(Gpr_Write_Addr_E),
		.ex_wen        	(Gpr_Write_E),

		// MEM 阶段（忙判断：mem_out_valid | ~mem_out_ready）
		.mem_out_valid 	(mem_in_valid),
		.mem_out_ready 	(mem_out_ready),
		.mem_rd        	(Gpr_Write_Addr_M),
		.mem_wen       	(Gpr_Write_M),

		.mem_stage_wen	(Gpr_Write_E_M),
		.mem_stage_rd	(Gpr_Write_Addr_E_M),
		.mem_in_valid	(mem_out_valid),
		.mem_stage_out_valid(Gpr_Write_M),
		// WB 阶段（忙判断：wb_out_valid | ~wb_out_ready）
		.wb_out_valid   (wb_in_valid),
		.wb_out_ready   (wb_in_ready),
		.wb_rd         	(Gpr_Write_Addr_WD),
		.wb_wen        	(Gpr_Write_WD),

		.stall_id      	(stall_id)

		// 前递单元设计
		,.clk(clock)
		,.exe_mem_is_load(exe_mem_is_load)
		,.exe_is_load	(exe_is_load)
		,.mem_rvalid	(axi_rvalid_mem)
		,.forwardA      (forwardA)
		,.forwardB      (forwardB)
	);



	ysyx_24100006_ifu IF(
		.clk(clock),
		.reset(reset),
		// 直接将 hazard 的 stall 信号给 IFU：
		.stall_id(stall_id),

		.is_fence_i(is_fence_i_D),
		.icache_flush_done(icache_flush_done_CE),

		.redirect_valid(redirect_valid_E_F),
		.npc(npc_E_F),
		// AXI 接口信号
		// read data addr
		.axi_araddr(axi_araddr_if),
		.axi_arready(axi_arready_if),
		.axi_arvalid(axi_arvalid_if),
		// read data
		.axi_rvalid(axi_rvalid_if),
		.axi_rready(axi_rready_if),
		.axi_rdata(axi_rdata_if),
		// write data addr
		.axi_awvalid(axi_awvalid_if),
		.axi_awready(axi_awready_if),
		// write data
		.axi_wvalid(axi_wvalid_if),
		.axi_wready(axi_wready_if),
		// response
		.axi_bvalid(axi_bvalid_if),
		.axi_bready(axi_bready_if),
		// 新增AXI信号
		.axi_arlen(axi_arlen_if),
		.axi_arsize(axi_arsize_if),
		.axi_rlast(axi_rlast_if),
		// 模块握手信号
		.if_in_valid(if_in_valid),
		.if_in_ready(if_in_ready),


		.pc_F(pc_F),
		.inst_F(inst_F),

		// Access Fault异常
		.Access_Fault(Access_Fault)

		// 异常处理相关
		,.csr_mtvec(mtvec_D)
		,.EXC(irq_WD)
		,.irq(irq_F)
		,.irq_no(irq_no_F)
	);
	
	ysyx_24100006_idu ID(
		.clk(clock),
		.reset(reset),

		.stall_id(stall_id),

		.instruction(instruction_F_D),
		.pc_D(pc_F_D),
		.irq_W(irq_WD),
		.irq_no_W(irq_no_WD),
		.Gpr_Write_Addr_W(Gpr_Write_Addr_WD),
		.Csr_Write_Addr_W(Csr_Write_Addr_WD),
		.Gpr_Write_W(Gpr_Write_WD),
		.Csr_Write_W(Csr_Write_WD),
		.wdata_gpr_W(wdata_gpr_WD),
		.wdata_csr_W(wdata_csr_WD),
		
		.id_out_valid(id_out_valid),
		.id_out_ready(id_out_ready),
		.id_in_valid(id_in_valid),
		.id_in_ready(id_in_ready),

		.rs1_ren(rs1_ren_D),
		.rs2_ren(rs2_ren_D),
		.is_break(is_break_D),

		.pc_E(pc_D),
		.sext_imm(sext_imm_D),
		.rs1_data(rs1_data_D),
		.rs2_data(rs2_data_D),
		.rdata_csr(rdata_csr_D),
		.is_fence_i(is_fence_i_D),
		.aluop(alu_op_D),
		.AluSrcA(AluSrcA_D),
		.AluSrcB(AluSrcB_D),
		.Gpr_Write_E(Gpr_Write_D),
		.Csr_Write_E(Csr_Write_D),
		.Gpr_Write_Addr(Gpr_Write_Addr_D),
		.Csr_Write_Addr(Csr_Write_Addr_D),
		.Gpr_Write_RD(Gpr_Write_RD_D),
		.Csr_Write_RD(Csr_Write_RD_D),
		.Jump(Jump_D),
		.Mem_WMask(Mem_WMask_D),
		.Mem_RMask(Mem_RMask_D),
		.sram_read_write(sram_read_write_D),
		.mtvec(mtvec_D),
		.mepc(mepc_D)

		// 异常处理相关
		,.irq_F(irq_F_D)
		,.irq_no_F(irq_no_F_D)
		,.irq_D(irq_D)
		,.irq_no_D(irq_no_D)

		// 前递单元设计
		,.forwardA(forwardA)
		,.forwardB(forwardB)
		,.exe_fw_data(exe_fw_data)
		,.mem_fw_data(mem_fw_data)
		,.wb_fw_data(wdata_gpr_WD)
	);

	ysyx_24100006_exeu EXE(
		.clk(clock),
		.reset(reset),

		.icache_flush_done(icache_flush_done_CE),
		.is_break_i(is_break_D_E), // 是否是断点指令
		.is_break_o(is_break_E),

		.pc_E(pc_D_E),
		.sext_imm_E(sext_imm_D_E),
		.rs1_data_E(rs1_data_D_E),
		.rs2_data_E(rs2_data_D_E),
		.rdata_csr_E(rdata_csr_D_E),
		.mtvec(mtvec_D_E),
		.mepc(mepc_D_E),
		.is_fence_i(is_fence_i_D_E),
		.irq_E(irq_D_E),
		.irq_no_E(irq_no_D_E),
		.aluop(alu_op_D_E),
		.AluSrcA(AluSrcA_D_E),
		.AluSrcB(AluSrcB_D_E),
		.Jump(Jump_D_E),
		.Gpr_Write_E(Gpr_Write_D_E),
		.Csr_Write_E(Csr_Write_D_E),
		.Gpr_Write_Addr_E(Gpr_Write_Addr_D_E),
		.Csr_Write_Addr_E(Csr_Write_Addr_D_E),
		.Gpr_Write_RD_E(Gpr_Write_RD_D_E),
		.Csr_Write_RD_E(Csr_Write_RD_D_E),
		.Mem_WMask_E(Mem_WMask_D_E),
		.Mem_RMask_E(Mem_RMask_D_E),
		.sram_read_write_E(sram_read_write_D_E),

		.exe_out_valid(exe_out_valid),
		.exe_out_ready(exe_out_ready),
		.exe_in_valid(exe_in_valid),
		.exe_in_ready(exe_in_ready),

		.npc_E(npc_E),
		.redirect_valid(redirect_valid_E),

		.pc_M(pc_E),
		.alu_result(alu_result_E),
		.sext_imm_M(sext_imm_E),
		.rs1_data_M(rs1_data_E),
		.rs2_data_M(rs2_data_E),
		.rdata_csr_M(rdata_csr_E),
		.irq_M(irq_E),
		.irq_no_M(irq_no_E),
		.Gpr_Write_M(Gpr_Write_E),
		.Csr_Write_M(Csr_Write_E),
		.Gpr_Write_Addr_M(Gpr_Write_Addr_E),
		.Csr_Write_Addr_M(Csr_Write_Addr_E),
		.Gpr_Write_RD_M(Gpr_Write_RD_E),
		.Csr_Write_RD_M(Csr_Write_RD_E),
		.Mem_WMask_M(Mem_WMask_E),
		.Mem_RMask_M(Mem_RMask_E),
		.sram_read_write_M(sram_read_write_E)

		// 前递单元设计
		,.exe_is_load(exe_is_load)
		,.exe_fw_data(exe_fw_data)
	);

	ysyx_24100006_memu MEM(
		.clk(clock),
		.reset(reset),
// 调试信息
.npc_E(npc_E_M),
.npc_M(npc_M),

		.is_break_i(is_break_E_M), // 是否是断点指令
		.is_break_o(is_break_M),

		.sram_read_write(sram_read_write_E_M),
		.pc_M(pc_E_M),
		.alu_result_M(alu_result_E_M),
		.sext_imm_M(sext_imm_E_M),
		.rs1_data_M(rs1_data_E_M),
		.rs2_data_M(rs2_data_E_M),
		.rdata_csr_M(rdata_csr_E_M),

		.irq_M(irq_E_M),
		.irq_no_M(irq_no_E_M),
		.Gpr_Write_M(Gpr_Write_E_M),
		.Csr_Write_M(Csr_Write_E_M),
		.Gpr_Write_Addr_M(Gpr_Write_Addr_E_M),
		.Csr_Write_Addr_M(Csr_Write_Addr_E_M),
		.Gpr_Write_RD_M(Gpr_Write_RD_E_M),
		.Csr_Write_RD_M(Csr_Write_RD_E_M),
		.Mem_WMask_M(Mem_WMask_E_M),
		.Mem_RMask_M(Mem_RMask_E_M),

		// AXI 接口信号
		// read data addr
		.axi_araddr(axi_araddr_mem),
		.axi_arready(axi_arready_mem),
		.axi_arvalid(axi_arvalid_mem),
		// read data
		.axi_rdata(axi_rdata_mem),
		.axi_rvalid(axi_rvalid_mem),
		.axi_rready(axi_rready_mem),
		// write data addr
		.axi_awaddr(axi_awaddr_mem),
		.axi_awvalid(axi_awvalid_mem),
		.axi_awready(axi_awready_mem),
		// write data
		.axi_wvalid(axi_wvalid_mem),
		.axi_wdata(axi_wdata_mem),
		.axi_wready(axi_wready_mem),
		// response
		.axi_bvalid(axi_bvalid_mem),
		.axi_bready(axi_bready_mem),
		.axi_bresp(axi_bresp_mem),
		// 新增AXI信号
		.axi_arlen(axi_arlen_mem),
		.axi_arsize(axi_arsize_mem),
		.axi_rlast(axi_rlast_mem),
		.axi_awlen(axi_awlen_mem),
		.axi_awsize(axi_awsize_mem),
		.axi_wstrb(axi_wstrb_mem),
		.axi_wlast(axi_wlast_mem),
		.axi_addr_suffix(axi_addr_suffix_mem),

		// 模块握手信号
		.mem_out_valid(mem_out_valid),
		.mem_out_ready(mem_out_ready),
		.mem_in_valid(mem_in_valid),
		.mem_in_ready(mem_in_ready),
		.is_load(is_load),
		.pc_W(pc_M),
		.sext_imm_W(sext_imm_M),
		.alu_result_W(alu_result_M),
		.rs1_data_W(rs1_data_M),
		.rdata_csr_W(rdata_csr_M),
		.Mem_rdata_extend(Mem_rdata_M),
		.irq_W(irq_M),
		.irq_no_W(irq_no_M),
		.Gpr_Write_W(Gpr_Write_M),
		.Csr_Write_W(Csr_Write_M),
		.Gpr_Write_Addr_W(Gpr_Write_Addr_M),
		.Csr_Write_Addr_W(Csr_Write_Addr_M),
		.Gpr_Write_RD_W(Gpr_Write_RD_M),
		.Csr_Write_RD_W(Csr_Write_RD_M)

		// 前递单元设计
		// ,.mem_is_load(mem_is_load)
		,.exe_mem_is_load(exe_mem_is_load)
		,.mem_fw_data(mem_fw_data)
	);

	ysyx_24100006_wbu WB(
		.clk(clock),
		.reset(reset),
		
		.is_break_i(is_break_M_W), // 是否是断点指令

		.pc_w(pc_M_W),
		.sext_imm(sext_imm_M_W),
		.alu_result(alu_result_M_W),
		.Mem_rdata_extend(Mem_rdata_M_W),
		.rdata_csr(rdata_csr_M_W),
		.rs1_data(rs1_data_M_W),
		.irq_W(irq_M_W),
		.irq_no_W(irq_no_M_W),
		.Gpr_Write(Gpr_Write_M_W),
		.Csr_Write(Csr_Write_M_W),
		.Gpr_Write_Addr(Gpr_Write_Addr_M_W),
		.Csr_Write_Addr(Csr_Write_Addr_M_W),
		.Gpr_Write_RD(Gpr_Write_RD_M_W),
		.Csr_Write_RD(Csr_Write_RD_M_W),
		
		.wb_out_valid(wb_out_valid),
		.wb_out_ready(wb_out_ready),
		.wb_in_valid(wb_in_valid),
		.wb_in_ready(1),

		.irq_WD(irq_WD),
		.irq_no_WD(irq_no_WD),
		.Gpr_Write_WD(Gpr_Write_WD),
		.Csr_Write_WD(Csr_Write_WD),
		.Gpr_Write_Addr_WD(Gpr_Write_Addr_WD),
		.Csr_Write_Addr_WD(Csr_Write_Addr_WD),
		.wdata_gpr(wdata_gpr_WD),
		.wdata_csr(wdata_csr_WD)

// 调试信息
,.mtvec(mtvec_D)
,.npc_M(npc_M_W)
,.npc_W(npc_W)
	);

	// always @(*) begin
	// 	if(instruction_F_D == 32'h00100073)begin
	// 		$display(" %x %x %x",Jump_D_E,pc_F,instruction_F_D);
	// 	end
	// end

	// TAG:一些仿真使用的参数:使用下面的方式需要将csrc/CircuitSim/dpi.cpp的函数取消注释，但是这样访问会拖慢仿真速度
`ifdef VERILATOR_SIM
	import "DPI-C" function void get_inst(input int inst);
	import "DPI-C" function void get_pc(input int pc);
	import "DPI-C" function void get_npc(input int npc);
	import "DPI-C" function void get_if_valid(input bit new_inst);	// 是否是新指令
	import "DPI-C" function void get_wb_ready(input bit wb_ready);
	import "DPI-C" function void get_pc_w(input int pc_w);
	import "DPI-C" function void get_npc_w(input int npc_w);
	always @(*) begin
		get_inst(axi_rdata_if);
		get_pc(pc_F);
		get_npc(npc_E_F);					// pc先不进行diff test，因为这个进行diff test找不到信号与之对应了
		get_if_valid(if_in_valid);
		get_wb_ready(wb_in_valid);			// 用于diff test，这个结合npc_temp信号刚好，因为wb_out_valid有效的时候还没有写入，所以需要使用wb_in_valid
		get_pc_w(pc_M_W);
		get_npc_w(npc_W);
	end
`endif


	// TAGS:Performance Counters
`ifdef VERILATOR_SIM
import "DPI-C" function void axi_handshake(
	input bit valid, 
	input bit ready, 
	input bit last, 
	input int operate_type
);
import "DPI-C" function void exeu_finish(input bit valid);
import "DPI-C" function void idu_instr_type(
	input bit valid,
	input int opcode
);
import "DPI-C" function void ins_start(input bit new_ins_valid);
import "DPI-C" function void lsu_read_latency(input bit arvalid, input bit rvalid);
import "DPI-C" function void lsu_write_latency(input bit awvalid, input bit bvalid);
import "DPI-C" function void cache_hit(input bit valid, input bit hit);
import "DPI-C" function void cache_access_time(input bit arvalid,input bit rvalid);

	always @(*) begin
		axi_handshake(axi_rvalid_if	, axi_rready_if	, 1'b1	, 1);
		axi_handshake(axi_rvalid_mem, axi_rready_mem, axi_rlast_mem	, 2);
		axi_handshake(axi_wvalid_mem, axi_wready_mem, axi_wlast_mem	, 3);

		exeu_finish(exe_in_valid);
		idu_instr_type(id_in_valid, {25'b0, instruction_F_D[6:0]});

		// 获取当前的指令的开始时间(用axi总线取指有效作为开始)
		ins_start(axi_arvalid_if);

		lsu_read_latency(axi_arvalid_mem	, axi_rvalid_mem);
		lsu_write_latency(axi_awvalid_mem	, axi_bvalid_mem);
		
		// 判断cahce是否命中
		cache_hit(if_in_valid ,icache_hit);
		// 计算cache命中的总时间
		cache_access_time(axi_arvalid_if, axi_rvalid_if);
	end
`endif
endmodule

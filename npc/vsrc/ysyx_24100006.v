module ysyx_24100006(
	input			clock,
    input			reset,

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
);
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
	wire [31:0] mem_addr_M;		// 对齐到四字节边界的地址
	wire [31:0] rdraw_M;		// 从mem读取出来的内容

	// 这个是在MEMU中判断是LOAD操作还是STORE操作使用，其他模块不使用
	wire [1:0] sram_read_write;


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
	reg 		axi_arready_if;
	reg 		axi_arvalid_if;
	// read data
	reg 		axi_rvalid_if;
	reg 		axi_rready_if;
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
	reg 		axi_arready_mem;
	reg 		axi_arvalid_mem;
	// read data
	reg 		axi_rvalid_mem;
	reg 		axi_rready_mem;
	reg [1:0] 	axi_rresp_mem;
	// write data addr
	reg 		axi_awvalid_mem;
	reg 		axi_awready_mem;
	// write data
	reg 		axi_wvalid_mem;
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
	reg [1:0]	axi_addr_suffix;
    
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
		.axi_rdata(clint_axi_rdata)
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

	// Access Fault异常信号
	wire [1:0] 	Access_Fault;

	// 仲裁器
	ysyx_24100006_axi_arbiter arbiter(
		.clk(clock),
		.reset(reset),

		// ================== IFU接口 ==================
		// 读地址通道
		.ifu_axi_arvalid(axi_arvalid_if),
		.ifu_axi_arready(axi_arready_if),
		.ifu_axi_araddr(pc_FD),
		// 读数据通道
		.ifu_axi_rvalid(axi_rvalid_if),
		.ifu_axi_rready(axi_rready_if),
		.ifu_axi_rresp(axi_rresp_if),
		.ifu_axi_rdata(instruction),
		// AXI新增信号
		.ifu_axi_arlen(axi_arlen_if),
		.ifu_axi_arsize(axi_arsize_if),
		.ifu_axi_rlast(axi_rlast_if),

		// ================== MEMU接口 ==================
		// 读地址通道
		.mem_axi_arvalid(axi_arvalid_mem),
		.mem_axi_arready(axi_arready_mem),
		.mem_axi_araddr(mem_addr_M),
		// 读数据通道
		.mem_axi_rvalid(axi_rvalid_mem),
		.mem_axi_rready(axi_rready_mem),
		.mem_axi_rresp(axi_rresp_mem),
		.mem_axi_rdata(rdraw_M),
		// 写地址通道
		.mem_axi_awvalid(axi_awvalid_mem),
		.mem_axi_awready(axi_awready_mem),
		.mem_axi_awaddr(mem_addr_M),
		// 写数据通道
		.mem_axi_wvalid(axi_wvalid_mem),
		.mem_axi_wready(axi_wready_mem),
		.mem_axi_wdata(rs2_data_EM),
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
		.sram_axi_wlast(m_axi_wlast)
	);

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
		.io_master_awid_o         (io_master_awid),          // 无对应信号，强制置零
		.io_master_awlen_o        (io_master_awlen),
		.io_master_awsize_o       (io_master_awsize),
		.io_master_awburst_o      (io_master_awburst),          // 无对应信号，强制置零
		
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
		.io_master_bid_i          (io_master_bid),          // 无对应信号，强制置零
		
		// 读地址通道
		.io_master_arready_i      (io_master_arready),
		.io_master_arvalid_o      (io_master_arvalid),
		.io_master_araddr_o       (io_master_araddr),
		.io_master_arid_o         (io_master_arid),          // 无对应信号，强制置零
		.io_master_arlen_o        (io_master_arlen),
		.io_master_arsize_o       (io_master_arsize),
		.io_master_arburst_o      (io_master_arburst),          // 无对应信号，强制置零
		
		// 读数据通道
		.io_master_rready_o       (io_master_rready),
		.io_master_rvalid_i       (io_master_rvalid),
		.io_master_rresp_i        (io_master_rresp),
		.io_master_rdata_i        (io_master_rdata),
		.io_master_rlast_i        (io_master_rlast),
		.io_master_rid_i          (io_master_rid)           // 无对应信号，强制置零
	);

	ysyx_24100006_axi_xbar xbar (
		// 时钟和复位
		.clk(clock),
		.reset(reset),
		.mem_ready(mem_ready),
		
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

		.m_addr_suffix(axi_addr_suffix),
		

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

		// Access Fault异常
		.Access_Fault(Access_Fault)
	);

	ysyx_24100006_ifu IF(
		.clk(clock),
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
		// 新增AXI信号
		.axi_arlen(axi_arlen_if),
		.axi_arsize(axi_arsize_if),
		.axi_rlast(axi_rlast_if),
		// 模块握手信号
		.wb_ready(wb_ready),
		.id_ready(id_ready),
		.if_valid(if_valid),
		.pc_F(pc_FD),
		.PCW(PCW),

		// Access Fault异常
		.Access_Fault(Access_Fault)
	);
	
	ysyx_24100006_idu ID(
		.clk(clock),
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
		.clk(clock),
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
		.clk(clock),
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
		.axi_bresp(axi_bresp_mem),
		// 新增AXI信号
		.axi_arlen(axi_arlen_mem),
		.axi_arsize(axi_arsize_mem),
		.axi_rlast(axi_rlast_mem),
		.axi_awlen(axi_awlen_mem),
		.axi_awsize(axi_awsize_mem),
		.axi_wstrb(axi_wstrb_mem),
		.axi_wlast(axi_wlast_mem),
		.axi_addr_suffix(axi_addr_suffix),

		// 模块握手信号
		.exe_valid(exe_valid),
		.wb_ready(wb_ready),
		.mem_valid(mem_valid),
		.mem_ready(mem_ready),

		.mem_addr(mem_addr_M),
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
		.clk(clock),
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

	always @(*) begin
		axi_handshake(axi_rvalid_if	, axi_rready_if	, axi_rlast_if	, 1);
		axi_handshake(axi_rvalid_mem, axi_rready_mem, axi_rlast_mem	, 2);
		axi_handshake(axi_wvalid_mem, axi_wready_mem, axi_wlast_mem	, 3);

		exeu_finish(exe_valid);
		idu_instr_type(id_valid, {25'b0, instruction[6:0]});

		// 获取当前的指令的开始时间(用axi总线取指有效作为开始)
		ins_start(axi_arvalid_if);

		lsu_read_latency(axi_arvalid_mem	, axi_rvalid_mem);
		lsu_write_latency(axi_awvalid_mem	, axi_bvalid_mem);
	end
`endif
endmodule

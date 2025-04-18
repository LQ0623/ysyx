module ysyx_24100006_axi_xbar #(
    parameter SRAM_ADDR     = 32'h8000_0000,
    parameter UART_ADDR     = 32'ha000_03f8,
    parameter CLINT_ADDR    = 32'ha000_0048
)(
    input         clk,
    input         reset,
    input         mem_ready,
    
    // 主设备接口
    // 写通道
    input         m_axi_awvalid,
    output        m_axi_awready,
    input  [31:0] m_axi_awaddr,
    
    input         m_axi_wvalid,
    output        m_axi_wready,
    input  [31:0] m_axi_wdata,
    input  [7:0]  m_axi_bytes,
    
    output        m_axi_bvalid,
    input         m_axi_bready,
    output [1:0]  m_axi_bresp,

    // 读通道
    input         m_axi_arvalid,
    output        m_axi_arready,
    input  [31:0] m_axi_araddr,
    
    output        m_axi_rvalid,
    input         m_axi_rready,
    output [31:0] m_axi_rdata,
    output [1:0]  m_axi_rresp,

    // AXI新增信号
    // 读通道
	input [7:0]  m_axi_arlen,
	input [2:0]  m_axi_arsize,
	output       m_axi_rlast,
	// 写通道
	input [7:0]	 m_axi_awlen,
	input [2:0]	 m_axi_awsize,
	input [3:0]	 m_axi_wstrb,
	input        m_axi_wlast,

    input [1:0]  m_addr_suffix,

    // SRAM从设备
    output        sram_axi_awvalid,
    input         sram_axi_awready,
    output [31:0] sram_axi_awaddr,
    
    output        sram_axi_wvalid,
    input         sram_axi_wready,
    output [31:0] sram_axi_wdata,
    output [7:0]  sram_axi_bytes,
    
    input         sram_axi_bvalid,
    output        sram_axi_bready,
    input  [1:0]  sram_axi_bresp,

    output        sram_axi_arvalid,
    output        sram_axi_arready,
    output [31:0] sram_axi_araddr,
    
    output        sram_axi_rvalid,
    output        sram_axi_rready,
    input  [31:0] sram_axi_rdata,
    input  [1:0]  sram_axi_rresp,
    // 新增AXI信号
	// 读通道
	output 	[7:0]	sram_axi_arlen,
	output 	[2:0]	sram_axi_arsize,
	input 			sram_axi_rlast,
	// 写通道
	output 	[7:0]	sram_axi_awlen,
	output 	[2:0]	sram_axi_awsize,
	output 	[3:0]	sram_axi_wstrb,
	output 			sram_axi_wlast,

    // CLINT从设备
    output        clint_axi_awvalid,
    input         clint_axi_awready,
    output [31:0] clint_axi_awaddr,
    
    output        clint_axi_wvalid,
    input         clint_axi_wready,
    output [31:0] clint_axi_wdata,
    output [7:0]  clint_axi_bytes,
    
    input         clint_axi_bvalid,
    output        clint_axi_bready,
    input  [1:0]  clint_axi_bresp,

    output        clint_axi_arvalid,
    output        clint_axi_arready,
    output [31:0] clint_axi_araddr,
    
    output        clint_axi_rvalid,
    output        clint_axi_rready,
    input  [31:0] clint_axi_rdata,
    input  [1:0]  clint_axi_rresp,

    // 实现让NPC抛出Access Fault异常
    // 根据rresp和bresp进行错误判断
    // 当xresp表示有错误信息是，将下面的信号拉高，然后IFU中将pc置为0
    // 00: 读写正确
    // 01: 读发生错误
    // 10: 写发生错误
    output  [1:0]  Access_Fault  //  Access Fault Alert
);

    // 地址解码
    // wire sel_sram   = (m_axi_awaddr >= SRAM_ADDR && m_axi_awaddr < (SRAM_ADDR + 32'h0800_0000)) ||
    //                 (m_axi_araddr >= SRAM_ADDR && m_axi_araddr < (SRAM_ADDR + 32'h0800_0000));       // SRAM的空间大小到在am中有

    // wire sel_clint  = (m_axi_awaddr >= CLINT_ADDR && m_axi_awaddr < (CLINT_ADDR + 32'h0000_0008)) ||
    //                 (m_axi_araddr >= CLINT_ADDR && m_axi_araddr < (CLINT_ADDR + 32'h0000_0008));      // CLINT

    wire sel_sram = 1;
    wire sel_clint = 0;

    // 写通道路由
    // SRAM
    assign sram_axi_awvalid     = sel_sram ? m_axi_awvalid  : 0;
    assign sram_axi_awaddr      = sel_sram ? m_axi_awaddr   : 32'h0;
    assign sram_axi_wvalid      = sel_sram ? m_axi_wvalid   : 0;
    assign sram_axi_wdata       = sel_sram ? m_axi_wdata    : 32'h0;
    assign sram_axi_bytes       = sel_sram ? m_axi_bytes    : 8'h0;
    assign sram_axi_bready      = sel_sram ? m_axi_bready   : 0;

    // CLINT
    assign clint_axi_awvalid    = sel_clint ? m_axi_awvalid  : 0;
    assign clint_axi_awaddr     = sel_clint ? m_axi_awaddr   : 32'h0;
    assign clint_axi_wvalid     = sel_clint ? m_axi_wvalid   : 0;
    assign clint_axi_wdata      = sel_clint ? m_axi_wdata    : 32'h0;
    assign clint_axi_bytes      = sel_clint ? m_axi_bytes    : 8'h0;
    assign clint_axi_bready     = sel_clint ? m_axi_bready   : 0;

    // 读通道路由
    // SRAM
    assign sram_axi_arvalid     = sel_sram ? m_axi_arvalid  : 0;
    assign sram_axi_araddr      = sel_sram ? m_axi_araddr   : 32'h0;
    assign sram_axi_rready      = sel_sram ? m_axi_rready   : 0;

    // CLINT
    assign clint_axi_arvalid    = sel_clint ? m_axi_arvalid  : 0;
    assign clint_axi_araddr     = sel_clint ? m_axi_araddr   : 32'h0;
    assign clint_axi_rready     = sel_clint ? m_axi_rready   : 0;


    // 响应合并
    assign m_axi_awready    =   sel_sram ? sram_axi_awready :
                                sel_clint ? clint_axi_awready : 0;

    assign m_axi_wready     =   sel_sram ? sram_axi_wready :
                                sel_clint ? clint_axi_wready : 0;

    assign m_axi_bvalid     =   sel_sram ? sram_axi_bvalid :
                                sel_clint ? clint_axi_bvalid : 0;

    assign m_axi_bresp      =   sel_sram ? sram_axi_bresp :
                                sel_clint ? clint_axi_bresp : 2'b00;

    assign m_axi_arready    =   sel_sram ? sram_axi_arready :
                                sel_clint ? clint_axi_arready : 0;

    assign m_axi_rvalid     = sel_sram ? sram_axi_rvalid :
                                sel_clint ? clint_axi_rvalid : 0;

    assign m_axi_rdata      = sel_sram ? real_sram_data :
                                sel_clint ? clint_axi_rdata : 32'h0;

    assign m_axi_rresp      = sel_sram ? sram_axi_rresp :
                                sel_clint ? clint_axi_rresp : 2'b00;

    // 新增AXI信号
    assign m_axi_rlast      = sram_axi_rlast;
    assign sram_axi_arlen   = m_axi_arlen;
    assign sram_axi_arsize  = 3'b010;           // 读SRAM是地址对齐的，所以需要直接读取4字节，然后在选择
    assign sram_axi_awlen   = m_axi_awlen;
    assign sram_axi_awsize  = m_axi_awsize;
    assign sram_axi_wstrb   = m_axi_wstrb;
    assign sram_axi_wlast   = m_axi_wlast;

    // 根据非对齐地址来进行选择
    wire [31:0] real_sram_data;
    assign real_sram_data   =   (m_axi_arsize == 3'b000) ? // lb / lbu指令，读取一个字节
                                    (   (m_addr_suffix == 2'b00) ? {24'b0,sram_axi_rdata[7:0]}      :
                                        (m_addr_suffix == 2'b01) ? {24'b0,sram_axi_rdata[15:8]}     :
                                        (m_addr_suffix == 2'b10) ? {24'b0,sram_axi_rdata[23:16]}    :
                                        (m_addr_suffix == 2'b11) ? {24'b0,sram_axi_rdata[31:24]}    : 32'b0) :
                                (m_axi_arsize == 3'b001) ? // lh / lhu指令，读取三个字节
                                    (   (m_addr_suffix == 2'b00) ? {16'b0,sram_axi_rdata[15:0]}     :
                                        (m_addr_suffix == 2'b01) ? {16'b0,sram_axi_rdata[23:8]}     :
                                        (m_addr_suffix == 2'b10) ? {16'b0,sram_axi_rdata[31:16]}    : 32'b0) :
                                (m_axi_arsize == 3'b010) ? // lw指令，读取四个字节
                                    (   (m_addr_suffix == 2'b00) ? sram_axi_rdata                   : 32'b0) : 32'b0;

    // Acess Fault信号
    assign Access_Fault     = (sram_axi_rresp != 2'b00 || clint_axi_rresp != 2'b00) ? 2'b01 : 
                                ((sram_axi_bresp != 2'b00 || clint_axi_bresp != 2'b00) ? 2'b10 : 2'b00);

endmodule


// +-----+      +---------+      +------+      +-----+
// | IFU | ---> |         |      |      | ---> | UART|  [0xa000_03f8, 0xa000_0400)
// +-----+      |         |      |      |      +-----+
//              | Arbiter | ---> | Xbar |
// +-----+      |         |      |      |      +-----+
// | LSU | ---> |         |      |      | ---> | SRAM|  [0x8000_0000, 0x87ff_ffff)
// +-----+      +---------+      +------+      +-----+
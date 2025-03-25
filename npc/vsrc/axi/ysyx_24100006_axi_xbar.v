module ysyx_24100006_axi_xbar #(
    parameter SRAM_ADDR = 32'h8000_0000,
    parameter UART_ADDR = 32'ha000_0000
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
    input  [7:0]  m_axi_wstrb,
    
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

    // SRAM从设备
    output        sram_axi_awvalid,
    input         sram_axi_awready,
    output [31:0] sram_axi_awaddr,
    
    output        sram_axi_wvalid,
    input         sram_axi_wready,
    output [31:0] sram_axi_wdata,
    output [7:0]  sram_axi_wstrb,
    
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

    // UART从设备
    output        uart_axi_awvalid,
    input         uart_axi_awready,
    output [31:0] uart_axi_awaddr,
    
    output        uart_axi_wvalid,
    input         uart_axi_wready,
    output [31:0] uart_axi_wdata,
    output [7:0]  uart_axi_wstrb,
    
    input         uart_axi_bvalid,
    output        uart_axi_bready,
    input  [1:0]  uart_axi_bresp,

    output        uart_axi_arvalid,
    output        uart_axi_arready,
    output [31:0] uart_axi_araddr,
    
    output        uart_axi_rvalid,
    output        uart_axi_rready,
    input  [31:0] uart_axi_rdata,
    input  [1:0]  uart_axi_rresp
);

    // 地址解码
    wire sel_sram = (m_axi_awaddr >= SRAM_ADDR && m_axi_awaddr < (SRAM_ADDR + 32'h1000_0000)) ||
                    (m_axi_araddr >= SRAM_ADDR && m_axi_araddr < (SRAM_ADDR + 32'h1000_0000));       // 假设每个从设备16MB空间

    wire sel_uart = (mem_ready == 1'b0) && ((m_axi_awaddr >= (UART_ADDR + 32'h0000_03f8) && m_axi_awaddr < (UART_ADDR + 32'h0000_0400)) ||
                    (m_axi_araddr >= (UART_ADDR + 32'h0000_03f8) && m_axi_araddr < (UART_ADDR + 32'h0000_0400)));      // UART 4KB空间

    // wire sel_sram = 1;
    // wire sel_uart = 0;

    // 写通道路由
    assign sram_axi_awvalid = sel_sram ? m_axi_awvalid  : 0;
    assign sram_axi_awaddr  = sel_sram ? m_axi_awaddr   : 32'h0;
    assign sram_axi_wvalid  = sel_sram ? m_axi_wvalid   : 0;
    assign sram_axi_wdata   = sel_sram ? m_axi_wdata    : 32'h0;
    assign sram_axi_wstrb   = sel_sram ? m_axi_wstrb    : 8'h0;
    assign sram_axi_bready  = sel_sram ? m_axi_bready   : 0;

    assign uart_axi_awvalid = sel_uart ? m_axi_awvalid  : 0;
    assign uart_axi_awaddr  = sel_uart ? m_axi_awaddr   : 32'h0;
    assign uart_axi_wvalid  = sel_uart ? m_axi_wvalid   : 0;
    assign uart_axi_wdata   = sel_uart ? m_axi_wdata    : 32'h0;
    assign uart_axi_wstrb   = sel_uart ? m_axi_wstrb    : 8'h0;
    assign uart_axi_bready  = sel_uart ? m_axi_bready   : 0;

    // 读通道路由
    assign sram_axi_arvalid = sel_sram ? m_axi_arvalid  : 0;
    assign sram_axi_araddr  = sel_sram ? m_axi_araddr   : 32'h0;
    assign sram_axi_rready  = sel_sram ? m_axi_rready   : 0;

    assign uart_axi_arvalid = sel_uart ? m_axi_arvalid  : 0;
    assign uart_axi_araddr  = sel_uart ? m_axi_araddr   : 32'h0;
    assign uart_axi_rready  = sel_uart ? m_axi_rready   : 0;

    // 响应合并
    assign m_axi_awready    = sel_sram ? sram_axi_awready :
                                (sel_uart ? uart_axi_awready : 0);

    assign m_axi_wready     = sel_sram ? sram_axi_wready :
                                (sel_uart ? uart_axi_wready : 0);

    assign m_axi_bvalid     = sel_sram ? sram_axi_bvalid :
                                (sel_uart ? uart_axi_bvalid : 0);

    assign m_axi_bresp      = sel_sram ? sram_axi_bresp :
                                (sel_uart ? uart_axi_bresp : 2'b00);

    assign m_axi_arready    = sel_sram ? sram_axi_arready :
                                (sel_uart ? uart_axi_arready : 0);

    assign m_axi_rvalid     = sel_sram ? sram_axi_rvalid :
                                (sel_uart ? uart_axi_rvalid : 0);

    assign m_axi_rdata      = sel_sram ? sram_axi_rdata :
                                (sel_uart ? uart_axi_rdata : 32'h0);

    assign m_axi_rresp      = sel_sram ? sram_axi_rresp :
                                (sel_uart ? uart_axi_rresp : 2'b00);

endmodule


// +-----+      +---------+      +------+      +-----+
// | IFU | ---> |         |      |      | ---> | UART|  [0x1000_0000, 0x1000_0fff)
// +-----+      |         |      |      |      +-----+
//              | Arbiter | ---> | Xbar |
// +-----+      |         |      |      |      +-----+
// | LSU | ---> |         |      |      | ---> | SRAM|  [0x8000_0000, 0x80ff_ffff)
// +-----+      +---------+      +------+      +-----+
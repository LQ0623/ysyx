// TAG：这个axi文件只是简单的转发，不进行任何的制约
// Burst types
`define AXI_BURST_TYPE_FIXED                                2'b00               //突发类型  FIFO
`define AXI_BURST_TYPE_INCR                                 2'b01               //ram  
`define AXI_BURST_TYPE_WRAP                                 2'b10

module ysyx_24100006_axi #(
    parameter AXI_DATA_WIDTH    = 32,
    parameter AXI_ADDR_WIDTH    = 32,
    parameter AXI_ID_WIDTH      = 4,
    // parameter AXI_STRB_WIDTH    = AXI_DATA_WIDTH/8,
    parameter AXI_STRB_WIDTH    = 4,
    parameter AXI_RESP_WIDTH    = 2,
    parameter AXI_LEN_WIDTH     = 8,
    parameter AXI_SIZE_WIDTH    = 3,
    parameter AXI_BURST_WIDTH   = 2
)(
    input                           clk,
    input                           reset,

    // Interface with CPU
    // 读地址通道
    input                           axi_arvalid_i,
    output                          axi_arready_o,
    input   [AXI_ADDR_WIDTH - 1:0]  axi_araddr_i,
    // 读数据通道
    output                          axi_rvalid_o,
    input                           axi_rready_i,
    output  [AXI_RESP_WIDTH - 1:0]  axi_rresp_o,
    output  [AXI_DATA_WIDTH - 1:0]  axi_rdata_o,
    // 写地址通道
    input                           axi_awvalid_i,
    output                          axi_awready_o,
    input   [AXI_ADDR_WIDTH - 1:0]  axi_awaddr_i,
    // 写数据通道
    input                           axi_wvalid_i,
    output                          axi_wready_o,
    input   [AXI_DATA_WIDTH - 1:0]  axi_wdata_i,
    input   [AXI_STRB_WIDTH - 1:0]  axi_wstrb_i,
    // 写响应通道
    output                          axi_bvalid_o,
    input                           axi_bready_i,
    output  [AXI_RESP_WIDTH - 1:0]  axi_bresp_o,
    
    // 突发配置
    input   [AXI_LEN_WIDTH  - 1:0]  axi_arlen_i,   // 读突发长度
    input   [AXI_LEN_WIDTH  - 1:0]  axi_awlen_i,   // 写突发长度
    input   [AXI_SIZE_WIDTH - 1:0]  axi_arsize_i,  // 读突发大小
    input   [AXI_SIZE_WIDTH - 1:0]  axi_awsize_i,  // 写突发大小
    output                          axi_rlast_o,    // 读最后一个传输
    input                           axi_wlast_o,    // 写最后一个传输

    //-----------------------------
    // AXI4 主设备接口 (物理总线侧)
    //-----------------------------
    // 写地址通道
    input                           io_master_awready_i,
    output                          io_master_awvalid_o,
    output  [AXI_ADDR_WIDTH - 1:0]  io_master_awaddr_o,
    output  [AXI_ID_WIDTH   - 1:0]  io_master_awid_o,
    output  [AXI_LEN_WIDTH  - 1:0]  io_master_awlen_o,
    output  [AXI_SIZE_WIDTH - 1:0]  io_master_awsize_o,
    output  [AXI_BURST_WIDTH- 1:0]  io_master_awburst_o,

    // 写数据通道
    input                           io_master_wready_i,
    output  reg                     io_master_wvalid_o,
    output  [AXI_DATA_WIDTH - 1:0]  io_master_wdata_o,
    output  [AXI_STRB_WIDTH - 1:0]  io_master_wstrb_o,
    output                          io_master_wlast_o,

    // 写响应通道
    output                          io_master_bready_o,
    input                           io_master_bvalid_i,
    input   [AXI_RESP_WIDTH - 1:0]  io_master_bresp_i,
    input   [AXI_ID_WIDTH   - 1:0]  io_master_bid_i,

    // 读地址通道
    input                           io_master_arready_i,
    output                          io_master_arvalid_o,
    output  [AXI_ADDR_WIDTH - 1:0]  io_master_araddr_o,
    output  [AXI_ID_WIDTH   - 1:0]  io_master_arid_o,
    output  [AXI_LEN_WIDTH  - 1:0]  io_master_arlen_o,
    output  [AXI_SIZE_WIDTH - 1:0]  io_master_arsize_o,
    output  [AXI_BURST_WIDTH- 1:0]  io_master_arburst_o,

    // 读数据通道
    output                          io_master_rready_o,
    input                           io_master_rvalid_i,
    input   [AXI_RESP_WIDTH - 1:0]  io_master_rresp_i,
    input   [AXI_DATA_WIDTH - 1:0]  io_master_rdata_i,
    input                           io_master_rlast_i,
    input   [AXI_ID_WIDTH   - 1:0]  io_master_rid_i
);

    // 主设备接口输出信号连接 (io_master_*_o)
    assign io_master_awvalid_o = axi_awvalid_i;         // 写地址有效
    assign io_master_awaddr_o  = axi_awaddr_i;          // 写地址总线
    assign io_master_awid_o    = 0;                     // 无对应信号，强制置零
    assign io_master_awlen_o   = axi_awlen_i;           // 写突发长度
    assign io_master_awsize_o  = axi_awsize_i;          // 写突发大小
    assign io_master_awburst_o = 0;                     // 无对应信号，强制置零

    assign io_master_wvalid_o  = axi_wvalid_i;          // 写数据有效
    assign io_master_wdata_o   = axi_wdata_i;           // 写数据总线
    assign io_master_wstrb_o   = axi_wstrb_i;           // 写字节选通
    assign io_master_wlast_o   = axi_wlast_o;           // 写传输结束

    assign io_master_bready_o  = axi_bready_i;          // 写响应准备

    assign io_master_arvalid_o = axi_arvalid_i;         // 读地址有效
    assign io_master_araddr_o  = axi_araddr_i;          // 读地址总线
    assign io_master_arid_o    = 0;                     // 无对应信号，强制置零
    assign io_master_arlen_o   = axi_arlen_i;           // 读突发长度
    assign io_master_arsize_o  = axi_arsize_i;          // 读突发大小
    assign io_master_arburst_o = 2'b01;                 // 无对应信号，强制置零

    assign io_master_rready_o  = axi_rready_i;          // 读数据准备

    // 主设备接口输入信号连接 (io_master_*_i → 用户侧输出)
    assign axi_awready_o = io_master_awready_i;         // 写地址准备
    assign axi_wready_o  = io_master_wready_i;          // 写数据准备
    assign axi_bvalid_o  = io_master_bvalid_i;          // 写响应有效
    assign axi_bresp_o   = io_master_bresp_i;           // 写响应状态
    assign axi_arready_o = io_master_arready_i;         // 读地址准备
    assign axi_rvalid_o  = io_master_rvalid_i;          // 读数据有效
    assign axi_rresp_o   = io_master_rresp_i;           // 读响应状态
    assign axi_rdata_o   = io_master_rdata_i;           // 读数据总线
    assign axi_rlast_o   = io_master_rlast_i;           // 读传输结束

endmodule
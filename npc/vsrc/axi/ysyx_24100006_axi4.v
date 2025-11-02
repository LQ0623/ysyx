// Burst types
`define AXI_BURST_TYPE_FIXED                                2'b00               //突发类型  FIFO
`define AXI_BURST_TYPE_INCR                                 2'b01               //ram  
`define AXI_BURST_TYPE_WRAP                                 2'b10

module ysyx_24100006_axi4 #(
    parameter AXI_DATA_WIDTH    = 32,
    parameter AXI_ADDR_WIDTH    = 32,
    parameter AXI_ID_WIDTH      = 4,
    // parameter AXI_STRB_WIDTH    = AXI_DATA_WIDTH/8,
    parameter AXI_STRB_WIDTH    = 8,
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
    output                          axi_wlast_o,    // 写最后一个传输

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

    // ------------------Write Transaction------------------
    wire [AXI_ID_WIDTH - 1:0] axi_id    = {AXI_ID_WIDTH{1'b0}};

    // 写地址通道
    // TAG：备注为初始化的是现阶段可以不用管的信号
    assign io_master_awaddr_o   = axi_awaddr_i;
    assign io_master_awid_o     = axi_id;                   // 初始化即可
    assign io_master_awlen_o    = axi_awlen_i;
    assign io_master_awsize_o   = axi_awsize_i;
    assign io_master_awburst_o  = `AXI_BURST_TYPE_INCR;     // 初始化即可

    assign axi_awready_o        = io_master_awready_i;
    
    // 写数据通道
    assign io_master_wdata_o    = axi_wdata_i;
    assign io_master_wstrb_o    = axi_wstrb_i;
    assign io_master_wlast_o    = axi_wlast_o;              // 这个可以设置一个计数器，看是否以及发送了awlen+1个数据了

    // TAG:目前还是直接转发valid和ready信号，如果后续需要传输多个数据在进行修改，
    // TAG:后面的握手可以改到axi这一模块进行了，而不是在IFU和MEMU进行
    /* =============================写地址通道=========================== */
    assign io_master_awvalid_o  = axi_awvalid_i;
    
    /* =============================写数据通道=========================== */
    reg [AXI_LEN_WIDTH - 1:0] w_count;  // 记录写入的数量
    assign axi_wlast_o          = (axi_wvalid_i && (w_count == axi_awlen_i)) ? 1'b1 : 1'b0;
    assign axi_wready_o         = io_master_wready_i;

    reg    w_last_ok;   // 是否是最后一次写入
    always @(posedge clk) begin
        if(reset) begin
            w_count             <= 8'b0;
        end else if(axi_wvalid_i == 1'b1 && axi_awvalid_i == 1'b1 && w_last_ok == 1'b0) begin
            if(io_master_wready_i == 1'b1 && axi_wlast_o == 1'b1) begin // 完成最后一次传输
                io_master_wvalid_o  <= 1'b0;
                w_last_ok           <= axi_wlast_o;
                $display("AXI W end");
            end else if(io_master_wready_i == 1'b1) begin   // 还有数据写入
                io_master_wvalid_o  <= 1'b1;
                w_count             <= w_count + 1'b1;
                $display("AXI W count ++");
            end else begin
                io_master_wvalid_o  <= 1'b1;
            end
        end else begin
            w_count                 <= 8'b0;
            io_master_wvalid_o      <= 1'b0;
            w_last_ok               <= 1'b0;
        end
    end

    /* =============================写响应通道=========================== */
    // TAG：目前的bready直接使用CPU传出来的信号值
    assign io_master_bready_o   = axi_bready_i;
    assign axi_bvalid_o         = io_master_bvalid_i;
    assign axi_bresp_o          = io_master_bresp_i;
    // always @(posedge clk) begin
    //     if(reset) begin
    //         io_master_bready_o      <= 1'b0;
    //     end else if(axi_wvalid_i == 1'b1 && io_master_bready_o == 1'b0) begin
    //         io_master_bready_o      <= 1'b1;
    //     end else begin
    //         io_master_bready_o      <= 1'b0;
    //     end
    // end

    // ------------------Read Transaction------------------
    // 读地址通道
    assign io_master_araddr_o   = axi_araddr_i;
    assign io_master_arid_o     = axi_id;
    assign io_master_arlen_o    = axi_arlen_i;
    assign io_master_arsize_o   = axi_arsize_i;
    assign io_master_arburst_o  = `AXI_BURST_TYPE_INCR;

    assign axi_arready_o        = io_master_arready_i;

    /* =============================读地址通道=========================== */
    assign io_master_arvalid_o  = axi_arvalid_i;

    // 读数据通道
    assign axi_rvalid_o         = io_master_rvalid_i;
    assign axi_rdata_o          = io_master_rdata_i;
    assign axi_rlast_o          = io_master_rlast_i;
    /* =============================读数据通道=========================== */
    assign io_master_rready_o   = axi_rready_i;

endmodule
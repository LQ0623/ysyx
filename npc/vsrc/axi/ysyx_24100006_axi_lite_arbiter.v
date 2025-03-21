// axi 仲裁器
module ysyx_24100006_axi_lite_arbiter (
    input           clk,
    input           reset,

    // Master 0(IFU)接口
    input   [31:0]  m0_araddr,
    input           m0_arvalid,
    output          m0_arready,
    output  [31:0]  m0_rdata,
    output          m0_rvalid,
    input           m0_rready,

    // Master 1(MEMU)接口
    input   [31:0]  m1_awaddr,
    input   [31:0]  m1_wdata,
    input   [3:0]   m1_wstrb,
    input           m1_awvalid,
    input           m1_wvalid,
    output          m1_awready,
    output          m1_wready,
    output          m1_bvalid,
    input           m1_bready,

    // Slave 接口
    output  [31:0]  s_araddr,
    output          s_arvalid,
    input           s_arready,
    input   [31:0]  s_rdata,
    input           s_rvalid,
    output          s_rready,

    output  [31:0]  s_awaddr,
    output  [31:0]  s_wdata,
    output  [3:0]   s_wstrb,
    output          s_awvalid,
    output          s_wvalid,
    input           s_awready,
    input           s_wready,
    input           s_bvalid,
    output          s_bready
);

    // 状态定义
    parameter   ARB_IDLE = 0, 
                ARB_M0 = 1,     // IFU占用总线
                ARB_M1 = 2;     // MEMU占用总线

    reg [1:0] state;
    reg grant_m0;   // IFU授权信号
    reg grant_m1;   // MEMU授权信号

    // 仲裁策略：优先级仲裁（IFU优先）
    always @(posedge clk) begin
        if(reset) begin
            state       <= ARB_IDLE;
            grant_m0    <= 1'b0;
            grant_m1    <= 1'b0;
        end else begin
            case(state)
                ARB_IDLE: begin
                    if(m0_valid == 1'b1) begin  // IFU在请求SRAM
                        grant_m0    <= 1'b1;
                        state       <= ARB_M0;
                    end else if(m1_valid == 1'b1) begin // MEMU请求
                        grant_m1    <= 1'b1;
                        state       <= ARB_M1;
                    end
                end

                ARB_M0: begin
                    if(s_rvalid == 1'b1 && s_rready == 1'b1)begin   // 读传输完成
                        grant_m0    <= 1'b1;
                        state       <= ARB_IDLE;
                    end
                end

                ARB_M1: begin
                    if(s_bvalid == 1'b1 && s_bready == 1'b1) begin  // 写传输完成
                        grant_m1    <= 1'b0;
                        state       <= ARB_IDLE;
                    end
                end
            endcase
        end
    end

    // 读通道仲裁
    assign  s_arvalid   = grant_m0 ? m0_arvalid : 1'b0;
    assign  s_araddr    = grant_m0 ? m0_araddr  : 32'b0;
    assign  m0_arready  = grant_m0 ? s_arready  : 1'b0;

    // 写通道仲裁
    assign  s_awvalid   = grant_m1 ? m1_awvalid : 1'b0;
    assign  s_awaddr    = grant_m1 ? m1_awaddr  : 32'b0;
    assign  s_wvalid    = grant_m1 ? m1_wvalid  : 1'b0;
    assign  s_wdata     = grant_m1 ? m1_wdata   : 32'b0;
    assign  s_wstrb     = grant_m1 ? m1_wstrb   : 4'b0;
    assign  m1_awready  = grant_m1 ? s_awready  : 1'b0;
    assign  m1_wready   = grant_m1 ? s_wready   : 1'b0;

    // 响应通道路由
    assign  m0_rvalid   = grant_m0 ? s_rvalid   : 1'b0;
    assign  m0_rdata    = s_rdata;
    assign  s_rready    = grant_m0 ? m0_rready  : 1'b0;

    assign  m1_bvalid   = grant_m1 ? s_bvalid   : 1'b0;
    assign  s_bready    = grant_m1 ? m1_bready  : 1'b0;

endmodule
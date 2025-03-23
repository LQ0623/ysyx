// axi 仲裁器：相当于将仲裁器当作一个中转站，将不同模块的信号在这里进行分发，然后在统一传给SRAM
// 写信号在当前不需要进行仲裁，因为只有MEMU会进行SRAM的写入
module ysyx_24100006_axi_arbiter (
    input   clk,
    input   reset,

    // ================== IFU接口 ==================
    // 读地址通道
    input               ifu_axi_arvalid,
    output              ifu_axi_arready,
    input   [31:0]      ifu_axi_araddr,
    // 读数据通道
    output              ifu_axi_rvalid,
    input               ifu_axi_rready,
    output              ifu_axi_rresp,
    output  [31:0]      ifu_axi_rdata,

    // ================== MEMU接口 ==================
    // 读地址通道
    input               mem_axi_arvalid,
    output              mem_axi_arready,
    input   [31:0]      mem_axi_araddr,
    // 读数据通道
    output              mem_axi_rvalid,
    input               mem_axi_rready,
    output              mem_axi_rresp,
    output  [31:0]      mem_axi_rdata,
    // 写地址通道
    input               mem_axi_awvalid,
    output              mem_axi_awready,
    input   [31:0]      mem_axi_awaddr,
    // 写数据通道
    input               mem_axi_wvalid,
    output              mem_axi_wready,
    input   [31:0]      mem_axi_wdata,
    input   [7:0]       mem_axi_wstrb,
    // 写响应通道
    output              mem_axi_bvalid,
    input               mem_axi_bready,
    output  [1:0]       mem_axi_bresp,
    

    // ================== SRAM接口 ==================
    // 读地址通道
    output              sram_axi_arvalid,
    input               sram_axi_arready,
    output  [31:0]      sram_axi_araddr,
    // 读数据通道
    input               sram_axi_rvalid,
    output              sram_axi_rready,
    input               sram_axi_rresp,
    input   [31:0]      sram_axi_rdata,
    // 写地址通道
    output              sram_axi_awvalid,
    input               sram_axi_awready,
    output  [31:0]      sram_axi_awaddr,
    // 写数据通道
    output              sram_axi_wvalid,
    input               sram_axi_wready,
    output  [31:0]      sram_axi_wdata,
    output  [7:0]       sram_axi_wstrb,
    // 写响应通道
    input               sram_axi_bvalid,
    output              sram_axi_bready,
    input   [1:0]       sram_axi_bresp
);

    parameter   ARB_IDLE        = 3'b000,   // 空闲状态
                ARB_IFU_READ    = 3'b001,   // IF进行读操作
                ARB_MEMU_READ   = 3'b010;   // MEMU进行读操作

    // ================== 仲裁状态机 ==================
    parameter   IDLE = 0, BUSY = 1;

    reg [1:0] axi_state;                // AXI目前的状态
    reg [2:0] read_targeted_module;     // 当前是哪一个模块进行读操作

    always @(posedge clk) begin
        if(reset) begin
            axi_state               <= IDLE;
            read_targeted_module    <= ARB_IDLE;
        end else begin
            case(axi_state)
                IDLE: begin     // 空闲状态
                    // 固定优先级
                    // MEMU优先策略
                    if(mem_axi_arvalid == 1'b1) begin
                        axi_state               <= BUSY;
                        read_targeted_module    <= ARB_MEMU_READ;
                    end else if(ifu_axi_arvalid == 1'b1) begin
                        axi_state               <= BUSY;
                        read_targeted_module    <= ARB_IFU_READ;
                    end
                end

                BUSY: begin     // 总线不是空闲状态
                    // 现在只是针对单次传输，没有突发传输，表示一次读传输完成
                    if(sram_axi_rready == 1'b1 && sram_axi_rvalid == 1'b1) begin
                        axi_state               <= IDLE;
                        read_targeted_module    <= ARB_IDLE;
                    end
                end
            endcase
        end
    end

    // ================== 信号转发逻辑 ==================
    // IFU 读通道
    assign ifu_axi_arready  =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_arready : 1'b0;
    assign ifu_axi_rvalid   =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rvalid  : 1'b0;
    assign ifu_axi_rresp    =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rresp   : 1'b0;
    // assign ifu_axi_rdata    =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rdata   : 32'b0;

    // MEMU 读通道
    assign mem_axi_arready  =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_arready : 1'b0;
    assign mem_axi_rvalid   =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rvalid  : 1'b0;
    assign mem_axi_rresp    =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rresp   : 1'b0;
    // assign mem_axi_rdata    =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rdata   : 32'b0; 

    // MEMU 写通道
    assign mem_axi_awready  =   sram_axi_awready;
    assign mem_axi_wready   =   sram_axi_wready;
    assign mem_axi_bvalid   =   sram_axi_bvalid;

    // SRAM 读通道
    assign sram_axi_arvalid =   (read_targeted_module == ARB_MEMU_READ) ? mem_axi_arvalid : 
                                ((read_targeted_module == ARB_IFU_READ) ? ifu_axi_arvalid : 1'b0);
    assign sram_axi_rready  =   (read_targeted_module == ARB_MEMU_READ) ? mem_axi_rready  : 
                                ((read_targeted_module == ARB_IFU_READ) ? ifu_axi_rready  : 1'b0);
    assign sram_axi_araddr  =   (read_targeted_module == ARB_MEMU_READ) ? mem_axi_araddr  : 
                                ((read_targeted_module == ARB_IFU_READ) ? ifu_axi_araddr  : 32'b0);


    // ================== 读数据通道寄存器 ==================
    reg [31:0] ifu_rdata_reg;
    reg [31:0] mem_rdata_reg;

    // IFU读数据通道更新逻辑
    always @(posedge clk) begin
        if (reset) begin
            ifu_rdata_reg <= 32'b0;
        end else begin
            // 仅当仲裁给IFU且SRAM返回有效数据时更新
            if (read_targeted_module == ARB_IFU_READ && sram_axi_rvalid) 
                ifu_rdata_reg <= sram_axi_rdata;
            // 其他情况保持原值
        end
    end

    // MEMU读数据通道更新逻辑
    always @(posedge clk) begin
        if (reset) begin
            mem_rdata_reg <= 32'b0;
        end else begin
            // 仅当仲裁给MEMU且SRAM返回有效数据时更新
            if (read_targeted_module == ARB_MEMU_READ && sram_axi_rvalid) 
                mem_rdata_reg <= sram_axi_rdata;
            // 其他情况保持原值
        end
    end

    // 最终输出连接
    assign ifu_axi_rdata = ifu_rdata_reg;
    assign mem_axi_rdata = mem_rdata_reg;


    // SRAM 写通道
    assign sram_axi_awvalid =   mem_axi_awvalid;
    assign sram_axi_wvalid  =   mem_axi_wvalid;
    assign sram_axi_bready  =   mem_axi_bready;
    assign sram_axi_awaddr  =   mem_axi_awaddr;
    assign sram_axi_wdata   =   mem_axi_wdata;
    assign sram_axi_wstrb   =   mem_axi_wstrb;

endmodule
// 这个模块是xbar和arbiter一起的，后面需要重新写
// 把xbar和arbiter的修改字段的功能全部写到内部去
module ysyx_24100006_xbar_arbiter #(
    parameter SRAM_ADDR     = 32'h8000_0000,
    parameter SPI_ADDR      = 32'h1000_1000
)(
    input         clk,
    input         reset,
    
    // ================== IFU接口 ==================
    // 读地址通道
    input               ifu_axi_arvalid,
    output              ifu_axi_arready,
    input   [31:0]      ifu_axi_araddr,
    // 读数据通道
    output              ifu_axi_rvalid,
    input               ifu_axi_rready,
    output  [1:0]       ifu_axi_rresp,
    output  [31:0]      ifu_axi_rdata,
    // AXI新增信号
    input   [7:0]       ifu_axi_arlen,
    input   [2:0]       ifu_axi_arsize,
    output              ifu_axi_rlast,

    // ================== MEMU接口 ==================
    // 读地址通道
    input               mem_axi_arvalid,
    output              mem_axi_arready,
    input   [31:0]      mem_axi_araddr,
    // 读数据通道
    output              mem_axi_rvalid,
    input               mem_axi_rready,
    output  [1:0]       mem_axi_rresp,
    output  [31:0]      mem_axi_rdata,
    // 写地址通道
    input               mem_axi_awvalid,
    output              mem_axi_awready,
    input   [31:0]      mem_axi_awaddr,
    // 写数据通道
    input               mem_axi_wvalid,
    output              mem_axi_wready,
    input   [31:0]      mem_axi_wdata,
    // 写响应通道
    output              mem_axi_bvalid,
    input               mem_axi_bready,
    output  [1:0]       mem_axi_bresp,
    // 新增AXI信号
    input   [7:0]       mem_axi_arlen,
    input   [2:0]       mem_axi_arsize,
    output              mem_axi_rlast,
    // 写通道
    input   [7:0]       mem_axi_awlen,
    input   [2:0]       mem_axi_awsize,
    input   [3:0]       mem_axi_wstrb,
    input               mem_axi_wlast,
    input   [1:0]       mem_axi_addr_suffix,

    // ================== 从设备接口 ==================
    // SRAM从设备
    output        sram_axi_awvalid,
    input         sram_axi_awready,
    output [31:0] sram_axi_awaddr,
    
    output        sram_axi_wvalid,
    input         sram_axi_wready,
    output [31:0] sram_axi_wdata,
    
    input         sram_axi_bvalid,
    output        sram_axi_bready,
    input  [1:0]  sram_axi_bresp,

    output        sram_axi_arvalid,
    input         sram_axi_arready,
    output [31:0] sram_axi_araddr,
    
    input         sram_axi_rvalid,
    output        sram_axi_rready,
    input  [31:0] sram_axi_rdata,
    input  [1:0]  sram_axi_rresp,
    // 新增AXI信号
    output  [7:0]  sram_axi_arlen,
    output  [2:0]  sram_axi_arsize,
    input          sram_axi_rlast,
    // 写通道
    output  [7:0]  sram_axi_awlen,
    output  [2:0]  sram_axi_awsize,
    output  [3:0]  sram_axi_wstrb,
    output         sram_axi_wlast,

`ifdef NPC
    // UART从设备
    output        uart_axi_awvalid,
    input         uart_axi_awready,
    output [31:0] uart_axi_awaddr,
    
    output        uart_axi_wvalid,
    input         uart_axi_wready,
    output [31:0] uart_axi_wdata,
    output [3:0]  uart_axi_wstrb,
    
    input         uart_axi_bvalid,
    output        uart_axi_bready,
    input  [1:0]  uart_axi_bresp,

    output        uart_axi_arvalid,
    input         uart_axi_arready,
    output [31:0] uart_axi_araddr,
    
    input         uart_axi_rvalid,
    output        uart_axi_rready,
    input  [31:0] uart_axi_rdata,
    input  [1:0]  uart_axi_rresp,
`endif

    // CLINT从设备
    // output        clint_axi_awvalid,
    // input         clint_axi_awready,
    // output [31:0] clint_axi_awaddr,
    
    // output        clint_axi_wvalid,
    // input         clint_axi_wready,
    // output [31:0] clint_axi_wdata,
    
    // input         clint_axi_bvalid,
    // output        clint_axi_bready,
    // input  [1:0]  clint_axi_bresp,

    output        clint_axi_arvalid,
    input         clint_axi_arready,
    output [31:0] clint_axi_araddr,
    
    input         clint_axi_rvalid,
    output        clint_axi_rready,
    input  [31:0] clint_axi_rdata,
    input  [1:0]  clint_axi_rresp,
    input         clint_axi_rlast

`ifdef VERILATOR_SIM
    // Access Fault信号
    ,output  [1:0]  Access_Fault
`endif
);

    // 地址定义
`ifndef NPC
    parameter UART_ADDR     = 32'h1000_0000;
    parameter CLINT_ADDR    = 32'h0200_0000;
`else
    parameter UART_ADDR     = 32'ha000_03f8;
    parameter CLINT_ADDR    = 32'ha000_0048;
`endif

    // ================== 仲裁器逻辑 ==================
    parameter   ARB_IDLE        = 3'b000,
                ARB_IFU_READ    = 3'b001,
                ARB_MEMU_READ   = 3'b010,
                ARB_MEMU_WRITE  = 3'b100;

    parameter   IDLE = 0, BUSY = 1;

    reg [1:0] axi_state;
    reg [2:0] targeted_module;
    wire [31:0] real_sram_data;

    // 仲裁状态机
`ifndef NPC
    always @(posedge clk) begin
        if(reset) begin
            axi_state <= IDLE;
            targeted_module <= ARB_IDLE;
        end else begin
            case(axi_state)
                IDLE: begin
                    if(mem_axi_awvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_MEMU_WRITE;
                    end else if(ifu_axi_arvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_IFU_READ;
                    end else if(mem_axi_arvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_MEMU_READ;
                    end
                end
                BUSY: begin
                    if((targeted_module == ARB_IFU_READ || targeted_module == ARB_MEMU_READ) && 
                       ((sram_axi_rready && sram_axi_rvalid && sram_axi_rlast) || (clint_axi_rready && clint_axi_rvalid && clint_axi_rlast))) begin
                        axi_state <= IDLE;
                        targeted_module <= ARB_IDLE;
                    end else if(targeted_module == ARB_MEMU_WRITE && 
                               sram_axi_bready && sram_axi_bvalid) begin
                        axi_state <= IDLE;
                        targeted_module <= ARB_IDLE;
                    end
                end
            endcase
        end
    end
`else
    // NPC需要判断UART的写入是否完成
    always @(posedge clk) begin
        if(reset) begin
            axi_state <= IDLE;
            targeted_module <= ARB_IDLE;
        end else begin
            case(axi_state)
                IDLE: begin
                    if(mem_axi_awvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_MEMU_WRITE;
                    end else if(ifu_axi_arvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_IFU_READ;
                    end else if(mem_axi_arvalid) begin
                        axi_state <= BUSY;
                        targeted_module <= ARB_MEMU_READ;
                    end
                end
                BUSY: begin
                    if((targeted_module == ARB_IFU_READ || targeted_module == ARB_MEMU_READ) && 
                       ((sram_axi_rready && sram_axi_rvalid && sram_axi_rlast) || (clint_axi_rready && clint_axi_rvalid && clint_axi_rlast))) begin
                        axi_state <= IDLE;
                        targeted_module <= ARB_IDLE;
                    end else if(targeted_module == ARB_MEMU_WRITE && 
                               ((sram_axi_bready && sram_axi_bvalid) || (uart_axi_bready && uart_axi_bvalid)) ) begin
                        axi_state <= IDLE;
                        targeted_module <= ARB_IDLE;
                    end
                end
            endcase
        end
    end
`endif

    // ================== 地址解码 ==================
`ifndef NPC
    // wire sel_clint  =   (mem_axi_araddr >= CLINT_ADDR && mem_axi_araddr < (CLINT_ADDR + 32'h0000_ffff) && targeted_module == ARB_MEMU_READ);
    // wire sel_uart   =   (mem_axi_araddr >= UART_ADDR && mem_axi_araddr < (UART_ADDR + 32'h0000_1000) && targeted_module == ARB_MEMU_READ);
    // wire sel_spi    =   (mem_axi_araddr >= SPI_ADDR && mem_axi_araddr < (SPI_ADDR + 32'h0000_1000) && targeted_module == ARB_MEMU_READ) || 
    //                     (ifu_axi_araddr >= SPI_ADDR && ifu_axi_araddr < (SPI_ADDR + 32'h0000_1000) && targeted_module == ARB_IFU_READ);
    wire sel_clint  =   (mem_axi_araddr[31:16] == CLINT_ADDR[31:16] && targeted_module == ARB_MEMU_READ);
    wire sel_uart   =   (mem_axi_araddr[31:12] == UART_ADDR[31:12] && targeted_module == ARB_MEMU_READ);
    wire sel_spi    =   (mem_axi_araddr[31:12] == SPI_ADDR[31:12] && targeted_module == ARB_MEMU_READ) || 
                        (ifu_axi_araddr[31:12] == SPI_ADDR[31:12] && targeted_module == ARB_IFU_READ);
    wire sel_sram   =    ~sel_clint;
`else
    wire sel_uart   = (mem_axi_awaddr >= UART_ADDR && mem_axi_awaddr < (UART_ADDR + 32'h0000_0008) && targeted_module == ARB_MEMU_WRITE);
    wire sel_clint  = (mem_axi_araddr >= CLINT_ADDR && mem_axi_araddr < (CLINT_ADDR + 32'h0000_0008) && targeted_module == ARB_MEMU_READ);
    wire sel_sram   = ~sel_uart & ~sel_clint;
    wire sel_spi    = 1'b0;
`endif

    // ================== 主设备到仲裁器的连接 ==================
    // IFU读通道
    wire ifu_arready  = (targeted_module == ARB_IFU_READ) ? sram_axi_arready : 1'b0;
    wire ifu_rvalid   = (targeted_module == ARB_IFU_READ) ? sram_axi_rvalid  : 1'b0;
    wire ifu_rlast    = (targeted_module == ARB_IFU_READ) ? sram_axi_rlast   : 1'b0;

    // MEMU读通道
    wire mem_arready  = (targeted_module == ARB_MEMU_READ) ? sram_axi_arready : 1'b0;
    wire mem_rvalid   = (targeted_module == ARB_MEMU_READ) ? sram_axi_rvalid  : 1'b0;
    wire mem_rlast    = (targeted_module == ARB_MEMU_READ) ? sram_axi_rlast   : 1'b0;

    // MEMU写通道
    wire mem_awready  = (targeted_module == ARB_MEMU_WRITE) ? sram_axi_awready : 1'b0;
    wire mem_wready   = (targeted_module == ARB_MEMU_WRITE) ? sram_axi_wready  : 1'b0;
    wire mem_bvalid   = (targeted_module == ARB_MEMU_WRITE) ? sram_axi_bvalid  : 1'b0;

    // ================== 仲裁器到SRAM的连接 ==================
    wire sram_arvalid = (targeted_module == ARB_MEMU_READ) ? mem_axi_arvalid : 
                       ((targeted_module == ARB_IFU_READ) ? ifu_axi_arvalid : 1'b0);
    wire sram_rready  = (targeted_module == ARB_MEMU_READ) ? mem_axi_rready : 
                       ((targeted_module == ARB_IFU_READ) ? ifu_axi_rready : 1'b0);
    wire [31:0] sram_araddr = (targeted_module == ARB_MEMU_READ) ? mem_axi_araddr : 
                             ((targeted_module == ARB_IFU_READ) ? ifu_axi_araddr : 32'b0);

    // AXI新增信号
    wire [7:0] sram_arlen = (targeted_module == ARB_MEMU_READ) ? mem_axi_arlen :
                           ((targeted_module == ARB_IFU_READ) ? ifu_axi_arlen : 8'h0);
    wire [2:0] sram_arsize = (targeted_module == ARB_MEMU_READ) ? mem_axi_arsize :
                            ((targeted_module == ARB_IFU_READ) ? ifu_axi_arsize : 3'h0);

    wire [1:0] sram_addr_suffix = (targeted_module == ARB_MEMU_READ) ? mem_axi_addr_suffix : 2'b0;

    // 写入的实际数据，数据需要移位的
    wire [31:0] real_axi_wdata = 
        (mem_axi_wstrb == 4'b0001) ? {24'b0, mem_axi_wdata[7:0]} :
        (mem_axi_wstrb == 4'b0010) ? {16'b0, mem_axi_wdata[7:0], 8'b0} :
        (mem_axi_wstrb == 4'b0100) ? {8'b0, mem_axi_wdata[7:0], 16'b0} :
        (mem_axi_wstrb == 4'b1000) ? {mem_axi_wdata[7:0], 24'b0} :
        (mem_axi_wstrb == 4'b0011) ? {16'b0, mem_axi_wdata[15:0]} :
        (mem_axi_wstrb == 4'b0110) ? {8'b0, mem_axi_wdata[15:0], 8'b0} :
        (mem_axi_wstrb == 4'b1100) ? {mem_axi_wdata[15:0], 16'b0} :
        (mem_axi_wstrb == 4'b1111) ? mem_axi_wdata : 32'b0;

    // SRAM写通道
    wire sram_awvalid = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_awvalid : 1'b0;
    wire [31:0] sram_awaddr = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_awaddr : 32'b0;
    wire sram_wvalid = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_wvalid : 1'b0;
    wire sram_bready = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_bready : 1'b0;

    // AXI新增信号
    wire [7:0] sram_awlen = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_awlen : 8'h0;
    wire [2:0] sram_awsize = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_awsize : 3'h0;
    wire [3:0] sram_wstrb = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_wstrb : 4'h0;
    wire sram_wlast = (targeted_module == ARB_MEMU_WRITE) ? mem_axi_wlast : 1'b0;

    // ================== 读数据通道寄存器 ==================
    // reg [31:0] ifu_rdata_reg;
    // reg [31:0] mem_rdata_reg;

    // 根据非对齐地址来进行选择读取内存的数据
    // assign real_sram_data = 
    //     (sram_arsize == 3'b000) ? // lb / lbu指令，读取一个字节
    //         ((sram_addr_suffix == 2'b00) ? {24'b0, sram_axi_rdata[7:0]} :
    //          (sram_addr_suffix == 2'b01) ? {24'b0, sram_axi_rdata[15:8]} :
    //          (sram_addr_suffix == 2'b10) ? {24'b0, sram_axi_rdata[23:16]} :
    //          (sram_addr_suffix == 2'b11) ? {24'b0, sram_axi_rdata[31:24]} : 32'b0) :
    //     (sram_arsize == 3'b001) ? // lh / lhu指令，读取两个字节
    //         ((sram_addr_suffix == 2'b00) ? {16'b0, sram_axi_rdata[15:0]} :
    //          (sram_addr_suffix == 2'b01) ? {16'b0, sram_axi_rdata[23:8]} :
    //          (sram_addr_suffix == 2'b10) ? {16'b0, sram_axi_rdata[31:16]} : 32'b0) :
    //     (sram_arsize == 3'b010) ? // lw指令，读取四个字节
    //         ((sram_addr_suffix == 2'b00) ? sram_axi_rdata : 32'b0) : 32'b0;
    
    // 真正读取的数据寄存
    wire [31:0] real_read_data = (sel_clint) ? clint_axi_rdata : sram_axi_rdata;

    // always @(posedge clk) begin
    //     if (reset) begin
    //         ifu_rdata_reg <= 32'b0;
    //         mem_rdata_reg <= 32'b0;
    //     end else begin
    //         if (targeted_module == ARB_IFU_READ && (sram_axi_rvalid || clint_axi_rvalid)) 
    //             ifu_rdata_reg <= real_read_data;
    //         if (targeted_module == ARB_MEMU_READ && (sram_axi_rvalid || clint_axi_rvalid)) 
    //             mem_rdata_reg <= real_read_data;
    //     end
    // end

    // 最终输出连接
    // assign ifu_axi_rdata = (targeted_module == ARB_IFU_READ && sram_axi_rvalid) ? real_read_data : ifu_rdata_reg;
    // assign mem_axi_rdata = (targeted_module == ARB_MEMU_READ && (sram_axi_rvalid || clint_axi_rvalid)) ? real_read_data : mem_rdata_reg;
    assign ifu_axi_rdata = real_read_data;
    assign mem_axi_rdata = real_read_data;

    // ================== 交叉开关逻辑 ==================
    // 写通道路由
    // SRAM
    assign sram_axi_awvalid = sel_sram ? sram_awvalid : 0;
    assign sram_axi_awaddr = sel_sram ? sram_awaddr : 32'h0;
    assign sram_axi_wvalid = sel_sram ? sram_wvalid : 0;
    assign sram_axi_wdata = sel_sram ? real_axi_wdata : 32'h0;
    assign sram_axi_bready = sel_sram ? sram_bready : 0;

`ifdef NPC
    // UART
    assign uart_axi_awvalid = sel_uart ? mem_axi_awvalid : 0;
    assign uart_axi_awaddr = sel_uart ? mem_axi_awaddr : 32'h0;
    assign uart_axi_wvalid = sel_uart ? mem_axi_wvalid : 0;
    assign uart_axi_wdata = sel_uart ? mem_axi_wdata : 32'h0;
    assign uart_axi_wstrb = sel_uart ? mem_axi_wstrb : 4'h0;
    assign uart_axi_bready = sel_uart ? mem_axi_bready : 0;
`endif

    // 读通道路由
    // SRAM
    assign sram_axi_arvalid = sel_sram ? sram_arvalid : 0;
    assign sram_axi_araddr = sel_sram ? sram_araddr : 32'h0;
    assign sram_axi_rready = sel_sram ? sram_rready : 0;

`ifdef NPC
    // UART
    assign uart_axi_arvalid = 0;
    assign uart_axi_araddr = 32'h0;
    assign uart_axi_rready = 0;
`endif

    // CLINT
    assign clint_axi_arvalid = sel_clint ? mem_axi_arvalid : 0;
    assign clint_axi_araddr = sel_clint ? mem_axi_araddr : 32'h0;
    assign clint_axi_rready = sel_clint ? mem_axi_rready : 0;

    // ================== 响应合并 ==================
`ifndef NPC
    // 响应合并（无NPC）
    assign ifu_axi_arready = sel_sram ? ifu_arready : 0;
    assign ifu_axi_rvalid = sel_sram ? ifu_rvalid : 0;
    assign ifu_axi_rresp = sel_sram ? sram_axi_rresp : 2'b00;
    assign ifu_axi_rlast = sel_sram ? ifu_rlast : 0;

    assign mem_axi_arready = sel_sram ? mem_arready : 
                            sel_clint ? clint_axi_arready : 0;
    assign mem_axi_rvalid = sel_sram ? mem_rvalid : 
                           sel_clint ? clint_axi_rvalid : 0;
    assign mem_axi_rresp = sel_sram ? sram_axi_rresp : 
                          sel_clint ? clint_axi_rresp : 2'b00;
    assign mem_axi_rlast = sel_sram ? mem_rlast : 
                          sel_clint ? clint_axi_rlast : 0;

    assign mem_axi_awready = sel_sram ? mem_awready : 0;
    assign mem_axi_wready = sel_sram ? mem_wready : 0;
    assign mem_axi_bvalid = sel_sram ? mem_bvalid : 0;
    assign mem_axi_bresp = sel_sram ? sram_axi_bresp : 2'b00;
`else
    // 响应合并（有NPC）
    assign ifu_axi_arready = sel_sram ? ifu_arready : 0;
    assign ifu_axi_rvalid = sel_sram ? ifu_rvalid : 0;
    assign ifu_axi_rresp = sel_sram ? sram_axi_rresp : 2'b00;
    assign ifu_axi_rlast = sel_sram ? ifu_rlast : 0;

    assign mem_axi_arready = sel_sram ? mem_arready : 
                            sel_uart ? uart_axi_arready : 
                            sel_clint ? clint_axi_arready : 0;
    assign mem_axi_rvalid = sel_sram ? mem_rvalid : 
                           sel_uart ? uart_axi_rvalid : 
                           sel_clint ? clint_axi_rvalid : 0;
    assign mem_axi_rresp = sel_sram ? sram_axi_rresp : 
                          sel_uart ? uart_axi_rresp : 
                          sel_clint ? clint_axi_rresp : 2'b00;
    assign mem_axi_rlast = sel_sram ? mem_rlast : 
                          sel_uart ? 1'b1 : 
                          sel_clint ? clint_axi_rlast : 0;

    assign mem_axi_awready = sel_sram ? mem_awready : 
                            sel_uart ? uart_axi_awready : 0;
    assign mem_axi_wready = sel_sram ? mem_wready : 
                           sel_uart ? uart_axi_wready : 0;
    assign mem_axi_bvalid = sel_sram ? mem_bvalid : 
                           sel_uart ? uart_axi_bvalid : 0;
    assign mem_axi_bresp = sel_sram ? sram_axi_bresp : 
                          sel_uart ? uart_axi_bresp : 2'b00;
`endif

    // ================== AXI信号传递 ==================
    assign sram_axi_arlen = sram_arlen;
    assign sram_axi_arsize = sel_uart ? 3'b000 : (sel_spi ? sram_arsize : 3'b010);
    assign sram_axi_awlen = sram_awlen;
    assign sram_axi_awsize = sram_awsize;
    assign sram_axi_wstrb = sram_wstrb;
    assign sram_axi_wlast = sram_wlast;

`ifdef VERILATOR_SIM
    // Acess Fault信号
    assign Access_Fault = (sram_axi_rresp != 2'b00 || clint_axi_rresp != 2'b00) ? 2'b01 : 
                         ((sram_axi_bresp != 2'b00) ? 2'b10 : 2'b00);
`endif

endmodule
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
    output  [1:0]       ifu_axi_rresp,
    output  [31:0]      ifu_axi_rdata,
    
    // AXI 新增信号
    input 	reg	[7:0]	ifu_axi_arlen,
	input 	reg	[2:0]	ifu_axi_arsize,
	output 	reg			ifu_axi_rlast,

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
	// 读通道
	input 	reg	[7:0]	mem_axi_arlen,
	input 	reg	[2:0]	mem_axi_arsize,
	output 	reg			mem_axi_rlast,
	// 写通道
	input 	reg	[7:0]	mem_axi_awlen,
	input 	reg	[2:0]	mem_axi_awsize,
	input 	reg [3:0]	mem_axi_wstrb,
	input 	reg			mem_axi_wlast,
    

    // ================== SRAM接口 ==================
    // 读地址通道
    output              sram_axi_arvalid,
    input               sram_axi_arready,
    output  [31:0]      sram_axi_araddr,
    // 读数据通道
    input               sram_axi_rvalid,
    output              sram_axi_rready,
    input   [1:0]       sram_axi_rresp,
    input   [31:0]      sram_axi_rdata,
    // 写地址通道
    output              sram_axi_awvalid,
    input               sram_axi_awready,
    output  reg[31:0]   sram_axi_awaddr,
    // 写数据通道
    output              sram_axi_wvalid,
    input               sram_axi_wready,
    output  [31:0]      sram_axi_wdata,
    // 写响应通道
    input               sram_axi_bvalid,
    output              sram_axi_bready,
    input   [1:0]       sram_axi_bresp,

    // 新增AXI信号
	// 读通道
	output 	reg	[7:0]	sram_axi_arlen,
	output 	reg	[2:0]	sram_axi_arsize,
	input 	reg			sram_axi_rlast,
	// 写通道
	output 	reg	[7:0]	sram_axi_awlen,
	output 	reg	[2:0]	sram_axi_awsize,
	output 	reg [3:0]	sram_axi_wstrb,
	output 	reg			sram_axi_wlast
);

    parameter   ARB_IDLE        = 3'b000,   // 空闲状态
                ARB_IFU_READ    = 3'b001,   // IF进行读操作
                ARB_MEMU_READ   = 3'b010,   // MEMU进行读操作
                ARB_MEMU_WRITE  = 3'b100;   // MEMU进行写操作

    // ================== 读仲裁状态机 ==================
    parameter   IDLE = 0, BUSY = 1;

    reg [1:0] axi_state;                // AXI目前的状态
    reg [2:0] read_targeted_module;     // 当前是哪一个模块进行读操作

    // ================== 读操作 ==================
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
    assign ifu_axi_rresp    =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rresp   : 2'b0;
    // assign ifu_axi_rdata    =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rdata   : 32'b0;

    // AXI新增信号
    assign ifu_axi_rlast    =   (read_targeted_module == ARB_IFU_READ) ? sram_axi_rlast    : 1'b0;

    // MEMU 读通道
    assign mem_axi_arready  =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_arready : 1'b0;
    assign mem_axi_rvalid   =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rvalid  : 1'b0;
    assign mem_axi_rresp    =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rresp   : 2'b0;
    // assign mem_axi_rdata    =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rdata   : 32'b0; 

    // AXI新增信号
    assign mem_axi_rlast    =   (read_targeted_module == ARB_MEMU_READ) ? sram_axi_rlast    : 1'b0;

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

    // AXI 新增信号
    assign sram_axi_arlen   =   (read_targeted_module == ARB_MEMU_READ) ? mem_axi_arlen   :
                                ((read_targeted_module == ARB_IFU_READ)) ? ifu_axi_arlen  : 8'h0;
    assign sram_axi_arsize   =   (read_targeted_module == ARB_MEMU_READ) ? mem_axi_arsize :
                                ((read_targeted_module == ARB_IFU_READ)) ? ifu_axi_arsize : 3'h0;

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


    // ================== SRAM写仲裁状态机 ==================
    parameter   W_IDLE = 0, W_BUSY = 1;

    reg [1:0] axi_state_w;                // AXI目前的状态
    reg [2:0] write_targeted_module;     // 当前是哪一个模块进行读操作
    // ================== 写操作 ==================
    always @(posedge clk) begin
        if(reset) begin
            axi_state_w             <= IDLE;
            write_targeted_module   <= ARB_IDLE;
        end else begin
            case(axi_state_w)
                W_IDLE: begin     // 空闲状态
                    // 固定优先级
                    // MEMU优先策略
                    if(mem_axi_awvalid == 1'b1) begin
                        axi_state_w             <= W_BUSY;
                        write_targeted_module   <= ARB_MEMU_WRITE;
                    end
                end

                W_BUSY: begin     // 总线不是空闲状态
                    // 现在只是针对单次传输，没有突发传输，表示一次读传输完成
                    if(sram_axi_bready == 1'b1 && sram_axi_bvalid == 1'b1) begin
                        axi_state_w             <= W_IDLE;
                        write_targeted_module   <= ARB_IDLE;
                    end
                end
            endcase
        end
    end

    // 写入的实际数据，数据需要移位的
    wire [31:0] real_axi_wdata;
    assign real_axi_wdata = (mem_axi_wstrb == 4'b0001) ? ({24'b0,mem_axi_wdata[7:0]}) :
                                (mem_axi_wstrb == 4'b0010) ? ({16'b0,mem_axi_wdata[7:0],8'b0}) :
                                (mem_axi_wstrb == 4'b0100) ? ({8'b0,mem_axi_wdata[7:0],16'b0}) :
                                (mem_axi_wstrb == 4'b1000) ? ({mem_axi_wdata[7:0],24'b0}) :
                                // sh 指令
                                (mem_axi_wstrb == 4'b0011) ? ({16'b0,mem_axi_wdata[15:0]}) :
                                (mem_axi_wstrb == 4'b0110) ? ({8'b0,mem_axi_wdata[15:0],8'b0}) :
                                (mem_axi_wstrb == 4'b1100) ? ({mem_axi_wdata[15:0],16'b0}) :
                                // sw 指令
                                (mem_axi_wstrb == 4'b1111) ? mem_axi_wdata : 32'b0;



    // SRAM 写通道
    assign sram_axi_awvalid =   mem_axi_awvalid;
    assign sram_axi_wvalid  =   mem_axi_wvalid;
    assign sram_axi_bready  =   mem_axi_bready;
`ifdef YSYXSOC
    assign sram_axi_awaddr  =   mem_axi_awaddr; //  写地址可以一直传输,但是只有当valid=1时才能够有效
`else
    assign sram_axi_awaddr  =   (write_targeted_module == ARB_MEMU_WRITE) ? mem_axi_awaddr : 32'b0;
`endif
    assign sram_axi_wdata   =   real_axi_wdata;

    // AXI新增信号
    assign sram_axi_awlen   =   mem_axi_awlen;
    assign sram_axi_awsize  =   mem_axi_awsize;
    assign sram_axi_wstrb   =   mem_axi_wstrb;
    assign sram_axi_wlast   =   mem_axi_wlast;

endmodule
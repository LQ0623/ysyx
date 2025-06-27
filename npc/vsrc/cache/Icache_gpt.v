// GPT写的，可以参考其中的一些逻辑的写法，这个在sdram的控制器中也是这么使用的状态机
module Icache_gpt (
    input               clk,        // 时钟
    input               rst,        // 复位
//cpu <---> icache
    input               cpu_arvalid_i,
    output reg          cpu_arready_o,
    input [31:0]        cpu_araddr_i,

    output reg          cpu_rvalid_o,
    input               cpu_rready_i,
    output reg [31:0]   cpu_rdata_o,
        
// icache <---> cpu
    output reg          axi_arvalid_o,
    input  reg          axi_arready_i,
    output reg [31:0]   axi_araddr_o,

    input               axi_rvalid_i,
    output reg          axi_rready_o,
    input  reg [31:0]   axi_rdata_i

);


    // 缓存参数
    parameter BLOCK_SIZE    = 4;            // cache块大小 (bytes)
    parameter NUM_BLOCKS    = 16;           // cache块数量
    parameter INDEX_WIDTH   = 4;            // 索引位宽 (log2(NUM_BLOCKS))
    parameter OFFSET_WIDTH  = 2;            // 偏移位宽 (log2(BLOCK_SIZE))
    parameter TAG_WIDTH     = 32 - INDEX_WIDTH - OFFSET_WIDTH; // Tag位宽

    // ===================== 缓存存储结构 ======================
    reg [TAG_WIDTH-1:0]   tags [0:NUM_BLOCKS-1];    // Tag存储
    reg [31:0]            data [0:NUM_BLOCKS-1];    // 数据存储
    reg                   valid [0:NUM_BLOCKS-1];   // 有效位

    // ======================= 内部信号 =======================
    wire [OFFSET_WIDTH-1:0] offset;      // 地址偏移
    wire [INDEX_WIDTH-1:0]  index;       // 地址索引
    wire [TAG_WIDTH-1:0]    tag;         // 地址Tag

    reg  [31:0]             req_addr;    // 当前请求地址
    reg                     req_pending; // 请求挂起标志

    // ======================== 状态机 ========================
    typedef enum logic [1:0] {
        IDLE,         // 空闲状态
        CHECK_CACHE,  // 检查缓存
        MEM_READ,     // 主存读取
        SEND_RESP     // 发送响应
    } state_t;

    state_t current_state, next_state;

    // 状态寄存器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) current_state <= IDLE;
        else current_state <= next_state;
    end

    // 下一状态逻辑
    always @(*) begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (cpu_arvalid_i && cpu_arready_o) 
                    next_state = CHECK_CACHE;
            end
            
            CHECK_CACHE: begin
                if (valid[index] && (tags[index] == tag))
                    next_state = SEND_RESP;  // 命中
                else
                    next_state = MEM_READ;    // 未命中
            end
            
            MEM_READ: begin
                if (axi_rvalid_i && axi_rready_o) 
                    next_state = SEND_RESP;
            end
            
            SEND_RESP: begin
                if (cpu_rvalid && cpu_rready) 
                    next_state = IDLE;
            end
        endcase
    end

    // ====================== 地址解析 ========================
    assign offset = req_addr[OFFSET_WIDTH-1:0];
    assign index  = req_addr[OFFSET_WIDTH+INDEX_WIDTH-1:OFFSET_WIDTH];
    assign tag    = req_addr[31:OFFSET_WIDTH+INDEX_WIDTH];

// cpu <---> icache
    // 读地址通道
    always @(posedge clk) begin
        if(rst)begin
            req_addr            <= 32'b0;
            req_pending         <= 1'b0;
            cpu_axi_arready_o   <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    cpu_arready_o       <= 1'b1;
                    if(cpu_arvalid_i == 1'b1 && cpu_arready_o == 1'b1)begin
                        req_addr        <= cpu_araddr_i;
                        req_pending     <= 1'b1;
                        cpu_arready_o   <= 1'b0;    //  表示现在无法接收新的请求
                    end
                end
                
                SEND_RESP: begin
                    // 响应完成后准备接收新请求
                    if (cpu_rvalid_o && cpu_rready_i) begin
                        cpu_arready_o       <= 1'b1;
                        req_pending         <= 1'b0;
                    end
                end

                default: begin
                    cpu_arready_o           <= 1'b0;
                end
            endcase
        end
    end

    // 读数据通道
    always @(posedge clk) begin
        if(rst)begin
            cpu_rvalid_o        <= 1'b0;
            cpu_rdata_o         <= 32'b0;
        end else begin
            case (current_state)
                CHECK_CACHE: begin
                    // 缓存命中
                    if (valid[index] && (tags[index] == tag)) begin
                        cpu_rdata_o  <= data[index];
                        cpu_rvalid_o <= 1'b1;
                    end
                end

                MEM_READ: begin
                    // 主存读取完成
                    if (axi_rvalid_i && axi_rready_o) begin
                        cpu_rdata_o  <= axi_rdata_i;
                        cpu_rvalid_o <= 1'b1;
                    end
                end
                
                SEND_RESP: begin
                    // 响应完成
                    if (cpu_rvalid_o && cpu_rready_i) begin
                        cpu_rvalid_o <= 1'b0;
                    end
                end
                
                default: begin
                    cpu_rvalid_o <= 1'b0;
                end
            endcase
        end
    end

// icache <---> MEM
    // 读地址通道
    always @(posedge clk) begin
        if(rst)begin
            axi_arvalid_o   <= 1'b0;
            axi_araddr_o    <= 32'b0;
        end else begin
            case (current_state)
                CHECK_CACHE: begin
                    // 缓存未命中 - 发起主存请求
                    if (!(valid[index] && (tags[index] == tag))) begin
                        axi_araddr_o  <= req_addr;
                        axi_arvalid_o <= 1'b1;
                    end
                end
                
                MEM_READ: begin
                    // 地址被接收
                    if (axi_arvalid_o && axi_arready_i) begin
                        axi_arvalid_o <= 1'b0;
                    end
                end
                
                default: begin
                    if (!req_pending) begin
                        axi_arvalid_o <= 1'b0;
                    end
                end
            endcase
        end
    end

    // 读数据通道
    always @(posedge clk) begin
        if (rst) begin
            axi_rready_o <= 1'b0;
        end else begin
            case (current_state)
                MEM_READ: begin
                    axi_rready_o <= 1'b1;  // 准备接收数据
                    
                    // 数据接收完成
                    if (axi_rvalid_i && axi_rready_o) begin
                        axi_rready_o <= 1'b0;
                    end
                end
                
                default: begin
                    axi_rready_o <= 1'b0;
                end
            endcase
        end
    end

// ===================== 缓存更新逻辑 =====================
    always @(posedge clk or negedge rst) begin
        integer i;
        if (rst) begin
            // 复位缓存
            for (i = 0; i < NUM_BLOCKS; i = i + 1) begin
                valid[i]    <= 1'b0;
                tags[i]     <= {TAG_WIDTH{1'b0}};
                data[i]     <= 32'b0;
            end
        end else begin
            // 主存读取完成 - 更新缓存
            if (axi_rvalid_i && axi_rready_o) begin
                data[index]  <= axi_rdata_i;  // 更新数据
                tags[index]  <= tag;          // 更新Tag
                valid[index] <= 1'b1;         // 置位有效位
            end
        end
    end


endmodule

/* 
    31     11 9    4 3      0                   127       0
   +---------+-------+--------+                 +---------+
   |   tag   | index | offset |                  cache_data
   +---------+-------+--------+                 +---------+   
*/
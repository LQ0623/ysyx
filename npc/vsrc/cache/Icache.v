module Icache#(
    parameter SRAM_BASE_ADDR    = 32'h0f00_0000,
    parameter SRAM_SIZE         = 32'h00ff_ffff
)(
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
    input [31:0]        axi_rdata_i,


    output reg          hit // 是否Cache命中
);


    // 缓存参数
    parameter BLOCK_SIZE    = 16;           // cache块大小 (bytes),四个字节
    parameter NUM_BLOCKS    = 16;           // cache块数量
    parameter INDEX_WIDTH   = 4;            // 索引位宽 (log2(NUM_BLOCKS))
    parameter OFFSET_WIDTH  = 4;            // 偏移位宽 (log2(BLOCK_SIZE))
    parameter TAG_WIDTH     = 32 - INDEX_WIDTH - OFFSET_WIDTH; // Tag位宽



    // 缓存存储结构 (使用触发器)
    reg [TAG_WIDTH-1:0]   tags [0:NUM_BLOCKS-1];    // 存储Tag
    // reg [31:0]            data [0:NUM_BLOCKS-1];    // 存储数据
    reg [127:0]           cache_data [0:NUM_BLOCKS-1];    // 存储数据(存储四条指令)
    reg                   valid[0:NUM_BLOCKS-1];    // 有效位

    // ======================= 内部信号 =======================
    wire [OFFSET_WIDTH-1:0] offset;         // 地址偏移
    wire [INDEX_WIDTH-1:0]  index;          // 地址索引
    wire [TAG_WIDTH-1:0]    tag;            // 地址Tag

    reg  [31:0]             req_addr;       // 当前请求地址
    reg  [31:0]             resp_data;      // 缓存数据
    wire                    cache_update;   // 是否更新缓存
    reg                     bypass;         // 是否绕过缓存标志

    reg [1:0]               fill_count;         // 缓存块填充计数器 (0-3)
    reg [31:0]              fill_base_addr;     // 当前填充的基地址
    reg [3:0]               fill_index;         // 当前填充的缓存索引
    wire                    fill_end;           // 填充是否结束

    // ====================== 地址解析 ========================
    assign offset = req_addr[OFFSET_WIDTH-1:0];
    assign index  = req_addr[OFFSET_WIDTH+INDEX_WIDTH-1:OFFSET_WIDTH];
    assign tag    = req_addr[31:OFFSET_WIDTH+INDEX_WIDTH];

    // ================== SRAM地址检测 ===================
    wire is_sram_addr;
    assign is_sram_addr = (cpu_araddr_i >= SRAM_BASE_ADDR) && (cpu_araddr_i < (SRAM_BASE_ADDR + SRAM_SIZE));

    // 状态定义
    typedef enum logic [2:0] {
        IDLE,               // 空闲状态
        CHECK_CACHE,        // 检查缓存
        MEM_READ_ADDR,      // 内存读地址阶段
        MEM_READ_DATA,      // 内存读数据阶段
        FILL_BLOCK,         // 填充缓存块
        BYPASS_READ_ADDR,   // 绕过缓存的读地址阶段
        BYPASS_READ_DATA,   // 绕过缓存的读数据阶段
        SEND_RESP           // 发送响应
    } state_t;
    state_t state;

    // 状态机
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state           <= IDLE;

            // 内部信号
            req_addr        <= 32'b0;
            resp_data       <= 32'b0;
            bypass          <= 1'b0;
            hit             <= 1'b0;
            fill_count      <= 2'b0;
            fill_base_addr  <= 32'b0;
            fill_index      <= 4'b0;

            // axi协议
            cpu_arready_o   <= 1'b0;
            cpu_rvalid_o    <= 1'b0;
            cpu_rdata_o     <= 32'b0;

            axi_arvalid_o   <= 1'b0;
            axi_araddr_o    <= 32'b0;
            axi_rready_o    <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (cpu_arvalid_i) begin
                        cpu_arready_o       <= 1'b1;            // 准备接收新请求
                        cpu_rvalid_o        <= 1'b0;            // 确保响应无效

                        if(cpu_arvalid_i == 1'b1 && cpu_arready_o == 1'b1)begin
                            cpu_arready_o   <= 1'b0;            // 接收后不再就绪
                            req_addr        <= cpu_araddr_i;    // 锁存地址

                            // 检查是否需要绕过缓存
                            if (is_sram_addr) begin
                                bypass      <= 1'b1;
                                state       <= BYPASS_READ_ADDR;
                            end else begin
                                bypass      <= 1'b0;
                                state       <= CHECK_CACHE;
                            end
                        end
                    end else begin
                        hit <= 1'b0;
                    end
                end
                
                CHECK_CACHE: begin
                    if (valid[index] && (tags[index] == tag)) begin
                        // 命中: 从缓存读取数据
                        hit             <= 1'b1;
                        // resp_data       <= data[index];

                        // 根据偏移量选择缓存块中的指令
                        case (offset[3:2])
                            2'b00: resp_data <= cache_data[index][31:0];
                            2'b01: resp_data <= cache_data[index][63:32];
                            2'b10: resp_data <= cache_data[index][95:64];
                            2'b11: resp_data <= cache_data[index][127:96];
                        endcase

                        state           <= SEND_RESP;       // 命中
                    end else begin
                        // 未命中: 发起内存读请求
                        // axi_arvalid_o   <= 1'b1;
                        // axi_araddr_o    <= req_addr;

                        fill_count      <= 2'b0;
                        fill_base_addr  <= {req_addr[31:4], 4'b0}; // 对齐到16B边界
                        fill_index      <= index;
                        
                        hit             <= 1'b0;
                        state           <= MEM_READ_ADDR;
                    end
                end

                MEM_READ_ADDR: begin
                    axi_arvalid_o       <= 1'b1;
                    axi_araddr_o        <= fill_base_addr + {28'b0,fill_count,2'b0}; // 每次4B

                    if(axi_arready_i == 1'b1 && axi_arvalid_o == 1'b1)begin
                        axi_arvalid_o   <= 1'b0;
                        state           <= MEM_READ_DATA;
                    end
                end

                MEM_READ_DATA: begin
                    axi_rready_o        <= 1'b1;

                    if (axi_rready_o == 1'b1 && axi_rvalid_i == 1'b1) begin
                        
                        axi_rready_o <= 1'b0;
                        fill_count <= fill_count + 1;
                        
                        if (fill_count == 2'b11) begin                    
                            // 返回请求的指令
                            case (offset[3:2])
                                2'b00: resp_data    <= cache_data[fill_index][31:0];
                                2'b01: resp_data    <= cache_data[fill_index][63:32];
                                2'b10: resp_data    <= cache_data[fill_index][95:64];
                                2'b11: resp_data    <= cache_data[fill_index][127:96];
                            endcase
                            
                            state   <= FILL_BLOCK;
                            // state <= SEND_RESP;
                        end else begin
                            // 继续填充缓存块
                            state <= MEM_READ_ADDR;
                        end
                    end

                    // if(axi_rready_o == 1'b1 && axi_rvalid_i == 1'b1)begin
                    //     axi_rready_o    <= 1'b0;
                    //     resp_data       <= axi_rdata_i;
                    //     state           <= SEND_RESP;
                    // end
                end

                // 需要等待缓存块填写完毕,然后才能读
                FILL_BLOCK: begin
                    // 返回请求的指令
                    case (offset[3:2])
                        2'b00: resp_data    <= cache_data[fill_index][31:0];
                        2'b01: resp_data    <= cache_data[fill_index][63:32];
                        2'b10: resp_data    <= cache_data[fill_index][95:64];
                        2'b11: resp_data    <= cache_data[fill_index][127:96];
                    endcase
                    state <= SEND_RESP;
                end

                BYPASS_READ_ADDR: begin
                    // 直接发起内存读请求（绕过缓存）
                    axi_arvalid_o       <= 1'b1;
                    axi_araddr_o        <= req_addr;
                    
                    // 地址通道握手成功
                    if (axi_arvalid_o == 1'b1 && axi_arready_i == 1'b1) begin
                        axi_arvalid_o   <= 1'b0;
                        axi_rready_o    <= 1'b1; // 准备接收数据
                        state           <= BYPASS_READ_DATA;
                    end
                end
                
                BYPASS_READ_DATA: begin
                    // 数据通道握手成功
                    if (axi_rvalid_i && axi_rready_o) begin
                        axi_rready_o    <= 1'b0;
                        resp_data       <= axi_rdata_i; // 保存响应数据
                        state           <= SEND_RESP;
                    end
                end
                

                // 复位信号
                SEND_RESP: begin
                    // 向CPU发出响应
                    cpu_rvalid_o        <= 1'b1;
                    cpu_rdata_o         <= resp_data;
                    hit                 <= 1'b0;

                    if(cpu_rvalid_o == 1'b1 && cpu_rready_i == 1'b1)begin
                        cpu_rvalid_o    <= 1'b0;
                        state           <= IDLE;
                    end
                end
                default: begin
                    // 内部信号
                    req_addr        <= 32'b0;
                    resp_data       <= 32'b0;
                    hit             <= 1'b0;
                    bypass          <= 1'b0;

                    // axi协议
                    cpu_arready_o   <= 1'b0;
                    cpu_rvalid_o    <= 1'b0;
                    cpu_rdata_o     <= 32'b0;

                    axi_arvalid_o   <= 1'b0;
                    axi_araddr_o    <= 32'b0;
                    axi_rready_o    <= 1'b0;
                end
            endcase
        end
    end

// ===================== 缓存更新逻辑 =====================
    assign cache_update = (axi_rready_o == 1'b1 && axi_rvalid_i == 1'b1);
    assign fill_end = (fill_count == 2'b11);
    always @(posedge clk) begin
        integer i;
        if (rst) begin
            // 复位缓存
            for (i = 0; i < NUM_BLOCKS; i = i + 1) begin
                valid[i] <= 1'b0;
                tags[i] <= {TAG_WIDTH{1'b0}};
                cache_data[i] <= 128'b0;
            end
        end else begin
            // 主存读取完成 - 更新缓存
            if (cache_update == 1'b1 && bypass == 1'b0) begin
                // 存储接收到的数据到临时缓存块
                case (fill_count)
                    2'b00: cache_data[fill_index][31:0]   <= axi_rdata_i;
                    2'b01: cache_data[fill_index][63:32]  <= axi_rdata_i;
                    2'b10: cache_data[fill_index][95:64]  <= axi_rdata_i;
                    2'b11: cache_data[fill_index][127:96] <= axi_rdata_i;
                endcase
            end

            if(fill_end == 1'b1)begin
                // 完成整个缓存块的填充
                tags[fill_index] <= tag;
                valid[fill_index] <= 1'b1;
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
module Icache#(
    parameter SRAM_BASE_ADDR    = 32'h0f00_0000,
    parameter SRAM_SIZE         = 32'h00ff_ffff
)(
    input               clk,        // 时钟
    input               rst,        // 复位
    input               fence_i_i,  // 是否刷新icache

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
    output reg [7:0]    axi_arlen_o,    // 新增：突发长度
    output reg [2:0]    axi_arsize_o,   // 新增：突发大小
    output reg [1:0]    axi_arburst_o,  // 新增：突发类型

    input               axi_rvalid_i,
    output reg          axi_rready_o,
    input [31:0]        axi_rdata_i,
    
    input               axi_rlast_i,    // 新增：突发传输结束

    output reg          hit, // 是否Cache命中
    output              icache_flush_done   // Cache是否已经无效所有的cache块
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
    wire [OFFSET_WIDTH-1:0] offset;             // 地址偏移
    wire [INDEX_WIDTH-1:0]  index;              // 地址索引
    wire [TAG_WIDTH-1:0]    tag;                // 地址Tag

    reg  [31:0]             req_addr;           // 当前请求地址
    reg  [31:0]             resp_data;          // 缓存数据
    wire                    cache_update;       // 是否更新缓存
    reg                     bypass;             // 是否绕过缓存标志

    wire                    fill_end;           // 填充是否结束

    reg [1:0]               burst_count;        // 突发传输计数器
    reg [31:0]              burst_base_addr;    // 突发传输基地址

    // 刷新控制信号
    reg                     flush_req;      // 刷新请求
    reg                     flushing;       // 正在刷新状态
    reg [INDEX_WIDTH-1:0]   flush_index;    // 当前刷新索引

    // ====================== 地址解析 ========================
    assign offset = req_addr[OFFSET_WIDTH-1:0];
    assign index  = req_addr[OFFSET_WIDTH+INDEX_WIDTH-1:OFFSET_WIDTH];
    assign tag    = req_addr[31:OFFSET_WIDTH+INDEX_WIDTH];

    // ================== SRAM地址检测 ===================
    wire is_sram_addr;
    assign is_sram_addr = (cpu_araddr_i >= SRAM_BASE_ADDR) && (cpu_araddr_i < (SRAM_BASE_ADDR + SRAM_SIZE));

    // 状态定义
    localparam IDLE              = 4'b0000;     // 空闲状态
    localparam CHECK_CACHE       = 4'b0001;     // 检查缓存
    localparam MEM_READ_ADDR     = 4'b0010;     // 内存读地址阶段
    localparam MEM_READ_DATA     = 4'b0011;     // 内存读数据阶段
    localparam FILL_BLOCK        = 4'b0100;     // 填充缓存块
    localparam BYPASS_READ_ADDR  = 4'b0101;     // 绕过缓存的读地址阶段
    localparam BYPASS_READ_DATA  = 4'b0110;     // 绕过缓存的读数据阶段
    localparam SEND_RESP         = 4'b0111;     // 发送响应
    localparam FLUSH_CACHE       = 4'b1000;     // 刷新icache
    reg [3:0]   state;

    // TAG:性能计数器使用
`ifdef VERILATOR_SIM
    reg                     cache_fill_start;
    reg                     cache_fill_end;
`endif


    // ===================== 刷新控制 =====================
    assign icache_flush_done = (flushing == 1'b1 && ({1'b0, flush_index} == NUM_BLOCKS-1));
    // 检测fence.i指令
    always @(posedge clk) begin
        if (rst) begin
            flush_req       <= 1'b0;
        end else begin
            // fence.i指令到来时设置刷新请求
            if (fence_i_i) begin
                flush_req   <= 1'b1;
            end 
            // 刷新完成时清除刷新请求
            else if (flushing == 1'b1 && ({1'b0, flush_index} == NUM_BLOCKS-1)) begin
                flush_req   <= 1'b0;
            end
        end
    end

    // 状态机
    always @(posedge clk) begin
        if (rst) begin
            state           <= IDLE;

            // 内部信号
            req_addr        <= 32'b0;
            resp_data       <= 32'b0;
            bypass          <= 1'b0;
            hit             <= 1'b0;

            // axi协议
            cpu_arready_o   <= 1'b0;
            cpu_rvalid_o    <= 1'b0;
            cpu_rdata_o     <= 32'b0;

            axi_arvalid_o   <= 1'b0;
            axi_araddr_o    <= 32'b0;
            axi_rready_o    <= 1'b0;

            // icache刷新使用
            flushing        <= 1'b0;
            flush_index     <= 0;

        `ifdef VERILATOR_SIM
            cache_fill_start<= 1'b0;
            cache_fill_end  <= 1'b0;
        `endif
        end else begin

            // 刷新操作优先级最高
            if (flush_req && !flushing) begin
                flushing    <= 1'b1;
                flush_index <= 0;
                state       <= FLUSH_CACHE;
            end

            case (state)
                // 新增：缓存刷新状态
                FLUSH_CACHE: begin
                    
                    // 移动到下一个索引
                    if ({1'b0, flush_index} < NUM_BLOCKS - 1) begin
                        flush_index     <= flush_index + 1;
                    end else begin
                        // 刷新完成
                        flushing        <= 1'b0;
                        state           <= IDLE;
                    end
                end

                IDLE: begin
                    if (cpu_arvalid_i && !flush_req) begin
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
                        // 缓存未命中，准备突发传输
                        burst_base_addr <= {req_addr[31:4], 4'b0}; // 对齐到16字节边界
                        burst_count     <= 2'b0;
                        
                        hit             <= 1'b0;
                        state           <= MEM_READ_ADDR;

                    `ifdef VERILATOR_SIM
                        cache_fill_start<= 1'b1;
                    `endif
                    end
                end

                MEM_READ_ADDR: begin

                `ifdef VERILATOR_SIM
                    cache_fill_start<= 1'b0;
                `endif

                    // 设置突发传输参数
                    axi_arvalid_o       <= 1'b1;
                    axi_araddr_o        <= burst_base_addr;
                    axi_arlen_o         <= 8'b0011; // 突发长度4 (len=3)
                    axi_arsize_o        <= 3'b010;  // 每次传输4字节 (32位)
                    axi_arburst_o       <= 2'b01;   // 递增突发

                    if(axi_arready_i == 1'b1 && axi_arvalid_o == 1'b1)begin
                        axi_arvalid_o   <= 1'b0;
                        axi_rready_o    <= 1'b1;
                        state           <= MEM_READ_DATA;
                    end
                end

                MEM_READ_DATA: begin
                    // axi_rready_o        <= 1'b1;

                    if (axi_rready_o == 1'b1 && axi_rvalid_i == 1'b1) begin

                        // 更新突发计数器
                        burst_count     <= burst_count + 1;
                        // 突发传输结束
                        if (axi_rlast_i) begin

                        `ifdef VERILATOR_SIM
                            cache_fill_end<= 1'b1;
                        `endif

                            axi_rready_o<= 1'b0;
                            state       <= FILL_BLOCK;
                        end
                    end

                end

                // 需要等待缓存块填写完毕,然后才能读
                FILL_BLOCK: begin
                    `ifdef VERILATOR_SIM
                        cache_fill_end<= 1'b0;
                    `endif

                    // 返回请求的指令
                    case (offset[3:2])
                        2'b00: resp_data    <= cache_data[index][31:0];
                        2'b01: resp_data    <= cache_data[index][63:32];
                        2'b10: resp_data    <= cache_data[index][95:64];
                        2'b11: resp_data    <= cache_data[index][127:96];
                    endcase
                    state <= SEND_RESP;
                end

                BYPASS_READ_ADDR: begin
                    // 直接发起内存读请求（绕过缓存）
                    // 直接发起内存读请求（绕过缓存）
                    axi_arvalid_o <= 1'b1;
                    axi_araddr_o  <= req_addr;
                    axi_arlen_o   <= 8'b0000; // 突发长度1
                    axi_arsize_o  <= 3'b010;   // 4字节传输
                    axi_arburst_o <= 2'b01;    // 递增突发
                    
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
    assign fill_end = (axi_rlast_i == 1'b1);

    // i的定义需要放在外面，不能放在always里面，不然不能综合
    integer i;
    always @(posedge clk) begin

        if (rst) begin
            // 复位缓存
            for (i = 0; i < NUM_BLOCKS; i = i + 1) begin
                valid[i]        <= 1'b0;
                tags[i]         <= {TAG_WIDTH{1'b0}};
                cache_data[i]   <= 128'b0;
            end
        end else if(state == FLUSH_CACHE)begin
            // 逐个无效化缓存项
            valid[flush_index]  <= 1'b0;
        end else begin
            // 主存读取完成 - 更新缓存
            if (cache_update == 1'b1 && bypass == 1'b0) begin
                // 存储接收到的数据到临时缓存块
                case (burst_count)
                    2'b00: cache_data[index][31:0]   <= axi_rdata_i;
                    2'b01: cache_data[index][63:32]  <= axi_rdata_i;
                    2'b10: cache_data[index][95:64]  <= axi_rdata_i;
                    2'b11: cache_data[index][127:96] <= axi_rdata_i;
                endcase
            end

            if(fill_end == 1'b1)begin
                // 完成整个缓存块的填充
                tags[index]     <= tag;
                valid[index]    <= 1'b1;
            end
        end
    end


// TAGS:Performance Counters
`ifdef VERILATOR_SIM
    import "DPI-C" function void cache_miss_time(
        input bit start_fill,
        input bit end_fill
    );

    always @(*) begin
        cache_miss_time(cache_fill_start, cache_fill_end);
    end
`endif

endmodule

/* 
    31     11 9    4 3      0                   127       0
   +---------+-------+--------+                 +---------+
   |   tag   | index | offset |                  cache_data
   +---------+-------+--------+                 +---------+   
*/
// icache 参数: set = 2, way = 1, block_size = 16B
module Icache#(
    parameter SRAM_BASE_ADDR    = 32'h0f00_0000,
    parameter SRAM_SIZE         = 32'h00ff_ffff
)(
    input               clk,        // 时钟
    input               rst,        // 复位
    input               fence_i_i,  // 是否刷新icache

// cpu <---> icache
    input               cpu_arvalid_i,
    output reg          cpu_arready_o,
    input  [31:0]       cpu_araddr_i,

    output reg          cpu_rvalid_o,
    input               cpu_rready_i,
    output reg [31:0]   cpu_rdata_o,
        
// icache <---> axi
    output reg          axi_arvalid_o,
    input               axi_arready_i,
    output reg [31:0]   axi_araddr_o,
    output reg [7:0]    axi_arlen_o,    // 突发长度
    output reg [2:0]    axi_arsize_o,   // 突发大小
    output reg [1:0]    axi_arburst_o,  // 突发类型

    input               axi_rvalid_i,
    output reg          axi_rready_o,
    input  [31:0]       axi_rdata_i,
    input               axi_rlast_i,    // 突发传输结束

    output reg          hit,            // 是否Cache命中（即时指示）
    output              icache_flush_done   // Cache是否已经无效所有的cache块
);

    // ===================== 参数与阵列 =====================
    localparam BLOCK_SIZE    = 16;            // 16B 一行，4条指令
    localparam NUM_BLOCKS    = 2;             // 2 组（direct-mapped、set=2）
    localparam INDEX_WIDTH   = 1;             // log2(NUM_BLOCKS)
    localparam OFFSET_WIDTH  = 4;             // log2(BLOCK_SIZE)
    localparam TAG_WIDTH     = 32 - INDEX_WIDTH - OFFSET_WIDTH;

    // 单路直接映射：tags/valid/data
    reg [TAG_WIDTH-1:0]   tags       [0:NUM_BLOCKS-1];
    reg [127:0]           cache_data [0:NUM_BLOCKS-1];
    reg                   valid      [0:NUM_BLOCKS-1];

    // ===================== SRAM 地址检测 ==================
    wire is_sram_addr_i = (cpu_araddr_i >= SRAM_BASE_ADDR) &&
                          (cpu_araddr_i < (SRAM_BASE_ADDR + SRAM_SIZE));

    // ===================== 刷新控制 =======================
    reg                     flush_req;      // fence 请求闩位
    reg                     flushing;       // 刷新进行中
    reg  [INDEX_WIDTH-1:0]  flush_index;    // 刷新索引

    assign icache_flush_done = (flushing == 1'b1 && ({1'b0, flush_index} == NUM_BLOCKS-1));

    always @(posedge clk) begin
        if (rst) begin
            flush_req   <= 1'b0;
        end else begin
            if (fence_i_i) begin
                flush_req <= 1'b1;
            end else if (flushing == 1'b1 && ({1'b0, flush_index} == NUM_BLOCKS-1)) begin
                flush_req <= 1'b0;
            end
        end
    end

    // ===================== 命中流水 (I$1/I$2/I$3) =====================
    // S1: 采样地址/分解
    reg        v_s1;
    reg [31:0] s1_addr;
    reg [OFFSET_WIDTH-1:0] s1_off;
    reg [INDEX_WIDTH-1:0]  s1_idx;
    reg [TAG_WIDTH-1:0]    s1_tag;

    // S2: 读阵列/比较（这里阵列为寄存器数组，可组合读；为稳健寄存一拍）
    reg        v_s2;
    reg [31:0] s2_addr;
    reg [OFFSET_WIDTH-1:0] s2_off;
    reg [INDEX_WIDTH-1:0]  s2_idx;
    reg [TAG_WIDTH-1:0]    s2_tag;

    reg                    s2_validbit;
    reg [TAG_WIDTH-1:0]    s2_tag_from_mem;
    reg [127:0]            s2_data_line;

    wire hit_s2 = v_s2 & s2_validbit & (s2_tag_from_mem == s2_tag);
    wire bypass_s2 = v_s2 & ((s2_addr >= SRAM_BASE_ADDR) && (s2_addr < (SRAM_BASE_ADDR + SRAM_SIZE)));

    // S3: 选择返回字
    reg        v_s3;
    reg [31:0] s3_rdata;

    // 命中输出保持（直到 CPU 消费）
    reg        hit_out_valid;
    reg [31:0] hit_out_data;

    // ===================== 缺失/旁路 FSM =====================
    // 状态
    localparam IDLE              = 4'b0000;
    localparam MEM_READ_ADDR     = 4'b0010;
    localparam MEM_READ_DATA     = 4'b0011;
    localparam FILL_BLOCK        = 4'b0100;
    localparam BYPASS_READ_ADDR  = 4'b0101;
    localparam BYPASS_READ_DATA  = 4'b0110;
    localparam FLUSH_CACHE       = 4'b1000;
    reg [3:0]   state;

    // 缺失上下文
    reg                miss_busy;
    reg [31:0]         miss_addr;
    reg [INDEX_WIDTH-1:0] miss_idx;
    reg [TAG_WIDTH-1:0]   miss_tag;
    reg [OFFSET_WIDTH-1:0]miss_off;

    // 突发相关
    reg [1:0]   burst_count;
    reg [31:0]  burst_base_addr;

    // FSM 输出保持（直到 CPU 消费）
    reg        fsm_out_valid;
    reg [31:0] fsm_out_data;

    // AXI 写入缓存判定
    wire cache_update = (axi_rready_o == 1'b1 && axi_rvalid_i == 1'b1);
    wire fill_end     = (axi_rlast_i == 1'b1);

    // 流水入口阻塞条件：缺失处理中或刷新
    wire stall_s1 = miss_busy | flushing;

    // =============== VERILATOR 计数（保持原接口） ===============
`ifdef VERILATOR_SIM
    reg cache_fill_start, cache_fill_end;
`endif

    // ===================== 复位与通用寄存器 =====================
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            // 顶层/对外
            cpu_arready_o   <= 1'b0;
            cpu_rvalid_o    <= 1'b0;
            cpu_rdata_o     <= 32'b0;
            axi_arvalid_o   <= 1'b0;
            axi_araddr_o    <= 32'b0;
            axi_arsize_o    <= 3'b010;
            axi_arlen_o     <= 8'b0;
            axi_arburst_o   <= 2'b01;
            axi_rready_o    <= 1'b0;

            // 流水
            v_s1 <= 1'b0; v_s2 <= 1'b0; v_s3 <= 1'b0;
            hit_out_valid <= 1'b0; hit_out_data <= 32'b0;

            // FSM
            state <= IDLE; miss_busy <= 1'b0;
            fsm_out_valid <= 1'b0; fsm_out_data <= 32'b0;
            burst_count <= 2'b00; burst_base_addr <= 32'b0;

            // 刷新
            flushing    <= 1'b0;
            flush_index <= {INDEX_WIDTH{1'b0}};

            // 命中信号
            hit <= 1'b0;

            // valid 位复位（保留 tags/data 以省资源）
            for (i = 0; i < NUM_BLOCKS; i = i + 1) begin
                valid[i] <= 1'b0;
            end

        `ifdef VERILATOR_SIM
            cache_fill_start<= 1'b0;
            cache_fill_end  <= 1'b0;
        `endif
        end else begin
            // ------------------- fence 冲刷流水/进入刷新 -------------------
            if (fence_i_i && !flushing) begin
                // 清流水与对外返回
                v_s1 <= 1'b0; v_s2 <= 1'b0; v_s3 <= 1'b0;
                hit_out_valid <= 1'b0;
                fsm_out_valid <= 1'b0;
                cpu_rvalid_o  <= 1'b0;

                // 若正在缺失或旁路，等 FSM 结束再进入 FLUSH
                if (!miss_busy && state==IDLE) begin
                    flushing    <= 1'b1;
                    flush_index <= {INDEX_WIDTH{1'b0}};
                    state       <= FLUSH_CACHE;
                end
            end

            // ------------------- 流水入口 ready -------------------
            cpu_arready_o <= ~stall_s1 & ~flush_req; // fence 请求期间暂不接收

            // ------------------- I$1：采样 -------------------
            if (!stall_s1 && !flush_req) begin
                v_s1 <= cpu_arvalid_i;
                if (cpu_arvalid_i) begin
                    s1_addr <= cpu_araddr_i;
                    s1_off  <= cpu_araddr_i[OFFSET_WIDTH-1:0];
                    s1_idx  <= cpu_araddr_i[OFFSET_WIDTH+INDEX_WIDTH-1:OFFSET_WIDTH];
                    s1_tag  <= cpu_araddr_i[31:OFFSET_WIDTH+INDEX_WIDTH];
                end
            end else begin
                // 入口阻塞或 fence：不推进
                v_s1 <= 1'b0;
            end

            // ------------------- I$2：读阵列/比较 -------------------
            // （寄存器数组组合读，这里寄存一拍）
            v_s2    <= v_s1;
            s2_addr <= s1_addr;
            s2_off  <= s1_off;
            s2_idx  <= s1_idx;
            s2_tag  <= s1_tag;

            s2_validbit     <= valid[s1_idx];
            s2_tag_from_mem <= tags[s1_idx];
            s2_data_line    <= cache_data[s1_idx];

            // ------------------- I$3：命中选择/输出保持 -------------------
            // 命中则推进到 S3
            v_s3 <= v_s2 & hit_s2 & ~flushing & ~miss_busy;

            if (v_s2 & hit_s2) begin
                case (s2_off[3:2])
                    2'b00: s3_rdata <= s2_data_line[31:0];
                    2'b01: s3_rdata <= s2_data_line[63:32];
                    2'b10: s3_rdata <= s2_data_line[95:64];
                    2'b11: s3_rdata <= s2_data_line[127:96];
                endcase
            end

            // 命中输出保持（直到 CPU 消费）
            if (v_s3) begin
                hit_out_valid <= 1'b1;
                hit_out_data  <= s3_rdata;
            end else if (hit_out_valid & cpu_rready_i) begin
                hit_out_valid <= 1'b0;
            end

            // 即时命中观测信号（非握手）
            hit <= (v_s2 & hit_s2);

            // ------------------- miss / bypass 触发 -> 进入 FSM -------------------
            if (v_s2 && ~hit_s2 && ~bypass_s2 && ~miss_busy && ~flushing) begin
                // 触发缺失
                miss_busy   <= 1'b1;
                miss_addr   <= s2_addr;
                miss_idx    <= s2_idx;
                miss_tag    <= s2_tag;
                miss_off    <= s2_off;

                // 清掉在途流水输出以免与 FSM 同时驱动
                v_s1 <= 1'b0; v_s2 <= 1'b0; v_s3 <= 1'b0;
                hit_out_valid <= 1'b0;

            `ifdef VERILATOR_SIM
                cache_fill_start <= 1'b1;
            `endif

                // 配置突发
                burst_base_addr <= {s2_addr[31:4], 4'b0};
                burst_count     <= 2'b00;

                // AXI AR
                axi_arvalid_o <= 1'b1;
                axi_araddr_o  <= {s2_addr[31:4], 4'b0};
                axi_arlen_o   <= 8'd3;     // 4 拍（len=3）
                axi_arsize_o  <= 3'b010;   // 4 字节
                axi_arburst_o <= 2'b01;    // INCR

                axi_rready_o  <= 1'b0;     // 等待AR握手后再拉起

                state <= MEM_READ_ADDR;
            end
            else if (v_s2 && bypass_s2 && ~miss_busy && ~flushing) begin
                // 旁路：一次性读
                miss_busy   <= 1'b1;
                miss_addr   <= s2_addr;
                miss_off    <= s2_off; // 实际不用 offset，对齐访问一条

                // 清流水
                v_s1 <= 1'b0; v_s2 <= 1'b0; v_s3 <= 1'b0;
                hit_out_valid <= 1'b0;

                // 发 AR
                axi_arvalid_o <= 1'b1;
                axi_araddr_o  <= s2_addr;
                axi_arlen_o   <= 8'd0;     // 单拍
                axi_arsize_o  <= 3'b010;
                axi_arburst_o <= 2'b01;
                axi_rready_o  <= 1'b0;

                state <= BYPASS_READ_ADDR;
            end

            // ========================= FSM =========================
            case (state)
                IDLE: begin
                    // 等待触发，或 fence 流程
                    fsm_out_valid <= fsm_out_valid; // 保持（等待 CPU 消费）
                end

                // ---------- 刷新表项 ----------
                FLUSH_CACHE: begin
                    // 逐项失效
                    valid[flush_index] <= 1'b0;
                    if ({1'b0, flush_index} < NUM_BLOCKS - 1) begin
                        flush_index <= flush_index + 1'b1;
                    end else begin
                        flushing    <= 1'b0;
                        state       <= IDLE;
                    end
                end

                // ---------- 缺失：发地址 ----------
                MEM_READ_ADDR: begin
                `ifdef VERILATOR_SIM
                    cache_fill_start <= 1'b0;
                `endif
                    if (axi_arvalid_o && axi_arready_i) begin
                        axi_arvalid_o <= 1'b0;
                        axi_rready_o  <= 1'b1;
                        state         <= MEM_READ_DATA;
                    end
                end

                // ---------- 缺失：收数据并写入缓存 ----------
                MEM_READ_DATA: begin
                    if (axi_rready_o && axi_rvalid_i) begin
                        // 写行内不同字
                        cache_data[miss_idx][burst_count*32 +: 32] <= axi_rdata_i;
                        burst_count <= burst_count + 2'd1;

                        if (axi_rlast_i) begin
                        `ifdef VERILATOR_SIM
                            cache_fill_end <= 1'b1;
                        `endif
                            axi_rready_o <= 1'b0;

                            // 行填充完成 -> 标记有效并写 tag
                            tags[miss_idx]  <= miss_tag;
                            valid[miss_idx] <= 1'b1;

                            state <= FILL_BLOCK;
                        end
                    end
                end

                // ---------- 缺失：选择返回字并出数 ----------
                FILL_BLOCK: begin
                `ifdef VERILATOR_SIM
                    cache_fill_end <= 1'b0;
                `endif
                    // 选出 miss 对应 32b
                    case (miss_off[3:2])
                        2'b00: fsm_out_data <= cache_data[miss_idx][31:0];
                        2'b01: fsm_out_data <= cache_data[miss_idx][63:32];
                        2'b10: fsm_out_data <= cache_data[miss_idx][95:64];
                        2'b11: fsm_out_data <= cache_data[miss_idx][127:96];
                    endcase
                    fsm_out_valid <= 1'b1;

                    // 缺失服务结束，释放入口
                    miss_busy <= 1'b0;

                    // 回到空闲，等待 CPU 消费 fsm_out_valid
                    state <= IDLE;
                end

                // ---------- 旁路：发地址 ----------
                BYPASS_READ_ADDR: begin
                    if (axi_arvalid_o && axi_arready_i) begin
                        axi_arvalid_o <= 1'b0;
                        axi_rready_o  <= 1'b1;
                        state         <= BYPASS_READ_DATA;
                    end
                end

                // ---------- 旁路：收数据并出数 ----------
                BYPASS_READ_DATA: begin
                    if (axi_rready_o && axi_rvalid_i) begin
                        axi_rready_o  <= 1'b0;
                        fsm_out_data  <= axi_rdata_i;
                        fsm_out_valid <= 1'b1;

                        // 旁路结束
                        miss_busy <= 1'b0;
                        state     <= IDLE;
                    end
                end

                default: begin
                    state <= IDLE;
                end
            endcase

            // ========================= 对 CPU 的统一返回仲裁 =========================
            // 规则：FSM（缺失/旁路）优先；否则命中流水输出。
            // 两路的 valid 都采用“保持直到被 cpu_rready_i 消费”的策略。
            if (!cpu_rvalid_o) begin
                if (fsm_out_valid) begin
                    cpu_rvalid_o <= 1'b1;
                    cpu_rdata_o  <= fsm_out_data;
                end else if (hit_out_valid) begin
                    cpu_rvalid_o <= 1'b1;
                    cpu_rdata_o  <= hit_out_data;
                end
            end else if (cpu_rvalid_o && cpu_rready_i) begin
                cpu_rvalid_o <= 1'b0;
                // 清除对应源的 valid
                if (fsm_out_valid) begin
                    fsm_out_valid <= 1'b0;
                end else if (hit_out_valid) begin
                    hit_out_valid <= 1'b0;
                end
            end
        end
    end

    // ===================== 失效/写入阵列（除复位外的合并逻辑） =====================
    // 这里 tags/cache_data 的复位省略以节省资源（仅 valid 清 0）。
    // 在刷新状态机中按索引将 valid 置 0；在缺失填充完成时写 tag/valid。
    // 上面的 FSM 已经完成这些更新，这里无需再写额外 always 块。

// ===================== 性能计数器（保持原接口） =====================
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
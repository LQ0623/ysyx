// ============================================================
// Tiny Direct-Mapped I-Cache (area-optimized, CPU side uses AXI-like handshake)
// - CPU侧使用 arvalid/arready & rvalid/rready 握手
// - 数据行用寄存器直接存储（1 行 × 16B = 4×32bit）>= 4 指令
// - 直接映射：单 tag + valid
// - 直通区域：0x0f00_0000 ~ 0x0fff_ffff（单拍）
// - 回填：4 拍 AXI burst
// - 命中路径保留 1 拍等待（S_HIT_WAIT），便于与同步RAM等价时序；也可直接去掉以减1拍
// ============================================================

module Icache #(
    parameter SRAM_BASE_ADDR = 32'h0f00_0000,
    parameter SRAM_SIZE      = 32'h00ff_ffff
)(
    input               clk,
    input               rst,
    input               fence_i_i,

    // ---------------- CPU <-> I$ (AXI-like read address/data channels) ----------------
    // AR channel
    input               cpu_arvalid_i,  // CPU 发起请求：addr 同拍有效
    output              cpu_arready_o,  // I$ 空闲且可接受请求时拉高
    input  [31:0]       cpu_araddr_i,   // 指令地址

    // R channel
    output              cpu_rvalid_o,   // I$ 返回数据有效（保持到与cpu_rready_i握手）
    input               cpu_rready_i,   // CPU 接受数据
    output [31:0]       cpu_rdata_o,    // 指令数据

    // ---------------- I$ <-> 外部AXI（与原版一致） ----------------
    output              axi_arvalid_o,
    input               axi_arready_i,
    output [31:0]       axi_araddr_o,
    output [7:0]        axi_arlen_o,

    input               axi_rvalid_i,
    output              axi_rready_o,
    input  [31:0]       axi_rdata_i,
    input               axi_rlast_i,

    output              icache_flush_done

`ifdef VERILATOR_SIM
    ,output reg         hit
`endif
);
    // ---------------------- Params / widths ----------------------
    localparam OFFSET_WIDTH   = 4;                  // 16B line
    localparam TAG_WIDTH      = 32 - OFFSET_WIDTH;  // 28 bits (addr[31:4])
    localparam WORDS_PER_LINE = 4;                  // 4 × 32b
    localparam WORD_SEL_W     = 2;

    // ---------------------- Bypass region ------------------------
    // 简化判断：高8位为 0x0f 即认定直通
    wire is_sram_addr_now = (cpu_araddr_i[31:24] == 8'h0f);

    // ---------------------- FSM states ---------------------------
    localparam S_IDLE      = 3'b000;
    localparam S_LOOKUP    = 3'b001;
    localparam S_MISS_AR   = 3'b010;
    localparam S_MISS_R    = 3'b011;
    // localparam S_HIT_WAIT  = 3'b100;  // 命中路径等待1拍
    localparam S_RESP      = 3'b100;  // 等待CPU取走数据（rvalid保持，直到rready握手）

    reg [2:0] state, state_n;

    // ---------------------- Request latches ----------------------
    reg [TAG_WIDTH-1:0]  req_tag;     // addr[31:4]
    reg [WORD_SEL_W-1:0] word_sel;    // addr[3:2]
    reg                  req_bypass;

    // ---------------------- Tag/valid （单行）--------------------
    reg [TAG_WIDTH-1:0]  tag_q;
    reg                  valid_q;

    // ---------------------- AXI address channel ------------------
    reg         arvalid_q;
    reg [31:0]  araddr_q;

    // ---------------------- Data path ----------------------------
    // 1行×4词（直接用reg存储）
    reg [31:0] line [0:WORDS_PER_LINE-1];

    // 命中组合数据（RESP 时直接用）
    wire [31:0] hit_word_comb = line[word_sel];

    // Miss/直通缓冲
    reg [31:0]  miss_or_bypass_data_q;
    // RESP 数据来源：1=命中（组合读取 line[]）；0=miss/直通缓冲
    reg         resp_src_is_hit_q;

    // 回填 burst 计数
    reg [1:0]   burst_cnt;

    // ---------------------- VERILATOR stats ----------------------
`ifdef VERILATOR_SIM
    reg cache_fill_start, cache_fill_end;
`endif

    // ---------------------- fence / flush ------------------------
    reg fence_d;
    always @(posedge clk) begin
        if (rst) fence_d <= 1'b0;
        else     fence_d <= fence_i_i;
    end
    wire fence_pulse = fence_i_i & ~fence_d;
    assign icache_flush_done = fence_pulse;

    // ---------------------- Handshake / I/O ----------------------
    // 仅在空闲且非fence时接受CPU请求
    assign cpu_arready_o = (state == S_IDLE) && ~fence_i_i;

    // R通道：在S_RESP保持rvalid直到CPU rready握手
    assign cpu_rvalid_o  = (state == S_RESP);
    assign cpu_rdata_o   = resp_src_is_hit_q ? hit_word_comb : miss_or_bypass_data_q;

    // 外部AXI（与原版一致）
    assign axi_arvalid_o = arvalid_q;
    assign axi_araddr_o  = araddr_q;
    assign axi_arlen_o   = req_bypass ? 8'd0 : 8'd3;  // 直通：单拍；回填：4拍
    assign axi_rready_o  = (state == S_MISS_R);

    // AXI R 完成条件
    wire r_done_bypass = req_bypass && axi_rvalid_i && axi_rready_o;                   // 单拍
    wire r_done_fill   = (~req_bypass) && axi_rvalid_i && axi_rready_o && axi_rlast_i; // 4拍
    wire r_done        = r_done_bypass | r_done_fill;

    // ---------------------- Sequential ---------------------------
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            state                 <= S_IDLE;
            valid_q               <= 1'b0;
            tag_q                 <= {TAG_WIDTH{1'b0}};
            arvalid_q             <= 1'b0;
            araddr_q              <= 32'b0;
            miss_or_bypass_data_q <= 32'b0;
            resp_src_is_hit_q     <= 1'b0;
            burst_cnt             <= 2'b00;
            req_tag               <= {TAG_WIDTH{1'b0}};
            word_sel              <= {WORD_SEL_W{1'b0}};
            req_bypass            <= 1'b0;
            for (i=0; i<WORDS_PER_LINE; i=i+1) line[i] <= 32'b0;
`ifdef VERILATOR_SIM
            hit               <= 1'b0;
            cache_fill_start  <= 1'b0;
            cache_fill_end    <= 1'b0;
`endif
        end else begin
            // fence：1拍脉冲，清valid
            if (fence_pulse) begin
                valid_q <= 1'b0;
            end

            state <= state_n;

            case (state)
                // ---------------- IDLE ----------------
                S_IDLE: begin
`ifdef VERILATOR_SIM
                    hit <= 1'b0;
`endif
                    // CPU请求握手：arvalid & arready
                    if (cpu_arvalid_i && cpu_arready_o) begin
                        req_tag    <= cpu_araddr_i[31:4];  // 28-bit tag
                        word_sel   <= cpu_araddr_i[3:2];
                        req_bypass <= is_sram_addr_now;
                    end
                end

                // ---------------- LOOKUP ----------------
                S_LOOKUP: begin
                    if (req_bypass) begin
                        // 直通 -> miss路径（单拍R）
                        resp_src_is_hit_q <= 1'b0;
`ifdef VERILATOR_SIM
                        hit <= 1'b0;
                        cache_fill_start <= 1'b1;
`endif
                    end else if (valid_q && (tag_q == req_tag)) begin
                        // 命中：RESP 数据来源为组合读取
                        resp_src_is_hit_q <= 1'b1;
`ifdef VERILATOR_SIM
                        hit <= 1'b1;
`endif
                    end else begin
                        // 未命中：发起AXI读并回填
                        resp_src_is_hit_q <= 1'b0;
`ifdef VERILATOR_SIM
                        hit <= 1'b0;
                        cache_fill_start <= 1'b1;
`endif
                    end
                end

                // ---------------- MISS AR ----------------
                S_MISS_AR: begin
`ifdef VERILATOR_SIM
                    cache_fill_start <= 1'b0;
`endif
                    arvalid_q <= 1'b1;
                    araddr_q  <= req_bypass ? {req_tag, word_sel, 2'b00}  // 直通：字对齐
                                            : {req_tag, 4'b0000};        // 回填：行对齐
                    if (axi_arvalid_o && axi_arready_i) begin
                        arvalid_q <= 1'b0;
                        burst_cnt <= 2'b00;
                    end
                end

                // ---------------- MISS R ----------------
                S_MISS_R: begin
                    if (axi_rvalid_i && axi_rready_o) begin
                        if (req_bypass) begin
                            // 直通：单拍进缓冲
                            miss_or_bypass_data_q <= axi_rdata_i;
                        end else begin
                            // 回填：逐拍写入行寄存器；命中词同时放入缓冲
                            line[burst_cnt] <= axi_rdata_i;
                            if (burst_cnt == word_sel)
                                miss_or_bypass_data_q <= axi_rdata_i;
                            burst_cnt <= burst_cnt + 2'd1;
                        end

                        if (r_done) begin
                            if (!req_bypass) begin
                                tag_q   <= req_tag;
                                valid_q <= 1'b1;
                            end
`ifdef VERILATOR_SIM
                            if (!req_bypass) cache_fill_end <= 1'b1;
`endif
                        end
                    end
                end

                // ---------------- HIT WAIT ----------------
                // S_HIT_WAIT: begin
                //     // 保留一拍等待（可直接省略此状态以减1拍）
                // end

                // ---------------- RESP ----------------
                S_RESP: begin
`ifdef VERILATOR_SIM
                    cache_fill_end <= 1'b0;
`endif
                    // 在此状态保持 cpu_rvalid_o=1，直到 CPU 以 rready 握手取走
                end

                default: ;
            endcase
        end
    end

    // ---------------------- Next-state logic ---------------------
    wire will_hit = (~req_bypass) && valid_q && (tag_q == req_tag);

    always @* begin
        state_n = state;
        case (state)
            S_IDLE: begin
                if (cpu_arvalid_i && cpu_arready_o) state_n = S_LOOKUP;
            end
            S_LOOKUP: begin
                if (req_bypass) begin
                    state_n = S_MISS_AR;
                end else if (will_hit) begin
                    state_n = S_RESP;  // 命中：进入等待1拍（可直接改到S_RESP）
                end else begin
                    state_n = S_MISS_AR;   // 未命中：走AXI
                end
            end
            S_MISS_AR: begin
                if (axi_arvalid_o && axi_arready_i) state_n = S_MISS_R;
            end
            S_MISS_R: begin
                if (r_done) state_n = S_RESP; // 直通：首拍即完成；回填：看RLAST
            end
            // S_HIT_WAIT: begin
            //     state_n = S_RESP;
            // end
            S_RESP: begin
                // 仅当 CPU rready 与 rvalid 握手后回到空闲
                if (cpu_rvalid_o && cpu_rready_i) state_n = S_IDLE;
            end
            default: state_n = S_IDLE;
        endcase
    end

// -------------------- TAGS:Performance Counters -----------------
`ifdef VERILATOR_SIM
    import "DPI-C" function void cache_miss_time(
        input bit start_fill,
        input bit end_fill
    );
    always @(*) cache_miss_time(cache_fill_start, cache_fill_end);
`endif

endmodule

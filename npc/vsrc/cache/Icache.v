// set = 2, way = 1, block_size = 16B（4×32bit）; 0x0f00_0000~0x0fff_ffff 直通
module Icache #(
    parameter SRAM_BASE_ADDR = 32'h0f00_0000,
    parameter SRAM_SIZE      = 32'h00ff_ffff
)(
    input               clk,
    input               rst,
    input               fence_i_i,

    // CPU -> I$
    input               cpu_arvalid_i,
    output              cpu_arready_o,
    input  [31:0]       cpu_araddr_i,

    // I$ -> CPU
    output              cpu_rvalid_o,
    input               cpu_rready_i,
    output [31:0]       cpu_rdata_o,

    // I$ -> AXI
    output              axi_arvalid_o,
    input               axi_arready_i,
    output [31:0]       axi_araddr_o,
    output [7:0]        axi_arlen_o,

    // AXI -> I$
    input               axi_rvalid_i,
    output              axi_rready_o,
    input  [31:0]       axi_rdata_i,
    input               axi_rlast_i,

    output              icache_flush_done

`ifdef VERILATOR_SIM
    ,output reg         hit
`endif
);

    localparam NUM_BLOCKS    = 2;
    localparam INDEX_WIDTH   = 1;            // log2(2)
    localparam OFFSET_WIDTH  = 4;            // log2(16)
    localparam TAG_WIDTH     = 32 - INDEX_WIDTH - OFFSET_WIDTH; // 27

    // 存储体：2 组 × 128bit 行，tag 各 27b，valid 共 2b
    reg [127:0]                 cache_data [0:NUM_BLOCKS-1];
    reg [TAG_WIDTH-1:0]         tags       [0:NUM_BLOCKS-1];
    reg [NUM_BLOCKS-1:0]        valid;

    // 直通区域判断（指令地址不会命中，但保留逻辑）
    wire is_sram_addr_now = (cpu_araddr_i[31:24] == 8'h0f);

    // 状态机
    localparam S_IDLE    = 3'b000;
    localparam S_LOOKUP  = 3'b001;
    localparam S_MISS_AR = 3'b010;
    localparam S_MISS_R  = 3'b011;
    localparam S_RESP    = 3'b100;

    reg [2:0]  state, state_n;

    // 请求保持
    reg  [27:0] req_line_addr;    // addr[31:4]
    reg  [1:0]  word_sel;         // addr[3:2]
    reg         req_bypass;       // 本次请求是否直通

    // 命中判断索引/Tag
    wire [INDEX_WIDTH-1:0] req_index = req_line_addr[0];
    wire [TAG_WIDTH-1:0]   req_tag   = req_line_addr[27:1];

    // AXI 地址通道寄存（确保握手期间稳定）
    reg         arvalid_q;
    reg  [31:0] araddr_q;

    // 读数据阶段
    reg  [1:0]  burst_cnt;
    reg  [31:0] miss_or_bypass_data_q;   // 仅 miss/直通使用
    reg         resp_src_is_hit_q;       // RESP 的数据来源：1=命中组合；0=miss/直通缓冲

    // —— VERILATOR 统计 —— //
`ifdef VERILATOR_SIM
    reg cache_fill_start, cache_fill_end;
`endif

    // fence：上升沿 1 拍脉冲 + 仅该拍清 valid
    reg fence_d;
    always @(posedge clk) begin
        if (rst) fence_d <= 1'b0;
        else     fence_d <= fence_i_i;
    end
    wire fence_pulse         = fence_i_i & ~fence_d;
    assign icache_flush_done = fence_pulse;

    // 取词函数
    function [31:0] pick_word;
        input [127:0] line;
        input [1:0]   sel;
        begin
            pick_word = line[sel*32 +: 32];
        end
    endfunction

    // 命中组合数据（在 RESP 直接用，不落地寄存，避免“上一拍残留”）
    wire [31:0] hit_word_comb = pick_word(cache_data[req_index], word_sel);

    // ---------------- 接口信号 ----------------
    assign cpu_arready_o = (state == S_IDLE) && ~fence_i_i;
    assign cpu_rvalid_o  = (state == S_RESP);
    // RESP 时根据来源选择：命中→组合；miss/直通→寄存缓冲
    assign cpu_rdata_o   = resp_src_is_hit_q ? hit_word_comb : miss_or_bypass_data_q;

    assign axi_arvalid_o = arvalid_q;
    assign axi_araddr_o  = araddr_q;
    assign axi_arlen_o   = req_bypass ? 8'd0 : 8'd3; // 直通单拍；回填 4 拍
    assign axi_rready_o  = (state == S_MISS_R);

    // —— NEW：直通与回填完成条件分流 —— //
    wire r_done_bypass = req_bypass && axi_rvalid_i && axi_rready_o;                     // 单拍：不依赖 RLAST
    wire r_done_fill   = (~req_bypass) && axi_rvalid_i && axi_rready_o && axi_rlast_i;   // 回填：看 RLAST
    wire r_done        = r_done_bypass | r_done_fill;

    // ---------------- 时序 ----------------
    always @(posedge clk) begin
        if (rst) begin
            state                <= S_IDLE;
            valid                <= 2'b00;
            arvalid_q            <= 1'b0;
            araddr_q             <= 32'b0;
            burst_cnt            <= 2'b00;
            miss_or_bypass_data_q<= 32'b0;
            resp_src_is_hit_q    <= 1'b0;
            req_line_addr        <= 28'b0;
            word_sel             <= 2'b0;
            req_bypass           <= 1'b0;
`ifdef VERILATOR_SIM
            hit               <= 1'b0;
            cache_fill_start  <= 1'b0;
            cache_fill_end    <= 1'b0;
`endif
        end else begin
            // fence：仅该拍清空 valid
            if (fence_pulse) begin
                valid <= 2'b00;
            end

            state <= state_n;

            case (state)
                S_IDLE: begin
`ifdef VERILATOR_SIM
                    hit <= 1'b0;
`endif
                    if (cpu_arvalid_i && cpu_arready_o) begin
                        req_line_addr <= cpu_araddr_i[31:4];
                        word_sel      <= cpu_araddr_i[3:2];
                        req_bypass    <= is_sram_addr_now;
                    end
                end

                S_LOOKUP: begin
                    // 记录 RESP 的数据来源（命中：组合直读；否则：来自 miss/直通缓冲）
                    if (req_bypass) begin
                        resp_src_is_hit_q <= 1'b0;
`ifdef VERILATOR_SIM
                        hit <= 1'b0;
                        cache_fill_start <= 1'b1;
`endif
                    end else if (valid[req_index] && (tags[req_index] == req_tag)) begin
                        resp_src_is_hit_q <= 1'b1; // 命中：组合直读
`ifdef VERILATOR_SIM
                        hit <= 1'b1;
`endif
                    end else begin
                        resp_src_is_hit_q <= 1'b0;
`ifdef VERILATOR_SIM
                        hit <= 1'b0;
                        cache_fill_start <= 1'b1;
`endif
                    end
                end

                S_MISS_AR: begin
`ifdef VERILATOR_SIM
                    cache_fill_start <= 1'b0;
`endif
                    // 拉起 AR，有握手就进入数据阶段
                    arvalid_q <= 1'b1;
                    araddr_q  <= req_bypass ? {req_line_addr, word_sel, 2'b00}
                                            : {req_line_addr, 4'b0000};
                    if (axi_arvalid_o && axi_arready_i) begin
                        arvalid_q <= 1'b0;
                        burst_cnt <= 2'b00;
                    end
                end

                S_MISS_R: begin
                    if (axi_rvalid_i && axi_rready_o) begin
                        if (req_bypass) begin
                            // 直通：第一拍数据直接进缓冲
                            miss_or_bypass_data_q <= axi_rdata_i;
                        end else begin
                            // 回填：写整行，并在对应拍把需要返回的字也放进缓冲
                            cache_data[req_index][burst_cnt*32 +: 32] <= axi_rdata_i;
                            if (burst_cnt == word_sel) miss_or_bypass_data_q <= axi_rdata_i;
                            burst_cnt <= burst_cnt + 2'd1;
                        end

                        if (r_done) begin
                            if (!req_bypass) begin
                                tags[req_index]  <= req_tag;
                                valid[req_index] <= 1'b1;
                            end
`ifdef VERILATOR_SIM
                            if (!req_bypass) cache_fill_end <= 1'b1;
`endif
                        end
                    end
                end

                S_RESP: begin
`ifdef VERILATOR_SIM
                    cache_fill_end <= 1'b0;
`endif
                    // 等待 CPU 取走
                end
                default:;
            endcase
        end
    end

    // ---------------- 下一状态 ----------------
    always @* begin
        state_n = state;
        case (state)
            S_IDLE: begin
                if (cpu_arvalid_i && cpu_arready_o) state_n = S_LOOKUP;
            end
            S_LOOKUP: begin
                if (req_bypass) begin
                    state_n = S_MISS_AR;
                end else if (valid[req_index] && (tags[req_index] == req_tag)) begin
                    state_n = S_RESP;      // 命中：直接去 RESP（数据组合提供）
                end else begin
                    state_n = S_MISS_AR;   // 未命中：去读主存
                end
            end
            S_MISS_AR: begin
                if (axi_arvalid_o && axi_arready_i) state_n = S_MISS_R;
            end
            S_MISS_R: begin
                if (r_done) state_n = S_RESP;   // 直通：首拍即完成；回填：看 RLAST
            end
            S_RESP: begin
                if (cpu_rvalid_o && cpu_rready_i) state_n = S_IDLE;
            end
            default: state_n = S_IDLE;
        endcase
    end

// TAGS:Performance Counters
`ifdef VERILATOR_SIM
    import "DPI-C" function void cache_miss_time(
        input bit start_fill,
        input bit end_fill
    );
    always @(*) cache_miss_time(cache_fill_start, cache_fill_end);
`endif

endmodule


/* 
    31     11 9    4 3      0                   127       0
   +---------+-------+--------+                 +---------+
   |   tag   | index | offset |                  cache_data
   +---------+-------+--------+                 +---------+   
*/
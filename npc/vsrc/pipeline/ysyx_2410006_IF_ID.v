// 冲刷流水线：清空有效位即可；数据在 valid=0 时视为无效，不必清零（节省复位/冲刷多路选择器面积）
// TODO: PCW信号不用向外暴露了（保持现有接口，不新增端口）
module ysyx_24100006_IF_ID(
    input           clk,
    input           reset,

    input           flush_i,

    // IFU  <----> IF_ID
    input           in_valid,
    output          in_ready,
    input   [31:0]  instruction_i,

    // IF_ID <----> IDU
    output          out_valid,
    input           out_ready,
    output  [31:0]  instruction_o


    ,input  [31:0]  pc_i,
    output  [31:0]  pc_o


    // ,input  [31:0]  pc_add_4_i
    // ,output [31:0]  pc_add_4_o
);

    // ================= Registers =================
    reg             valid_q;

    reg [31:0]      instruction_q;
    // reg [31:0]      pc_add_4_q;


    reg [31:0]      pc_q;


    // ================= Handshake =================
    // 简化：in_ready = ~valid_q || out_ready
    // 语义：若本级为空即可接收；或下游准备好时可滑动
    assign in_ready   = (~valid_q) || out_ready;
    assign out_valid  =  valid_q;

    // ================= Outputs ===================
    assign instruction_o = instruction_q;
    // assign pc_add_4_o    = pc_add_4_q;


    assign pc_o          = pc_q;


    // ================= Control ===================
    // 接收新数据（同时满足：上游有效 且 我方可接收）
    wire accept = in_valid && in_ready;
    // 下游取走当前拍（本级持有有效 且 下游 ready）
    wire send   = valid_q && out_ready;

    // 有效位：flush/复位优先；其次依据 accept/send 自动进出栈
    always @(posedge clk) begin
        if (reset) begin
            valid_q <= 1'b0;
        end else if (flush_i) begin
            valid_q <= 1'b0; // 冲刷：仅清有效位
        end else begin
            // 若同时 send 与 accept，保持 valid=1（换新不掉拍）
            if (accept)
                valid_q <= 1'b1;
            else if (send)
                valid_q <= 1'b0;
            // 否则保持
        end
    end

    // 数据位：仅在真正接收新拍时写入（降低翻转/利于推导CE门控）
    always @(posedge clk) begin
        if (accept) begin
            instruction_q <= instruction_i;
            // pc_add_4_q    <= pc_add_4_i;

            pc_q          <= pc_i;

        end
// `ifdef VERILATOR_SIM
//         else if (reset || flush_i) begin
//             // 仅用于仿真波形可读性；综合时不需要清零，节省面积
//             instruction_q <= 32'b0;
//             pc_add_4_q    <= 32'b0;
//             irq_q         <= 1'b0;
//             irq_no_q      <= 4'b0;
// `ifdef VERILATOR_SIM
//             pc_q          <= 32'b0;
// `endif
//         end
// `endif
    end

endmodule

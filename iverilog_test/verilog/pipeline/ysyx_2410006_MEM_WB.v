// 最后的那个reset不能删除或者被设置为仅仿真有效，不然就会运行rtt出错
module ysyx_24100006_MEM_WB(
    input           clk,
    input           reset,

`ifdef VERILATOR_SIM
    input  [31:0]   pc_i,
    output [31:0]   pc_o,
    input  [31:0]   npc_M,
    output [31:0]   npc_W,
`endif

    input           is_break_i,
    output          is_break_o,
    
    // MEMU  <----> MEM_WB
    input           in_valid,
    output          in_ready,
    
    input  [3:0]    Gpr_Write_Addr_i,
    input  [11:0]   Csr_Write_Addr_i,
    input  [3:0]    irq_no_i,

    // 控制信号
    input           irq_i,
    input           Gpr_Write_i,
    input           Csr_Write_i,

    // MEM_WB <----> WBU
    output          out_valid,
    input           out_ready,

    output [3:0]    Gpr_Write_Addr_o,
    output [11:0]   Csr_Write_Addr_o,
    output [3:0]    irq_no_o,

    // 控制信号
    output          irq_o,
    output          Gpr_Write_o,
    output          Csr_Write_o

    // 面积优化
    ,input  [31:0]  wdata_csr_i
    ,input  [31:0]  wdata_gpr_i
    ,output [31:0]  wdata_csr_o
    ,output [31:0]  wdata_gpr_o

    // 异常处理相关
    ,input          flush_i
);

    // ================= Registers =================
    reg             valid_q;

    reg [3:0]       Gpr_Write_Addr_q;
    reg [11:0]      Csr_Write_Addr_q;
    reg [3:0]       irq_no_q;

    reg             irq_q;
    reg             Gpr_Write_q;
    reg             Csr_Write_q;
    reg             is_break_q;

    // payload
    reg [31:0]      wdata_gpr_q;
    reg [31:0]      wdata_csr_q;

`ifdef VERILATOR_SIM
    reg [31:0]      pc_q;
    reg [31:0]      npc_q;
`endif

    // ================= Handshake =================
    // 空或“可滑动”即可接收
    assign in_ready  = (~valid_q) || out_ready;
    // flush 当拍屏蔽输出，保持“即刻杀”语义
    assign out_valid = valid_q & ~flush_i;

    // ================= Outputs ===================
    assign Gpr_Write_Addr_o = Gpr_Write_Addr_q;
    assign Csr_Write_Addr_o = Csr_Write_Addr_q;
    assign irq_no_o         = irq_no_q;

    assign irq_o            = irq_q;
    assign Gpr_Write_o      = Gpr_Write_q;
    assign Csr_Write_o      = Csr_Write_q;
    assign is_break_o       = is_break_q;

    assign wdata_gpr_o      = wdata_gpr_q;
    assign wdata_csr_o      = wdata_csr_q;

`ifdef VERILATOR_SIM
    assign pc_o             = pc_q;
    assign npc_W            = npc_q;
`endif

    // ================= Control ===================
    wire accept = in_valid  && in_ready;      // 本拍接入新数据
    wire send   = out_valid && out_ready;     // 本拍对下游完成握手（考虑 flush 屏蔽）

    // 有效位：复位/冲刷优先
    always @(posedge clk) begin
        if (reset) begin
            valid_q <= 1'b0;
        end else if (flush_i) begin
            valid_q <= 1'b0;                  // 冲刷：仅清有效位
        end else begin
            if (accept)      valid_q <= 1'b1; // 有新拍 → 有效
            else if (send)   valid_q <= 1'b0; // 被消费且无新拍 → 置空
            // 否则保持
        end
    end

    // 数据位：仅在 accept 时更新（便于门控/降翻转）
    always @(posedge clk) begin
        if (accept) begin
            Gpr_Write_Addr_q <= Gpr_Write_Addr_i;
            Csr_Write_Addr_q <= Csr_Write_Addr_i;
            irq_no_q         <= irq_no_i;

            irq_q            <= irq_i;
            Gpr_Write_q      <= Gpr_Write_i;
            Csr_Write_q      <= Csr_Write_i;
            is_break_q       <= is_break_i;

            wdata_gpr_q      <= wdata_gpr_i;
            wdata_csr_q      <= wdata_csr_i;

`ifdef VERILATOR_SIM
            pc_q             <= pc_i;
            npc_q            <= npc_M;
`endif
        end
// `ifdef VERILATOR_SIM
        // 仿真友好：reset/flush 清零，便于读波形（综合时可不清以省面积）
        else if (reset || flush_i) begin
            Gpr_Write_Addr_q <= 4'd0;
            Csr_Write_Addr_q <= 12'd0;
            irq_no_q         <= 4'b0;

            irq_q            <= 1'b0;
            Gpr_Write_q      <= 1'b0;
            Csr_Write_q      <= 1'b0;
            is_break_q       <= 1'b0;

            wdata_gpr_q      <= 32'd0;
            wdata_csr_q      <= 32'd0;

`ifdef VERILATOR_SIM
            pc_q             <= pc_i;
            npc_q            <= npc_M;
`endif
        end
// `endif
    end

endmodule

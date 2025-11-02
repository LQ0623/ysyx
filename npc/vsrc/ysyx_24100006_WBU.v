/**
    写回模块
*/
import "DPI-C" function void npc_trap ();
module ysyx_24100006_wbu(
    input           clk,
    input           reset,
    input           is_break_i,

    // control signal
    input           irq_W,
    input [3:0]     irq_no_W,
    input           Gpr_Write,
	input           Csr_Write,
    input [3:0]     Gpr_Write_Addr,
    input [11:0]    Csr_Write_Addr,

    // 握手机制使用
	input           wb_out_valid,   // MEM_WB -> WBU   (上游 valid)
    output          wb_out_ready,   // WBU -> MEM_WB   (上游 ready)

`ifdef VERILATOR_SIM
    output          wb_in_valid,    // WBU -> 下游      (下游 valid)
    input           wb_in_ready,    // 下游 -> WBU      (下游 ready)
`endif

    output          irq_WD,
    output [3:0]    irq_no_WD,
    output          Gpr_Write_WD,
	output          Csr_Write_WD,
    output [3:0]    Gpr_Write_Addr_WD,
    output [11:0]   Csr_Write_Addr_WD,
    output [31:0]   wdata_gpr,
    output [31:0]   wdata_csr

    // 面积优化
	,input 	[31:0]  wdata_gpr_W
	,input 	[31:0]  wdata_csr_W

`ifdef VERILATOR_SIM
    // 调试使用
    ,input  [31:0]  pc_w
    ,input  [31:0]  mtvec
    ,input  [31:0]  npc_M
    ,output [31:0]  npc_W
`endif
);
    
`ifdef VERILATOR_SIM
    // 调试使用
    reg [31:0] npc_temp;
`endif

    // 握手机制
	parameter S_IDLE = 0, S_WRITE = 1;
	reg state;

    // TAG:WBU总是就绪，因为写寄存器是单周期操作
    assign wb_out_ready = 1'b1;

    // WBU通常能在一个周期内完成寄存器写入，所以通常总是就绪
    // 但为了支持标准握手协议，我们实现完整的valid/ready机制
`ifdef VERILATOR_SIM
    reg wb_out_ready_reg;
    // assign wb_out_ready = wb_out_ready_reg;

    // 用于跟踪是否正在处理数据
    reg processing;
    assign wb_in_valid = processing;

    always @(posedge clk) begin
        if (reset) begin
            wb_out_ready_reg    <= 1'b1;  // 复位后WBU空闲
            processing          <= 1'b0;

        end else begin
            // 默认：WBU空闲，可以接收新数据
            wb_out_ready_reg    <= 1'b1;
            
            // 当上游有有效数据且我们空闲时，开始处理
            if (wb_out_valid && wb_out_ready_reg) begin
                // 实际写入寄存器操作发生在此处
                // 这是关键：WB阶段必须实际执行物理写入
                // 而不仅仅是产生信号
                
                // 标记我们正在处理（虽然通常立即完成）
                processing      <= 1'b1;


                // 一旦开始处理，WBU不再空闲，直到处理完成
                npc_temp        <= irq_WD ? mtvec : npc_M; // 调试使用

            end
            
            // 通常WBU在一个周期内完成，所以processing不会持续
            // 但如果需要模拟多周期行为（如调试模式），可以扩展
            if (processing) begin
                // 实际写入已完成，清除处理标志
                processing      <= 1'b0;
            end
        end
    end
`endif

    assign irq_WD               = irq_W;
    assign irq_no_WD            = irq_no_W;
    assign Gpr_Write_WD         = Gpr_Write;
    assign Csr_Write_WD         = Csr_Write;
    assign Gpr_Write_Addr_WD    = Gpr_Write_Addr;
    assign Csr_Write_Addr_WD    = Csr_Write_Addr;

`ifdef VERILATOR_SIM
    assign npc_W = npc_temp;        // 调试使用
`endif

    // 选择写入通用寄存器的内容
    assign wdata_gpr            = wdata_gpr_W;

	// 选择写入系统寄存器的内容
    assign wdata_csr            = wdata_csr_W;

`ifdef VERILATOR_SIM
always @(*) begin
    if(is_break_i == 1)
        npc_trap();
end
`endif

endmodule
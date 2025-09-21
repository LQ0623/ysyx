// 冲刷流水线就是将所有的存储的数据都置为0
module ysyx_24100006_ID_EXE(
    input           clk,
    input           reset,

    input           is_break_i,
    output          is_break_o,
    input           flush_i,   // NEW: flush current ID/EXE pipeline register on redirect
    // IDU  <----> ID_EXE
    input           in_valid,
    output          in_ready,
    input [31:0]    pc_i,
    input [31:0]    sext_imm_i,
    input [31:0]    rs1_data_i,
    input [31:0]    rs2_data_i,
    input [31:0]    rdata_csr_i,
    input [3:0]     alu_op_i,
    input [3:0]     Gpr_Write_Addr_i,
    input [11:0]    Csr_Write_Addr_i,
    input [2:0]     Gpr_Write_RD_i,
    input [1:0]     Csr_Write_RD_i,
    input [3:0]     Jump_i,
    input [7:0]     Mem_WMask_i,
    input [2:0]     Mem_RMask_i,
    input [7:0]     irq_no_i,
    input [31:0]    mtvec_i,
    input [31:0]    mepc_i,
    

    // 控制信号
    input           is_fence_i_i,
    input           irq_i,
    input           AluSrcA_i,
    input           AluSrcB_i,
    input           Gpr_Write_i,
    input           Csr_Write_i,
    input [1:0]     sram_read_write_i,


    // ID_EXE <----> EXEU
    output          out_valid,
    input           out_ready,      // 下一级给的输入
    output [31:0]   pc_o,
    output [31:0]   sext_imm_o,
    output [31:0]   rs1_data_o,
    output [31:0]   rs2_data_o,
    output [31:0]   rdata_csr_o,
    output [3:0]    alu_op_o,
    output [3:0]    Gpr_Write_Addr_o,
    output [11:0]   Csr_Write_Addr_o,
    output [2:0]    Gpr_Write_RD_o,
    output [1:0]    Csr_Write_RD_o,
    output [3:0]    Jump_o,
    output [7:0]    Mem_WMask_o,
    output [2:0]    Mem_RMask_o,
    output [7:0]    irq_no_o,
    output [31:0]   mtvec_o,
    output [31:0]   mepc_o,
        

    // 控制信号
    output          is_fence_i_o,
    output          irq_o,
    output          AluSrcA_o,
    output          AluSrcB_o,
    output          Gpr_Write_o,
    output          Csr_Write_o,
    output [1:0]    sram_read_write_o
);

    // 声明临时寄存器
    reg [31:0]      pc_temp;
    reg [31:0]      sext_imm_temp;
    reg [31:0]      rs1_data_temp;
    reg [31:0]      rs2_data_temp;
    reg [31:0]      rdata_csr_temp;
    reg [3:0]       alu_op_temp;
    reg [3:0]       Gpr_Write_Addr_temp;
    reg [11:0]      Csr_Write_Addr_temp;
    reg [2:0]       Gpr_Write_RD_temp;
    reg [1:0]       Csr_Write_RD_temp;
    reg [3:0]       Jump_temp;
    reg [7:0]       Mem_WMask_temp;
    reg [2:0]       Mem_RMask_temp;
    reg [7:0]       irq_no_temp;
    reg [31:0]      mtvec_temp;
    reg [31:0]      mepc_temp;
    reg             is_fence_i_temp;
    reg             irq_temp;
    reg             AluSrcA_temp;
    reg             AluSrcB_temp;
    reg             Gpr_Write_temp;
    reg             Csr_Write_temp;
    reg             is_break_temp;
    reg [1:0]       sram_read_write_temp;
    reg             valid_temp;
    
    // 使用 assign 语句将临时寄存器赋值给输出信号
    assign pc_o                 = pc_temp;
    assign sext_imm_o           = sext_imm_temp;
    assign rs1_data_o           = rs1_data_temp;
    assign rs2_data_o           = rs2_data_temp;
    assign rdata_csr_o          = rdata_csr_temp;
    assign alu_op_o             = alu_op_temp;
    assign Gpr_Write_Addr_o     = Gpr_Write_Addr_temp;
    assign Csr_Write_Addr_o     = Csr_Write_Addr_temp;
    assign Gpr_Write_RD_o       = Gpr_Write_RD_temp;
    assign Csr_Write_RD_o       = Csr_Write_RD_temp;
    assign Jump_o               = Jump_temp;
    assign Mem_WMask_o          = Mem_WMask_temp;
    assign Mem_RMask_o          = Mem_RMask_temp;
    assign irq_no_o             = irq_no_temp;
    assign mtvec_o              = mtvec_temp;
    assign mepc_o               = mepc_temp;
    assign is_fence_i_o         = is_fence_i_temp;
    assign irq_o                = irq_temp;
    assign AluSrcA_o            = AluSrcA_temp;
    assign AluSrcB_o            = AluSrcB_temp;
    assign Gpr_Write_o          = Gpr_Write_temp;
    assign Csr_Write_o          = Csr_Write_temp;
    assign is_break_o           = is_break_temp;
    assign sram_read_write_o    = sram_read_write_temp;

    assign out_valid            = (flush_i == 1'b1) ? 1'b0 : valid_temp;
    // 当没有有效存储时，或者当存储并且下游准备好时，可以接受新数据（可以滑动）
    assign in_ready             = (!valid_temp) || (out_ready && valid_temp);

    // 如果 in_valid==0 且 in_ready==1 -> 清除有效（已由 valid_r <= in_valid 完成）
    always @(posedge clk) begin
        if (reset) begin
            // 复位逻辑 - 所有临时寄存器赋值为0
            valid_temp              <= 1'b0;
            pc_temp                 <= 32'h00000000;
            sext_imm_temp           <= 32'd0;
            rs1_data_temp           <= 32'd0;
            rs2_data_temp           <= 32'd0;
            rdata_csr_temp          <= 32'd0;
            alu_op_temp             <= 4'd0;
            Gpr_Write_Addr_temp     <= 4'b0;
            Csr_Write_Addr_temp     <= 12'b0;
            Gpr_Write_RD_temp       <= 3'd0;
            Csr_Write_RD_temp       <= 2'd0;
            Jump_temp               <= 4'd0;
            Mem_WMask_temp          <= 8'd0;
            Mem_RMask_temp          <= 3'd0;
            irq_no_temp             <= 8'd0;
            mtvec_temp              <= 32'd0;
            mepc_temp               <= 32'd0;
            is_fence_i_temp         <= 1'd0;
            irq_temp                <= 1'd0;
            AluSrcA_temp            <= 1'd0;
            AluSrcB_temp            <= 1'd0;
            Gpr_Write_temp          <= 1'd0;
            Csr_Write_temp          <= 1'd0;
            is_break_temp           <= 1'b0;        // 复位时不是ebreak状态
            sram_read_write_temp    <= 2'd0;
        end else begin
            // flush的时候，将所有的数据都清除，不然会导致错误的指令被执行
            if(flush_i)begin
                valid_temp       <= 1'b0; // 冲刷流水线
                irq_temp         <= 1'b0; // 冲刷流水线时清除中断信号
                pc_temp                 <= 32'h00000000;
                sext_imm_temp           <= 32'd0;
                rs1_data_temp           <= 32'd0;
                rs2_data_temp           <= 32'd0;
                rdata_csr_temp          <= 32'd0;
                alu_op_temp             <= 4'd0;
                Gpr_Write_Addr_temp     <= 4'b0;
                Csr_Write_Addr_temp     <= 12'b0;
                Gpr_Write_RD_temp       <= 3'd0;
                Csr_Write_RD_temp       <= 2'd0;
                Jump_temp               <= 4'd0;
                Mem_WMask_temp          <= 8'd0;
                Mem_RMask_temp          <= 3'd0;
                irq_no_temp             <= 8'd0;
                mtvec_temp              <= 32'd0;
                mepc_temp               <= 32'd0;
                is_fence_i_temp         <= 1'd0;
                AluSrcA_temp            <= 1'd0;
                AluSrcB_temp            <= 1'd0;
                Gpr_Write_temp          <= 1'd0;
                Csr_Write_temp          <= 1'd0;
                is_break_temp           <= 1'b0;        // 复位时不是ebreak状态
                sram_read_write_temp    <= 2'd0;
            end
            // 当允许接受新输入时
            else if (in_ready) begin
                valid_temp                  <= in_valid;
                if (in_valid)begin
                    // 非复位逻辑 - 将输入信号赋值给临时寄存器
                    pc_temp                 <= pc_i;
                    sext_imm_temp           <= sext_imm_i;
                    rs1_data_temp           <= rs1_data_i;
                    rs2_data_temp           <= rs2_data_i;
                    rdata_csr_temp          <= rdata_csr_i;
                    alu_op_temp             <= alu_op_i;
                    Gpr_Write_Addr_temp     <= Gpr_Write_Addr_i;
                    Csr_Write_Addr_temp     <= Csr_Write_Addr_i;
                    Gpr_Write_RD_temp       <= Gpr_Write_RD_i;
                    Csr_Write_RD_temp       <= Csr_Write_RD_i;
                    Jump_temp               <= Jump_i;
                    Mem_WMask_temp          <= Mem_WMask_i;
                    Mem_RMask_temp          <= Mem_RMask_i;
                    irq_no_temp             <= irq_no_i;
                    mtvec_temp              <= mtvec_i;
                    mepc_temp               <= mepc_i;
                    is_fence_i_temp         <= is_fence_i_i;
                    irq_temp                <= irq_i;
                    AluSrcA_temp            <= AluSrcA_i;
                    AluSrcB_temp            <= AluSrcB_i;
                    Gpr_Write_temp          <= Gpr_Write_i;
                    Csr_Write_temp          <= Csr_Write_i;
                    is_break_temp           <= is_break_i;
                    sram_read_write_temp    <= sram_read_write_i;
                end 
            end
            // 没有新数据则一直保持数据
        end
    end

endmodule
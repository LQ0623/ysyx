// 冲刷流水线就是将所有的存储的数据都置为0
module ysyx_24100006_ID_EXE(
    input           clk,
    input           reset,

`ifdef VERILATOR_SIM
    // 调试使用
    input [31:0]    pc_i,
    output [31:0]   pc_o,
`endif

    input           is_break_i,
    output          is_break_o,
    input           flush_i,   // NEW: flush current ID/EXE pipeline register on redirect
    // IDU  <----> ID_EXE
    input           in_valid,
    output          in_ready,
    
    input [3:0]     alu_op_i,
    input [3:0]     Gpr_Write_Addr_i,
    input [11:0]    Csr_Write_Addr_i,
    input [1:0]     Gpr_Write_RD_i,
    input [2:0]     Jump_i,
    input [3:0]     irq_no_i,

    // 控制信号
    input           is_fence_i_i,
    input           irq_i,
    input           Gpr_Write_i,
    input           Csr_Write_i,
    input [1:0]     sram_read_write_i,


    // ID_EXE <----> EXEU
    output          out_valid,
    input           out_ready,      // 下一级给的输入
    
    output [3:0]    alu_op_o,
    output [3:0]    Gpr_Write_Addr_o,
    output [11:0]   Csr_Write_Addr_o,
    output [1:0]    Gpr_Write_RD_o,
    output [2:0]    Jump_o,
    output [3:0]    irq_no_o
        
    // 面积优化
    ,input  [31:0]  pc_j_m_e_n_i
    ,input  [31:0]  alu_a_data_i
    ,input  [31:0]  alu_b_data_i
    ,input  [31:0]  pc_add_imm_i
    ,output [31:0]  pc_j_m_e_n_o
    ,output [31:0]  alu_a_data_o
    ,output [31:0]  alu_b_data_o
    ,output [31:0]  pc_add_imm_o

    ,input  [31:0]  wdata_csr_i
    ,input  [31:0]  wdata_gpr_i
    ,output [31:0]  wdata_csr_o
    ,output [31:0]  wdata_gpr_o

    ,input  [2:0]   Mem_Mask_i
    ,output [2:0]   Mem_Mask_o

    ,input  [31:0]  pc_add_4_i
    ,output [31:0]  pc_add_4_o,

    // 控制信号
    output          is_fence_i_o,
    output          irq_o,
    output          Gpr_Write_o,
    output          Csr_Write_o,
    output [1:0]    sram_read_write_o
);

    // 声明临时寄存器

`ifdef VERILATOR_SIM
    // 调试使用
    reg [31:0]      pc_temp;
`endif

    reg [3:0]       alu_op_temp;
    reg [3:0]       Gpr_Write_Addr_temp;
    reg [11:0]      Csr_Write_Addr_temp;
    reg [1:0]       Gpr_Write_RD_temp;
    reg [2:0]       Jump_temp;
    reg [2:0]       Mem_WMask_temp;
    reg [2:0]       Mem_RMask_temp;
    reg [3:0]       irq_no_temp;
    reg             is_fence_i_temp;
    reg             irq_temp;
    reg             Gpr_Write_temp;
    reg             Csr_Write_temp;
    reg             is_break_temp;
    reg [1:0]       sram_read_write_temp;
    reg             valid_temp;
    
    // 面积优化
    reg [31:0]      pc_j_m_e_n_temp;
    reg [31:0]      alu_a_data_temp;
    reg [31:0]      alu_b_data_temp;
    reg [31:0]      pc_add_imm_temp;
    assign pc_j_m_e_n_o         = pc_j_m_e_n_temp;
    assign alu_a_data_o         = alu_a_data_temp;
    assign alu_b_data_o         = alu_b_data_temp;
    assign pc_add_imm_o         = pc_add_imm_temp;

    reg [31:0]      wdata_gpr_temp;
    reg [31:0]      wdata_csr_temp;
    assign wdata_gpr_o          = wdata_gpr_temp;
    assign wdata_csr_o          = wdata_csr_temp;

    reg [2:0]       Mem_Mask_temp;
    assign Mem_Mask_o           = Mem_Mask_temp;

    reg [31:0]      pc_add_4_temp;
    assign pc_add_4_o           = pc_add_4_temp;


    // 使用 assign 语句将临时寄存器赋值给输出信号
`ifdef VERILATOR_SIM
    // 调试使用
    assign pc_o                 = pc_temp;
`endif

    assign alu_op_o             = alu_op_temp;
    assign Gpr_Write_Addr_o     = Gpr_Write_Addr_temp;
    assign Csr_Write_Addr_o     = Csr_Write_Addr_temp;
    assign Gpr_Write_RD_o       = Gpr_Write_RD_temp;
    assign Jump_o               = Jump_temp;
    assign irq_no_o             = irq_no_temp;
    assign is_fence_i_o         = is_fence_i_temp;
    assign irq_o                = irq_temp;
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
            valid_temp                  <= 1'b0;

`ifdef VERILATOR_SIM
            // 调试使用
            pc_temp                     <= 32'h00000000;
`endif

            alu_op_temp                 <= 4'd0;
            Gpr_Write_Addr_temp         <= 4'b0;
            Csr_Write_Addr_temp         <= 12'b0;
            Gpr_Write_RD_temp           <= 2'd0;
            Jump_temp                   <= 3'd0;
            irq_no_temp                 <= 4'b0;
            is_fence_i_temp             <= 1'd0;
            irq_temp                    <= 1'd0;
            Gpr_Write_temp              <= 1'd0;
            Csr_Write_temp              <= 1'd0;
            is_break_temp               <= 1'b0;        // 复位时不是ebreak状态
            sram_read_write_temp        <= 2'd0;
        end else begin
            // flush的时候，将所有的数据都清除，不然会导致错误的指令被执行
            if(flush_i)begin
                valid_temp              <= 1'b0; // 冲刷流水线
                irq_temp                <= 1'b0; // 冲刷流水线时清除中断信号

`ifdef VERILATOR_SIM
                // 调试使用
                pc_temp                 <= 32'h00000000;
`endif

                alu_op_temp             <= 4'd0;
                Gpr_Write_Addr_temp     <= 4'b0;
                Csr_Write_Addr_temp     <= 12'b0;
                Gpr_Write_RD_temp       <= 2'd0;
                Jump_temp               <= 3'd0;
                irq_no_temp             <= 4'b0;
                is_fence_i_temp         <= 1'd0;
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

`ifdef VERILATOR_SIM
                    // 调试使用
                    pc_temp                 <= pc_i;
`endif
                    alu_op_temp             <= alu_op_i;
                    Gpr_Write_Addr_temp     <= Gpr_Write_Addr_i;
                    Csr_Write_Addr_temp     <= Csr_Write_Addr_i;
                    Gpr_Write_RD_temp       <= Gpr_Write_RD_i;
                    Jump_temp               <= Jump_i;
                    irq_no_temp             <= irq_no_i;
                    is_fence_i_temp         <= is_fence_i_i;
                    irq_temp                <= irq_i;
                    Gpr_Write_temp          <= Gpr_Write_i;
                    Csr_Write_temp          <= Csr_Write_i;
                    is_break_temp           <= is_break_i;
                    sram_read_write_temp    <= sram_read_write_i;

                    // 面积优化
                    pc_j_m_e_n_temp         <= pc_j_m_e_n_i;
                    alu_a_data_temp         <= alu_a_data_i;
                    alu_b_data_temp         <= alu_b_data_i;
                    pc_add_imm_temp         <= pc_add_imm_i;

                    wdata_gpr_temp          <= wdata_gpr_i;
                    wdata_csr_temp          <= wdata_csr_i;

                    Mem_Mask_temp           <= Mem_Mask_i;

                    pc_add_4_temp           <= pc_add_4_i;
                end 
            end
            // 没有新数据则一直保持数据
        end
    end

endmodule
// 冲刷流水线就是将所有的存储的数据都置为0
// TODO：要想是否可以建一个新的模块来算这个，放在IFU的前面，这个应该存在问题，因为最开始的几拍就流不起来了
module ysyx_24100006_EXE_MEM(
    input           clk,
    input           reset,
    
input [31:0]    npc_E,
output [31:0]   npc_M,
    input           is_break_i,
    output          is_break_o,

    // EXEU   <----> EXE_MEM
    input           in_valid,
    output          in_ready,
    input [31:0]    pc_i,
    input [31:0]    npc_i,          // 还是需要缓存一下npc
    input           redirect_valid_i,   // 是使用EXE计算的NPC还是直接pc+4
    input [31:0]    alu_result_i,
    input [31:0]    sext_imm_i,
    input [31:0]    rs1_data_i,
    input [31:0]    rs2_data_i,
    input [31:0]    rdata_csr_i,
    input [3:0]     Gpr_Write_Addr_i,
    input [11:0]    Csr_Write_Addr_i,
    input [2:0]     Gpr_Write_RD_i,
    input [1:0]     Csr_Write_RD_i,
    input [7:0]     Mem_WMask_i,
    input [2:0]     Mem_RMask_i,
    input [7:0]     irq_no_i,

    // 控制信号
    input           irq_i,
    input           Gpr_Write_i,
    input           Csr_Write_i,
    input [1:0]     sram_read_write_i,

    // EXE_MEM <----> MEMU
    output          out_valid,
    input           out_ready,
    output [31:0]   pc_o,
    output [31:0]   npc_o,          // 缓存后的npc,这个信号是去IFU的
    output          redirect_valid_o,
    output [31:0]   alu_result_o,
    output [31:0]   sext_imm_o,
    output [31:0]   rs1_data_o,
    output [31:0]   rs2_data_o,
    output [31:0]   rdata_csr_o,
    output [3:0]    Gpr_Write_Addr_o,
    output [11:0]   Csr_Write_Addr_o,
    output [2:0]    Gpr_Write_RD_o,
    output [1:0]    Csr_Write_RD_o,
    output [7:0]    Mem_WMask_o,
    output [2:0]    Mem_RMask_o,
    output [7:0]    irq_no_o,

    // 控制信号
    output          irq_o,
    output          Gpr_Write_o,
    output          Csr_Write_o,
    output [1:0]    sram_read_write_o

    // 异常处理相关
    ,input          flush_i
);

    // 声明临时寄存器
    reg [31:0]  pc_temp;    
    reg [31:0]  npc_temp;
    reg         redirect_valid_temp;
    reg [31:0]  alu_result_temp;
    reg [31:0]  sext_imm_temp;
    reg [31:0]  rs1_data_temp;
    reg [31:0]  rs2_data_temp;
    reg [31:0]  rdata_csr_temp;
    
    reg [3:0]   Gpr_Write_Addr_temp;
    reg [11:0]  Csr_Write_Addr_temp;
    reg [2:0]   Gpr_Write_RD_temp;
    reg [1:0]   Csr_Write_RD_temp;
    reg [7:0]   Mem_WMask_temp;
    reg [2:0]   Mem_RMask_temp;
    reg [7:0]   irq_no_temp;
    reg         irq_temp;
    reg         Gpr_Write_temp;
    reg         Csr_Write_temp;
    reg         is_break_temp; // 是否是ebreak指令
    reg [1:0]   sram_read_write_temp;
    reg         valid_temp;

reg [31:0] npc_temp_old;

    // 使用 assign 语句将临时寄存器赋值给输出信号
    assign pc_o                 = pc_temp;
    assign npc_o                = npc_temp;
    assign redirect_valid_o     = redirect_valid_temp;
    assign alu_result_o         = alu_result_temp;
    assign sext_imm_o           = sext_imm_temp;
    assign rs1_data_o           = rs1_data_temp;
    assign rs2_data_o           = rs2_data_temp;
    assign rdata_csr_o          = rdata_csr_temp;
    assign Gpr_Write_Addr_o     = Gpr_Write_Addr_temp;
    assign Csr_Write_Addr_o     = Csr_Write_Addr_temp;
    assign Gpr_Write_RD_o       = Gpr_Write_RD_temp;
    assign Csr_Write_RD_o       = Csr_Write_RD_temp;
    assign Mem_WMask_o          = Mem_WMask_temp;
    assign Mem_RMask_o          = Mem_RMask_temp;
    assign irq_no_o             = irq_no_temp;
    assign irq_o                = irq_temp;
    assign Gpr_Write_o          = Gpr_Write_temp;
    assign Csr_Write_o          = Csr_Write_temp;
    assign is_break_o           = is_break_temp;
    assign sram_read_write_o    = sram_read_write_temp;

    assign out_valid            = valid_temp;
    // 当没有有效存储时，或者当存储并且下游准备好时，可以接受新数据（可以滑动）
    assign in_ready             = (!valid_temp) || (out_ready && valid_temp);

assign npc_M = npc_temp_old;
    // 如果 in_valid==0 且 in_ready==1 -> 清除有效（已由 valid_r <= in_valid 完成）
    always @(posedge clk) begin
        if (reset) begin
            // 复位逻辑 - 所有临时寄存器赋值为0
            valid_temp              <= 1'b0;
            pc_temp                 <= 32'h00000000;
            npc_temp                <= 32'd0;
            redirect_valid_temp     <= 1'b0;
            alu_result_temp         <= 32'd0;
            sext_imm_temp           <= 32'd0;
            rs1_data_temp           <= 32'd0;
            rs2_data_temp           <= 32'd0;
            rdata_csr_temp          <= 32'd0;
            Gpr_Write_Addr_temp     <= 4'b0;
            Csr_Write_Addr_temp     <= 12'b0;
            Gpr_Write_RD_temp       <= 3'd0;
            Csr_Write_RD_temp       <= 2'd0;
            Mem_WMask_temp          <= 8'd0;
            Mem_RMask_temp          <= 3'd0;
            irq_no_temp             <= 8'd0;
            irq_temp                <= 1'd0;
            Gpr_Write_temp          <= 1'd0;
            Csr_Write_temp          <= 1'd0;
            is_break_temp           <= 1'b0; // 复位时不可能是ebreak指令
            sram_read_write_temp    <= 2'd0;

npc_temp_old            <= 32'd0;
        end
        // 若果当前输出被接受且有跳转指令，则清除当前的有效位，防止错误执行
        else if(out_ready && redirect_valid_temp)begin 
            valid_temp <=0;
            redirect_valid_temp<=0;
        end
        else if(flush_i == 1)begin
            valid_temp <=0;
            irq_temp         <= 1'b0;
            redirect_valid_temp<=0;
        end
        else begin
            // 当允许接受新输入时
            if (in_ready) begin
                valid_temp                  <= in_valid;
                if (in_valid)begin
                    // 非复位逻辑 - 将输入信号赋值给临时寄存器
                    pc_temp                 <= pc_i;
                    npc_temp                <= npc_i;
                    redirect_valid_temp     <= redirect_valid_i;
                    alu_result_temp         <= alu_result_i;
                    sext_imm_temp           <= sext_imm_i;
                    rs1_data_temp           <= rs1_data_i;
                    rs2_data_temp           <= rs2_data_i;
                    rdata_csr_temp          <= rdata_csr_i;
                    Gpr_Write_Addr_temp     <= Gpr_Write_Addr_i;
                    Csr_Write_Addr_temp     <= Csr_Write_Addr_i;
                    Gpr_Write_RD_temp       <= Gpr_Write_RD_i;
                    Csr_Write_RD_temp       <= Csr_Write_RD_i;
                    Mem_WMask_temp          <= Mem_WMask_i;
                    Mem_RMask_temp          <= Mem_RMask_i;
                    irq_no_temp             <= irq_no_i;
                    irq_temp                <= irq_i;
                    Gpr_Write_temp          <= Gpr_Write_i;
                    Csr_Write_temp          <= Csr_Write_i;
                    is_break_temp           <= is_break_i;
                    sram_read_write_temp    <= sram_read_write_i;

                    npc_temp_old            <= npc_i;
                end 
            end
            // 没有新数据则一直保持数据
        end
    end

endmodule
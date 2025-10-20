// 冲刷流水线就是将所有的存储的数据都置为0
// TODO：要想是否可以建一个新的模块来算这个，放在IFU的前面，这个应该存在问题，因为最开始的几拍就流不起来了
module ysyx_24100006_EXE_MEM(
    input           clk,
    input           reset,

`ifdef VERILATOR_SIM
    input [31:0]    pc_i,
    output [31:0]   pc_o,
    input [31:0]    npc_E,
    output [31:0]   npc_M,
`endif

    input           is_break_i,
    output          is_break_o,

    // EXEU   <----> EXE_MEM
    input           in_valid,
    output          in_ready,
    input [31:0]    npc_i,          // 还是需要缓存一下npc
    input           redirect_valid_i,   // 是使用EXE计算的NPC还是直接pc+4
    input [31:0]    alu_result_i,
    input [3:0]     Gpr_Write_Addr_i,
    input [11:0]    Csr_Write_Addr_i,
    input [1:0]     Gpr_Write_RD_i,

    // 控制信号
    input           irq_i,
    input           Gpr_Write_i,
    input           Csr_Write_i,
    input [1:0]     sram_read_write_i,

    // EXE_MEM <----> MEMU
    output          out_valid,
    input           out_ready,
    output [31:0]   npc_o,          // 缓存后的npc,这个信号是去IFU的
    output          redirect_valid_o,
    output [31:0]   alu_result_o,
    output [3:0]    Gpr_Write_Addr_o,
    output [11:0]   Csr_Write_Addr_o,
    output [1:0]    Gpr_Write_RD_o,

    // 控制信号
    output          irq_o,
    output          Gpr_Write_o,
    output          Csr_Write_o,
    output [1:0]    sram_read_write_o

    // 面积优化
    ,input  [31:0]  wdata_csr_i
    ,input  [31:0]  wdata_gpr_i
    ,output [31:0]  wdata_csr_o
    ,output [31:0]  wdata_gpr_o

    ,input  [2:0]   Mem_Mask_i
    ,output [2:0]   Mem_Mask_o

    // 异常处理相关
    ,input          flush_i
);

    // 声明临时寄存器
    reg [31:0]      npc_temp;
    reg             redirect_valid_temp;
    reg [31:0]      alu_result_temp;
    reg [31:0]      rs2_data_temp;
    
    reg [3:0]       Gpr_Write_Addr_temp;
    reg [11:0]      Csr_Write_Addr_temp;
    reg [1:0]       Gpr_Write_RD_temp;
    reg             irq_temp;
    reg             Gpr_Write_temp;
    reg             Csr_Write_temp;
    reg             is_break_temp; // 是否是ebreak指令
    reg [1:0]       sram_read_write_temp;
    reg             valid_temp;

`ifdef VERILATOR_SIM
    reg [31:0]      pc_temp;
    reg [31:0]      npc_temp_old;
`endif

    // 面积优化
    reg [31:0]      wdata_gpr_temp;
    reg [31:0]      wdata_csr_temp;
    assign wdata_gpr_o          = wdata_gpr_temp;
    assign wdata_csr_o          = wdata_csr_temp;

    reg [2:0]       Mem_Mask_temp;
    assign Mem_Mask_o           = Mem_Mask_temp;

    // 使用 assign 语句将临时寄存器赋值给输出信号
    assign npc_o                = npc_temp;
    assign redirect_valid_o     = redirect_valid_temp;
    assign alu_result_o         = alu_result_temp;
    assign Gpr_Write_Addr_o     = Gpr_Write_Addr_temp;
    assign Csr_Write_Addr_o     = Csr_Write_Addr_temp;
    assign Gpr_Write_RD_o       = Gpr_Write_RD_temp;
    assign irq_o                = irq_temp;
    assign Gpr_Write_o          = Gpr_Write_temp;
    assign Csr_Write_o          = Csr_Write_temp;
    assign is_break_o           = is_break_temp;
    assign sram_read_write_o    = sram_read_write_temp;

    assign out_valid            = valid_temp;
    // 当没有有效存储时，或者当存储并且下游准备好时，可以接受新数据（可以滑动）
    assign in_ready             = (!valid_temp) || (out_ready && valid_temp);

`ifdef VERILATOR_SIM
    assign pc_o                 = pc_temp;
    assign npc_M                = npc_temp_old;
`endif

    always@(posedge clk)begin
        if(reset)begin
            valid_temp <= 1'b0;
        end else begin
            // flush的时候，将有效位清除
            if(flush_i)begin
                valid_temp  <= 1'b0;
            end
            // 当允许接受新输入时
            else if (in_ready) begin
                valid_temp <= in_valid;
            end
            // 否则保持不变
        end
    end

    // 如果 in_valid==0 且 in_ready==1 -> 清除有效（已由 valid_r <= in_valid 完成）
    always @(posedge clk) begin
        if (reset) begin
            // 复位逻辑 - 所有临时寄存器赋值为0

`ifdef VERILATOR_SIM
            pc_temp                 <= 32'h00000000;
`endif

            npc_temp                <= 32'd0;
            redirect_valid_temp     <= 1'b0;
            alu_result_temp         <= 32'd0;
            Gpr_Write_Addr_temp     <= 4'b0;
            Csr_Write_Addr_temp     <= 12'b0;
            Gpr_Write_RD_temp       <= 2'd0;
            irq_temp                <= 1'd0;
            Gpr_Write_temp          <= 1'd0;
            Csr_Write_temp          <= 1'd0;
            is_break_temp           <= 1'b0; // 复位时不可能是ebreak指令
            sram_read_write_temp    <= 2'd0;

        end
        // 若果当前输出被接受且有跳转指令，则清除当前的有效位，防止错误执行
        else if(out_ready && redirect_valid_temp)begin 
            valid_temp              <=0;
            redirect_valid_temp     <=0;
        end
        else if(flush_i == 1)begin
            valid_temp              <=0;
            irq_temp                <= 1'b0;
            redirect_valid_temp     <=0;
        end
        else begin
            // 当允许接受新输入时
            if (in_ready & in_valid) begin
                // if (in_valid)begin
                    // 非复位逻辑 - 将输入信号赋值给临时寄存器
                    npc_temp                <= npc_i;
                    redirect_valid_temp     <= redirect_valid_i;
                    alu_result_temp         <= alu_result_i;
                    Gpr_Write_Addr_temp     <= Gpr_Write_Addr_i;
                    Csr_Write_Addr_temp     <= Csr_Write_Addr_i;
                    Gpr_Write_RD_temp       <= Gpr_Write_RD_i;
                    irq_temp                <= irq_i;
                    Gpr_Write_temp          <= Gpr_Write_i;
                    Csr_Write_temp          <= Csr_Write_i;
                    is_break_temp           <= is_break_i;
                    sram_read_write_temp    <= sram_read_write_i;
`ifdef VERILATOR_SIM
                    pc_temp                 <= pc_i;
                    npc_temp_old            <= npc_i;
`endif
                    // 面积优化
                    wdata_gpr_temp          <= wdata_gpr_i;
                    wdata_csr_temp          <= wdata_csr_i;

                    Mem_Mask_temp           <= Mem_Mask_i;
                end 
            end
            // 没有新数据则一直保持数据
        end
    // end

endmodule

// TAGS:原版面积更小
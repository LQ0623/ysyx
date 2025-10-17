/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input               clk,
    input               reset,

`ifdef VERILATOR_SIM
    input [31:0]        pc_M,
    output [31:0]       pc_W,
    input  [31:0]       npc_E,
    output [31:0]       npc_M,
`endif

    input               is_break_i,
    output              is_break_o,
    input [1:0]         sram_read_write,    // 00:无访存 01:读 10:写

    // from EXE_MEM（上一拍已寄存，但仍需在本级再次锁存）
    input [31:0]        alu_result_M,

    // control signal
    input               irq_M,
    input [3:0]         irq_no_M,
    input               Gpr_Write_M,
    input               Csr_Write_M,
    input [3:0]         Gpr_Write_Addr_M,
    input [11:0]        Csr_Write_Addr_M,
    input [1:0]         Gpr_Write_RD_M,

    // AXI-Lite接口
    // read_addr
    output  reg [31:0]  axi_araddr,
    input   reg         axi_arready,
    output  reg         axi_arvalid,
    // read data
    input   reg [31:0]  axi_rdata,
    input   reg         axi_rvalid,
    output  reg         axi_rready,
    // write addr
    output  reg [31:0]  axi_awaddr,
    input   reg         axi_awready,
    output  reg         axi_awvalid,
    // write data
    input   reg         axi_wready,
    output  reg [31:0]  axi_wdata,
    output  reg         axi_wvalid,
    // response
    input   reg         axi_bvalid,
    output  reg         axi_bready,

    // 新增AXI信号
    // 读通道
    output  reg [7:0]   axi_arlen,
    output  reg [2:0]   axi_arsize,
    // 写通道
    output  reg [7:0]   axi_awlen,
    output  reg [2:0]   axi_awsize,
    output  reg [3:0]   axi_wstrb,
    output  reg         axi_wlast,

    // 用于分辨原始的地址的后两位
    output  reg [1:0]   axi_addr_suffix,


    // 握手机制使用
    input               mem_out_valid,   // EXE_MEM -> MEMU (上游 valid)
    output              mem_out_ready,   // MEMU -> EXE_MEM  (上游 ready)
    output              mem_in_valid,    // MEMU -> MEM_WB (下游 valid)
    input               mem_in_ready,    // MEM_WB -> MEMU (下游 ready)
    output              is_load,
    // to MEM_WB（下游）
    // control signal to WBU（经 MEM_WB）
    output              irq_W,
    output [3:0]        irq_no_W,
    output              Gpr_Write_W,
    output              Csr_Write_W,
    output [3:0]        Gpr_Write_Addr_W,
    output [11:0]       Csr_Write_Addr_W

    // 面积优化
    ,input  [31:0]      wdata_gpr_M
    ,input  [31:0]      wdata_csr_M
    ,output [31:0]      wdata_gpr_W
    ,output [31:0]      wdata_csr_W

    ,input  [2:0]       Mem_Mask_M

    // 前递单元设计
    ,output             exe_mem_is_load
    ,output [31:0]      mem_fw_data
);

    // ================= 内部寄存器（在接收上游时一次性锁存） =================
    reg         is_break_r;

    reg         irq_r;
    reg [3:0]   irq_no_r;
    reg         Gpr_Write_r;
    reg         Csr_Write_r;
    reg [3:0]   Gpr_Write_Addr_r;
    reg [11:0]  Csr_Write_Addr_r;
    reg [1:0]   Gpr_Write_RD_r;

    // 面积优化
    reg [31:0]  wdata_gpr_r;
    reg [31:0]  wdata_csr_r;

    reg [2:0]   Mem_Mask_r;

    // 访存锁存
    reg [31:0]  locked_addr;   // 地址锁存
    reg [31:0]  locked_data;   // 写数据锁存
    reg [1:0]   locked_sram_read_write;
    reg [31:0]  locked_read_data;

    // ================= 状态机（已精简：仅 3 个状态） =================
    // 现在：  S_IDLE, S_ACCESS(读写统一), S_SEND
    localparam  S_IDLE   = 2'b00,
                S_ACCESS = 2'b01,
                S_SEND   = 2'b11;

    reg [1:0] state;

    // ----------------- 上下游握手信号（纯组合） -----------------
    assign mem_out_ready = (state[0] == 1'b0);
    assign mem_in_valid  = (state[1] == 1'b1);

    always @(posedge clk) begin
        if (reset) begin
            // axi 握手信号初始化
            axi_arvalid <= 0;
            axi_awvalid <= 0;
            axi_wvalid  <= 0;
            axi_rready  <= 0;
            axi_bready  <= 0;
            axi_wdata   <= 0;

            axi_arlen   <= 8'b0;
            axi_arsize  <= 3'b010;
            axi_awlen   <= 8'b0;
            axi_awsize  <= 3'b010;
            axi_wstrb   <= 4'b0;
            axi_wlast   <= 1'b0;

            axi_addr_suffix<= 2'b0;
            locked_sram_read_write<=0;
            state       <= S_IDLE;
            locked_read_data   <= 0;
        end else begin
            case(state)
                // ================== S_IDLE ==================
                S_IDLE: begin
                    locked_sram_read_write <= 2'b00;
                    if (mem_out_valid && mem_out_ready) begin
                        if (sram_read_write == 2'b00) begin
                            // 无访存，直接进入发送
                            locked_addr  <= 32'h0;
                            locked_data  <= 32'h0;
                            state        <= S_SEND;
                        end else begin
                            // 锁存本次操作类型/地址/写数据
                            locked_sram_read_write <= sram_read_write;
                            locked_addr  <= alu_result_M;
                            locked_data  <= wdata_gpr_M;

                            // 直接在此拍发起 AXI 访问，下一拍转 S_ACCESS
                            if (sram_read_write == 2'b01) begin
                                // READ
                                axi_araddr   <= alu_result_M;
                                axi_arsize   <= (Mem_Mask_M==3'b000 || Mem_Mask_M==3'b001) ? 3'b000 :
                                                (Mem_Mask_M==3'b010 || Mem_Mask_M==3'b011) ? 3'b001 :
                                                                                              3'b010;
                                axi_addr_suffix <= alu_result_M[1:0];
                                axi_arvalid  <= 1'b1;
                                axi_rready   <= 1'b0;      // 等地址握手完成再置 1
                            end else begin
                                // WRITE（地址+数据同拍发）
                                axi_awaddr   <= alu_result_M;
                                axi_awsize   <= (Mem_Mask_M==3'b000) ? 3'b000 :
                                                (Mem_Mask_M==3'b001) ? 3'b001 :
                                                                       3'b010;
                                axi_awvalid  <= 1'b1;

                                axi_wdata    <= wdata_gpr_M;
                                axi_wvalid   <= 1'b1;
                                axi_wlast    <= 1'b1;
                                // 写掩码（保持原实现）
                                axi_wstrb    <=  (Mem_Mask_M == 3'b000) ? // SB
                                                    ((alu_result_M[1:0]==2'b00) ? 4'b0001 :
                                                     (alu_result_M[1:0]==2'b01) ? 4'b0010 :
                                                     (alu_result_M[1:0]==2'b10) ? 4'b0100 :
                                                                                   4'b1000) :
                                                 (Mem_Mask_M == 3'b001) ?       // SH
                                                    ((alu_result_M[1:0]==2'b00) ? 4'b0011 :
                                                     (alu_result_M[1:0]==2'b01) ? 4'b0110 :
                                                     (alu_result_M[1:0]==2'b10) ? 4'b1100 :
                                                                                   4'b0000) :
                                                 (Mem_Mask_M == 3'b011) ?       // SW
                                                    ((alu_result_M[1:0]==2'b00) ? 4'b1111 : 4'b0000) :
                                                                            4'b0000;
                                axi_bready   <= 1'b0;      // AW/W 完成后再置 1
                            end
                            state <= S_ACCESS;
                        end
                    end
                end

                // ================== S_ACCESS（读写统一） ==================
                S_ACCESS: begin
                    if (locked_sram_read_write == 2'b01) begin
                        // ---- READ PATH ----
                        if (axi_arvalid && axi_arready) begin
                            axi_arvalid <= 1'b0;
                            axi_rready  <= 1'b1;          // 开始接收读数据
                        end
                        if (axi_rvalid && axi_rready) begin
                            locked_read_data <= axi_rdata; // 读数据锁存（扩展在组合逻辑中）
                            axi_rready  <= 1'b0;
                            locked_sram_read_write <= 2'b00; // 本次读完成
                            state       <= S_SEND;
                        end
                    end else if (locked_sram_read_write == 2'b10) begin
                        // ---- WRITE PATH ----
                        if (axi_awready) begin
                            axi_awvalid <= 1'b0;
                        end
                        if (axi_wready) begin
                            axi_wvalid  <= 1'b0;
                            axi_wlast   <= 1'b0;
                            axi_wstrb   <= 4'b0;
                            axi_wdata   <= 32'b0;
                        end
                        if (!axi_bready && axi_awvalid==1'b0 && axi_wvalid==1'b0) begin
                            // 地址/数据都被接收后，开始等待响应
                            axi_bready <= 1'b1;
                        end
                        if (axi_bvalid && axi_bready) begin
                            axi_bready  <= 1'b0;
                            locked_sram_read_write <= 2'b00; // 本次写完成
                            state       <= S_SEND;
                        end
                    end else begin
                        // 理论不应到此分支（防御性处理）
                        state <= S_SEND;
                    end
                end

                // ================== S_SEND ==================
                S_SEND: begin
                    if (mem_in_ready) begin
                        state <= S_IDLE;

                        // 恢复 AXI 缺省
                        axi_arsize <= 3'b010;
                        axi_awsize <= 3'b010;
                    end
                end

                default: state <= S_IDLE;
            endcase
        end
    end

`ifdef VERILATOR_SIM
    reg [31:0]  pc_r;
    reg [31:0]  npc_r;
`endif

    // 所存数据
    always @(posedge clk) begin
        if(reset)begin
            // 本级寄存器复位
            is_break_r      <= 1'b0; // 复位时不可能是ebreak指令

`ifdef VERILATOR_SIM
            pc_r            <= 32'b0;
`endif

            irq_r           <= 1'b0;
            irq_no_r        <= 4'b0;
            Gpr_Write_r     <= 1'b0;
            Csr_Write_r     <= 1'b0;
            Gpr_Write_Addr_r<= 4'b0;
            Csr_Write_Addr_r<= 12'b0;
            Gpr_Write_RD_r  <= 2'b0;
        end else begin
            if(state[0] == 1'b0)begin
                // 锁存所有将要向下游传递的字段
                is_break_r      <= is_break_i;

                irq_r           <= irq_M;
                irq_no_r        <= irq_no_M;
                Gpr_Write_r     <= Gpr_Write_M;
                Csr_Write_r     <= Csr_Write_M;
                Gpr_Write_Addr_r<= Gpr_Write_Addr_M;
                Csr_Write_Addr_r<= Csr_Write_Addr_M;
                Gpr_Write_RD_r  <= Gpr_Write_RD_M;

                wdata_gpr_r     <= wdata_gpr_M;
                wdata_csr_r     <= wdata_csr_M;

                Mem_Mask_r      <= Mem_Mask_M;

`ifdef VERILATOR_SIM
                pc_r            <= pc_M;
                npc_r           <= npc_E;
`endif
            end
        end
    end
    

    // ================== 对外输出（保持原样） ==================
    assign is_load = (locked_sram_read_write == 2'b01); // 仅在读操作时为1

    assign is_break_o       = is_break_r;

    // 因为需要判断是否前递或者阻塞，所以寄存器是否读写以及地址都需要锁存并且在state==S_IDLE时更新
    assign Gpr_Write_W      = (state[0] == 1'b0) ? Gpr_Write_M : Gpr_Write_r;
    assign Csr_Write_W      = (state[0] == 1'b0) ? Csr_Write_M : Csr_Write_r;
    wire [1:0] Gpr_Write_RD_W   = (state[0] == 1'b0) ? Gpr_Write_RD_M : Gpr_Write_RD_r;
    assign Gpr_Write_Addr_W = (state[0] == 1'b0) ? Gpr_Write_Addr_M : Gpr_Write_Addr_r;
    assign Csr_Write_Addr_W = (state[0] == 1'b0) ? Csr_Write_Addr_M : Csr_Write_Addr_r;

`ifdef VERILATOR_SIM
    assign pc_W             = (state[0] == 1'b0) ? pc_M : pc_r;
    assign npc_M            = (state[0] == 1'b0) ? npc_E : npc_r; 
`endif


    wire [31:0] Mem_rdata_extend;
    wire [31:0] mem_rdata;
    assign mem_rdata = (axi_rvalid) ? axi_rdata : locked_read_data;

    wire [31:0] r_byte = (mem_rdata >> ({axi_addr_suffix,3'b0}));

    wire [15:0] r_half =
        (axi_addr_suffix == 2'b00) ? mem_rdata[15:0]  :
        (axi_addr_suffix == 2'b01) ? mem_rdata[23:8]  :
        (axi_addr_suffix == 2'b10) ? mem_rdata[31:16] :
                                    16'h0000; // 非法半字对齐(…11)时给0或按你异常策略处理

    wire [31:0] Mem_rdata_extend =
        (Mem_Mask_r == 3'b000) ? {{24{r_byte[7]}},  r_byte[7:0]}  : // LB
        (Mem_Mask_r == 3'b001) ? {24'b0,            r_byte[7:0]}  : // LBU
        (Mem_Mask_r == 3'b010) ? {{16{r_half[15]}}, r_half}  : // LH
        (Mem_Mask_r == 3'b011) ? {16'b0,            r_half}  : // LHU
                                mem_rdata;                  // LW (3'b100)

    // 异常处理相关（保持原样，未使用 axi_bresp）
    assign irq_W            = irq_r;
    assign irq_no_W         = irq_no_r;

    // 面积优化
    assign wdata_gpr_W      = (Gpr_Write_RD_W[0] & Gpr_Write_RD_W[1]) ? Mem_rdata_extend
                                                        : ((state[0] == 1'b0) ? wdata_gpr_M : wdata_gpr_r);
    assign wdata_csr_W      = (state[0] == 1'b0) ? wdata_csr_M : wdata_csr_r;

    // 前递单元设计（保持原样）
    reg [1:0] cnt;
    always @(posedge clk) begin
        if(reset) begin
            cnt <= 2'b0;
        end else begin
            if(mem_out_ready == 1'b1 && sram_read_write == 2'b01)begin
                cnt <= cnt + 1'b1;
            end
            if(axi_rvalid == 1'b1) begin
                cnt <= cnt - 1'b1;
            end
        end
    end

    assign exe_mem_is_load  = (sram_read_write == 2'b01 && cnt != 0) ? 1'b1 : 1'b0;
    assign mem_fw_data      = wdata_gpr_W;

`ifdef VERILATOR_SIM
always @(*) begin
    if(is_break_o == 1 && mem_in_valid == 1'b1)
        npc_trap();
end
`endif

endmodule

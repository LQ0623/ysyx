module ysyx_24100006_hazard(
    // data hazard

    // 来自 ID 阶段
    input  [3:0]   id_rs1,          // instruction[18:15]
    input  [3:0]   id_rs2,          // instruction[23:20]
    input          id_rs1_ren,
    input          id_rs2_ren,
    input  [3:0]    id_rd,
    input           id_wen,

    // EX 阶段目的寄存器与状态
    input          ex_out_valid,
    input          ex_out_ready,
    input  [3:0]   ex_rd,
    input          ex_wen,          // Gpr_Write_E

    // MEM 阶段
    input          mem_out_valid,    // 注意：mem 模块的 "out" 对应 u_EXE_MEM 的 out -> mem_out_valid
    input          mem_out_ready,
    input  [3:0]   mem_rd,
    input          mem_wen,         // Gpr_Write_M

    // WB 阶段
    input          wb_out_valid,
    input          wb_out_ready,
    input  [3:0]   wb_rd,
    input          wb_wen,          // Gpr_Write_W

    output         stall_id

    // control hazard
    // input           ex_is_branch,  // 是否是分支指令
    // input           ex_is_jal,
    // input           ex_is_jalr,
    // input           ex_branch_taken,
    // input  [31:0]   ex_target,
    // input  [31:0]   ex_pc_plus4,

    // // outputs to IF/ID and IFU
    // output          flush_if,
    // output          flush_id,
    // output          new_pc_valid,
    // output [31:0]   new_pc
);
    // 修改 raw 判定，加入一个额外条件：
    // 只有当 ID 的来源寄存器不是“被 ID 同一条指令要写回并覆盖的目标”，才按正常规则判冲突
    wire id_rs1_logical = ~(id_wen && (id_rd == id_rs1)); // 如果ID会写且与rs1同号，则认为不是外部真实依赖（根据你的语义可调整）
    wire id_rs2_logical = ~(id_wen && (id_rd == id_rs2));

    wire busy_ex  = ex_out_valid  | ~ex_out_ready;
    wire busy_mem = mem_out_valid | ~mem_out_ready;
    wire busy_wb  = wb_out_valid  | ~wb_out_ready;

    // rd != x0
    wire ex_wen_v  = ex_wen  & (ex_rd  != 4'd0);
    wire mem_wen_v = mem_wen & (mem_rd != 4'd0);
    wire wb_wen_v  = wb_wen  & (wb_rd  != 4'd0);

    // 与任一阶段 RAW 冲突
    wire raw_ex_rs1  = id_rs1_ren & ex_wen_v  & busy_ex  & (id_rs1 == ex_rd)    & id_rs1_logical;
    wire raw_ex_rs2  = id_rs2_ren & ex_wen_v  & busy_ex  & (id_rs2 == ex_rd)    & id_rs2_logical;
    wire raw_mem_rs1 = id_rs1_ren & mem_wen_v & busy_mem & (id_rs1 == mem_rd)   & id_rs1_logical;
    wire raw_mem_rs2 = id_rs2_ren & mem_wen_v & busy_mem & (id_rs2 == mem_rd)   & id_rs2_logical;
    wire raw_wb_rs1  = id_rs1_ren & wb_wen_v  & busy_wb  & (id_rs1 == wb_rd)    & id_rs1_logical;
    wire raw_wb_rs2  = id_rs2_ren & wb_wen_v  & busy_wb  & (id_rs2 == wb_rd)    & id_rs2_logical;

    assign stall_id = raw_ex_rs1 | raw_ex_rs2 |
                      raw_mem_rs1| raw_mem_rs2|
                      raw_wb_rs1 | raw_wb_rs2 ;
endmodule

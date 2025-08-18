module ysyx_24100006_hazard(
    // 来自 ID 阶段
    input  [3:0]   id_rs1,          // instruction[18:15]
    input  [3:0]   id_rs2,          // instruction[23:20]
    input          id_rs1_ren,
    input          id_rs2_ren,

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
);
    wire busy_ex  = ex_out_valid  | ~ex_out_ready;
    wire busy_mem = mem_out_valid | ~mem_out_ready;
    wire busy_wb  = wb_out_valid  | ~wb_out_ready;

    // rd != x0
    wire ex_wen_v  = ex_wen  & (ex_rd  != 4'd0);
    wire mem_wen_v = mem_wen & (mem_rd != 4'd0);
    wire wb_wen_v  = wb_wen  & (wb_rd  != 4'd0);

    // 与任一阶段 RAW 冲突
    wire raw_ex_rs1  = id_rs1_ren & ex_wen_v  & busy_ex  & (id_rs1 == ex_rd);
    wire raw_ex_rs2  = id_rs2_ren & ex_wen_v  & busy_ex  & (id_rs2 == ex_rd);
    wire raw_mem_rs1 = id_rs1_ren & mem_wen_v & busy_mem & (id_rs1 == mem_rd);
    wire raw_mem_rs2 = id_rs2_ren & mem_wen_v & busy_mem & (id_rs2 == mem_rd);
    wire raw_wb_rs1  = id_rs1_ren & wb_wen_v  & busy_wb  & (id_rs1 == wb_rd);
    wire raw_wb_rs2  = id_rs2_ren & wb_wen_v  & busy_wb  & (id_rs2 == wb_rd);

    assign stall_id = raw_ex_rs1 | raw_ex_rs2 |
                      raw_mem_rs1| raw_mem_rs2|
                      raw_wb_rs1 | raw_wb_rs2 ;
endmodule

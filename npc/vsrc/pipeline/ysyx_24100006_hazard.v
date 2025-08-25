module ysyx_24100006_hazard(
    // data hazard

    // 来自 ID 阶段
    input  [3:0]   id_rs1,          // instruction[18:15]
    input  [3:0]   id_rs2,          // instruction[23:20]
    input          id_rs1_ren,
    input          id_rs2_ren,
    input  [3:0]    id_rd,
    input           id_wen,
input id_out_valid,         //什么时候需要阻塞
input is_load,
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
    input [3:0]    mem_stage_rd,    // 这才是真正的MEM阶段的rd，mem_rd其实是EXE阶段出来的，但是如果是load-use，那么mem_rd和mem_stage_rd不一样
    input          mem_in_valid,
    input          mem_stage_out_valid,     // 表示mem处理完总线请求时，存储的要写回的寄存器是否有效
    // WB 阶段
    input          wb_out_valid,
    input          wb_out_ready,
    input  [3:0]   wb_rd,
    input          wb_wen,          // Gpr_Write_W

    output         stall_id
);
    // 修改 raw 判定，加入一个额外条件：
    // 只有当 ID 的来源寄存器不是“被 ID 同一条指令要写回并覆盖的目标”，才按正常规则判冲突

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

    // 如果是 load 指令，且 ID 阶段的 rs1 或 rs2 与 EX 阶段的 rd 相同，则认为是 RAW 冲突
    wire raw_ex_load_rs = (is_load == 1) && 
                            ((id_rs1_ren == 1  && (mem_wen_v == 1 && ((id_rs1 == mem_stage_rd)))) ||
                            (id_rs2_ren == 1  && (mem_wen_v == 1 && ((id_rs2 == mem_stage_rd)))) ||
                            (id_rs1_ren == 1  && (wb_wen_v == 1 && ((id_rs1 == wb_rd)))) ||
                            (id_rs2_ren == 1  && (wb_wen_v == 1 && ((id_rs2 == wb_rd)))));

    wire raw_load_ex_rs = (mem_in_valid == 1'b1) &&((id_rs1_ren == 1  && (mem_stage_out_valid == 1 && ((id_rs1 == mem_stage_rd)))) ||
                            (id_rs2_ren == 1  && (mem_stage_out_valid == 1 && ((id_rs2 == mem_stage_rd)))));

    //  前面的加上out_valid是因为需要确保ID级的输出是有效的，这样才能和EX/MEM/WB阶段的指令进行对比
    assign stall_id = ((raw_ex_rs1 | raw_ex_rs2 |
                        raw_mem_rs1| raw_mem_rs2|
                        raw_wb_rs1 | raw_wb_rs2) & id_out_valid) || raw_ex_load_rs || raw_load_ex_rs;

endmodule

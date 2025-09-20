module ysyx_24100006_hazard(
    // data hazard
input         clk,
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

    input          mem_stage_wen,   // 这里是因为load-use的情况，所以需要知道mem阶段正在处理的指令的rd是否写回，而不能学之前使用mem_wen，mem_wen是下一条指令的，而不是表示正在处理的指令是否需要写入寄存器
    input [3:0]    mem_stage_rd,    // 这才是真正的MEM阶段的rd，mem_rd其实是EXE阶段出来的，但是如果是load-use，那么mem_rd和mem_stage_rd不一样
    input          mem_in_valid,
    input          mem_stage_out_valid,     // 表示mem处理完总线请求时，存储的要写回的寄存器是否有效
    // WB 阶段
    input          wb_out_valid,
    input          wb_out_ready,
    input  [3:0]   wb_rd,
    input          wb_wen,          // Gpr_Write_W

    output         stall_id

    // 前递单元设计
    ,input          exe_mem_is_load
    ,input          exe_is_load // EXE阶段的指令是否是load指令
    ,input          mem_rvalid  // MEM阶段访存是否取出结果
    ,output [1:0]   forwardA    // 00: 不前递，01: 从EX前递，10: 从MEM前递, 11: 从WB前递
    ,output [1:0]   forwardB
);

    // rd != x0
    wire ex_wen_v  = ex_wen  & (ex_rd  != 4'd0);
    wire mem_wen_v = mem_wen & (mem_rd != 4'd0);
    wire wb_wen_v  = wb_wen  & (wb_rd  != 4'd0);

    // 与任一阶段 RAW 冲突
    wire raw_ex_rs1  = id_rs1_ren & ex_wen_v  & (id_rs1 == ex_rd);
    wire raw_ex_rs2  = id_rs2_ren & ex_wen_v  & (id_rs2 == ex_rd);
    wire raw_mem_rs1 = id_rs1_ren & mem_wen_v & (id_rs1 == mem_rd);
    wire raw_mem_rs2 = id_rs2_ren & mem_wen_v & (id_rs2 == mem_rd);
    wire raw_wb_rs1  = id_rs1_ren & wb_wen_v  & (id_rs1 == wb_rd);
    wire raw_wb_rs2  = id_rs2_ren & wb_wen_v  & (id_rs2 == wb_rd);

    // 前递单元设计(有冲突，且能够通过前递解决，在输出有效的时候就前递)
    // 优先级：EX > MEM > WB
    wire can_rs1_fw_exe, can_rs2_fw_exe, can_rs1_fw_mem, can_rs2_fw_mem, can_rs1_fw_wb, can_rs2_fw_wb;
    assign can_rs1_fw_exe = raw_ex_rs1 && (exe_is_load == 1'b0) && (id_out_valid == 1'b1); // 如果EXE阶段是load指令，则不能前递
    assign can_rs2_fw_exe = raw_ex_rs2 && (exe_is_load == 1'b0) && (id_out_valid == 1'b1);
    assign can_rs1_fw_mem = raw_mem_rs1&& (is_load == 1'b0 || mem_rvalid == 1) && (id_out_valid == 1'b1); // 如果MEM阶段是load指令，则不能前递
    assign can_rs2_fw_mem = raw_mem_rs2&& (is_load == 1'b0 || mem_rvalid == 1) && (id_out_valid == 1'b1);
    assign can_rs1_fw_wb  = raw_wb_rs1 && (id_out_valid == 1'b1);
    assign can_rs2_fw_wb  = raw_wb_rs2 && (id_out_valid == 1'b1);
    
    assign forwardA = can_rs1_fw_exe ? 2'b01 :
                      can_rs1_fw_mem ? 2'b10 :
                      can_rs1_fw_wb  ? 2'b11 : 2'b00;

    assign forwardB = can_rs2_fw_exe ? 2'b01 :
                      can_rs2_fw_mem ? 2'b10 : 
                      can_rs2_fw_wb  ? 2'b11 : 2'b00;

    // 当mem_out_ready == 1的时候检测是否有冲突，只需要一拍(当mem_out_ready刚为1的时候，所有的检测都没有效果了，因为EXE阶段的指令已经进入了MEM阶段，但是MEM阶段接收数据需要一个周期，这期间可能会有冲突)
    // 这里的mem_out_ready是指mem模块的out_ready信号，表示mem模块的输出可以被下一个模块接收
    reg [1:0] mem_out_ready_d;
    always @(posedge clk) begin
        mem_out_ready_d <= {mem_out_ready_d[0], mem_out_ready};
    end
    wire raw_mem_ready_rs = (mem_out_ready == 1) && (mem_out_ready_d != 2'b11) && (exe_is_load == 1) && (raw_ex_rs1 || raw_ex_rs2);

    // exe/mem -> mem
    wire raw_ex_load_rs =   (exe_mem_is_load == 1) && 
                            ((id_rs1_ren == 1  && (mem_stage_wen == 1 && ((id_rs1 == mem_stage_rd)))) ||
                            (id_rs2_ren == 1  && (mem_stage_wen == 1 && ((id_rs2 == mem_stage_rd)))));
            
    // 只需要判断在exe级发生冲突且是load指令以及mem级发生冲突且是load指令但还没有取出数据的情况就行，只有这两种情况才需要stall
    assign stall_id =   (raw_ex_rs1 && exe_is_load) && (mem_out_ready == 0 || ex_out_valid) ||    // EXE本身只用在结果有效的时候不冲突就行，后面的exe->exe/mem和exe/mem->mem的冲突由raw_ex_load_rs和raw_mem_ready_rs进行判断
                        (raw_ex_rs2 && exe_is_load) && (mem_out_ready == 0 || ex_out_valid) || 
                        (raw_mem_rs1 && is_load && mem_rvalid == 1'b0) || 
                        (raw_mem_rs2 && is_load && mem_rvalid == 1'b0) || raw_ex_load_rs || raw_mem_ready_rs;

endmodule

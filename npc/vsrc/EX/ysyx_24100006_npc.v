
`include "/home/lq/ysyx-workbench/npc/vsrc/define/ysyx_24100006_ctrl_define.vh"

module ysyx_24100006_npc(
    input[31:0]     pc,
    input[1:0]      Skip_mode,
    input[31:0]     sext_imm,
    input[31:0]     rs_data,
    input           zf,         // 判断rs_data是否等于rt_data，相等就会为1
    output[31:0]    npc
);

    assign npc  =   (Jump == `ysyx_24100006_NJUMP)? (pc + 4):
                    (Jump == `ysyx_24100006_JAL)?   (pc + sext_imm):
                    (Jump == `ysyx_24100006_JALR)?  ((rs_data+ imm_sext) & (~32'b1)):
                    (Jump == `ysyx_24100006_JBEQ && zf == 1'b1)?  (pc + sext_imm) : 0;  // 这个需要单独的一个信号来控制

endmodule



// `include "ysyx_24100006_ctrl_define.v"

// 控制信号宏定义
// REG_WRITE
`define ysyx_24100006_REGW                  1
`define ysyx_24100006_REGNW                 0
// MEM_WRITE
`define ysyx_24100006_MEMW                  1
`define ysyx_24100006_MEMNW                 0
// pc跳转是否加imm
`define ysyx_24100006_NJUMP                 0
`define ysyx_24100006_JAL                   1
`define ysyx_24100006_JALR                  2
`define ysyx_24100006_JBEQ                  3
// 指令的imm的类型
`define ysyx_24100006_I_TYPE_IMM            0
`define ysyx_24100006_J_TYPE_IMM            1
`define ysyx_24100006_S_TYPE_IMM            2
`define ysyx_24100006_B_TYPE_IMM            3
`define ysyx_24100006_U_TYPE_IMM            4
// 操作
`define ysyx_24100006_add_op                0
`define ysyx_24100006_sub_op                1

//ALU的源操作数
//AluSrcA
`define ysyx_24100006_A_PC                  1
`define ysyx_24100006_A_RS                  0
//AluSrcB
`define ysyx_24100006_B_IMM                 1
`define ysyx_24100006_B_RT                  0
//写寄存器的内容
`define ysyx_24100006_REG_IMM               0   // 写回寄存器的是符号扩展之后的立即数
`define ysyx_24100006_REG_RESULT            1   // 写回寄存器的是alu计算的结果
`define ysyx_24100006_REG_PC_PLUS_4         2   // 写回寄存器的是pc+4的结果


module ysyx_24100006_npc(
    input[31:0]     pc,
    input[3:0]      Skip_mode,
    input[31:0]     sext_imm,
    input[31:0]     rs_data,
    input           zf,         // 判断rs_data是否等于rt_data，相等就会为1
    output[31:0]    npc
);

    assign npc  =   (Skip_mode == `ysyx_24100006_NJUMP)? (pc + 4):
                    (Skip_mode == `ysyx_24100006_JAL)?   (pc + sext_imm):
                    (Skip_mode == `ysyx_24100006_JALR)?  ((rs_data+ sext_imm) & (~32'b1)):
                    (Skip_mode == `ysyx_24100006_JBEQ && zf == 1'b1)?  (pc + sext_imm) : (pc + 4);  // 这个需要单独的一个信号来控制

endmodule


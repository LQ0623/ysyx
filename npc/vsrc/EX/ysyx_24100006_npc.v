
// `include "ysyx_24100006_ctrl_define.v"

// 控制信号宏定义
/*----------exception---------------*/
// 是否发生异常
`define ysyx_24100006_NIRQ                  0
`define ysyx_24100006_IRQ                   1
`define ysyx_24100006_MECALL                8'b00001011
/*----------exception---------------*/
// GPR_WRITE
`define ysyx_24100006_GPRW                  1
`define ysyx_24100006_GPRNW                 0
// CSR_WRITE
`define ysyx_24100006_CSRW                  1
`define ysyx_24100006_CSRNW                 0
// MEM_WRITE
`define ysyx_24100006_MEMW                  1
`define ysyx_24100006_MEMNW                 0
// 写多少字节的内存
`define ysyx_24100006_WByte                 8'b00000001
`define ysyx_24100006_WHWord                8'b00000011   // 半字
`define ysyx_24100006_WWord                 8'b00001111

// MEM_READ
`define ysyx_24100006_MEMR                  1
`define ysyx_24100006_MEMNR                 0
// 读多少字节的内存，以及读取出来之后怎么进行扩展
`define ysyx_24100006_RByte                 0
`define ysyx_24100006_RByteU                1
`define ysyx_24100006_RHWord                2   // 半字
`define ysyx_24100006_RHWordU               3   // 半字
`define ysyx_24100006_RWord                 4

// pc跳转是否加imm
`define ysyx_24100006_NJUMP                 0
`define ysyx_24100006_JAL                   1
`define ysyx_24100006_JALR                  2
`define ysyx_24100006_JBEQ                  3
`define ysyx_24100006_JBNE                  4
`define ysyx_24100006_JBLT                  5
`define ysyx_24100006_JBGE                  6
`define ysyx_24100006_JBLTU                 7
`define ysyx_24100006_JBGEU                 8
`define ysyx_24100006_JUMPMRET              9
`define ysyx_24100006_JUMPECALL             10
// 指令的imm的类型
`define ysyx_24100006_I_TYPE_IMM            0
`define ysyx_24100006_J_TYPE_IMM            1
`define ysyx_24100006_S_TYPE_IMM            2
`define ysyx_24100006_B_TYPE_IMM            3
`define ysyx_24100006_U_TYPE_IMM            4
// 操作
/**
    这里cmp和cmpu还有sub只能是奇数，因为需要补码运算
*/
`define ysyx_24100006_add_op                0
`define ysyx_24100006_sub_op                1
`define ysyx_24100006_cmpu_op               9  // 无符号比较
`define ysyx_24100006_cmp_op                3  // 有符号比较
`define ysyx_24100006_srl_op                4  // 无符号右移
`define ysyx_24100006_sra_op                5  // 有符号右移
`define ysyx_24100006_sll_op                6  // 左移
`define ysyx_24100006_and_op                7  // 与操作
`define ysyx_24100006_xor_op                8  // 异或操作
`define ysyx_24100006_or_op                 2  // 或操作

//ALU的源操作数
//AluSrcA
`define ysyx_24100006_A_PC                  1
`define ysyx_24100006_A_RS                  0
//AluSrcB
`define ysyx_24100006_B_IMM                 1
`define ysyx_24100006_B_RT                  0
//写通用寄存器的内容
`define ysyx_24100006_GPR_IMM               0   // 写回寄存器的是符号扩展之后的立即数
`define ysyx_24100006_GPR_RESULT            1   // 写回寄存器的是alu计算的结果
`define ysyx_24100006_GPR_PC_PLUS_4         2   // 写回寄存器的是pc+4的结果
`define ysyx_24100006_MEMR_RESULT           3   // 写回寄存器的是读内存的结果
`define ysyx_24100006_CSR                   4   // 写CSR系统寄存器的值到通用寄存器中
//写系统寄存器的内容
`define ysyx_24100006_EPC                   0   // 写mepc到寄存器
`define ysyx_24100006_CW                    1   // csrrw指令使用
`define ysyx_24100006_CS                    2   // csrrs指令使用，将通用寄存器取出来的值与CSR寄存器的值进行或操作



/**
    计算下一条指令
*/
module ysyx_24100006_npc(
    input clk,
    input[31:0]     pc,
    input[31:0]     mtvec,
    input[31:0]     mepc,
    input[3:0]      Skip_mode,
    input[31:0]     sext_imm,
    input[31:0]     rs_data,
    input           cmp_result,
    input           zf,         // 判断rs_data是否等于rt_data，相等就会为1
    output reg [31:0]    npc
);

    wire [31:0] npc_temp;
    assign npc_temp  =   (Skip_mode == `ysyx_24100006_NJUMP)?                        (pc + 4):
                    (Skip_mode == `ysyx_24100006_JAL)?                          (pc + sext_imm):
                    (Skip_mode == `ysyx_24100006_JALR)?                         ((rs_data+ sext_imm) & (~32'b1)):
                    (Skip_mode == `ysyx_24100006_JBEQ && zf == 1'b1)?           (pc + sext_imm) :  // 这个需要单独的一个信号来控制
                    (Skip_mode == `ysyx_24100006_JBNE && zf == 1'b0)?           (pc + sext_imm) :
                    (Skip_mode == `ysyx_24100006_JBLT && cmp_result == 1'b1)?   (pc + sext_imm) :
                    (Skip_mode == `ysyx_24100006_JBLTU && cmp_result == 1'b1)?  (pc + sext_imm) :
                    (Skip_mode == `ysyx_24100006_JBGE && cmp_result == 1'b0)?   (pc + sext_imm) :
                    (Skip_mode == `ysyx_24100006_JBGEU && cmp_result == 1'b0)?  (pc + sext_imm) :
                    (Skip_mode == `ysyx_24100006_JUMPMRET)?                     (mepc)          : 
                    (Skip_mode == `ysyx_24100006_JUMPECALL)?                    (mtvec)         : (pc + 4);
    always @(posedge clk)begin
        npc <= npc_temp;
    end

endmodule


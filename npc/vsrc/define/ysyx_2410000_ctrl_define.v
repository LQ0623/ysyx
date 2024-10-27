// 控制信号宏定义
// REG_WRITE
`define ysyx_24100006_REGW                  1
`define ysyx_24100006_REGNW                 0
// MEM_WRITE
`define ysyx_24100006_MEMW                  1
`define ysyx_24100006_MEMNW                 0
// 写多少字节的内存
`define ysyx_24100006_WByte                 8'b00000001
`define ysyx_24100006_WHWord                8'b00000011   // 半字
`define ysyx_24100006_WWord                 8'b00000111

// 写入的值是否需要符号扩展
`define ysyx_24100006_write_one_sext        2   // 进行符号扩展
`define ysyx_24100006_write_zero_sext       1   // 进行零扩展
`define ysyx_24100006_write_no_sext         0   // 不进行符号扩展

// MEM_READ
`define ysyx_24100006_MEMR                  1
`define ysyx_24100006_MEMNR                 0
// 读多少字节的内存
`define ysyx_24100006_RByte                 0
`define ysyx_24100006_RHWord                1   // 半字
`define ysyx_24100006_RWord                 2

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
// 指令的imm的类型
`define ysyx_24100006_I_TYPE_IMM            0
`define ysyx_24100006_J_TYPE_IMM            1
`define ysyx_24100006_S_TYPE_IMM            2
`define ysyx_24100006_B_TYPE_IMM            3
`define ysyx_24100006_U_TYPE_IMM            4
// 操作
`define ysyx_24100006_add_op                0
`define ysyx_24100006_sub_op                1
`define ysyx_24100006_cmpu_op               2  // 无符号比较
`define ysyx_24100006_cmp_op                3  // 有符号比较
`define ysyx_24100006_srl_op                4  // 无符号右移
`define ysyx_24100006_sra_op                5  // 有符号右移
`define ysyx_24100006_sll_op                6  // 左移
`define ysyx_24100006_and_op                7  // 与操作
`define ysyx_24100006_xor_op            8  // 抑或操作
`define ysyx_24100006_or_op                 9  // 或操作

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
`define ysyx_24100006_MEMR_RESULT           3   // 写回寄存器的是读内存的结果

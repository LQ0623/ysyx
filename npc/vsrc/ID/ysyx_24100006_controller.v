/**
    输出一些控制信号
*/

// `include "ysyx_24100006_ctrl_define.v"
// `include "ysyx_24100006_inst_define.v"

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

// RISCV32E 指令宏定义
//opcode
`define ysyx_24100006_SYSTEM              7'b1110011
`define ysyx_24100006_I_type              7'b0010011
`define ysyx_24100006_R_type              7'b0110011
`define ysyx_24100006_S_type              7'b0100011
`define ysyx_24100006_B_type              7'b1100011
`define ysyx_24100006_auipc               7'b0010111
`define ysyx_24100006_lui                 7'b0110111
`define ysyx_24100006_jal                 7'b1101111
`define ysyx_24100006_jalr                7'b1100111
`define ysyx_24100006_load                7'b0000011
//function
  //ysyx_24100006_SYSTEM
`define ysyx_24100006_ebreak              12'b000000000001
`define ysyx_24100006_ecall               12'b000000000000
`define ysyx_24100006_mret                12'b001100000010
`define ysyx_24100006_inv                 3'b000
`define ysyx_24100006_csrrw               3'b001
`define ysyx_24100006_csrrs               3'b010

  //ysyx_24100006_I_type
`define ysyx_24100006_addi                3'b000
`define ysyx_24100006_slli                3'b001
`define ysyx_24100006_slti                3'b010
`define ysyx_24100006_sltiu               3'b011
`define ysyx_24100006_xori                3'b100
`define ysyx_24100006_sri                 3'b101
`define ysyx_24100006_srli                7'b0000000
`define ysyx_24100006_srai                7'b0100000
`define ysyx_24100006_ori                 3'b110
`define ysyx_24100006_andi                3'b111

  //ysyx_24100006_R_type
`define ysyx_24100006_add_sub             3'b000
`define ysyx_24100006_add                 7'b0000000
`define ysyx_24100006_sub                 7'b0100000
`define ysyx_24100006_sll                 3'b001
`define ysyx_24100006_slt                 3'b010
`define ysyx_24100006_sltu                3'b011
`define ysyx_24100006_xor                 3'b100
`define ysyx_24100006_sr                  3'b101
`define ysyx_24100006_srl                 7'b0000000
`define ysyx_24100006_sra                 7'b0100000
`define ysyx_24100006_or                  3'b110
`define ysyx_24100006_and                 3'b111

  //ysyx_24100006_S_type
`define ysyx_24100006_sb                  3'b000
`define ysyx_24100006_sh                  3'b001
`define ysyx_24100006_sw                  3'b010

  //ysyx_24100006_B_type
`define ysyx_24100006_beq                 3'b000
`define ysyx_24100006_bne                 3'b001
`define ysyx_24100006_blt                 3'b100
`define ysyx_24100006_bge                 3'b101
`define ysyx_24100006_bltu                3'b110
`define ysyx_24100006_bgeu                3'b111

  // ysyx_24100006_load
`define ysyx_24100006_lb                  3'b000
`define ysyx_24100006_lh                  3'b001
`define ysyx_24100006_lw                  3'b010
`define ysyx_24100006_lbu                 3'b100
`define ysyx_24100006_lhu                 3'b101


import "DPI-C" function void npc_trap ();

module ysyx_24100006_controller(
    input [6:0]opcode,
    input [2:0]funct3,
    input [6:0]funct7,
    input [11:0]funct12,

    /* 是否发生中断 */
    output reg irq,
    output reg [7:0] irq_no,
    /* 操作类型 */
    output reg [3:0]aluop,
    /* 写通用寄存器 */
    output reg Gpr_Write,
    /* 写回通用寄存器的内容 */
    output reg [2:0] Gpr_Write_RD,
    /* 写系统寄存器 */
    output reg Csr_Write,
    /* 写系统寄存器的内容 */
    output reg [1:0] Csr_Write_RD,

    /* pc的跳转类型 */
    output reg [3:0] Jump,
    /* 立即数的种类 */
    output reg [2:0] Imm_Type,
    /* 源操作数的种类 */
    output reg AluSrcA,
    output reg AluSrcB,
    /* 是否读内存 */
    output reg Mem_Read,
    /* 读内存是读多少字节，以及如何扩展 */
    output reg [2:0] Mem_RMask,
    /* 是否写内存 */
    output reg Mem_Write,
    /* 写内存是多少字节 */
    output reg [7:0] Mem_WMask
);

    always @(*) begin
        case(opcode)
            `ysyx_24100006_SYSTEM: begin
                case (funct3)
                    `ysyx_24100006_csrrs:begin
                        irq             = `ysyx_24100006_NIRQ;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_CSR;
                        Csr_Write       = `ysyx_24100006_CSRW;
                        Csr_Write_RD    = `ysyx_24100006_CS;
                        Jump            = `ysyx_24100006_NJUMP;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                    `ysyx_24100006_csrrw:begin
                        irq             = `ysyx_24100006_NIRQ;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_CSR;
                        Csr_Write       = `ysyx_24100006_CSRW;
                        Csr_Write_RD    = `ysyx_24100006_CW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                    `ysyx_24100006_inv:begin
                        case (funct12)
                            `ysyx_24100006_ecall:begin
                                // $display("ecall\n");
                                irq             = `ysyx_24100006_IRQ;
                                irq_no          = `ysyx_24100006_MECALL;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Csr_Write       = `ysyx_24100006_CSRW;
                                Csr_Write_RD    = `ysyx_24100006_EPC;
                                Jump            = `ysyx_24100006_JUMPECALL;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                            `ysyx_24100006_mret:begin
                                irq             = `ysyx_24100006_NIRQ;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_JUMPMRET;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                            `ysyx_24100006_ebreak:begin
                                $display("12312312\n");
                                npc_trap();
                            end
                            default: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                        endcase
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                endcase
			end
            `ysyx_24100006_auipc: begin
                irq             = `ysyx_24100006_NIRQ;
                Csr_Write       = `ysyx_24100006_CSRNW;
                Jump            = `ysyx_24100006_NJUMP;
                Imm_Type        = `ysyx_24100006_U_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Gpr_Write       = `ysyx_24100006_GPRW;
                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
            end
            `ysyx_24100006_lui: begin
                irq             = `ysyx_24100006_NIRQ;
                Csr_Write       = `ysyx_24100006_CSRNW;
                Jump            = `ysyx_24100006_NJUMP;
                Imm_Type        = `ysyx_24100006_U_TYPE_IMM;
                Gpr_Write       = `ysyx_24100006_GPRW;
                Gpr_Write_RD    = `ysyx_24100006_GPR_IMM;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
            end
            `ysyx_24100006_jal: begin
                irq             = `ysyx_24100006_NIRQ;
                Csr_Write       = `ysyx_24100006_CSRNW;
                Jump            = `ysyx_24100006_JAL;
                Imm_Type        = `ysyx_24100006_J_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Gpr_Write       = `ysyx_24100006_GPRW;
                Gpr_Write_RD    = `ysyx_24100006_GPR_PC_PLUS_4;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
            end
            `ysyx_24100006_jalr: begin
                irq             = `ysyx_24100006_NIRQ;
                Csr_Write       = `ysyx_24100006_CSRNW;
                Jump            = `ysyx_24100006_JALR;
                Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Gpr_Write       = `ysyx_24100006_GPRW;
                Gpr_Write_RD    = `ysyx_24100006_GPR_PC_PLUS_4;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
            end
            `ysyx_24100006_I_type: begin
                case(funct3)
                    `ysyx_24100006_addi: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_slti: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_sltiu: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                    `ysyx_24100006_sri: begin
                        case(funct7)
                            `ysyx_24100006_srli: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                                aluop           = `ysyx_24100006_srl_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_IMM;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                            `ysyx_24100006_srai: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                                aluop           = `ysyx_24100006_sra_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_IMM;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                            default: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                        endcase
                    end
                    `ysyx_24100006_andi: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_and_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_xori: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_xor_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_ori: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_or_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_slli: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_sll_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                endcase
            end
            `ysyx_24100006_R_type: begin
                case(funct3)
                    `ysyx_24100006_add_sub: begin
                        case(funct7)
                            `ysyx_24100006_add: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_add_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                            `ysyx_24100006_sub: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_sub_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                            default: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                        endcase
                    end
                    `ysyx_24100006_sll: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_sll_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_slt: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_sltu: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_xor: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_xor_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_sr: begin
                        case(funct7)
                            `ysyx_24100006_srl: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_srl_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                            `ysyx_24100006_sra: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_sra_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Gpr_Write       = `ysyx_24100006_GPRW;
                                Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                            end
                            default: begin
                                irq             = `ysyx_24100006_NIRQ;
                                Csr_Write       = `ysyx_24100006_CSRNW;
                                Jump            = `ysyx_24100006_NJUMP;
                                Gpr_Write       = `ysyx_24100006_GPRNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;  
                            end
                        endcase
                    end
                    `ysyx_24100006_or: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_or_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    `ysyx_24100006_and: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        aluop           = `ysyx_24100006_and_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_GPR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                endcase
            end
            `ysyx_24100006_S_type: begin
                case(funct3)
                    `ysyx_24100006_sb: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_WMask       = `ysyx_24100006_WByte;
                    end
                    `ysyx_24100006_sh: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_WMask       = `ysyx_24100006_WHWord; 
                    end
                    `ysyx_24100006_sw: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_WMask       = `ysyx_24100006_WWord;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;  
                    end
                endcase
            end
            `ysyx_24100006_load: begin
                case(funct3)
                    // 这个指令需要0扩展
                    `ysyx_24100006_lbu: begin
                        // $display("lb\n");
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RByteU;
                    end
                    `ysyx_24100006_lb: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RByte;
                    end
                    `ysyx_24100006_lw: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RWord;   
                    end
                    `ysyx_24100006_lh: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RHWord;
                    end
                    `ysyx_24100006_lhu: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Gpr_Write       = `ysyx_24100006_GPRW;
                        Gpr_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RHWordU;
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;  
                    end
                endcase
            end
            `ysyx_24100006_B_type: begin
                case(funct3)
                    // 如果ALU的结果等于0且JUMP类型为JBEQ,就可以跳转
                    `ysyx_24100006_beq: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBEQ;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_sub_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;  
                    end
                    `ysyx_24100006_bne: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBNE;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_sub_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;  
                    end
                    `ysyx_24100006_blt: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBLT;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;  
                    end
                    `ysyx_24100006_bge: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBGE;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;   
                    end
                    `ysyx_24100006_bltu: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBLTU;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;       
                    end
                    `ysyx_24100006_bgeu: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_JBGEU;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;        
                    end
                    default: begin
                        irq             = `ysyx_24100006_NIRQ;
                        Csr_Write       = `ysyx_24100006_CSRNW;
                        Jump            = `ysyx_24100006_NJUMP;
                        Gpr_Write       = `ysyx_24100006_GPRNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;         
                    end
                endcase
            end
            default: begin
                irq             = `ysyx_24100006_NIRQ;
                Csr_Write       = `ysyx_24100006_CSRNW;
                Jump            = `ysyx_24100006_NJUMP;
                Gpr_Write       = `ysyx_24100006_GPRNW;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;       
            end
        endcase
    end

endmodule

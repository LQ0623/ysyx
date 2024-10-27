/**
    输出一些控制信号
*/

// `include "ysyx_24100006_ctrl_define.v"
// `include "ysyx_24100006_inst_define.v"

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
//function
  //ysyx_24100006_SYSTEM
`define ysyx_24100006_ebreak              12'b000000000001

  //ysyx_24100006_I_type
`define ysyx_24100006_addi                3'b000
  //ysyx_24100006_R_type
`define ysyx_24100006_add_sub             3'b000
`define ysyx_24100006_add                 7'b0000000
`define ysyx_24100006_sub                 7'b0100000
  //ysyx_24100006_S_type
`define ysyx_24100006_sw                  3'b010
  //ysyx_24100006_B_type
`define ysyx_24100006_beq                 3'b000


import "DPI-C" function void npc_trap ();

module ysyx_24100006_controller(
    input [6:0]opcode,
    input [2:0]funct3,
    input [6:0]funct7,

    output reg [3:0]aluop,
    /* 写寄存器 */
    output reg Reg_Write,
    /* 写回寄存器的内容 */
    output reg [1:0] Reg_Write_RD,
    /* pc的跳转类型 */
    output reg [3:0] Jump,
    /* 立即数的种类 */
    output reg [2:0] Imm_Type,
    /* 源操作数的种类 */
    output reg AluSrcA,
    output reg AluSrcB,
    /* 是否读内存 */
    output reg Mem_Read,
    /* 写内存是多少字节 */
    output reg [1:0] Mem_RMask,
    /* 是否写内存 */
    output reg Mem_Write,
    /* 写内存是多少字节 */
    output reg [7:0] Mem_WMask,
    /* 写入的值是否需要符号扩展 */
    output reg write_sext
);

    always @(*) begin
        case(opcode)
            `ysyx_24100006_SYSTEM: begin
                npc_trap();
			end
            `ysyx_24100006_auipc: begin
                Jump            = `ysyx_24100006_NJUMP;
                Imm_Type        = `ysyx_24100006_U_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Reg_Write       = `ysyx_24100006_REGW;
                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
                write_sext      = `ysyx_24100006_write_no_sext;
            end
            `ysyx_24100006_lui: begin
                Jump            = `ysyx_24100006_NJUMP;
                Imm_Type        = `ysyx_24100006_U_TYPE_IMM;
                Reg_Write       = `ysyx_24100006_REGW;
                Reg_Write_RD    = `ysyx_24100006_REG_IMM;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
                write_sext      = `ysyx_24100006_write_no_sext;
            end
            `ysyx_24100006_jal: begin
                Jump            = `ysyx_24100006_JAL;
                Imm_Type        = `ysyx_24100006_J_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Reg_Write       = `ysyx_24100006_REGW;
                Reg_Write_RD    = `ysyx_24100006_REG_PC_PLUS_4;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
                write_sext      = `ysyx_24100006_write_no_sext;
            end
            `ysyx_24100006_jalr: begin
                Jump            = `ysyx_24100006_JALR;
                Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                aluop           = `ysyx_24100006_add_op;
                AluSrcA         = `ysyx_24100006_A_PC;
                AluSrcB         = `ysyx_24100006_B_IMM;
                Reg_Write       = `ysyx_24100006_REGW;
                Reg_Write_RD    = `ysyx_24100006_REG_PC_PLUS_4;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
                write_sext      = `ysyx_24100006_write_no_sext;
            end
            `ysyx_24100006_I_type: begin
                case(funct3)
                    `ysyx_24100006_addi: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_slti: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_sltiu: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_sri: begin
                        case(funct7)
                            `ysyx_24100006_srli: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                Imm_Type        = `ysyx_24100006_I_type;
                                aluop           = `ysyx_24100006_srl_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_IMM;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Read        = `ysyx_24100006_MEMNW;
                                Mem_Write       = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_srai: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                Imm_Type        = `ysyx_24100006_I_type;
                                aluop           = `ysyx_24100006_sra_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_IMM;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Read        = `ysyx_24100006_MEMNW;
                                Mem_Write       = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            default: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                Reg_Write       = `ysyx_24100006_REGNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                        endcase
                    end
                    `ysyx_24100006_andi: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_and_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_xori: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_xor_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_ori: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_or_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_slli: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_sll_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                endcase
            end
            `ysyx_24100006_R_type: begin
                case(funct3)
                    `ysyx_24100006_add_sub: begin
                        case(funct7)
                            `ysyx_24100006_add: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_add_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_sub: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_sub_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_sll: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_sll_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_slt: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_cmp_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_sltu: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_cmpu_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_xor: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_xor_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_sr: begin
                                case(funct7)
                                    `ysyx_24100006_srl: begin
                                        Jump            = `ysyx_24100006_NJUMP;
                                        aluop           = `ysyx_24100006_srl_op;
                                        AluSrcA         = `ysyx_24100006_A_RS;
                                        AluSrcB         = `ysyx_24100006_B_RT;
                                        Reg_Write       = `ysyx_24100006_REGW;
                                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                        Mem_Write       = `ysyx_24100006_MEMNW;
                                        Mem_Read        = `ysyx_24100006_MEMNR;
                                        write_sext      = `ysyx_24100006_write_no_sext;
                                    end
                                    `ysyx_24100006_sra: begin
                                        Jump            = `ysyx_24100006_NJUMP;
                                        aluop           = `ysyx_24100006_sra_op;
                                        AluSrcA         = `ysyx_24100006_A_RS;
                                        AluSrcB         = `ysyx_24100006_B_RT;
                                        Reg_Write       = `ysyx_24100006_REGW;
                                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                        Mem_Write       = `ysyx_24100006_MEMNW;
                                        Mem_Read        = `ysyx_24100006_MEMNR;
                                        write_sext      = `ysyx_24100006_write_no_sext;
                                    end
                                    default: begin
                                        Jump            = `ysyx_24100006_NJUMP;
                                        Reg_Write       = `ysyx_24100006_REGNW;
                                        Mem_Write       = `ysyx_24100006_MEMNW;
                                        Mem_Read        = `ysyx_24100006_MEMNR;
                                        write_sext      = `ysyx_24100006_write_no_sext;
                                    end
                                endcase
                            end
                            `ysyx_24100006_or: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_or_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            `ysyx_24100006_and: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_and_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                            default: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                Reg_Write       = `ysyx_24100006_REGNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                                Mem_Read        = `ysyx_24100006_MEMNR;
                                write_sext      = `ysyx_24100006_write_no_sext;
                            end
                        endcase
                    end

                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                endcase
            end
            `ysyx_24100006_S_type: begin
                case(funct3)
                    `ysyx_24100006_sb: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_WMask       = `ysyx_24100006_WByte;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_sh: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        Mem_WMask       = `ysyx_24100006_WHWord;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_sw: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMW;
                        Mem_WMask       = `ysyx_24100006_WWord;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                endcase
            end
            `ysyx_24100006_load: begin
                case(funct3)
                    // 这个指令需要0扩展
                    `ysyx_24100006_lbu: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RByte;
                        write_sext      = `ysyx_24100006_write_zero_sext;
                    end
                    `ysyx_24100006_lb: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RByte;
                        write_sext      = `ysyx_24100006_write_one_sext;
                    end
                    `ysyx_24100006_lw: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RWord;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_lh: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RHWord;
                        write_sext      = `ysyx_24100006_write_one_sext;
                    end
                    `ysyx_24100006_lhu: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_MEMR_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMR;
                        Mem_RMask       = `ysyx_24100006_RHWord;
                        write_sext      = `ysyx_24100006_write_zero_sext;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                endcase
            end
            `ysyx_24100006_B_type: begin
                case(funct3)
                    // 如果ALU的结果等于0且JUMP类型为JBEQ,就可以跳转
                    `ysyx_24100006_beq: begin
                        Jump            = `ysyx_24100006_JBEQ;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_sub_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_bne: begin
                        Jump            = `ysyx_24100006_JBNE;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_sub_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_blt: begin
                        Jump            = `ysyx_24100006_JBLT;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_bge: begin
                        Jump            = `ysyx_24100006_JBGE;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmp_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_bltu: begin
                        Jump            = `ysyx_24100006_JBLTU;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    `ysyx_24100006_bgeu: begin
                        Jump            = `ysyx_24100006_JBGEU;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_cmpu_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                        Mem_Read        = `ysyx_24100006_MEMNR;
                        write_sext      = `ysyx_24100006_write_no_sext;
                    end
                endcase
            end
            default: begin
                Jump            = `ysyx_24100006_NJUMP;
                Reg_Write       = `ysyx_24100006_REGNW;
                Mem_Write       = `ysyx_24100006_MEMNW;
                Mem_Read        = `ysyx_24100006_MEMNR;
                write_sext      = `ysyx_24100006_write_no_sext;
            end
        endcase
    end

endmodule

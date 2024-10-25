/**
    输出一些控制信号
*/

`include "/home/lq/ysyx-workbench/npc/vsrc/define/ysyx_24100006_ctrl_define.v"
`include "/home/lq/ysyx-workbench/npc/vsrc/define/ysyx_24100006_inst_define.v"

import "DPI-C" function void npc_trap ();

module ysyx_24100006_controller(
    input [6:0]opcode,
    input [2:0]funct3,
    input [6:0]funct7,

    output [3:0]aluop,
    /* 写寄存器 */
    output Reg_Write,
    /* 写回寄存器的内容 */
    output[1:0] Reg_Write_RD,
    /* pc的跳转类型 */
    output [3:0] Jump,
    /* 立即数的种类 */
    output [2:0] Imm_Type,
    /* 源操作数的种类 */
    output AluSrcA,
    output AluSrcB,
    /* 是否写内存 */
    output Mem_Write
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
            end
            `ysyx_24100006_lui: begin
                Jump            = `ysyx_24100006_NJUMP;
                Imm_Type        = `ysyx_24100006_U_TYPE_IMM;
                Reg_Write       = `ysyx_24100006_REGW;
                Reg_Write_RD    = `ysyx_24100006_REG_IMM;
                Mem_Write       = `ysyx_24100006_MEMNW;
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
            end
            `ysyx_24100006_I_type: begin
                case(funct3)
                    `ysyx_24100006_addi:begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_I_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_IMM;
                        Reg_Write       = `ysyx_24100006_REGW;
                        Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
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
                            end
                            `ysyx_24100006_sub: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                aluop           = `ysyx_24100006_sub_op;
                                AluSrcA         = `ysyx_24100006_A_RS;
                                AluSrcB         = `ysyx_24100006_B_RT;
                                Reg_Write       = `ysyx_24100006_REGW;
                                Reg_Write_RD    = `ysyx_24100006_REG_RESULT;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                            default: begin
                                Jump            = `ysyx_24100006_NJUMP;
                                Reg_Write       = `ysyx_24100006_REGNW;
                                Mem_Write       = `ysyx_24100006_MEMNW;
                            end
                        endcase
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                endcase
            end
            `ysyx_24100006_S_type: begin
                case(funct3)
                    `ysyx_24100006_sw: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Imm_Type        = `ysyx_24100006_S_TYPE_IMM;
                        aluop           = `ysyx_24100006_add_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                    default: begin
                        Jump            = `ysyx_24100006_NJUMP;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                endcase
            end
            `ysyx_24100006_B_type: begin
                case(funct3)
                    `ysyx_24100006_beq: begin
                        Jump            = `ysyx_24100006_JBEQ;
                        Imm_Type        = `ysyx_24100006_B_TYPE_IMM;
                        aluop           = `ysyx_24100006_sub_op;
                        AluSrcA         = `ysyx_24100006_A_RS;
                        AluSrcB         = `ysyx_24100006_B_RT;
                        Reg_Write       = `ysyx_24100006_REGNW;
                        Mem_Write       = `ysyx_24100006_MEMNW;
                    end
                endcase
            end

        endcase
    end

endmodule

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

// 是内存写入还是读取
`define ysyx_24100006_mem_idle              2'b00
`define ysyx_24100006_mem_load              2'b01
`define ysyx_24100006_mem_store             2'b10

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


import "DPI-C" function void npc_trap (input int timer_counter);
// TAG:这里可以删除,只是测个时间
import "DPI-C" function void time_start();
import "DPI-C" function void time_end();

/**
    主要是重构一下controller模块
*/
module ysyx_24100006_controller_remake(

    input clk,
    input reset,

    input [6:0]opcode,
    input [2:0]funct3,
    input [6:0]funct7,
    input [11:0]funct12,

    input wb_ready,    // 代替掉集中式状态机中的state == WB
    input mem_valid,

    /* 是否发生中断 */
    output  irq,
    output  [7:0] irq_no,
    /* 操作类型 */
    output  [3:0]aluop,
    /* 写通用寄存器 */
    output  Gpr_Write,
    /* 写回通用寄存器的内容 */
    output  [2:0] Gpr_Write_RD,
    /* 写系统寄存器 */
    output  Csr_Write,
    /* 写系统寄存器的内容 */
    output  [1:0] Csr_Write_RD,

    /* pc的跳转类型 */
    output  [3:0] Jump,
    /* 立即数的种类 */
    output  [2:0] Imm_Type,
    /* 源操作数的种类 */
    output  AluSrcA,
    output  AluSrcB,
    /* 是否读内存 */
    output  Mem_Read,
    /* 读内存是读多少字节，以及如何扩展 */
    output  [2:0] Mem_RMask,
    /* 是否写内存 */
    output  Mem_Write,
    /* 写内存是多少字节 */
    output  [7:0] Mem_WMask,
    /* 控制MEMU的状态机是走读取数据还是写入数据的分支 */
    output [1:0] sram_read_write
);


    //TAG 这样写有一个问题，ebreak如何跳转到结束，加了，但是不确定正确

    assign irq = (opcode == `ysyx_24100006_SYSTEM && (funct3 == `ysyx_24100006_inv) && (funct12 == `ysyx_24100006_ecall)) ? `ysyx_24100006_IRQ : `ysyx_24100006_NIRQ;
    assign irq_no = (opcode == `ysyx_24100006_SYSTEM && (funct3 == `ysyx_24100006_inv) && (funct12 == `ysyx_24100006_ecall)) ? `ysyx_24100006_MECALL : 0;    //  只有ecall语句会使用这个信号
    
    // ALU操作类型
    assign aluop = 
        /* auipc指令 */
        (opcode == `ysyx_24100006_auipc) ? `ysyx_24100006_add_op :
        /* jal/jalr指令 */
        ((opcode == `ysyx_24100006_jal) || (opcode == `ysyx_24100006_jalr)) ? `ysyx_24100006_add_op :
        /* I-type指令 */
        (opcode == `ysyx_24100006_I_type) ? (
            (funct3 == `ysyx_24100006_addi) ? `ysyx_24100006_add_op :
            (funct3 == `ysyx_24100006_slti) ? `ysyx_24100006_cmp_op :
            (funct3 == `ysyx_24100006_sltiu) ? `ysyx_24100006_cmpu_op :
            (funct3 == `ysyx_24100006_sri) ? (
                (funct7 == `ysyx_24100006_srli) ? `ysyx_24100006_srl_op :
                (funct7 == `ysyx_24100006_srai) ? `ysyx_24100006_sra_op : 4'b0
            ) : 
            (funct3 == `ysyx_24100006_andi) ? `ysyx_24100006_and_op :
            (funct3 == `ysyx_24100006_xori) ? `ysyx_24100006_xor_op :
            (funct3 == `ysyx_24100006_ori) ? `ysyx_24100006_or_op :
            (funct3 == `ysyx_24100006_slli) ? `ysyx_24100006_sll_op : 4'b0
        ) :
        /* R-type指令 */
        (opcode == `ysyx_24100006_R_type) ? (
            (funct3 == `ysyx_24100006_add_sub) ? (
                (funct7 == `ysyx_24100006_add) ? `ysyx_24100006_add_op :
                (funct7 == `ysyx_24100006_sub) ? `ysyx_24100006_sub_op : 4'b0
            ) :
            (funct3 == `ysyx_24100006_sll) ? `ysyx_24100006_sll_op :
            (funct3 == `ysyx_24100006_slt) ? `ysyx_24100006_cmp_op :
            (funct3 == `ysyx_24100006_sltu) ? `ysyx_24100006_cmpu_op :
            (funct3 == `ysyx_24100006_xor) ? `ysyx_24100006_xor_op :
            (funct3 == `ysyx_24100006_sr) ? (
                (funct7 == `ysyx_24100006_srl) ? `ysyx_24100006_srl_op :
                (funct7 == `ysyx_24100006_sra) ? `ysyx_24100006_sra_op : 4'b0
            ) :
            (funct3 == `ysyx_24100006_or) ? `ysyx_24100006_or_op :
            (funct3 == `ysyx_24100006_and) ? `ysyx_24100006_and_op : 4'b0
        ) :
        /* S-type指令 */
        (opcode == `ysyx_24100006_S_type) ? `ysyx_24100006_add_op :
        /* Load指令 */
        (opcode == `ysyx_24100006_load) ? `ysyx_24100006_add_op :
        /* B-type指令 */
        (opcode == `ysyx_24100006_B_type) ? (
            (funct3 == `ysyx_24100006_beq || funct3 == `ysyx_24100006_bne) ? `ysyx_24100006_sub_op :
            (funct3 == `ysyx_24100006_blt || funct3 == `ysyx_24100006_bge) ? `ysyx_24100006_cmp_op :
            (funct3 == `ysyx_24100006_bltu || funct3 == `ysyx_24100006_bgeu) ? `ysyx_24100006_cmpu_op : 4'b0
        ) : 4'b0;

    // 通用寄存器写使能
    // 之前使用的wb_ready==1'b0，这个会导致写入的数据错误，所以使用mem_valid==1'b1进行写入
    assign Gpr_Write = (mem_valid == 1'b1) ? 
        /* SYSTEM指令 */
        ((opcode == `ysyx_24100006_SYSTEM) ? (
            (funct3 == `ysyx_24100006_csrrw || funct3 == `ysyx_24100006_csrrs) ? `ysyx_24100006_GPRW : 
            // (funct3 == `ysyx_24100006_inv && funct12 == `ysyx_24100006_ebreak) ? npc_trap() : 
            `ysyx_24100006_GPRNW
        ) :
        /* 其他指令 */
        (opcode == `ysyx_24100006_auipc || 
        opcode == `ysyx_24100006_lui ||
        opcode == `ysyx_24100006_jal ||
        opcode == `ysyx_24100006_jalr ||
        opcode == `ysyx_24100006_I_type ||
        opcode == `ysyx_24100006_R_type ||
        opcode == `ysyx_24100006_load) ? `ysyx_24100006_GPRW : `ysyx_24100006_GPRNW) : `ysyx_24100006_GPRNW;

    // 通用寄存器写回数据选择
    assign Gpr_Write_RD = 
        /* SYSTEM指令 */
        (opcode == `ysyx_24100006_SYSTEM) ? (
            (funct3 == `ysyx_24100006_csrrw || funct3 == `ysyx_24100006_csrrs) ? 
            `ysyx_24100006_CSR : 
            `ysyx_24100006_GPR_RESULT  // 默认值
        ) :
        /* auipc指令 */
        (opcode == `ysyx_24100006_auipc) ? `ysyx_24100006_GPR_RESULT :
        /* lui指令 */
        (opcode == `ysyx_24100006_lui) ? `ysyx_24100006_GPR_IMM :
        /* jal/jalr指令 */
        ((opcode == `ysyx_24100006_jal) || (opcode == `ysyx_24100006_jalr)) ? 
        `ysyx_24100006_GPR_PC_PLUS_4 :
        /* I-type/R-type指令 */
        ((opcode == `ysyx_24100006_I_type) || (opcode == `ysyx_24100006_R_type)) ? 
        `ysyx_24100006_GPR_RESULT :
        /* Load指令 */
        (opcode == `ysyx_24100006_load) ? `ysyx_24100006_MEMR_RESULT : 
        /* 默认值 */
        3'b0;

    // 系统寄存器写使能
    assign Csr_Write = (mem_valid == 1'b1) ?
        ((opcode == `ysyx_24100006_SYSTEM) ? 
            ((funct3 == `ysyx_24100006_csrrw || funct3 == `ysyx_24100006_csrrs) ? `ysyx_24100006_CSRW : 
            (funct3 == `ysyx_24100006_inv && funct12 == `ysyx_24100006_ecall) ? `ysyx_24100006_CSRW : 
            `ysyx_24100006_CSRNW) : `ysyx_24100006_CSRNW) : `ysyx_24100006_CSRNW;

    // CSR写回数据选择
    assign Csr_Write_RD = 
        (opcode == `ysyx_24100006_SYSTEM) ? (
            (funct3 == `ysyx_24100006_inv && funct12 == `ysyx_24100006_ecall) ? 
            `ysyx_24100006_EPC :
            (funct3 == `ysyx_24100006_csrrw) ? `ysyx_24100006_CW :
            (funct3 == `ysyx_24100006_csrrs) ? `ysyx_24100006_CS : 
            2'b00  // 默认
        ) : 2'b00;

    // 跳转类型
    assign Jump = 
        ((opcode == `ysyx_24100006_jal) ? `ysyx_24100006_JAL :
        (opcode == `ysyx_24100006_jalr) ? `ysyx_24100006_JALR :
        (opcode == `ysyx_24100006_SYSTEM && funct12 == `ysyx_24100006_ecall) ? `ysyx_24100006_JUMPECALL :
        (opcode == `ysyx_24100006_SYSTEM && funct12 == `ysyx_24100006_mret) ? `ysyx_24100006_JUMPMRET :
        (opcode == `ysyx_24100006_B_type) ? (
            (funct3 == `ysyx_24100006_beq) ? `ysyx_24100006_JBEQ :
            (funct3 == `ysyx_24100006_bne) ? `ysyx_24100006_JBNE :
            (funct3 == `ysyx_24100006_blt) ? `ysyx_24100006_JBLT :
            (funct3 == `ysyx_24100006_bge) ? `ysyx_24100006_JBGE :
            (funct3 == `ysyx_24100006_bltu) ? `ysyx_24100006_JBLTU :
            (funct3 == `ysyx_24100006_bgeu) ? `ysyx_24100006_JBGEU : `ysyx_24100006_NJUMP
        ) : `ysyx_24100006_NJUMP);

    // 立即数类型
    assign Imm_Type = 
        (opcode == `ysyx_24100006_auipc || opcode == `ysyx_24100006_lui) ? `ysyx_24100006_U_TYPE_IMM :
        (opcode == `ysyx_24100006_jal) ? `ysyx_24100006_J_TYPE_IMM :
        (opcode == `ysyx_24100006_jalr || opcode == `ysyx_24100006_I_type || opcode == `ysyx_24100006_load) ? `ysyx_24100006_I_TYPE_IMM :
        (opcode == `ysyx_24100006_S_type) ? `ysyx_24100006_S_TYPE_IMM :
        (opcode == `ysyx_24100006_B_type) ? `ysyx_24100006_B_TYPE_IMM : 3'b0;

    // ALU源A选择
    assign AluSrcA = 
        /* auipc/jal/jalr使用PC */
        ((opcode == `ysyx_24100006_auipc) || 
        (opcode == `ysyx_24100006_jal) || 
        (opcode == `ysyx_24100006_jalr)) ? 
        `ysyx_24100006_A_PC : 
        /* 其他指令使用寄存器 */
        `ysyx_24100006_A_RS;

    // ALU源B选择 
    assign AluSrcB = 
        /* 需要立即数的指令 */
        ((opcode == `ysyx_24100006_auipc) ||
        (opcode == `ysyx_24100006_jal) ||
        (opcode == `ysyx_24100006_jalr) ||
        (opcode == `ysyx_24100006_I_type) ||
        (opcode == `ysyx_24100006_S_type) ||
        (opcode == `ysyx_24100006_load)) ? 
        `ysyx_24100006_B_IMM : 
        /* R-type/B-type使用寄存器 */
        `ysyx_24100006_B_RT;

    // 内存读使能
    assign Mem_Read = 
        (opcode == `ysyx_24100006_load) ? `ysyx_24100006_MEMR : 
        `ysyx_24100006_MEMNR;

    // 内存读模式选择
    assign Mem_RMask = 
        (opcode == `ysyx_24100006_load) ? (
            (funct3 == `ysyx_24100006_lbu) ? `ysyx_24100006_RByteU :
            (funct3 == `ysyx_24100006_lb) ? `ysyx_24100006_RByte : 
            (funct3 == `ysyx_24100006_lw) ? `ysyx_24100006_RWord : 
            (funct3 == `ysyx_24100006_lh) ? `ysyx_24100006_RHWord : 
            (funct3 == `ysyx_24100006_lhu) ? `ysyx_24100006_RHWordU : 3'b0
        ) : 3'b0;

    // 内存写使能
    assign Mem_Write = (wb_ready == 1'b0)?
        ((opcode == `ysyx_24100006_S_type) ? `ysyx_24100006_MEMW : 
            `ysyx_24100006_MEMNW) : `ysyx_24100006_MEMNW;

    // 内存写模式选择
    assign Mem_WMask = 
        (opcode == `ysyx_24100006_S_type) ? (
            (funct3 == `ysyx_24100006_sb) ? `ysyx_24100006_WByte :
            (funct3 == `ysyx_24100006_sh) ? `ysyx_24100006_WHWord : 
            (funct3 == `ysyx_24100006_sw) ? `ysyx_24100006_WWord : 8'b0
        ) : 8'b0;

    assign sram_read_write =    (opcode == `ysyx_24100006_S_type)   ? `ysyx_24100006_mem_store  : 
                                (opcode == `ysyx_24100006_load)     ? `ysyx_24100006_mem_load   : `ysyx_24100006_mem_idle;


    reg [31:0] timer_counter;
    // 测试一个时钟周期大概是多少的us
    always @(posedge clk) begin
        if(reset) begin
            timer_counter   <= 0;
        end else begin
            if(timer_counter == 0) begin
                time_start();
            end
            timer_counter   <= timer_counter + 1'b1;
        end
    end

    always @(*) begin
        if(opcode == `ysyx_24100006_SYSTEM && funct3 == `ysyx_24100006_inv && funct12 == `ysyx_24100006_ebreak) begin
            $display("asdasdasdasd");
            time_end();
            npc_trap(timer_counter);
        end
    end

endmodule

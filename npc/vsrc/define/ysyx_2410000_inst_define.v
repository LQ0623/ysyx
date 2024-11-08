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

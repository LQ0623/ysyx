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

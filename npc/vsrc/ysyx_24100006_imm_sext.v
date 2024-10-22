module ysyx_24100006_imm_sext(
    input [31:0] inst,
    output [31:0] sext_imm
);

    assign sext_imm = {{20{inst[31]}},inst[31:20]};

endmodule

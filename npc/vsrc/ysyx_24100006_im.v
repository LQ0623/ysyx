/**
    模拟指令存储器
*/
module ysyx_24100006_im(
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] pc,
    output [31:0] instruction
);

    reg [31:0] instructions[1023:0];
    // initial 用于初始化
    initial begin
        $readmemb("inst.txt",instructions);
    end

    assign instruction = instructions[pc[11:2]];


endmodule

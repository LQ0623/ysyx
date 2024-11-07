/**
    模拟指令存储
*/
module ysyx_24100006_im(
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] pc,
    output reg [31:0] instruction
);

    import "DPI-C" function int pmem_read(input int raddr);
    always@(*)begin
        instruction = pmem_read(pc);
    end

    // reg [31:0] instructions[1023:0];
    // // initial 用于初始化
    // initial begin
    //     $readmemh("/home/lq/ysyx-workbench/npc/vsrc/inst.txt",instructions);
    // end

    // assign instruction = instructions[pc[11:2]];

endmodule

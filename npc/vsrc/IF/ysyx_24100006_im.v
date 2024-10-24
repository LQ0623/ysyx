/**
    模拟指令存储
*/
module ysyx_24100006_im(
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] pc,
    output [31:0] instruction
);

    import "DPI-C" function int pmem_read(input int raddr);
    always@(*)begin
        inst = pmem_read(pc);
    end

endmodule

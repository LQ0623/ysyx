/**
    模拟指令存储
*/
module ysyx_24100006_im(
    /* verilator lint_off UNUSEDSIGNAL */
    input [31:0] pc,
    output [31:0] instruction
);

    reg [31:0] instructions[1023:0];
    integer i;
    // initial 用于初始化
    initial begin
        $readmemh("/home/lq/ysyx-workbench/npc/vsrc/inst.txt",instructions);
        // for(i = 0;i<10;i = i+1)begin
        //     $display("instruction is 0x%0h",instructions[i]);
        // end
    end

    assign instruction = instructions[pc[11:2]];


endmodule

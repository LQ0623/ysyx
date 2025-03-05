/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

    input [31:0] npc,
    // control signal from IDU
    input PCW,

    output [31:0] pc_F,
    output [31:0] instruction   // 读出的指令
);

	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW(PCW),
		.npc(npc),
		.pc(pc_F)
	);

	wire [31:0] instruction_temp;	// 指令寄存器读出的数据
	ysyx_24100006_im IM(
		.valid(~(reset | clk)),
		.pc(pc_F),
		.instruction(instruction_temp)
	);

    /**
		IR寄存器：保存取出的指令
	*/
	ysyx_24100006_Reg #(32,32'h00000000) IR(
		.clk(clk),
		.rst(reset),
		.din(instruction_temp),
		.dout(instruction),
		.wen(1'b1)
	);

endmodule